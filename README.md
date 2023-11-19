# Dashpool - HELM

Helm charts to setup dashpool


| Service   | Build Status | Latest Docker Tag |
|-----------|--------------|-------------------|
| Frontend  | [![Frontend Build Status](https://github.com/dashpool/frontend/actions/workflows/build.yml/badge.svg)](https://github.com/dashpool/frontend/actions/workflows/build.yml) | [![Docker Frontend Image](https://img.shields.io/docker/v/dashpool/frontend?sort=semver)](https://hub.docker.com/r/dashpool/frontend/tags) |
| Backend   | [![Backend Build Status](https://github.com/dashpool/backend/actions/workflows/build.yml/badge.svg)](https://github.com/dashpool/backend/actions/workflows/build.yml) | [![Docker Backend Image](https://img.shields.io/docker/v/dashpool/backend?sort=semver)](https://hub.docker.com/r/dashpool/backend/tags) |
| Admin     | [![Admin Build Status](https://github.com/dashpool/admin/actions/workflows/docker.yml/badge.svg)](https://github.com/dashpool/admin/actions/workflows/docker.yml) | [![Docker Admin Image](https://img.shields.io/docker/v/dashpool/admin?sort=semver)](https://hub.docker.com/r/dashpool/admin/tags) |
| ExampleApp| [![ExampleApp Build Status](https://github.com/dashpool/exampleapp/actions/workflows/build.yml/badge.svg)](https://github.com/dashpool/exampleapp/actions/workflows/build.yml) | [![Docker ExampleApp Image](https://img.shields.io/docker/v/dashpool/exampleapp?sort=semver)](https://hub.docker.com/r/dashpool/exampleapp/tags) |


## Setup

```
helm repo add dashpool https://dashpool.github.io/helm 
helm repo update

helm install [-f myvalues.yaml] dashpool dashpool/dashpool
```

**A typical setup might look like:** myvalues.yaml
```
components:
  mongo: false
  ingress: true
  dashboard: false
  metrics: true

server:
  ports:
    extra: 9911

system:
  crt: ????????????????
  key: ????????????????
  mongohost: mongodb://???:???@???:27017
  dashpooldb: testdb

auth:
  skip: false
  clientId: ???????-????-????-????-????????????
  clientSecret: ????????????????????????????????????
  tenant: ??????-????-????-????-???????????
  cookieSecret: ?????????????????????????????????

  adminAuth: allowed_emails=???,???
  userAuth: allowed_groups=???????-????-????-????-?????????????
```

## Parameters
### Components
Select components you want to install (**mongo**, **ingress**, **dashboard**, **metrics**).
External components can replace internal setup.

### Namespaces
 * **apps**: (*default* dashpool-apps) dash apps will be here
 * **system**: (*default* dashpool-system) system apps will be here
 * **ingress**: (*default* dashpool-ingress) space for traefik

### Server
 * **ports**: Ports for all web, secure, admin, ...
 * **externalIPs**: External IPs of the server

### System
 * **appName**: (*default* dashpool)
 * **admin**: (*default* dashpool-user)
 * **cet** and **key** for tls
 * **mongohost**: (*default* mongodb://mongo.dashpool-system:27017)
 * **dashpooldb**: (*default* dashpool) name of the db in mongo
 * **docker**: secrets to pull private repos

### Crons
  * **adminUpdate**: (*default* '"*/5 * * * *"') update apps and track usage
  * **dbClean**: (*default* '"0 0 * * *"') MongoDB cleanup

### Auth
 * **skip** (*default* true) for local testing without auth
 * **clientId**, **clientSecret**, **tenant**, **cookieSecret** for Azure AD
 * **adminAuth** for the admin section (*e.g.* allowed_emails=admin@dashpool.com)
 * **userAuth** for the user logins (*e.g.* allowed_groups=?????-????-????-??????????)


### Local testing
```
helm install -f myvalues.yaml dashpool .
kubectl describe secret admin-token -n dashpool-system

helm upgrade -f myvalues.yaml dashpool .

helm uninstall dashpool
```

