SECRETS=$(find . -name "secret*.yaml")

for f in $SECRETS; do 
    echo "Sealing $f"
    kubeseal --cert http://192.168.1.118:8080/v1/cert.pem --allow-empty-data --format yaml < $f > $(dirname -- "$f")/sealed-$(basename "$f")
done