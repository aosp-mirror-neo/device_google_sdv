#  Copyright 2024 Google Inc

"""
A simple integration test that tests that the data partition is persistent across reboots

"""

import random
from mobly import asserts
from mobly import base_test, test_runner
from mobly.controllers import android_device

# A test directory and a test file that are created and tested for persistence
_TEST_DIR = '/data/local/tmp/data_partition_persistence_test_dir'
_TEST_FILE = _TEST_DIR + '/data_partition_persistence_test_file'

class DataPartitionPersistenceTest(base_test.BaseTestClass):
    def setup_class(self):
        super().setup_class()
        self.device = self.register_controller(android_device)[0]

    def teardown_test(self):
        self.cleanup()

    def test_data_is_persisted_across_reboots(self):
        # Cleanup the test artifacts from any previous runs
        self.cleanup()

        # Using a random file content to minimize the chance of the test passing just because the
        # file was already there
        TEST_FILE_CONTENT = str(random.randint(1000,9999))

        self.device.adb.shell(f'mkdir {_TEST_DIR}')
        self.device.adb.shell(f'echo {TEST_FILE_CONTENT} > {_TEST_FILE}')


        # this only returns after the device has rebooted
        self.device.reboot()
        test_file_content = self.device.adb.shell(f'cat {_TEST_FILE}').decode('utf-8').strip()
        asserts.assert_equal(TEST_FILE_CONTENT, test_file_content)

    def cleanup(self):
        self.device.adb.shell(f'rm -rf {_TEST_DIR}')

if __name__ == '__main__':
    # Reconstruct test runner arguments from Forrest runner.
    if '--' in sys.argv:
        index = sys.argv.index('--')
        sys.argv = sys.argv[:1] + sys.argv[index + 1 :]
    test_runner.main()
