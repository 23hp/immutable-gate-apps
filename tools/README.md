## Get HOST_PATH of a PVC
```
PV_NAME=$(kubectl get pvc data-pvc -n paperless -o jsonpath='{.spec.volumeName}')
HOST_PATH=$(kubectl get pv $PV_NAME -o jsonpath='{.spec.hostPath.path}')
```

## init a Kopia repo
    kopia repository create filesystem --path=/mnt/backup-disk/kopia-repo

# connect to the Kopia repo
    kopia repository connect filesystem --path=/mnt/backup-disk/kopia-repo

# create/incremental backup
    kopia snapshot create /data/paperless

# Export all database
```
pg_dumpall -U postgres > all_databases_$(date +%Y%m%d).sql

# or export and zip
pg_dumpall -U postgres | gzip > all_databases_$(date +%Y%m%d).sql.gz
```

# Import all database
```
psql -U postgres < all_databases_20260905.sql

# or unzip and import
gunzip -c all_databases_20260905.sql.gz | psql -U postgres
```