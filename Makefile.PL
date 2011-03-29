use ExtUtils::MakeMaker;

&WriteMakefile(

	NAME              => 'LWP::Simple::Post',
	VERSION_FROM      => 'lib/LWP/Simple/Post.pm',
	PREREQ_PM         => {

		'Test::More' => '0.01',
		'LWP' => '0.01',

	}, 

);
