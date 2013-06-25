package WWW::Deezer::Obj;

our $VERSION = '0.02';

use Moose;
use Moose::Util::TypeConstraints;

# base class for representing Deezer objects;

subtype 'JSONBoolean' => (as 'Int');

coerce 'JSONBoolean' => (
    from 'Ref',
    via { JSON::is_bool($_) }
);

has 'deezer_obj', is => 'rw', isa => 'Ref';

sub reinit_attr_values {
    my ($self, $new) = (shift, shift);
    my $package = caller || __PACKAGE__;

    my $meta = $package->meta;
    my @attrs = $meta->get_all_attributes();

    foreach my $attr (@attrs) {
        my $name = $attr->name;
        eval {
            $self->$name($new->$name) if ($attr->get_write_method && $name ne 'deezer_obj');
        };

        if ($@) {
            warn ($@);
        }
    }
}

1;
