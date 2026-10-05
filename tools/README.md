# Database Recovery

## Step 1: Restore backup

## Step 2: Untar archive
use another pod which has `tar` installed to mount the PVC and unzip the `tar` file.

    tar -xf database-postgres.tar

Restore specific database

    pg_restore -U postgres -d <target_database> --clean --if-exists /tmp/dumps/<database_name>.dump 