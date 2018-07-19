LDAP - 389 Directory Service
============================

Usage
-----

Build the LDAP image:

::

    $ docker-compose build

Create and start the containers:

::

    $ docker-compose up -d
    Creating network "docker-ldap-389ds_default" with the default driver
    Creating docker-ldap-389ds_ldap_1 ... done

Inspect LDAP logs:

::

    $ docker-compose logs -f ldap

Stop and destroy containers:

::

    $ docker-compose down

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
