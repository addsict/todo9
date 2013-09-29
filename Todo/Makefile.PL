use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'SampleApp',
    VERSION_FROM  => 'lib/SampleApp.pm',
    PREREQ_PM     => {
        'Kossy' =>  '0.19',
    },
    MIN_PERL_VERSION => '5.008001'
);

