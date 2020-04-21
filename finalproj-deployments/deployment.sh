echo "Create Mysql namespace"

kubectl create namespace db

kubectl -n db create secret generic mysql-root-pass --from-literal=password=root 
kubectl -n db create secret generic mysql-db-url --from-literal=database=finalproj --from-literal=url='jdbc:mysql://mysql.db.svc.cluster.local:3306/finalproj?useSSL=false&serverTimezone=UTC&useLegacyDatetimeCode=false&createDatabaseIfNotExist=true'

echo "Create Mysql pv & pvc"

kubectl create -f mysql-pv.yaml -n db

echo "Create Mysql statefulset and deployment"

kubectl create -f mysql-sts.yaml -n db

echo "Creating Backend namespace"

kubectl create namespace backend

kubectl -n backend create secret generic mysql-root-pass --from-literal=password=root 

kubectl -n backend create secret generic mysql-db-url --from-literal=database=finalproj --from-literal=url='jdbc:mysql://mysql.db.svc.cluster.local:3306/finalproj?useSSL=false&serverTimezone=UTC&useLegacyDatetimeCode=false&createDatabaseIfNotExist=true'

echo "Creating Backend Deployment"

kubectl apply -f backend-customer-dep.yaml -n backend
kubectl apply -f backend-vendor-dep.yaml -n backend

echo "Exposing Backend Service with load NodePort"

kubectl expose deployment backend-customer -n backend  --type=NodePort --port 8080 --target-port 8080

kubectl expose deployment backend-vendor -n backend  --type=NodePort --port 8080 --target-port 8080

echo "Creating frontend namespace"

kubectl create namespace frontend

kubectl apply -f frontend-react.yaml -n frontend

kubectl expose deployment frontend -n frontend  --type=LoadBalancer --port 8080 --target-port 8080

##################
helm repo add stable https://kubernetes-charts.storage.googleapis.com

kubectl create ns grafana

helm install my-prometheus-operator stable/prometheus-operator --namespace grafana

