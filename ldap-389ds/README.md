# LDAP - 389 Directory Server

## Usage

### Starting the services

Build the custom LDAP image:

```shell
$ docker compose build
```

Pull service images from Docker Hub:

```shell
$ docker compose pull
```

Create and start the containers:

```shell
$ docker compose up -d
```

This will start the following services:

| Service                 | Description                                                                | Address                |
|-------------------------|----------------------------------------------------------------------------|------------------------|
| `ldap`                  | 389 Directory Server LDAP directory with pre-configured users              | `ldap://localhost:389` |
| `phpldapadmin`          | phpLDAPadmin web-based LDAP browser to manage LDAP data                    | http://localhost:14080 |
| `self-service-password` | Self-Service Password (SSP) web service for users to change their password | http://localhost:14081 |

The following accounts are available (see [users.ldif](389ds/users.ldif)):

| DN                                      | Password       | Usage                                                   |
|-----------------------------------------|----------------|---------------------------------------------------------|
| `cn=Directory Manager`                  | `password`     | LDAP root account, used by SSP to look up users         |
| `cn=admin,dc=domain,dc=tld`             | `password`     | Directory administrator, used to log in to phpLDAPadmin |
| `uid=jdoe,ou=People,dc=domain,dc=tld`   | `password1234` | User, can change their password with SSP                |
| `uid=jsmith,ou=People,dc=domain,dc=tld` | `password7895` | User, can change their password with SSP                |

Inspect LDAP logs:

```shell
$ docker compose logs -f ldap
```

### Cleanup

To stop all services:

```shell
$ docker compose down
```

## Resources

### 389 Directory Server

Documentation:

- [389 Directory Server - Main Page](https://www.port389.org/)
- [GitHub - 389ds/389-ds-base: The enterprise-class Open Source LDAP server for Linux](https://github.com/389ds/389-ds-base)
- [Red Hat Directory Server 12](https://docs.redhat.com/en/documentation/red_hat_directory_server/12)
- [Installing Red Hat Directory Server](https://docs.redhat.com/en/documentation/red_hat_directory_server/12/html/installing_red_hat_directory_server/index)
- [Importing and exporting data](https://docs.redhat.com/en/documentation/red_hat_directory_server/12/html/importing_and_exporting_data/index)

Sample entries versions:

- https://github.com/389ds/389-ds-base/blob/main/src/lib389/lib389/configurations/__init__.py

### phpLDAPadmin

Documentation:

- [phpLDAPadmin](https://phpldapadmin.org/)
- [Configuration Variables](https://github.com/leenooks/phpLDAPadmin/wiki/Configuration-Variables)

Docker image:

- [phpldapadmin/phpldapadmin](https://hub.docker.com/r/phpldapadmin/phpldapadmin)

### Self-Service Password

Documentation:

- [Self Service Password](https://ltb-project.org/documentation/self-service-password.html)
- [LDAP Tool Box Self Service Password documentation](https://self-service-password.readthedocs.io/en/stable/)
- [General Parameters](https://self-service-password.readthedocs.io/en/stable/config_general.html)

Docker image:

- [ltbproject/self-service-password](https://hub.docker.com/r/ltbproject/self-service-password)

## Testing

To verify the LDAP server is running and contains entries, a query
can be made using the `ldapsearch` utility:

```shell
$ ldapsearch -x -H ldap://localhost:389 -b "dc=domain,dc=tld" "(uid=jdoe)" cn mail

# extended LDIF
#
# LDAPv3
# base <dc=domain,dc=tld> with scope subtree
# filter: (uid=jdoe)
# requesting: cn mail
#

# jdoe, People, domain.tld
dn: uid=jdoe,ou=People,dc=domain,dc=tld
cn: John Doe
mail: john.doe@domain.tld

# search result
search: 2
result: 0 Success

# numResponses: 2
# numEntries: 1
```

See [ldapsearch.md](ldapsearch.md) for more queries.
