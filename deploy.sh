docker build -t aenache/multi-client:latest -t aenache/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aenache/multi-server:latest -t aenache/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aenache/multi-worker:latest -t aenache/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aenache/multi-client:latest
docker push aenache/multi-server:latest
docker push aenache/multi-worker:latest

docker push aenache/multi-client:$SHA
docker push aenache/multi-server:$SHA
docker push aenache/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=aenache/multi-client:$SHA
kubectl set image deployments/server-deployment server=aenache/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aenache/multi-worker:$SHA