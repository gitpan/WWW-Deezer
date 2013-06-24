package WWW::Deezer::Obj;

use Moose;

# base class for representing Deezer objects;

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
