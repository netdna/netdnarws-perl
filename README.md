# NetDNA REST Web Services Perl Client

## Requirements (open cpan)

install JSON
install Net::OAuth;
install LWP::UserAgent;
install URI;
install Data::Dumper;
install IO::Socket::SSL
install LWP::Protocol::https

## Installation
wget https://github.com/netdna/netdnarws-perl/zipball/master
unzip master 
cd netdna-netdnarws-perl-b05c6b7/

## Usage
```perl
#!/usr/bin/perl -w

use NetDNARWS;
use Data::Dumper;
           
$api = new NetDNARWS( 'companyalias', 'fbe242bcaf4c95ed39a56da', 'e1429ab0873d0f13b62');

$api->get("/account.json");
```

## Methods
It has support for `GET`, `POST`, `PUT` and `DELETE` OAuth 1.0a signed requests.

Every request can take an optional debug parameter:

```perl
$api->get("/account.json", 1);
# Will output
# Making GET request to https://rws.netdna.com/myalias/account.json
#{... API Returned Stuff ...}
```

## Help

If your IO Socket doesn't install properly then run:

`CPAN::Shell->force(qw(install IO::Socket::SSL));`