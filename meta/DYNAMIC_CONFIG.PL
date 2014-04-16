# Hash::Util::FieldHash was first released with perl v5.9.4

sub parse_args {
	require ExtUtils::MakeMaker;
	require Text::ParseWords;
	ExtUtils::MakeMaker::parse_args(
		my $tmp = {},
		Text::ParseWords::shellwords($ENV{PERL_MM_OPT} || ''),
		@ARGV,
	);
	return $tmp->{ARGS} || {};
}
 
my $have_compiler
	= ! parse_args()->{PUREPERL_ONLY}
	&&  eval { require ExtUtils::CBuilder; 1 }
	&& ExtUtils::CBuilder->new->have_compiler;

if ($] < 5.009004)
{
	my $module = ($have_compiler && $] >= 5.008005)
		? 'Hash::FieldHash'
		: 'Hash::Util::FieldHash::Compat';
	$meta->{prereqs}{runtime}{requires}{$module} = 0;
}

$meta->{prereqs}{runtime}{requires}{'UNIVERSAL::DOES'} = 0
	if $] < 5.010000;

$meta->{prereqs}{test}{requires}{'Types::Standard'} = 0
	if $ENV{AUTOMATED_TESTING} || $ENV{EXTENDED_TESTING};
