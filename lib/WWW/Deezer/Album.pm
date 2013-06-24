package WWW::Deezer::Album;

use Moose;

extends 'WWW::Deezer::Obj';

use WWW::Deezer;
use WWW::Deezer::Artist;

# http://developers.deezer.com/api/album

has 'id' => (is => 'ro', isa => 'Int');
has 'title' => (is => 'ro', isa => 'Str');
has 'link' => (is => 'rw', isa => 'Str');
has 'cover' => (is => 'ro', isa => 'Str');
has 'genre_id' => (is => 'rw', isa => 'Int');
has 'label' => (is => 'ro', isa => 'Str');
has 'duration' => (is => 'ro', isa => 'Int');
has 'fans' => (is => 'ro', isa => 'Int');
has 'rating' => (is => 'ro', isa => 'Int');
has 'release_date' => (is => 'rw', isa => 'Str');
has 'available' => (is => 'ro');

has 'artist' => (
    is => 'ro', 
    isa => 'Ref', 
    weak_ref => 1
); # 2do: change Ref to Object

has 'tracks' => (is => 'ro');

around BUILDARGS => sub { # allow create Album object with single argument passed to constructor - deezer ID
    my ($orig, $class) = (shift, shift);
    my $self = {};

    if (@_ == 1 && !ref $_[0] ) {
        $self = $class->$orig( id => $_[0] );
        $self = WWW::Deezer->new->album($_[0]);
    }
    else {
        # 2DO: deal with Bool and JSON::XS::Boolean=\1 in 'radio' argument
        $self = $class->$orig(@_);
    }
    return $self;
};

around release_date => sub {
    my ($orig, $self) = (shift, shift);
    my $date = $self->$orig(@_);

    unless ($date) {
        # fetch recreate album.
        my $new_obj = $self->deezer_obj->album($self->id);
        $date = $new_obj->$orig(@_);
        $self->reinit_attr_values($new_obj);
    }

    return $date;
};

around link => sub {
    my ($orig, $self) = (shift, shift);
    my $date = $self->$orig(@_);

    unless ($date) {
        # fetch recreate album.
        my $new_obj = $self->deezer_obj->album($self->id);
        $date = $new_obj->$orig(@_);
        $self->reinit_attr_values($new_obj);
    }

    return $date;
};

around genre_id => sub {
    my ($orig, $self) = (shift, shift);
    my $date = $self->$orig(@_);

    unless ($date) {
        # fetch recreate album.
        my $new_obj = $self->deezer_obj->album($self->id);
        $date = $new_obj->$orig(@_);
        $self->reinit_attr_values($new_obj);
    }

    return $date;
};


sub comments {
    my $self = shift;
    return;
}

sub fans_list {
    my $self = shift;
}

1;
