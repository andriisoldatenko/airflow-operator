# You can override vars like REPOSITORY in a local.make file
-include local.make

# Public repository for images
REPOSITORY ?= astronomerinc

# Bump this on subsequent build, reset on new version or public release. Inherit from env for CI builds
BUILD_NUMBER ?= 1

# HELM_REPOSITORY := helm.astronomer.io
GITHUB_ORG := astronomer

ASTRONOMER_VERSION ?= 0.0.1

.PHONY: build-airflow-operator
build-airflow-operator:
	operator-sdk build ${REPOSITORY}/ap-airflow-operator:${ASTRONOMER_VERSION}

.PHONY: push-airflow-operator
push-airflow-operator:
	PUSH_IMAGE=${REPOSITORY}/ap-airflow-operator \
	PUSH_TAGS="${ASTRONOMER_VERSION} latest" \
	hack/push-image