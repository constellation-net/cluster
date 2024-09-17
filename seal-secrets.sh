#!/bin/bash
for filename in ./secrets/*.yml; do
    echo $(kubeseal --cert ./secrets/kubeseal.pub --secret-file ./secrets/$(basename filename).yml --format yaml --sealed-secret-file ./sealed-secrets/$(basename $filename).yml --validate)
done