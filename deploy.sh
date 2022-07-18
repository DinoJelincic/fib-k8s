docker build -t djelin00/fib-client:latest -t djelin00/fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t djelin00/fib-server:latest -t djelin00/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t djelin00/fib-worker:latest -t djelin00/fib-worker:$SHA -f ./worker/Dockerfile ./worker
docker push djelin00/fib-client:latest
docker push djelin00/fib-server:latest
docker push djelin00/fib-worker:latest
docker push djelin00/fib-client:$SHA
docker push djelin00/fib-server:$SHA
docker push djelin00/fib-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=djelin00/fib-server:$SHA
kubectl set image deployments/client-deployment client=djelin00/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=djelin00/fib-worker:$SHA
