docker build -t blee1979/multi-client:latest -t blee1979/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t blee1979/multi-server:latest -t blee1979/multi-server:$SHA -f ./server/Docerrfile ./server
docker build -t blee1979/multi-worker:latest -t blee1979/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push blee1979/multi-client:latest
docker push blee1979/multi-server:latest
docker push blee1979/multi-worker:latest

docker push blee1979/multi-client:$SHA
docker push blee1979/multi-server:$SHA
docker push blee1979/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=blee1979/multi-server:$SHA
kubectl set image deployments/client-deployment client=blee1979/multi-client:$SHA
kubectl set image deployment/worker-deployment  worker=blee1979/multi-worker:$SHA