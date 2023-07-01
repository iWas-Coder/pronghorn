[//]: # (Title of the project)

![logo](assets/logo.png "Pronghorn")
# Pronghorn: A fast and simple CI/CD pipeline

[//]: # (Repository badges)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![documentation](https://github.com/iWas-Coder/pronghorn/actions/workflows/docs.yaml/badge.svg)](https://github.com/iWas-Coder/pronghorn/actions/workflows/docs.yaml)
[![demo](https://github.com/iWas-Coder/pronghorn/actions/workflows/demo.yaml/badge.svg)](https://github.com/iWas-Coder/pronghorn/actions/workflows/demo.yaml)
[![CodeFactor](https://www.codefactor.io/repository/github/iwas-coder/pronghorn/badge)](https://www.codefactor.io/repository/github/iwas-coder/pronghorn)

[//]: # (README Body)

Pronghorn is a project based on the design and implementation of an automated continuous development, integration and deployment pipeline integrating a Git-based architecture.

> This work and all its documentation is licensed under the Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) License.  
> This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.  
> This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Table of Contents

- [Building](#building)
- [Infrastructure Provisioning](#infrastructure-provisioning)
  - [Development Architecture](#development-architecture)
  - [Production-ready Architecture](#production-ready-architecture)
- [CI/CD Pipeline Proposal](#cicd-pipeline-proposal)
  - [Git](#git)
  - [GitHub](#github)
  - [SonarQube](#sonarqube)
  - [Container Registry](#container-registry)
  - [Helm Charts Repository](#helm-charts-repository)
  - [Bitnami's Sealed Secrets](#bitnamis-sealed-secrets)
  - [ArgoCD](#argocd)

## Building

This project is built with GNU Make. It has a handy help panel to easily list all available make targets:
```shell
make help
```
By default, it builds all of them (`make`). Alternatively, it can be specified a set of targets and only those will get built (e.g. `make pdf`).

For more information, please check the full [INSTALL](./INSTALL) guide.

## Infrastructure Provisioning

Pronghorn offers both a development environment to work with from a local system, and a set of production-ready infrastructure bootstrapping solutions for multiple virtualization platforms as Terraform projects.

### Development Architecture

<img src="assets/docker-tornado.gif" alt="Docker" width=25%/>

(...)

### Production-ready Architecture

<img src="assets/k8s.png" alt="Kubernetes" width=25%/>

(...)


## CI/CD Pipeline Proposal

(...)

This is the flowchart for the pipeline that proposes this project:

<img src="assets/pipeline.png" alt="Pronghorn CI/CD Pipeline Proposal" width=100%/>

### Git

(...)

### GitHub

(...)

### SonarQube

(...)

### Container Registry

(...)

### Helm Charts Repository

(...)

### Bitnami's Sealed Secrets

(...)

### ArgoCD

(...)
