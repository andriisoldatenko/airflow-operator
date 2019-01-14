# airflow-operator

A Kubernetes Operator for Airflow that is used within the Astronomer platform.

## Add you you chart

```
wget -qO- https://storage.googleapis.com/kubernetes-charts/airflow-0.13.0.tgz | tar vxz -C ./helm-charts
```

## Build and run the operator

```
kubectl create -f deploy/crds/airflow_v1alpha1_crd.yaml --namespace andrii-dev
```

## Run as a pod inside a Kubernetes cluster

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

## Prerequisites

- git
- docker version 17.03+.
- kubectl version v1.9.0+.
- dep version v0.5.0+. (Optional if you aren't installing from source)
- go version v1.10+. (Optional if you aren't installing from source)
- Access to a kubernetes v.1.9.0+ cluster.

## Install the Operator SDK CLI

```bash
mkdir -p $GOPATH/src/github.com/operator-framework
cd $GOPATH/src/github.com/operator-framework
git clone https://github.com/operator-framework/operator-sdk
cd operator-sdk
git checkout master
make dep
# If you can see any issues, try also:
make dep-update
make install
```

Check installed version `v0.4.0`:

```
operator-sdk --version
operator-sdk version v0.4.0+git
```

## Create helm-based airflow operator project

```bash
operator-sdk new airflow-operator --api-version=example.com/v1alpha1 --kind=Airflow --type=helm
cd airflow-operator
```

## Project layout

- `deploy` - Contains a generic set of Kubernetes manifests for deploying this operator on a Kubernetes cluster.
- `helm-charts/airflow` - Contains a Helm chart initialized using the equivalent of [`helm create`](https://docs.helm.sh/helm/#helm-create) |
- `build` - Contains scripts that the operator-sdk uses for build and initialization.
- `watches.yaml` - Contains Group, Version, Kind, and Helm chart location.


## 