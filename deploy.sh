docker build -t spencerwang/multi-client:latest -t spencerwang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spencerwang/multi-server:latest -t spencerwang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t spencerwang/multi-worker:latest -t spencerwang/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push spencerwang/multi-client:latest
docker push spencerwang/multi-server:latest
docker push spencerwang/multi-worker:latest

docker push spencerwang/multi-client:$SHA
docker push spencerwang/multi-server:$SHA
docker push spencerwang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=spencerwang/multi-server:$SHA
kubectl set image deployment/client-deployment client=spencerwang/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=spencerwang/multi-worker:$SHA