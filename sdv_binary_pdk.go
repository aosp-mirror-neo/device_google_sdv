// Copyright 2024 Google LLC
package sdv_binary_pdk

import (
	"android/soong/android"
	"fmt"
	"sort"
	"strings"

	"github.com/google/blueprint"
)

func moduleSetToSlice(moduleSet map[string]bool) []string {
	modules := make([]string, 0, len(moduleSet))
	for module := range moduleSet {
		modules = append(modules, module)
	}
	sort.Strings(modules)
	return modules
}

var pctx = android.NewPackageContext("android/soong/sdv_binary_pdk")

func init() {
	pctx.Import("android/soong/android")
	android.RegisterModuleType("sdv_packing", sdvBinaryPdkFactory)
}

func sdvBinaryPdkFactory() android.Module {
	module := &sdvBinaryPdkModule{}
	module.AddProperties(&module.properties)
	android.InitAndroidMultiTargetsArchModule(module, android.HostAndDeviceSupported, android.MultilibCommon)
	return module
}

type sdvBinaryPdkModule struct {
	android.ModuleBase
	properties sdvBinaryPdkProperties
}

type sdvBinaryPdkProperties struct {
	Pdk_vars           []string
	Additional_modules []string
	Override_file       string
}

func (p *sdvBinaryPdkModule) UseGenericConfig() bool {
	return false
}

type sdvBinaryPdkDeptagType struct {
	blueprint.BaseDependencyTag
}

var sdvBinaryPdkDeptag = sdvBinaryPdkDeptagType{}

func (s sdvBinaryPdkDeptagType) IsSdvPrimaryImageVariation() {}

func (s *sdvBinaryPdkModule) DepsMutator(ctx android.BottomUpMutatorContext) {
	// Use map[string]bool as a set for efficient lookups and to avoid duplicates.
	deviceModuleSet := make(map[string]bool)
	deviceSharedModuleSet := make(map[string]bool)
	deviceRustLibSet := make(map[string]bool)
	hostModuleSet := make(map[string]bool)

	// For some modules, we need to add a dependency on the shared link variant so the .so file can be created.
	// For example: libsdv_comms_id_ffi.so
	sharedLinkVariation := []blueprint.Variation{{"link", "shared"}}
	// For some modules, we need to add a dependency on the rust_libraries variant so the .dylib.so file can be created.
	// For example: libsdv_authz_policy.dylib.so
	rustLibVariation := []blueprint.Variation{{"rust_libraries", "dylib"}}

	config := ctx.Config().VendorConfig("sdv_config")
	// Get all modules from the PDK vars and additional modules.
	var allModules []string
	for _, pdkVar := range s.properties.Pdk_vars {
		 moduleListStr := config.String(pdkVar)
		if moduleListStr != "" {
			allModules = append(allModules, strings.Split(moduleListStr, " ")...)
		}
	}
	allModules = append(allModules, s.properties.Additional_modules...)

	for _, module := range allModules {
		if !ctx.OtherModuleExists(module) {
			continue
		}
		if ctx.OtherModuleFarDependencyVariantExists(ctx.Config().BuildOSTarget.Variations(), module) {
			hostModuleSet[module] = true
		}
		if ctx.OtherModuleFarDependencyVariantExists(sharedLinkVariation, module) {
			deviceSharedModuleSet[module] = true
		}
		if ctx.OtherModuleFarDependencyVariantExists(rustLibVariation, module) {
			deviceRustLibSet[module] = true
		}
		if ctx.OtherModuleFarDependencyVariantExists(ctx.Config().AndroidFirstDeviceTarget.Variations(), module) {
			deviceModuleSet[module] = true
		}
	}

	ctx.AddVariationDependencies(
		ctx.Config().AndroidFirstDeviceTarget.Variations(),
		sdvBinaryPdkDeptag,
		moduleSetToSlice(deviceModuleSet)...)
	ctx.AddVariationDependencies(
		append(ctx.Config().AndroidFirstDeviceTarget.Variations(), sharedLinkVariation...),
		nil,
		moduleSetToSlice(deviceSharedModuleSet)...)
	ctx.AddVariationDependencies(
		append(ctx.Config().AndroidFirstDeviceTarget.Variations(), rustLibVariation...),
		nil,
		moduleSetToSlice(deviceRustLibSet)...)
	ctx.AddVariationDependencies(
		ctx.Config().BuildOSTarget.Variations(),
		nil,
		moduleSetToSlice(hostModuleSet)...)
}

var ctspHostJavaToolDeptag = sdvBinaryPdkDeptagType{}

func (s *sdvBinaryPdkModule) GenerateAndroidBuildActions(ctx android.ModuleContext) {
	if len(ctx.Config().Targets[android.Android]) == 0 {
		return
	}
	deviceName := ctx.Config().DeviceName()
	if deviceName == "" {
		return
	}
	sdvBaseFolder := android.PathForModuleOut(ctx, "sdv-binary-pdk")

	pkgFolder := sdvBaseFolder.Join(ctx, "packages")
	config := ctx.Config().VendorConfig("sdv_config")
	var packageFiles []android.Path
	for _, sdvBinaryPdkVar := range s.properties.Pdk_vars {
		moduleListStr := config.String(sdvBinaryPdkVar)
		var moduleNames []string
		for _, moduleName := range strings.Split(moduleListStr, " ") {
			if strings.TrimSpace(moduleName) != "" {
				moduleNames = append(moduleNames, moduleName)
			}
		}
		pkgFileName := strings.ToUpper(sdvBinaryPdkVar)
		pkgFilePath := pkgFolder.Join(ctx, pkgFileName)
		txtFilePath := pkgFolder.Join(ctx, pkgFileName+".txt")
		content := strings.Join(moduleNames, " ")
		android.WriteFileRule(ctx, pkgFilePath, content)
		packageFiles = append(packageFiles, pkgFilePath)

		android.WriteFileRule(ctx, txtFilePath, content)
		packageFiles = append(packageFiles, txtFilePath)
	}

	// Get all install paths for the modules.
	var installPaths []android.Path
	ctx.VisitDirectDepsProxy(func(module android.ModuleProxy) {
		info := android.GetInstallFiles(ctx, module)
		for _, spec := range info.PackagingSpecs {
			installPaths = append(installPaths, spec.FullInstallPath())
		}
	})

	sboxFolder := sdvBaseFolder.Join(ctx, "sbox")
	archiveFolder := sdvBaseFolder.Join(ctx, "archive")
	sanboxTextProto := sdvBaseFolder.Join(ctx, "sdv_sbox.textproto")
	collectorRule := android.NewRuleBuilder(pctx, ctx).Sbox(sboxFolder, sanboxTextProto)
	fileReportPath := sboxFolder.Join(ctx, "file_report.txt")
	moduleInfoPath := android.PathForArbitraryOutput(
		ctx,
		fmt.Sprintf("target/product/%s/module-info.json", deviceName))
	collectorCmd := collectorRule.Command().
		BuiltTool("binary_pdk_collector").
		FlagWithArg("--binary-dir ", archiveFolder.String()).
		FlagWithArg("--target-name ", deviceName).
		FlagWithArg("--target-architecture ", ctx.Config().Targets[android.Android][0].Arch.String()).
		FlagWithArg("--src-dir ", android.PathForSource(ctx, "").String()).
		FlagWithArg("--out-dir ", ctx.Config().OutDir()).
		FlagWithOutput("--file-report-path ", fileReportPath).
		FlagWithArg("--packages-dir ", pkgFolder.String()).
		Implicit(moduleInfoPath).
		Implicits(packageFiles).
		Implicits(installPaths).
		ImplicitOutput(fileReportPath)
	if s.properties.Override_file != "" {
		collectorCmd.
			FlagWithArg("--target-overrides ", s.properties.Override_file)
	}
	collectorRule.Build("binary_pdk_collector", "Running binary_pdk_collector")

	filesToZip := android.PathForModuleOut(ctx, "sdv_binary_pdk_files_to_archive.txt")
	findRule := android.NewRuleBuilder(pctx, ctx)
	findRule.Command().
		Text("find").
		Text(archiveFolder.String()).
		FlagWithOutput(">", filesToZip).
		Implicit(fileReportPath).
		ImplicitOutput(filesToZip)
	findRule.Build("sdv_binary_pdk_find_files", "Finding files for SDV Binary PDK zip")

	productOutZip := android.PathForArbitraryOutput(
		ctx,
		fmt.Sprintf("target/product/%s/sdv-binary-pdk/sdv-binary-pdk.zip", deviceName))
	zipRule := android.NewRuleBuilder(pctx, ctx)
	zipRule.Command().
		BuiltTool("soong_zip").
		FlagWithArg("-o ", productOutZip.String()).
		FlagWithArg("-C ", archiveFolder.String()).
		FlagWithArg("-l ", filesToZip.String()).
		Flag("-d").
		Implicit(filesToZip).
		ImplicitOutput(productOutZip)
	zipRule.Build("sdv_binary_pdk_zip", "Creating zip file for SDV Binary PDK")
	ctx.Phony(ctx.ModuleName(), productOutZip)
	ctx.DistForGoalWithFilename("sdv-binary-pdk", productOutZip, "sdv-binary-pdk/sdv-binary-pdk.zip")
	ctx.DistForGoalWithFilename("sdv-binary-pdk", fileReportPath, "sdv-binary-pdk/file_report.txt")
	ctx.SetOutputFiles(android.Paths{productOutZip}, ".zip")
}
