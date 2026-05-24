/*
==============================================================
Create Database and Schemas  (PostgreSQL Version)
==============================================================

Script Purpose:

    This script creates a new database named 'DataWarehouse'.

    If the database already exists,
    it will be dropped and recreated.

    Additionally, the script creates three schemas:
    'bronze', 'silver', and 'gold'.

WARNING:

    Running this script will permanently delete
    the existing 'DataWarehouse' database if it exists.

    Make sure you have proper backups before running.
==============================================================
*/
-- Drop the database if it already exists
DROP DATABASE IF EXISTS DataWarehouse;

-- Create a new database
CREATE DATABASE DataWarehouse;

-- ------------------------------------------------
-- Connect to the newly created database
-- (Run this command separately in psql)
--(we can also do things in cli)
-- ------------------------------------------------
\c DataWarehouse

-- ============================================
-- Create Schemas
-- ============================================

-- Create bronze schema
CREATE SCHEMA bronze;

-- Create silver schema
CREATE SCHEMA silver;

-- Create gold schema 
CREATE SCHEMA gold;
