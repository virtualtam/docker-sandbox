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

    $ yarn install

    yarn install v1.7.0
    [1/4] Resolving packages...
    [2/4] Fetching packages...
    [3/4] Linking dependencies...
    [4/4] Building fresh packages...
    Done in 4.01s.

    Run the example client:

::

    $ yarn ldap-search -h

    yarn run v1.7.0
    $ node client.js -h

      Usage: client [options]

      Options:

        -V, --version              output the version number
        -u, --username <username>  Username (default: jdoe)
        -h, --help                 output usage information
    Done in 0.21s.

::

    $ yarn ldap-search --username jsmith

    yarn run v1.7.0
    $ node client.js --username jsmith
    entry: {
      "dn": "uid=jsmith,ou=People,dc=domain,dc=tld",
      "controls": [],
      "sn": "Doe",
      "cn": "John Smith",
      "objectClass": [
        "top",
        "person",
        "organizationalPerson",
        "inetorgperson"
      ]
    }
    status: 0
    Done in 0.48s.
