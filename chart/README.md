# Code Server

Chart for ghcr.io/avp-cloud/code-server image

This chart creates:

- A PVC for persistence
- A deployment to serve IDE
- A service and ingress to serve requests, leveraging Okteto Cloud's automatic SSL endpoints for public access.
