package WWW::Deezer::Artist;

use Moose;

extends 'WWW::Deezer::Obj';

use WWW::Deezer;
use WWW::Deezer::Album;

# http://developers.deezer.com/api/artist

has 'id', is => 'ro', isa => 'Int';
has 'name', is => 'ro', isa => 'Str';
has 'link', is => 'ro', isa => 'Str';
has 'picture', is => 'ro', isa => 'Str';
has 'nb_album', is => 'rw', isa => 'Int';
has 'nb_fan', is => 'rw', isa => 'Int';
has 'radio', is => 'ro'; # should be bool, need coerce from JSON::XS::Boolean=\1

around BUILDARGS => sub { # allow create Artist object with single argument passed to constructor - deezer ID
    my ($orig, $class) = (shift, shift);
    my $self = {};

    if (@_ == 1 && !ref $_[0] ) {
        $self = $class->$orig( id => $_[0] );
        $self = WWW::Deezer->new->artist($_[0]);
    }
    else {
        # 2DO: deal with Bool and JSON::XS::Boolean=\1 in 'radio' argument
        $self = $class->$orig(@_);
    }
    return $self;
};

around nb_fan => sub {
    my ($orig, $self) = (shift, shift);
    my $fans = $self->$orig(@_);
    
    unless ($fans) {
        # fetch recreate artist.
        my $new_obj = $self->deezer_obj->artist($self->id);
        $fans = $new_obj->$orig(@_);
        $self->reinit_attr_values($new_obj);
    }

    return $fans;
};

around nb_album => sub {
    my ($orig, $self) = (shift, shift);
    my $albums = $self->$orig(@_);

    unless ($albums) {
        # fetch recreate artist.
        my $new_obj = $self->deezer_obj->artist($self->id);
        $albums = $new_obj->$orig(@_);
        $self->reinit_attr_values($new_obj);
    }

    return $albums;
};

sub top {
    my $self = shift;
    return;
}

sub albums {
    my $self = shift;
    return;
}   

sub comments {
    my $self = shift;
    return;
}   

sub fans {
    my $self = shift;
    return;
}   

sub related {
    my $self = shift;
    return;
}   

sub get_radio {
    my $self = shift;
    return;
}   

1;
