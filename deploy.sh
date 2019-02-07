docker build -t bird5555/multi-client:latest -t bird5555/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bird5555/multi-server:latest -t bird5555/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bird5555/multi-worker:latest -t bird5555/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bird5555/multi-client:latest
docker push bird5555/multi-server:latest
docker push bird5555/multi-worker:latest

docker push bird5555/multi-client:$SHA
docker push bird5555/multi-server:$SHA
docker push bird5555/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/multi-client-deployment client=bird5555/multi-client:$SHA
kubectl set image deployment/multi-server-deployment client=bird5555/multi-server:$SHA
kubectl set image deployment/multi-worker-deployment client=bird5555/multi-worker:$SHA

