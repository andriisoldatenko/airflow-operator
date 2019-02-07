# Airflow Operator

### Overview

A [Kubernetes Operator](https://coreos.com/operators/) that manages Apache Airflow, and automates tasks related to operating an Airflow cluster.

## Requirements

- git
- docker version 17.03+.
- kubectl version v1.11.3+.
- Access to a kubernetes v.1.11.3+ cluster.

## Clone Airflow Operator

```bash
git clone https://github.com/astronomer/airflow-operator.git
```

## Add airflow chart to `./helm-charts`

```
wget -qO- https://helm.astronomer.io/airflow-0.7.5.tgz | tar vxz -C ./helm-charts
```

### Build and push airflow-operator docker image (optional):

```
operator-sdk build astronomerio/airflow-operator:v0.0.2
docker push astronomerio/airflow-operator:v0.0.2
sed -i "" 's|REPLACE_IMAGE|astronomerio/airflow-operator:v0.0.1|g' deploy/operator.yaml
```

If you can see error like this:

```
zsh: command not found: operator-sdk
```
Please make sure you installed the [Operator SDK](https://github.com/operator-framework/operator-sdk/blob/master/doc/helm/user-guide.md#install-the-operator-sdk-cli) properly

## Build and run the operator

```
kubectl create -f deploy/crds/airflow_v1alpha1_crd.yaml
kubectl create -f deploy/crds/airflow_v1alpha1_cr.yaml
```

## Run as a pod inside a Kubernetes cluster

## Deploy the airflow-operator

```
kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/operator.yaml
```

```
kubectl apply -f deploy/operator.yaml
```

## Cleanup

```
kubectl delete -f deploy/crds/airflow_v1alpha1_cr.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/service_account.yaml
```

## How to deploy

```
kubectl apply -f deploy/crds/airflow_v1alpha1_cr.yaml
```

## Useful links

- [Introducing Operators](https://coreos.com/blog/introducing-operators.html)
- [Introducing the Operator Framework](https://coreos.com/blog/introducing-operator-framework)
- [Operators overview](https://coreos.com/operators/)
- [Operator SDK Samples - Helm](https://github.com/operator-framework/operator-sdk-samples/tree/master/helm)
