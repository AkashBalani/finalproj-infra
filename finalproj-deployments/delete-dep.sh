
kubectl delete secret mysql-root-pass -n db

kubectl delete secret mysql-db-url -n db


kubectl delete secret mysql-root-pass -n db

kubectl delete secret mysql-db-url -n db

echo "delete Mysql statefulset and deployment"

kubectl delete -f mysql-sts.yaml -n db


kubectl delete -f mysql-pv.yaml -n db

echo "Creating Backend Deployment"

kubectl delete -f backend-customer-dep.yaml -n backend
kubectl delete -f backend-vendor-dep.yaml -n backend

echo "Exposing Backend Service with load NodePort"

kubectl delete svc backend-customer -n backend

kubectl delete svc backend-vendor -n backend 
