#!/usr/bin/perl
use 5.008;

use strict;
use warnings;
use Cwd qw/abs_path/;
use File::Basename;
use File::Path;
use File::Copy;

my $seperator = "\n". "*" x 60 . "\n";
my $UsageInfo = "Usage: perl plot.pl <CSV File>.\n";

die "$UsageInfo" if(@ARGV != 1);

my $csvFile = $ARGV[0];

die "$UsageInfo" unless($csvFile =~ /\.csv$/);

open INPUT, "<", "$csvFile" or die "$UsageInfo";
my @csvContent = <INPUT>;
close INPUT;

chomp(my $titles = shift @csvContent);
die "Not enough data to plot $csvFile" if(@csvContent <= 1);

my @title = split /,/, $titles;
my $XTitle = shift @title;
print "The sweep value is $XTitle.\n";

my $tot = @title;
my $len_tot = length($tot);

my $cnt = 1;
foreach(@title) {
    chomp;
    my $tmp = $_;
    if($tmp =~ s/\(A\)//i) {
        printf "\e[1;35mBranch Current\e[m %${len_tot}d: %s\n", $cnt, $tmp;
    } elsif($tmp =~ s/\(V\)//i) {
        printf " \e[1;34mNode  Voltage\e[m %${len_tot}d: %s\n", $cnt, $tmp;
    } else {
        warn "Not unit in the title item $tmp\n";
    }
    $cnt++;
}

my $last_num_str = "";
$last_num_str = "-$tot" if(@title > 1);
printf "Please enter how many signals need to be plot[1%s]:", $last_num_str;
my $tot_plot = &inputNum(1, $tot);

$cnt = $tot_plot;
my $len_tot_plot = length($tot_plot);

my @plot_Signals = ();
while ($cnt > 0) {
    printf "Please enter the signal index[1%s] (%${len_tot_plot}d left):", $last_num_str, $cnt;
    my $index = &inputNum(1, $tot, @plot_Signals);
    push @plot_Signals, $index;
    $cnt--;
}

my @plot_current = ();
my @plot_voltage = ();
foreach(@plot_Signals) {
    push @plot_current, $_ if($title[$_ - 1] =~ /\(A\)/i);
    push @plot_voltage, $_ if($title[$_ - 1] =~ /\(V\)/i);
}

print "$seperator";
if(@plot_voltage > 0) {
    print "All voltage need to be plot:\n";
    printf " \e[1;34mNode  Voltage\e[m: %s\n", $title[$_ - 1] foreach (@plot_voltage);
}
if(@plot_current > 0) {
    print "All current need to be plot:\n";
    printf "\e[1;35mBranch Current\e[m: %s\n", $title[$_ - 1] foreach (@plot_current);
}
print "\n";

my $script_path = abs_path(dirname(__FILE__));
die "No 'temp' folder in script path '$script_path'.\n" if(-d "$script_path/temp");
mkdir("$script_path/temp");

if(@plot_voltage > 0) {
    open OUTV, ">", "$script_path/temp/tmpV.csv";
    foreach(@csvContent) {
        chomp;
        next if(/^\s*$/);
        my @rows = split /,/, $_;
        print OUTV "$rows[0]";
        print OUTV ",$rows[$_]" foreach (@plot_voltage);
        print OUTV "\n";
    }
    close OUTV;
}

if(@plot_current > 0) {
    open OUTI, ">", "$script_path/temp/tmpI.csv";
    foreach(@csvContent) {
        chomp;
        next if(/^\s*$/);
        my @rows = split /,/, $_;
        print OUTI "$rows[0]";
        print OUTI ",$rows[$_]" foreach (@plot_current);
        print OUTI "\n";
    }
    close OUTI;
}

my $plt_script = "";
if(@plot_current > 0 && @plot_voltage > 0) {$plt_script = "VI.plt";}
elsif(@plot_current > 0) {$plt_script = "I.plt";}
elsif(@plot_voltage > 0) {$plt_script = "V.plt";}
else {die "No output\n";}

chomp(my $rundir = `pwd`);
copy("$script_path/GnuPlotTemplate/$plt_script", "$script_path/temp/$plt_script");
chdir "$script_path/temp";

my $tmpScriptFile = "tmp.plt";
open GPLOT, ">", "$tmpScriptFile";

print GPLOT "set xlabel \"$XTitle\"\n";
print GPLOT "plot \\\n";

my @scriptPlot = ();
if(@plot_current > 0 && @plot_voltage > 0) {
    my $count = 2;
    foreach(@plot_voltage) {
        my $legend = $title[$_ - 1];
        $legend =~ s/\(V\)//i;
        $legend = "V(" . $legend .")";

        my $script = "dataV u 1:$count ";
        $script .= "t \"$legend\" ";
        $script .= "w lp lw 2 pt 1 axis x1y1,\\";

        push @scriptPlot, $script;
        $count++;
    }
    $count = 2;
    foreach(@plot_current) {
        my $legend = $title[$_ - 1];
        $legend =~ s/\(A\)//i;
        $legend = "I(" . $legend .")";

        my $script = "dataI u 1:$count ";
        $script .= "t \"$legend\" ";
        $script .= "w lp lw 2 pt 1 axis x1y2,\\";

        push @scriptPlot, $script;
        $count++;
    }

} elsif(@plot_current > 0) {
    my $count = 2;
    foreach(@plot_current) {
        my $legend = $title[$_ - 1];
        $legend =~ s/\(A\)//i;
        $legend = "I(" . $legend .")";

        my $script = "data u 1:$count ";
        $script .= "t \"$legend\" ";
        $script .= "w lp lw 2 pt 1,\\";

        push @scriptPlot, $script;
        $count++;
    }
} elsif(@plot_voltage > 0) {
    my $count = 2;
    foreach(@plot_voltage) {
        my $legend = $title[$_ - 1];
        $legend =~ s/\(V\)//i;
        $legend = "V(" . $legend .")";

        my $script = "data u 1:$count ";
        $script .= "t \"$legend\" ";
        $script .= "w lp lw 2 pt 1,\\";

        push @scriptPlot, $script;
        $count++;
    }
}
$scriptPlot[-1] =~ s/,\\//;
print GPLOT "$_\n" foreach(@scriptPlot);
close GPLOT;
system("cat $tmpScriptFile >> $plt_script");

print "GnuPlot Script File Generated.\n";

system("gnuplot $plt_script >/dev/null 2>&1");

chdir "$rundir";

my $oriEPS = "$script_path/temp/1.eps";
chomp(my $time = `date +%F-%H-%M-%S`);
my ($name, $path) = fileparse($csvFile, '.csv');
chop($path);
my $newEPS = "$path/$time\_$name.eps";
rename "$oriEPS", "$newEPS";

rmtree("$script_path/temp");

print "EPS file has been written to $newEPS.\n";

system("gs $newEPS");

sub inputNum {
    my $min = shift @_;
    my $max = shift @_;
    chomp(my $input = <STDIN>);
    until($input =~ /^\s*\d+\s*$/ && $min <= $input && $input <= $max && !(grep {$_ == $input} @_)) {
        print "Your input doesn't follow the restriction. Please try it again:";
        chomp($input = <STDIN>);
    }
    return $input;
}
