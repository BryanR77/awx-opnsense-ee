# awx-opnsense-ee

[![Build and publish](https://github.com/BryanR77/awx-opnsense-ee/actions/workflows/publish.yml/badge.svg)](https://github.com/BryanR77/awx-opnsense-ee/actions/workflows/publish.yml)

An Ansible Execution Environment (EE) for AWX integration with OPNsense.

## Overview

This repository builds a custom Ansible Execution Environment image that includes the necessary OPNsense integration components. Images are automatically built and published to GitHub Container Registry on every push to `main`.

## Repository Structure

- `execution-environment.yml` - Ansible Builder configuration defining the EE image contents
- `requirements.yml` - Ansible Galaxy collections required by the EE
- `.github/workflows/publish.yml` - GitHub Actions workflow for building and publishing

## Image Details

- **Base Image:** Rocky Linux 9 (`quay.io/rockylinux/rockylinux:9`)
- **Published Registry:** GitHub Container Registry (GHCR)
- **Latest Tag:** `ghcr.io/bryanr77/awx-opnsense-ee:latest`
- **Commit-tagged:** `ghcr.io/bryanr77/awx-opnsense-ee:<commit-sha>`

## Building Locally

To build the execution environment locally:

```bash
# Install ansible-builder
pip install ansible-builder

# Build the EE image
ansible-builder build \
  --tag ghcr.io/bryanr77/awx-opnsense-ee:latest \
  --file execution-environment.yml
```

To push to GHCR:

```bash
# Login to GHCR
docker login ghcr.io -u <username> -p <personal-access-token>

# Tag and push
docker push ghcr.io/bryanr77/awx-opnsense-ee:latest
```

## Automated Publishing

Images are automatically built and published via GitHub Actions when changes are pushed to `main` or when manually triggered via workflow dispatch. The workflow:

1. Installs `ansible-builder`
2. Builds the execution environment image
3. Tags with commit SHA
4. Pushes to GHCR
