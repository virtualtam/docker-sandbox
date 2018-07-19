FROM centos:7

RUN yum install -y epel-release \
    && yum update -y \
    && yum install -y 389-ds-base 389-adminutil \
    && yum clean all

COPY entrypoint.sh /entrypoint.sh
COPY ds-setup.inf /ds-setup.inf
COPY users.ldif /users.ldif

RUN useradd ldapadmin \
    && rm -fr /var/lock /usr/lib/systemd/system \
    # Bypass hostname check for 389-ds setup not to fail \
    && sed -i 's/checkHostname {/checkHostname {\nreturn();/g' /usr/lib64/dirsrv/perl/DSUtil.pm \
    # Disable SELinux \
    && sed -i 's/updateSelinuxPolicy($inf);//g' /usr/lib64/dirsrv/perl/* \
    # Do not restart at the end \
    && sed -i '/if (@errs = startServer($inf))/,/}/d' /usr/lib64/dirsrv/perl/* \
    && setup-ds.pl --silent --file /ds-setup.inf \
    && /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-dir \
    && sleep 10 \
    && ldapadd -H ldap:/// -f /users.ldif -x -D "cn=Directory Manager" -w password

EXPOSE 389

CMD ["/entrypoint.sh"]
