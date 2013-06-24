package WWW::Deezer::Track;

use Moose;

extends 'WWW::Deezer::Obj';

use WWW::Deezer::Album;
use WWW::Deezer::Artist;

# http://developers.deezer.com/api/track

has 'id', is => 'ro', isa => 'Int';
has 'title', is => 'ro', isa => 'Str';
has 'link', is => 'ro', isa => 'Str';
has 'duration', is => 'ro', isa => 'Int';
has 'track_position', is => 'ro', isa => 'Int';
has 'disk_number', is => 'ro', isa => 'Int';
has 'rank', is => 'ro', isa => 'Int';
has 'release_date', is => 'ro';
has 'preview', is => 'ro', isa => 'Str';

has 'artist' => (
    is => 'rw', 
    isa => 'Ref',
); # 2do: change Ref to Object

has 'album' => (is => 'rw', isa => 'Ref'); # 2do: change Ref to Object

has 'deezer_obj' => (is => 'rw', isa => 'Ref');

sub count {
    my $self = shift;
    return scalar @{$self->data};
}

sub first {
    my $self = shift;
    return $self->data->[0];
}

sub set_artist {
    my ($self, $data) = @_;
    my $artist = WWW::Deezer::Artist->new($data);
    $artist->deezer_obj($self->deezer_obj);
    $self->artist($artist);
    return $self;
}

sub set_album {
    my ($self, $data) = @_;
    my $album = WWW::Deezer::Album->new($data);
    $album->deezer_obj($self->deezer_obj);
    $self->album($album);
    return $self;
}

1;
