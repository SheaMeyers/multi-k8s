docker build -t sheameyers/multi-client:latest -t sheameyers/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sheameyers/multi-server:latest -t sheameyers/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sheameyers/multi-worker:latest -t sheameyers/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sheameyers/multi-client:latest
docker push sheameyers/multi-server:latest
docker push sheameyers/multi-worker:latest

docker push sheameyers/multi-client:$SHA
docker push sheameyers/multi-server:$SHA
docker push sheameyers/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=sheameyers/multi-server:$SHA
kubectl set image deployments/client-deployment client=sheameyers/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sheameyers/multi-worker:$SHA
