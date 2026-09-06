## Backup
```
velero backup create apps-backup --include-namespaces coder,immich,memos,paperless,wallabag
```

## Check progress
```
velero backup get
```

# Debug
```
velero backup describe apps-backup --details
velero backup logs apps-backup
```