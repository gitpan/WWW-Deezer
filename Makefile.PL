use 5.014002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'WWW::Deezer',
    VERSION_FROM      => 'lib/WWW/Deezer.pm', # finds $VERSION
    PREREQ_PM         => {
        'Moose'   => 0,
        'JSON'  => 0,
        'LWP'   => 0,
        'URI::Escape'   => 0,
        'Carp'  => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/WWW/Deezer.pm', # retrieve abstract from module
       AUTHOR         => 'Michael Katasonov <kabanoid@cpan.org>') : ()),
);
