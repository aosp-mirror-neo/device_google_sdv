// Copyright 2024 Google LLC

#[cfg(test)]
use std::path::Path;

#[test]
fn dev_pmsg0_exists() {
    assert!(Path::new("/dev/pmsg0").exists());
}

#[test]
fn sysfs_pstore_pmsg_has_contents_after_reboot() {
    let contents = std::fs::read("/sys/fs/pstore/pmsg-ramoops-0").unwrap();
    let expected = b"HelloPstore";
    // String defined in AndroidTest.xml
    assert!(
        contents.as_slice().windows(expected.len()).any(|b| b == expected),
        "content: {:?} not found in /sys/fs/pstore/pmsg-ramoops-0:\n{:?}",
        String::from_utf8_lossy(expected),
        String::from_utf8_lossy(&contents)
    );
}

#[test]
fn sysfs_pstore_console_exists() {
    assert!(Path::new("/sys/fs/pstore/console-ramoops-0").exists());
}
