# ImmutableGate APPs
repo for app deployment

- Encyption TOOL: **SOPS**

# Prerequisite
- [AGE](https://github.com/FiloSottile/age)
- [SOPS](https://github.com/getsops/sops)
- [Bitwarden Secret Manager CLI](https://github.com/bitwarden/sdk-sm/releases) Only needed when viewing/editing secrets locally.
```bash
    brew install age sops
```
Check [Bitwarden Secret Manager document](https://bitwarden.com/help/secrets-manager-cli/) to see how to install and config. Ensure `bws` command can be used from your machine.

## Usage

### In-place encryption
```bash
sops -e -i localhost.sops.yml
```
### Quickly view/change secrets
My AGE key is stored in Bitwarden Secret Manager
```bash
bws run -- sops localhost.sops.yml
```
### Secret template
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: plaintext-editable-secret
type: Opaque
stringData:
  username: myUserName
  password: MySecretPassword123!
  database-url: postgresql://user:pass@db:5432/mydb
```