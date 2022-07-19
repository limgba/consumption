#!/bin/perl

use feature "say";

sub sum
{
	my ($file) = @_;
	my $index=0;
	my $line=0;
	open(rd, "<$file");
	my $sum=0;
	while (<rd>)
	{
		my $str = $_;
		$line++;
		if ($line == 1)
		{
			@arr = split("\t", $str);
			$size = @arr;
			for ($i = 0; $i < $size; $i++)
			{
				if ("price" eq $arr[$i])
				{
					$index = $i;
					last;
				}
			}
		}
		else
		{
			@arr = split("\t", $str);
			$sum += $arr[$index];
		}
	}
	close(rd);
	return $sum;
}


$argc = @ARGV;
$sum = 0;
if ($argc == 1)
{
	$year=$ARGV[0];
	$sum=0;
	$month_str = `ls data/$year`;
	@months = split(" ", $month_str);
	foreach $month (@months)
	{
		$sum += sum("data/$year/$month");
	}
}
elsif ($argc == 2)
{
	$year=$ARGV[0];
	$month=$ARGV[1];
	$file="data/$year/$month";
	$sum = sum($file);
}
else
{
	$year=`date +%Y`;
	$year =~ s/\D//;
	$month=`date +%m`;
	$month =~ s/\D//;
	$month += 0;
	$file="data/$year/$month";
	$sum = sum($file);
}

say($sum);
