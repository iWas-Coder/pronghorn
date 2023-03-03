[//]: # (Title of the project)

![logo](https://raw.githubusercontent.com/iWas-Coder/pronghorn/master/assets/logo.png)
# Pronghorn: A fast and simple CI/CD pipeline

[//]: # (GPLv3 License indicator)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

[//]: # (README Body)

A fast, simple, efficient and automated CI/CD pipeline.

## Building
```shell
make help
```
For more information, please check the full [INSTALL](./INSTALL) guide.

## Architecture

![docker-tornado](https://miro.medium.com/max/624/0*lSZklwNLiZrkoitK.gif)

This project provides an automated way of deploying a CI/CD pipeline to develop software. It contains both a local deployment via Docker Compose (a container orchestration tool) for development and testing purposes, and a Kubernetes aimed Namespace, Deployment, Service and Helm Chart for a production-level stage.

This is a diagram of the pipeline architecture using Docker Compose in a local machine:

![dev-architecture](https://raw.githubusercontent.com/iWas-Coder/pronghorn/master/assets/architecture.png)
