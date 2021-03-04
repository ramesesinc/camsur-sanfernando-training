SET FOREIGN_KEY_CHECKS = 0;

BEGIN;
INSERT IGNORE INTO `sys_role` VALUES ('ADMIN', 'WATERWORKS'), ('APPROVER', 'WATERWORKS'), ('BILLER', 'BILLER'), ('MASTER', 'WATERWORKS MASTER'), ('PROCESSOR', 'PROCESSOR'), ('READER', 'WATERWORKS READER'), ('REPORT', 'WATERWORKS REPORT'), ('RULE_AUTHOR', 'WATERWORKS RULE_AUTHOR'), ('SHARED', 'WATERWORKS SHARED');
COMMIT;

BEGIN;
INSERT IGNORE INTO `sys_role_permission` VALUES ('USRROLPERM-356dadf7:177e2d55369:-7b1d', 'PROCESSOR', 'waterworks_compromise', 'create', 'File Compromise Agreement'), ('USRROLPERM36569ed9:177e1b2c6fb:-511d', 'PROCESSOR', 'waterworks_change_request', 'changeSubArea', 'Change Sub Area'), ('USRROLPERM36569ed9:177e1b2c6fb:-53ea', 'PROCESSOR', 'waterworks_change_request', 'changeContact', 'Change Contact'), ('USRROLPERM36569ed9:177e1b2c6fb:-5810', 'PROCESSOR', 'waterworks_change_request', 'changeClassification', 'Change Classification'), ('USRROLPERM36569ed9:177e1b2c6fb:-5a53', 'PROCESSOR', 'waterworks_change_request', 'changeAttributes', 'Change Attributes'), ('USRROLPERM36569ed9:177e1b2c6fb:-5c96', 'PROCESSOR', 'waterworks_change_request', 'changeAddress', 'Change Address'), ('USRROLPERM36569ed9:177e1b2c6fb:-5ea3', 'PROCESSOR', 'waterworks_change_request', 'changeOwner', 'Change Owner'), ('USRROLPERM36569ed9:177e1b2c6fb:-6082', 'PROCESSOR', 'waterworks_change_request', 'changeMeter', 'Change Meter'), ('USRROLPERM36569ed9:177e1b2c6fb:-72a1', 'PROCESSOR', 'waterworks_disconnection', 'create', 'File Disconnection'), ('USRROLPERM36569ed9:177e1b2c6fb:-748a', 'PROCESSOR', 'waterworks_reconnection', 'create', 'File Reconnection'), ('USRROLPERM36569ed9:177e1b2c6fb:-7670', 'PROCESSOR', 'waterworks_newconnection', 'create', 'File New Connection'), ('USRROLPERM47fb483d:177e2cd8499:-7ad5', 'PROCESSOR', 'waterworks_account', 'captureAccount', 'Capture Customer Account');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
