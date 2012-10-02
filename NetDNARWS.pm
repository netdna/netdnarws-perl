#!/usr/bin/perl -w

#NetDNA API Sample Code - Perl
#Version 1.1a

package NetDNARWS;
use NetDNA;
use strict;
use warnings;
use JSON;
use Net::OAuth;
use LWP::UserAgent;
use URI;
use Data::Dumper;
$Net::OAuth::PROTOCOL_VERSION = Net::OAuth::PROTOCOL_VERSION_1_0A;
our @ISA = qw(NetDNA);    # inherits from NetDNA
my $base_url = "https://rws.netdna.com/";
my $debug;

# Override constructor
sub new {
        my ($class) = @_;
        # Call the constructor of the parent class, NetDNA.
        my $self = $class->SUPER::new( $_[1], $_[2], $_[3] );
        # Add few more attributes
        bless $self, $class;
        return $self;
}

# Override helper function
sub get {
        my( $self, $address, $debug ) = @_;
        $address = $base_url . $self->{_myalias} . $address;

        if($debug){
                print "Making GET request to " . $address . "\n";
        }

        my $url = shift;
        my $ua = LWP::UserAgent->new;
        
        # Create request
        my $request = Net::OAuth->request("request token")->new(
                consumer_key => $self->{_consumer_key},  
                consumer_secret => $self->{_consumer_secret}, 
                request_url => $address, 
                request_method => 'GET', 
                signature_method => 'HMAC-SHA1',
                timestamp => time,
	        nonce => '', 
                callback => '',
        );

        # Sign request        
        $request->sign;

        # Get message to the Service Provider
        my $res = $ua->get($request->to_url); 
        
        # Decode JSON
        my $decoded_json = decode_json($res->content);
        if($decoded_json->{code} == 200) {
		if($debug){
                        print Dumper $decoded_json->{data};
		}
		return $decoded_json->{data};
	} else {
	        if($debug){
		        print Dumper $decoded_json->{error};
		}
		return $decoded_json->{error};
	}
        
        
        
}

1;
