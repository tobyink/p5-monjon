use v5.14;
use Benchmark qw(cmpthese);
use Devel::Size qw(size);

BEGIN { $ENV{MOO_XS_DISABLE} = 1 };

package Foo {
	use Moo;
	has attr1 => qw/ is rw /;
	has attr2 => qw/ is rw /;
}

package Fonjon {
	use Monjon;
	has attr1 => qw/ is rw pack Z6 /;
	has attr2 => qw/ is rw pack Z6 /;
}

cmpthese -3, {
	Moo     => q[ my $x = "Foo"->new(attr1 => "Hello", attr2 => "World"); $x->attr1($x->attr2) for 1..100 ],
	Monjon  => q[ my $x = "Fonjon"->new(attr1 => "Hello", attr2 => "World"); $x->attr1($x->attr2) for 1..100 ],
};

say "";
say "Moo object size: ", size "Foo"->new(attr1 => "Hello", attr2 => "World");
say "Monjon object size: ", size "Fonjon"->new(attr1 => "Hello", attr2 => "World");

__END__
         Rate Monjon    Moo
Monjon  745/s     --   -54%
Moo    1621/s   118%     --

Moo object size: 142
Monjon object size: 60
