LDAP - 389 Directory Service
============================

Usage
-----

Starting the services
~~~~~~~~~~~~~~~~~~~~~

Build the custom LDAP image:

::

    $ docker-compose build


Pull service images from Docker Hub:

::

    $ docker-compose pull

Create and start the containers:

::

    $ docker-compose up -d

    Creating network "ldap-389ds_ldap" with the default driver
    Creating ldap-389ds_ldap_1                  ... done
    Creating ldap-389ds_phpldapadmin_1          ... done
    Creating ldap-389ds_self-service-password_1 ... done


This will start the following services:

- a 389 Directory Service LDAP directory with pre-configured users (see LDIF
  files);
- a phpLDAPadmin web-based LDAP browser to manage LDAP data,
- a Self-Service Password (SSP) web service for users to reset their password.

Inspect LDAP logs:

::

    $ docker-compose logs -f ldap


Cleanup
~~~~~~~

To stop all services:

::

    $ docker-compose down

Resources
---------

389 Directory Service
~~~~~~~~~~~~~~~~~~~~~

Documentation:

- https://directory.fedoraproject.org/index.html
- https://directory.fedoraproject.org/docs/389ds/howto/quickstart.html
- https://access.redhat.com/documentation/en-us/Red_Hat_Directory_Server/10/
- https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/deployment_guide/index
- https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/installation_guide/index
- https://access.redhat.com/documentation/en-us/red_hat_directory_server/10/html/administration_guide/index

phpLDAPadmin
~~~~~~~~~~~~

Documentation:

- http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page
- http://phpldapadmin.sourceforge.net/wiki/index.php/Config.php
- http://phpldapadmin.sourceforge.net/function-ref/1.2/

Docker image:

- https://github.com/osixia/docker-phpLDAPadmin

Self-Service Password
~~~~~~~~~~~~~~~~~~~~~

Documentation:

- https://ltb-project.org/documentation/self-service-password/latest/start
- https://ltb-project.org/documentation/self-service-password/latest/config_general
- https://ltb-project.org/documentation/self-service-password/latest/config_ldap

Docker image:

- https://github.com/tiredofit/docker-self-service-password

Testing
-------

To verify the LDAP server is running and contains entries, a query
can be made using the ``ldapsearch`` utility:

::

    $ ldapsearch -x -b "dc=domain,dc=tld"

    # extended LDIF
    #
    # LDAPv3
    # base <dc=domain,dc=tld> with scope subtree
    # filter: (objectclass=*)
    # requesting: ALL
    #

    # domain.tld
    dn: dc=dc=domain,dc=tld
    objectClass: top
    objectClass: domain
    dc: domain

    # Directory Administrators, domain.tld
    dn: cn=Directory Administrators,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: groupofuniquenames
    cn: Directory Administrators
    uniqueMember: cn=Directory Manager

    # Groups, domain.tld
    dn: ou=Groups,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalunit
    ou: Groups

    # People, domain.tld
    dn: ou=People,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalunit
    ou: People

    # Special Users, domain.tld
    dn: ou=Special Users,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalUnit
    ou: Special Users
    description: Special Administrative Accounts

    # Accounting Managers, Groups, domain.tld
    dn: cn=Accounting Managers,ou=Groups,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: Accounting Managers
    ou: groups
    description: People who can manage accounting entries
    uniqueMember: cn=Directory Manager

    # HR Managers, Groups, domain.tld
    dn: cn=HR Managers,ou=Groups,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: HR Managers
    ou: groups
    description: People who can manage HR entries
    uniqueMember: cn=Directory Manager

    # QA Managers, Groups, domain.tld
    dn: cn=QA Managers,ou=Groups,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: QA Managers
    ou: groups
    description: People who can manage QA entries
    uniqueMember: cn=Directory Manager

    # PD Managers, Groups, domain.tld
    dn: cn=PD Managers,ou=Groups,dc=dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: PD Managers
    ou: groups
    description: People who can manage engineer entries
    uniqueMember: cn=Directory Manager

    # admin, domain.tld
    dn: cn=admin,dc=dc=domain,dc=tld
    objectClass: simpleSecurityObject
    objectClass: organizationalRole
    objectClass: top
    cn: admin
    description: LDAP administrator

    # search result
    search: 2
    result: 0 Success

    # numResponses: 11
    # numEntries: 10
