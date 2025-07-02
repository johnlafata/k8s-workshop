# Building and Running FastAPI App in Docker

```
cd app/fast-api-app/app
# on my macbook, I need to specify platform as linux/amd64
# because the image is built for linux and I am on macOS

docker build --platform linux/amd64 -t fast_api .

# you maybe able to skip the platform flag
docker build  -t fast_api .


docker run -it --rm -p 8000:8000 fast_api


docker tag fast_api harbor.lab.agi-explorer.com/library/fast_api

docker push harbor.lab.agi-explorer.com/library/fast_api 

```

## deployment
- Create deployment
##  create a deployment ( substitute your repository for harbor.lab.agi-explorer.com/library )
```
kubectl create deployment --image harbor.lab.agi-explorer.com/library/fast_api my-fast-api \
    --dry-run=client -o yaml  > deployment.yaml
```