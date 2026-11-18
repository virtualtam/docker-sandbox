# go-ldap example

Example Go client using the [go-ldap](https://github.com/go-ldap/ldap) library, that searches the directory
for a user by username (`uid` attribute) with an anonymous bind.

## Resources

- [go-ldap](https://github.com/go-ldap/ldap)
- [API reference](https://pkg.go.dev/github.com/go-ldap/ldap/v3)

## Client usage

Show usage:

```shell
$ go run . -h

Usage of /tmp/go-build.../exe/goclient:
  -username string
        Username (uid attribute) to look for in the directory (default "jdoe")
```

Search for a user:

```shell
$ go run . -username jsmith

DN: uid=jsmith,ou=People,dc=domain,dc=tld
  sn: [Smith]
  cn: [John Smith]
  objectClass: [top person organizationalPerson inetorgperson]
```

Run the tests:

```shell
$ go test ./...
```
