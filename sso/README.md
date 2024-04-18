# Zitadel SSO
## Overview
This Docker Compose configuration will run:

- a Zitadel Single Sign-On (SSO) provider
- a CockroachDB database to store Zitadel configuration

Zitadel will provide:

- Identity and Access Management (IAM) to manage:
    - organizations
    - projects
    - roles
    - users
- OAuth2 / OIDC for applications to sign in users

To play with SSO, we will run:

- a Gitea Git server
- a PostgreSQL database to store Gitea configuration

All services will be run in development mode with:

- high availability disabled
- TLS encryption disabled

## Configuration
### `/etc/hosts`
We will access services using a local fully qualified domain name (FQDN):

- Gitea will be available at `http://gitea.docker:3000` and `ssh git@gitea.docker -p 3022`
- Zitadel will be vailable at `http://zitadel.docker:8080`

This is required to properly setup:

- Zitadel as an OAuth2 authentication provider for Gitea
- the Gitea `redirect_uri` URL to redirect users to the Gitea application upon successfully
  logging in via Zitadel

Add the following lines to `/etc/hosts`:

```
127.0.10.1  gitea.docker
127.0.10.1  zitadel.docker
```

### SSO option 1: Manual configuration
#### Services
Start the services with Docker Compose:

```shell
$ docker compose up -d
```

#### Zitadel configuration
Login to Zitadel:

1. Go to `http://zitadel.docker:8080/ui/login/`
2. Login as the default administrator account:
    1. Loginname: `zitadel-admin@zitadel.zitadel.docker`
    2. Password: `Password1!`
3. You will be asked to update the administrator user's password


Create a project and application for Gitea :

1. Create a new `DevTools` project
2. In the `DevTools` project, create a `Gitea` application:
    1. Name: `Gitea`
    2. Type: `Web`
    3. `Continue`
    4. Authentication Method: `Code`
    5. `Continue`
    6. Redirect URIs: `http://gitea.docker:3000/user/oauth2/zitadel/callback`
    7. Post Logout URIs: `http://gitea.docker:3000/user/oauth2/zitadel/callback`
    8. `Continue`
    9. `Create`
    10. Note the `ClientId` and `ClientSecret` information (we will use it when configuring Gitea)

#### Gitea configuration
Access the Gitea first-time setup form:

1. Go to `http://gitea.docker:3000`
2. Expand the `Administrator Account`
    1. Configure the initial administrator account
3. Validate the configuration
4. Add a new authentication source: `http://gitea.docker:3000/admin/auths/new`
    1. Type: OAuth2
    2. Name: `zitadel`
    3. Oauth2 Provider: `OpenID Connect`
    4. Client ID & Client Secret: paste the credentials generated in Zitadel (step 2.10)
    5. OpenID Connect Auto Discovery URL: `http://zitadel.docker:8080/.well-known/openid-configuration`
    6. Save authentication source configuration

#### Create a user in Zitadel for usage in Gitea
1. Go to `http://zitadel.docker:8080/ui/console/users/create`
2. Fill user information, e.g.:
    1. Email: `jane.doe@zitadel.docker`
    2. User Name: `janedoe`
    3. Given Name: `Jane`
    4. Family Name: `Doe`
    5. Email Verified: yes
    6. Set Initial Password (this will need to be updated at first login)
    7. Create
3. In the `Authorizations` section for the new user:
    1. Click `New`
    2. Select the `DevTools` project
    3. Continue
    4. (Leave the `Roles` section empty for now)
    5. Save

#### Login to Gitea
1. Open a new private window or another browser (as we are already logged as the Zitadel admin)
2. Open `http://gitea.docker:3000/user/login`
3. Select `Sign in with zitadel`
    1. Login name: `jane.doe@zitadel.docker`
    2. Password: the initial password set for this user
4. Skip two-factor setup
5. Change user password
6. Next
7. Complete Gitea account creation
    1. Username: `janedoe`
    2. Email: `jane.doe@zitadel.docker`

### SSO option 2: Infrastructure-as-code with Terraform
TODO :)


## Resources
### Zitadel
- [Zitadel](https://zitadel.com/)
- [Set up ZITADEL with Docker Compose](https://zitadel.com/docs/self-hosting/deploy/compose)
- [Run ZITADEL on a (Sub)domain of Your Choice](https://zitadel.com/docs/self-hosting/manage/custom-domain)
- [Zitadel Database Configuration](https://zitadel.com/docs/self-hosting/manage/database)
- [Zitadel Configuration Options](https://zitadel.com/docs/self-hosting/manage/configure)
- [Zitadel Releases](https://github.com/zitadel/zitadel/releases)
- [Zitadel Production Setup](https://zitadel.com/docs/self-hosting/manage/production)
- [Zitadel Production Checklist](https://zitadel.com/docs/self-hosting/manage/productionchecklist)
- [Zitadel Terraform Provider](https://zitadel.com/docs/guides/manage/terraform/basics)
- [Update and Scale Zitadel](https://zitadel.com/docs/self-hosting/manage/updating_scaling)

### Gitea
- [Installation with Docker](https://docs.gitea.com/installation/install-with-docker)
- [Configuration Cheat Sheet](https://docs.gitea.com/administration/config-cheat-sheet)
- [go-gitea/gitea#4350 - Single Sign-On with OAuth2 provider (Keycloak) is not login single sign-on](https://github.com/go-gitea/gitea/issues/4350)
- [go-gitea/gitea#10016 - Make use of roles when using OIDC](https://github.com/go-gitea/gitea/issues/10016)
- [go-gitea/gitea#21376 - Implement PKCE for OpenID Connect](https://github.com/go-gitea/gitea/issues/21376)

### OAuth2
- [RFC 6749 - The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)
- [RFC 7636 - Proof Key for Code Exchange by OAuth Public Clients](https://datatracker.ietf.org/doc/html/rfc7636) (PKCE)
