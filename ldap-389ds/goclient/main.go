package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/go-ldap/ldap/v3"
)

const (
	ldapURL = "ldap://127.0.0.1:389"
	baseDN  = "dc=domain,dc=tld"
)

func userFilter(username string) string {
	return fmt.Sprintf("(&(objectClass=person)(uid=%s))", ldap.EscapeFilter(username))
}

func main() {
	username := flag.String("username", "jdoe", "Username (uid attribute) to look for in the directory")
	flag.Parse()

	conn, err := ldap.DialURL(ldapURL)
	if err != nil {
		log.Fatalf("failed to connect to %s: %s", ldapURL, err)
	}
	defer conn.Close()

	if err := conn.UnauthenticatedBind(""); err != nil {
		log.Fatalf("failed to bind anonymously: %s", err)
	}

	searchRequest := ldap.NewSearchRequest(
		baseDN,
		ldap.ScopeWholeSubtree, ldap.NeverDerefAliases, 0, 0, false,
		userFilter(*username),
		[]string{"sn", "cn", "objectClass"},
		nil,
	)

	result, err := conn.Search(searchRequest)
	if err != nil {
		log.Fatalf("failed to search for %q: %s", *username, err)
	}

	for _, entry := range result.Entries {
		entry.PrettyPrint(0)
	}
}
