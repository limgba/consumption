#!/bin/perl

use feature "say";

sub sum
{
	my ($file, $day) = @_;
	my $index=0;
	my $line=0;
	open(rd, "<$file");
	my $sum=0;
	my $i = 0;
	while (<rd>)
	{
		my $str = $_;
		$line++;
		if ($line == 1)
		{
			my @arr = split("\t", $str);
			my $size = @arr;
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
			my @arr = split("\t", $str);
			if ($day > 0 && $arr[0] != $day)
			{
				next;
			}
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
	@big_months = ();
	foreach $month (@months)
	{
		if ($month > 9)
		{
			push(@big_months, $month);
			next;
		}
		$consumption = sum("data/$year/$month", 0);
		$sum += $consumption;
		say("$month	$consumption");
	}

	foreach $month (@big_months)
	{
		$consumption = sum("data/$year/$month", 0);
		$sum += $consumption;
		say("$month	$consumption");
	}
}
elsif ($argc == 2)
{
	$year=$ARGV[0];
	$month=$ARGV[1];
	$file="data/$year/$month";
	$sum = sum($file, 0);
}
elsif ($argc == 3)
{
	$year=$ARGV[0];
	$month=$ARGV[1];
	$day=$ARGV[2];
	$file="data/$year/$month";
	$sum = sum($file, $day);
}
elsif ($argc == 4)
{
	$year=$ARGV[0];
	$month=$ARGV[1];
	$day=$ARGV[2];
	$is_before=$ARGV[3];

	$day += 0;
	$file="data/$year/$month";
	if ($is_before != 0)
	{
		for ($i = 1; $i < $day; $i++)
		{
			$sum += sum($file, $i);
		}
	}
	else
	{
		for ($i = $day; $i < 32; $i++)
		{
			$sum += sum($file, $i);
		}
	}
}
else
{
	$year=`date +%Y`;
	$year =~ s/\D//;
	$month=`date +%m`;
	$month =~ s/\D//;
	$month += 0;
	$file="data/$year/$month";
	$sum = sum($file, 0);
}

say($sum);
