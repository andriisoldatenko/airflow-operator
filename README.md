# Airflow operator

### Overview

The airflow operator manages apache airflow deployed to [Kubernetes] and automates tasks related to operating an airflow cluster.

## Requirements

- git
- docker version 17.03+.
- kubectl version v1.11.3+.
- Access to a kubernetes v.1.11.3+ cluster.


## Clone airflow operator

```bash
git clone https://github.com/astronomer/airflow-operator.git
```

## Add airflow chart to `./helm-charts`

```
wget -qO- https://helm.astronomer.io/airflow-0.7.5.tgz | tar vxz -C ./helm-charts
```

## Build and run the operator

```
kubectl create -f deploy/crds/airflow_v1alpha1_crd.yaml
```

## Run as a pod inside a Kubernetes cluster


### Build and push airflow-operator docker image (optional):

```
operator-sdk build astronomerio/airflow-operator:v0.0.1
docker push astronomerio/airflow-operator:v0.0.1
sed -i "" 's|REPLACE_IMAGE|astronomerio/airflow-operator:v0.0.1|g' deploy/operator.yaml
```


## Deploy the airflow-operator

```
kubectl create -f deploy/service_account.yaml --namespace andrii-dev
kubectl create -f deploy/role.yaml --namespace andrii-dev
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/operator.yaml
```


## Cleanup

```
kubectl delete -f deploy/crds/example_v1alpha1_airflow_cr.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/service_account.yaml
kubectl delete -f deploy/crds/example_v1alpha1_nginx_cr.yaml
```


## Useful links

- [Introducing Operators](https://coreos.com/blog/introducing-operators.html)
- [Introducing the Operator Framework](https://coreos.com/blog/introducing-operator-framework)
- [Operators overview](https://coreos.com/operators/)
- [Operator SDK Samples - Helm](https://github.com/operator-framework/operator-sdk-samples/tree/master/helm)