/*
====================================================================
DDL Script: Create Bronze Tables
====================================================================

Script Purpose:

    This script creates tables in the 'bronze' schema,
    dropping existing tables if they already exist.

    Run this script to re-define the DDL structure
    of Bronze tables.

====================================================================
*/
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$

DECLARE --declaration of variables
    start_time TIMESTAMP;
    end_time   TIMESTAMP;
	start_time_batch TIMESTAMP;
	end_time_batch TIMESTAMP;

BEGIN --try block
    start_time_batch :=CURRENT_TIMESTAMP;
    RAISE NOTICE '=========================================';
    RAISE NOTICE 'LOADING BRONZE LAYER';
    RAISE NOTICE '=========================================';

    ----------------------------------------------------------------
    -- CSV TABLE 1
    ----------------------------------------------------------------

    RAISE NOTICE 'LOADING CRM TABLES';

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE crm_cust_info';

    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE 'INSERTING crm_cust_info';

    COPY bronze.crm_cust_info
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));

    ----------------------------------------------------------------
    -- CSV TABLE 2
    ----------------------------------------------------------------

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE crm_prd_info';

    TRUNCATE TABLE bronze.crm_prd_info;

    RAISE NOTICE 'INSERTING crm_prd_info';

    COPY bronze.crm_prd_info
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));

    ----------------------------------------------------------------
    -- CSV TABLE 3
    ----------------------------------------------------------------

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE crm_sales_details';

    TRUNCATE TABLE bronze.crm_sales_details;

    RAISE NOTICE 'INSERTING crm_sales_details';

    COPY bronze.crm_sales_details
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));

    ----------------------------------------------------------------
    -- ERP TABLE 1
    ----------------------------------------------------------------

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE erp_cust_az12';

    TRUNCATE TABLE bronze.erp_cust_az12;

    RAISE NOTICE 'INSERTING erp_cust_az12';

    COPY bronze.erp_cust_az12
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));

    ----------------------------------------------------------------
    -- ERP TABLE 2
    ----------------------------------------------------------------

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE erp_loc_a101';

    TRUNCATE TABLE bronze.erp_loc_a101;

    RAISE NOTICE 'INSERTING erp_loc_a101';

    COPY bronze.erp_loc_a101
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));

    ----------------------------------------------------------------
    -- ERP TABLE 3
    ----------------------------------------------------------------

    start_time := CURRENT_TIMESTAMP;

    RAISE NOTICE 'TRUNCATE erp_px_cat_g1v2';

    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    RAISE NOTICE 'INSERTING erp_px_cat_g1v2';

    COPY bronze.erp_px_cat_g1v2
    FROM 'D:/sql/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := CURRENT_TIMESTAMP;

    RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time - start_time));
    end_time_batch :=CURRENT_TIMESTAMP;
	
    RAISE NOTICE '=========================================';
    RAISE NOTICE 'BRONZE LAYER LOADING COMPLETED';
	 RAISE NOTICE '>> Load Duration: % seconds',
    EXTRACT(EPOCH FROM (end_time_batch - start_time_batch));
    RAISE NOTICE '=========================================';

EXCEPTION--catch block
    WHEN OTHERS THEN

        RAISE NOTICE '=========================================';
        RAISE NOTICE 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        RAISE NOTICE 'ERROR MESSAGE: %', SQLERRM;
        RAISE NOTICE 'ERROR CODE: %', SQLSTATE;
        RAISE NOTICE '=========================================';

END;--end of try block 
$$;
