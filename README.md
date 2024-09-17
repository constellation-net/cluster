# Constellation Manifests
This repository stores all the YAML manifests that are to be deployed to the Kubernetes cluster, and is reconciled by [FluxCD](https://fluxcd.io).

## Repository Structure
To keep things somewhat simple, there is a strict structure to the repository.

### Flux Manifests
This is a directory created directly by Flux, and is not intended to be edited. 

### Resource Directories
Each type of resource deployed to the cluster via this repository (e.g. Secrets, HelmReleases, ConfigMaps, etc) has its own directory in the repository root. This makes naming easier and much more consistent.

## Naming Conventions
There are a few rules to how files are named in this repository. These exist to keep things consistent and avoid confusion or having to rename files in the future.

### HelmReleases & Dependents
Each Helm Release file should be named after the `releaseName` within that file's manifest. Likewise, any dependent manifests (Secrets, ConfigMaps, etc) should have the exact same name. 

## Sealed Secrets
This repository relies on [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets) to encrypt Secrets in the repository. This allows the repository to be publicly available without risking the safety of API tokens, passwords and other secrets.

Unsealed secrets should be kept locally in a `secrets` directory, which is in the `.gitignore`. Before commiting changes to the repository, you should run the `seal-secrets.sh` script, which will encrypt all secrets in `secrets` and dump the SealedSecrets in `sealed-secrets`.

The public key for encrypting secrets is kept at `sealed-secrets/kubeseal.pub`. In the future, this will likely be replaced with a URL solution that supports rolling certificates.

> **NOTE:** There is a Helm Release called `sealed-secrets`. This is what deploys the service that automatically decrypts SealedSecrets and is not to be confused with the `sealed-secrets` directory, which contains a series of SealedSecret manifests. 