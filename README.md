# Manage `couchdb`

## Description
This module manages `couchdb`. It installs the package and manages the file `/etc/couchdb/local.ini` which is created from a template.

## Parameters

- ip - the IP address that couchdb will bind to
- port - the port that couchdb should use

## Usage

### couchdb
Install `couchdb` and bind it to the default IP address 127.0.0.1 and the default port 5984.

    include couchdb

Install `couchdb` and bind it to the given IP address.

    class { 'couchdb':
      ip   => '192.168.170.150',
      port => '5987',
    }

## Authors

[Vinícius Teles](https://github.com/viniciusteles)

## License

This Puppet module is released under the MIT license:

* http://opensource.org/licenses/MIT
