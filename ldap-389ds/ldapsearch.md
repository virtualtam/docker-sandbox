# ldapsearch example

## Resources

- [ldapsearch(1): LDAP search tool - Linux man page](https://linux.die.net/man/1/ldapsearch)
- [Examples of Common ldapsearches](https://docs.redhat.com/en/documentation/red_hat_directory_server/11/html/administration_guide/examples-of-common-ldapsearches)
- [Finding Directory Entries-Using ldapsearch](https://docs.redhat.com/en/documentation/red_hat_directory_server/11/html/administration_guide/finding_directory_entries)

## Queries

### List all directory entries

```shell
$ ldapsearch -x -H ldap://localhost:389 -b "dc=domain,dc=tld"

# extended LDIF
#
# LDAPv3
# base <dc=domain,dc=tld> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# domain.tld
dn: dc=domain,dc=tld
objectClass: top
objectClass: domain
dc: domain
description: dc=domain,dc=tld

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
objectClass: organizationalunit
ou: Special Users
description: Special Administrative Accounts

# Accounting Managers, Groups, domain.tld
dn: cn=Accounting Managers,ou=Groups,dc=domain,dc=tld
objectClass: top
objectClass: groupOfUniqueNames
objectClass: nsMemberOf
cn: Accounting Managers
description: People who can manage accounting entries
ou: groups
uniqueMember: cn=Directory Manager

# HR Managers, Groups, domain.tld
dn: cn=HR Managers,ou=Groups,dc=domain,dc=tld
objectClass: top
objectClass: groupOfUniqueNames
objectClass: nsMemberOf
cn: HR Managers
description: People who can manage HR entries
ou: groups
uniqueMember: cn=Directory Manager

# QA Managers, Groups, domain.tld
dn: cn=QA Managers,ou=Groups,dc=domain,dc=tld
objectClass: top
objectClass: groupOfUniqueNames
objectClass: nsMemberOf
cn: QA Managers
description: People who can manage QA entries
ou: groups
uniqueMember: cn=Directory Manager

# PD Managers, Groups, domain.tld
dn: cn=PD Managers,ou=Groups,dc=domain,dc=tld
objectClass: top
objectClass: groupOfUniqueNames
objectClass: nsMemberOf
cn: PD Managers
description: People who can manage engineer entries
ou: groups
uniqueMember: cn=Directory Manager

# Directory Administrators, domain.tld
dn: cn=Directory Administrators,dc=domain,dc=tld
objectClass: top
objectClass: groupOfUniqueNames
objectClass: nsMemberOf
cn: Directory Administrators
uniqueMember: cn=Directory Manager
uniqueMember: cn=admin,dc=domain,dc=tld

# admin, domain.tld
dn: cn=admin,dc=domain,dc=tld
objectClass: simpleSecurityObject
objectClass: organizationalRole
objectClass: top
cn: admin
description: LDAP administrator

# jdoe, People, domain.tld
dn: uid=jdoe,ou=People,dc=domain,dc=tld
mail: john.doe@domain.tld
uid: jdoe
givenName: John
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
sn: Doe
cn: John Doe

# jsmith, People, domain.tld
dn: uid=jsmith,ou=People,dc=domain,dc=tld
mail: john.smith@domain.tld
uid: jsmith
givenName: John
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
sn: Smith
cn: John Smith

# search result
search: 2
result: 0 Success

# numResponses: 13
# numEntries: 12
```
