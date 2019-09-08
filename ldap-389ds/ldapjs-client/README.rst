ldapjs example
==============

Resources
---------

- `ldapjs <http://ldapjs.org>`_
- `Client API <http://ldapjs.org/client.html>`_
- `ldapjs: A reprise of LDAP <https://nodejs.org/en/blog/uncategorized/ldapjs-a-reprise-of-ldap/>`_

Client usage
------------

Install dependencies from NPM:

::

    $ npm install


Run the example client:

::

    $ npm run-script ldap-search -- -h

    > ldapjs-client@1.0.0 ldap-search /home/virtualtam/dev/docker/docker-sandbox/ldap-389ds/ldapjs-client
    > node client.js "-h"

    Usage: client [options]

    Options:
      -V, --version              output the version number
      -u, --username <username>  Username (default: "jdoe")
      -h, --help                 output usage information

::

    $ npm run-script ldap-search -- --username jsmith

    > ldapjs-client@1.0.0 ldap-search /home/virtualtam/dev/docker/docker-sandbox/ldap-389ds/ldapjs-client
    > node client.js "--username" "jsmith"

    entry: {
      "dn": "uid=jsmith,ou=People,dc=domain,dc=tld",
      "controls": [],
      "sn": "Smith",
      "cn": "John Smith",
      "objectClass": [
        "top",
        "person",
        "organizationalPerson",
        "inetorgperson"
      ]
    }
    status: 0
