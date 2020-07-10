docker build -t hgcook/multi-client:latest -t hgcook/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hgcook/multi-server:latest -t hgcook/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hgcook/multi-worker:latest -t hgcook/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hgcook/multi-client:latest
docker push hgcook/multi-server:latest
docker push hgcook/multi-worker:latest

docker push hgcook/multi-client:$SHA
docker push hgcook/multi-server:$SHA
docker push hgcook/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=hgcook/multi-client:$SHA
kubectl set image deployments/server-deployment server=hgcook/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hgcook/multi-worker:$SHA