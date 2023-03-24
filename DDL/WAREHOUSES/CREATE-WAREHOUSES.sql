CREATE OR REPLACE WAREHOUSE TPCDI_GENERAL_WH WITH WAREHOUSE_SIZE = 'MEDIUM' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = 'Warehouse to run TPC-DI status queries and run maintenance tasks.';

CREATE OR REPLACE WAREHOUSE TPCDI_FILE_LOAD WITH WAREHOUSE_SIZE = 'XLARGE' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = 'Warehouse to load TPC-DI files from stage';

CREATE OR REPLACE WAREHOUSE TASK_WH_A WITH WAREHOUSE_SIZE = 'XLARGE' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = 'Warehouse to run heavy TPC-DI tasks';

CREATE OR REPLACE WAREHOUSE TASK_WH_B WITH WAREHOUSE_SIZE = 'LARGE' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = 'Warehouse to run light TPC-DI tasks';