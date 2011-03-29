package LWP::Simple::Post;

	use strict;

	use vars qw($VERSION @EXPORT_OK @ISA);

	use constant DEBUG => 0;

	require Exporter;
	@ISA = qw(Exporter);

	@EXPORT_OK = qw( post post_xml );

	use LWP::UserAgent;
	use HTTP::Request;

	$VERSION = '0.04';

=head1 NAME

LWP::Simple::Post - Single-method POST requests

=head1 DESCRIPTION

Really simple wrapper to HTTP POST requests

=head1 SYNOPSIS

 use LWP::Simple::Post qw(post post_xml);

 my $response = post('http://production/receiver', 'some text');

=head1 OVERVIEW

This module is intended to do for HTTP POST requests what
LWP::Simple did for GET requests. If you want to do anything
complicated, this module is not for you. If you just want to
push data at a URL with the minimum of fuss, you're the target
audience.

=head1 METHODS

=head2 post

 my $content = post( string $url, string $data );

Posts the data in C<$data> to the URL in C<$url>, and returns
what we got back. Returns C<undef> on failure.

=cut

	sub post {

		my ( $url, $data ) = @_;

		my $ua = _init_ua(); 

		my $r = HTTP::Request->new( POST => $url );
		$r->content( $data );

		print $r->as_string if DEBUG;

		my $response = $ua->request( $r );

		if ( DEBUG ) { return $response->content };
		
		return $response->content if $response->is_success;
		return undef;

	}

=head2 post_xml

 my $content = post_xml( string $url, string $data );

Having written this module, it turned out that 99% of what I needed it
for required a content-type of C<text/xml>. This does exactly what C<post>
does, only the content-type header is set to C<text/html>.	

=cut

  sub post_xml {

    my ( $url, $data ) = @_;

    my $ua = _init_ua(); 

    my $r = HTTP::Request->new( POST => $url );
    $r->content( $data );
		$r->header('Content-type' => 'text/xml');

    print $r->as_string if DEBUG;

    my $response = $ua->request( $r );

    if ( DEBUG ) { return $response->content };

    return $response->content if $response->is_success;
    return undef;

  }

	sub _init_ua {

		my $ua = new LWP::UserAgent;  # we create a global UserAgent object
		my $ver = $LWP::VERSION = $LWP::VERSION;  # avoid warning
		$ua->agent("LWP::Simple/$LWP::VERSION");
		$ua->env_proxy;

		return $ua;

	}

=head1 AUTHOR

Peter Sergeant - C<pete@clueball.com>

=head1 COPYRIGHT

Copyright 2005 Pete Sergeant.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
