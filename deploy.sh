docker build -t arod7ayee/multi-client:latest -t arod7ayee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arod7ayee/multi-server:latest -t arod7ayee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arod7ayee/multi-worker:latest -t arod7ayee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arod7ayee/multi-client:latest
docker push arod7ayee/multi-server:latest
docker push arod7ayee/multi-worker:latest

docker push arod7ayee/multi-client:$SHA
docker push arod7ayee/multi-server:$SHA
docker push arod7ayee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arod7ayee/multi-server:$SHA
kubectl set image deployments/client-deployment client=arod7ayee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arod7ayee/multi-worker:$SHA