ldapsearch example
==================

Resources
---------

- `ldapsearch <https://linux.die.net/man/1/ldapsearch>`_ man page
- `Examples of Common ldapsearches
  <https://access.redhat.com/documentation/en-US/Red_Hat_Directory_Server/8.2/html/Administration_Guide/Examples-of-common-ldapsearches.html>`_
- `Finding Directory Entries-Using ldapsearch
  <https://www.centos.org/docs/5/html/CDS/ag/8.0/Finding_Directory_Entries-Using_ldapsearch.html>`_


Queries
-------

List all directory entries
~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ ldapsearch -x -b "dc=domain,dc=tld"

    # extended LDIF
    #
    # LDAPv3
    # base <dc=domain,dc=tld> with scope subtree
    # filter: (objectclass=*>`_
    # requesting: ALL
    #

    # domain.tld
    dn: dc=domain,dc=tld
    objectClass: top
    objectClass: domain
    dc: domain

    # Directory Administrators, domain.tld
    dn: cn=Directory Administrators,dc=domain,dc=tld
    objectClass: top
    objectClass: groupofuniquenames
    cn: Directory Administrators
    uniqueMember: cn=Directory Manager

    # Groups, domain.tld
    dn: ou=Groups,dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalunit
    ou: Groups

    # People, domain.tld
    dn: ou=People,dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalunit
    ou: People

    # Special Users, domain.tld
    dn: ou=Special Users,dc=domain,dc=tld
    objectClass: top
    objectClass: organizationalUnit
    ou: Special Users
    description: Special Administrative Accounts

    # Accounting Managers, Groups, domain.tld
    dn: cn=Accounting Managers,ou=Groups,dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: Accounting Managers
    ou: groups
    description: People who can manage accounting entries
    uniqueMember: cn=Directory Manager

    # HR Managers, Groups, domain.tld
    dn: cn=HR Managers,ou=Groups,dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: HR Managers
    ou: groups
    description: People who can manage HR entries
    uniqueMember: cn=Directory Manager

    # QA Managers, Groups, domain.tld
    dn: cn=QA Managers,ou=Groups,dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: QA Managers
    ou: groups
    description: People who can manage QA entries
    uniqueMember: cn=Directory Manager

    # PD Managers, Groups, domain.tld
    dn: cn=PD Managers,ou=Groups,dc=domain,dc=tld
    objectClass: top
    objectClass: groupOfUniqueNames
    cn: PD Managers
    ou: groups
    description: People who can manage engineer entries
    uniqueMember: cn=Directory Manager

    # admin, domain.tld
    dn: cn=admin,dc=domain,dc=tld
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
