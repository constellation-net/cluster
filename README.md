# cluster
Kubernetes manifests to do deployed to Constellation by FluxCD

## Namespaces
### starsys-secure
This namespace is home to any and all services dealing with important and secret data. Unlike most volumes, which are kept in the `starsys-storage` namespace, volumes containing secure data are kept within this namespace. This allows us to define a hard border around highly sensitive data and implement security protocols as such.

This namespace contains the following Deployments:
- [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets): encrypts Secrets for upload to Git repositories and securely decrypts them in the cluster
- [LLDAP](https://github.com/lldap/lldap): an LDAP server with a neat UI for managing user credentials & group-based access
- [Authelia](https://authelia.com): Single-Sign On provider that uses LLDAP to control access to services that don't natively support LDAP

Besides Deployments, the following other resources may also be kept here:
- Secrets containing sealed-secrets' private keys, used for decryption
- SealedSecrets and Secrets (unsealed) that are consumed by some of the Deployments listed above
- ServiceAccounts, ClusterRoles and ClusterRoleBindings that give certain access to the resources in this namespace

#### Rules & Considerations
This namespace should ***NEVER*** be exposed directly to the outside world. It must be proxied, with appropriate security in place to ensure a small attack vector. This is why some of these services could go in `starsys-system`, but don't.

RBAC resources for services that need access to data (e.g. volumes) from outside this namespace must be created within this namespace. This is a top-down approach to access, where less secure Deployments must be GIVEN access, not TAKE it.