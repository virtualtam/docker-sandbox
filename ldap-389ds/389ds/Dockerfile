FROM almalinux:10

RUN dnf upgrade -y \
    && dnf install -y 389-ds-base openldap-clients \
    && dnf clean all

COPY entrypoint.sh /entrypoint.sh
COPY ds-setup.inf /ds-setup.inf
COPY aci.ldif /aci.ldif
COPY users.ldif /users.ldif

RUN dscreate from-file /ds-setup.inf \
    && { /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-dir -d 0 & } \
    && timeout 30 sh -c 'until ldapsearch -x -H ldap:/// -b "" -s base >/dev/null 2>&1; do sleep 1; done' \
    && ldapmodify -H ldap:/// -f /aci.ldif -x -D "cn=Directory Manager" -w password \
    && ldapadd -H ldap:/// -f /users.ldif -x -D "cn=Directory Manager" -w password \
    && kill %1 \
    && wait

EXPOSE 389

CMD ["/entrypoint.sh"]
