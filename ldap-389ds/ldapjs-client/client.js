/**
 * Example NodeJS LDAP client
 */
const assert = require('assert');
const ldap = require('ldapjs');
const program = require('commander');

// LDAP directory connection settings
const ldapUrl = 'ldap://127.0.0.1:389';
const baseDn = 'dc=domain,dc=tld';

// Account used to bind to the LDAP directory
// Leave empty for anonymous bind
const bindDn = '';
const bindPassword = '';

/**
 * Search a user in the directory using her/his username (uid attribute)
 *
 * Search results are pretty-printed to the console
 *
 * @param client   LDAP client
 * @param baseDn   Base DN for LDAP searches
 * @param username Username to look for in the directory
 */
function searchUser(client, baseDn, username) {
    // Example LDAP search filter
    let opts = {
        filter: '(&(objectClass=person)(uid=' + username + '))',
        scope: 'sub',
        attributes: ['dn', 'sn', 'cn', 'objectClass']
    };

    client.search(baseDn, opts, function(err, res) {
        assert.ifError(err);

        res.on('searchEntry', function(entry) {
            console.log('entry: ' + JSON.stringify(entry.object, null, 2));
        });
        res.on('searchReference', function(referral) {
            console.log('referral: ' + referral.uris.join());
        });
        res.on('error', function(err) {
            console.error('error: ' + err.message);
            client.unbind(function(err) {
                assert.ifError(err);
            });
        });
        res.on('end', function(result) {
            console.log('status: ' + result.status);
            client.unbind(function(err) {
                assert.ifError(err);
            });
        });
    });
}

/**
 * Main function
 */
function main() {
    program
        .version('1.0.0')
        .option('-u, --username <username>', 'Username', 'jdoe')
        .parse(process.argv);

    // Connect to the LDAP directory server
    let client = ldap.createClient({
        url: ldapUrl,
    });

    // Anonymous bind
    client.bind(bindDn, bindPassword, function(err) {
        assert.ifError(err);
    });

    searchUser(client, baseDn, program.username);
}

main();
