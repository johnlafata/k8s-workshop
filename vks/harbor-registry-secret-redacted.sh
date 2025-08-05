kubectl create secret docker-registry harbor \
  --docker-server=<your-harbor-registry-url> \
  --docker-username=<your-harbor-registry-username> \
  --docker-password=<enter-password> \
  --docker-email=<enter-email-address> -n default
