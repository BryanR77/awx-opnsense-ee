# awx-opnsense-ee

[![Build and publish](https://github.com/BryanR77/awx-opnsense-ee/actions/workflows/publish.yml/badge.svg)](https://github.com/BryanR77/awx-opnsense-ee/actions/workflows/publish.yml)

This repository builds an Ansible Execution Environment (EE) for AWX integration with OPNsense. The project was migrated from GitLab CI to GitHub Actions and publishes images to GitHub Container Registry (GHCR).

**Repository layout**
- `Dockerfile`: builder image that runs `ansible-builder` to produce the EE image.
- `execution-environment.yml`: `ansible-builder` definition for the EE.
- `requirements.yml`: Ansible Galaxy collections used by the EE.
- `.github/workflows/publish.yml`: GitHub Actions workflow that builds and pushes to GHCR.

**Image names**
- Latest tag: `ghcr.io/bryanr77/awx-opnsense-ee:latest`
- Commit-tagged image: `ghcr.io/bryanr77/awx-opnsense-ee:<commit-sha>`

**Publishing via GitHub Actions**

The included workflow (`.github/workflows/publish.yml`) is triggered on pushes to `main` and via manual `workflow_dispatch`.

It performs these steps:
- Builds a builder image from the repository `Dockerfile` using `quay.io/rockylinux/rockylinux:9` as the `IMAGE` build-arg.
- Runs the builder container (mounting the host Docker socket) to run `ansible-builder build` and create the final EE image.
- Tags and pushes the image(s) to `ghcr.io`.

Permissions and tokens
- The workflow uses the repository `GITHUB_TOKEN` and requires the Actions permission to publish packages. By default `GITHUB_TOKEN` has `packages: write` for repository-level publishing; verify organization policies if publishing to an organization registry.
- If your organization restricts `GITHUB_TOKEN` package write access, create a Personal Access Token (PAT) with `write:packages` and add it to the repo secrets (example name: `GHCR_PAT`). Then update the workflow login step to use that secret.

Local testing
You can replicate the workflow locally. From the repository root (zsh):

```bash
# Build the builder image
docker build --pull --build-arg IMAGE=quay.io/rockylinux/rockylinux:9 -t awx-opnsense-ee-builder:latest .

# Run the builder to create the final image
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock awx-opnsense-ee-builder:latest -t ghcr.io/bryanr77/awx-opnsense-ee:latest

# After logging in to ghcr (docker login ghcr.io -u <user> -p <token>):
docker tag ghcr.io/bryanr77/awx-opnsense-ee:latest ghcr.io/bryanr77/awx-opnsense-ee:$(git rev-parse --short HEAD)
docker push ghcr.io/bryanr77/awx-opnsense-ee:latest
docker push ghcr.io/bryanr77/awx-opnsense-ee:$(git rev-parse --short HEAD)
```

Notes and recommendations
- If you prefer to disable the old GitLab CI config to avoid accidental runs, I can rename `,gitlab-ci.yaml` to `,gitlab-ci.yaml.disabled` or move it to an `.archive/` folder — tell me which you prefer.
- If you want a workflow badge added to this `README.md`, tell me and I will add one.

If you'd like, I can also:
- Add a GitHub Actions badge to this README.
- Archive or remove the `,gitlab-ci.yaml` file.
- Update the workflow to use a PAT instead of `GITHUB_TOKEN` and add explanatory comments.

---
Generated: GitHub Actions migration for GHCR publishing.
