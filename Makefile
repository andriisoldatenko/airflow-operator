# You can override vars like REPOSITORY in a local.make file
-include local.make

# Public repository for images
REPOSITORY ?= astronomerinc

# Bump this on subsequent build, reset on new version or public release. Inherit from env for CI builds
BUILD_NUMBER ?= 1

# HELM_REPOSITORY := helm.astronomer.io
GITHUB_ORG := astronomer

ASTRONOMER_AIRFLOW_OPERATOR_VERSION ?= 0.0.1

.PHONY: build-airflow-operator
build-airflow-operator:
	operator-sdk build astronomerio/airflow-operator:0.0.1

.PHONY: push-airflow-operator
push-airflow-operator:
	PUSH_IMAGE=${REPOSITORY}/ap-$${component} \
	PUSH_TAGS="${ASTRONOMER_VERSION} latest" \
	docker push ${PUSH_IMAGE} || exit 1