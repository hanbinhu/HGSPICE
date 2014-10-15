#!/usr/bin/perl
use 5.008;
# Include lib
use strict;
use warnings;
use Cwd qw/abs_path/;
use File::Basename;
use File::Path;
use File::Copy;
# Output Setting
my $seperator = "\n". "*" x 60 . "\n";
my $UsageInfo = "Usage: perl plot.pl <CSV File>.\n";
# Command Check & Obtain Input
die "$UsageInfo" if(@ARGV != 1);
my $csvFile = $ARGV[0];
die "$UsageInfo" unless($csvFile =~ /\.csv$/);
open INPUT, "<", "$csvFile" or die "$UsageInfo";
my @csvContent = <INPUT>;
close INPUT;
chomp(my $titles = shift @csvContent);
die "Not enough data to plot $csvFile" if(@csvContent <= 1);
# Deal with title
my @title = split /,/, $titles;
my $XTitle = shift @title;
print "The sweep value is $XTitle.\n";

my $tot = @title;
my $len_tot = length($tot);

my %UnitHash = (
    A => "Current",
    V => "Voltage",
    S => "Transconductance",
    O => "Resistance",
    F => "Capacitance",
);
my %UnitName = (
    A => "I",
    V => "V",
    S => "G",
    O => "R",
    F => "C",
);
my %UnitColor = (
    A => 35,
    V => 34,
    S => 36,
    O => 32,
    F => 31,
);

my $cnt = 1;
foreach(@title) {
    chomp;
    my $tmp = $_;
    my $flag = 1;
    foreach my $key (keys %UnitHash) {
        if($tmp =~ s/\($key\)//i) {
            printf "\e[1;$UnitColor{$key}m$UnitHash{$key}\e[m %${len_tot}d: %s\n", $cnt, $tmp;
            $flag = 0;
            last;
        }
    }
    warn "Not unit in the title item $tmp\n" if $flag;
    $cnt++;
}
# Ask for how much curves need to be ploted
my $last_num_str = "";
$last_num_str = "-$tot" if(@title > 1);
printf "Please enter how many signals need to be plot[1%s]:", $last_num_str;
my $tot_plot = &inputNum(1, $tot);

$cnt = $tot_plot;
my $len_tot_plot = length($tot_plot);

# Ask for which curves need to be ploted
my @plot_Signals = ();
while ($cnt > 0) {
    printf "Please enter the signal index[1%s] (%${len_tot_plot}d left):", $last_num_str, $cnt;
    my $index = &inputNum(1, $tot, @plot_Signals);
    push @plot_Signals, $index;
    $cnt--;
}

foreach my $unit (keys %UnitHash) {
    # Obtain plot curve index for current unit
    my @plot_curve = ();
    foreach(@plot_Signals) {
        push @plot_curve, $_ if($title[$_ - 1] =~ /\($unit\)/i);
    }
    next if @plot_curve <= 0;
    print "$seperator";
    print "All $UnitHash{$unit} need to be plot:\n";
    printf " \e[1;$UnitColor{$unit}m$UnitHash{$unit}\e[m: %s\n", $title[$_ - 1] foreach (@plot_curve);
    print "\n";
    my $script_path = abs_path(dirname(__FILE__));
    die "No 'temp' folder in script path '$script_path'.\n" if(-d "$script_path/temp");
    mkdir("$script_path/temp");
    # Create temporary file containing ploting data
    open OUT, ">", "$script_path/temp/tmp.csv";
    foreach(@csvContent) {
        chomp;
        next if(/^\s*$/);
        my @rows = split /,/, $_;
        print OUT "$rows[0]";
        print OUT ",$rows[$_]" foreach (@plot_curve);
        print OUT "\n";
    }
    close OUT;
    # Copy Gnuplot template
    my $plt_script = "template.plt";
    die "No output\n" unless @plot_curve > 0;

    chomp(my $rundir = `pwd`);
    copy("$script_path/GnuPlotTemplate/$plt_script", "$script_path/temp/$plt_script");
    chdir "$script_path/temp";
    # Generate script
    my $tmpScriptFile = "tmp.plt";
    open GPLOT, ">", "$tmpScriptFile";

    my $outputEPS = $UnitHash{$unit} . ".eps";
    print GPLOT "set output \"$outputEPS\"\n";
    print GPLOT "set xlabel \"$XTitle\"\n";
    print GPLOT "set ylabel \"$UnitHash{$unit}($unit)\"\n";
    print GPLOT "plot \\\n";
    my @scriptPlot = ();
    my $count = 2;
    foreach(@plot_curve) {
        my $legend = $title[$_ - 1];
        $legend =~ s/\($unit\)//i;
        $legend = $UnitName{$unit} . "(" . $legend .")";
        my $script = "data u 1:$count ";
        $script .= "t \"$legend\" ";
        $script .= "w lp lw 2 pt 1,\\";
        push @scriptPlot, $script;
        $count++;
    }
    $scriptPlot[-1] =~ s/,\\//;
    print GPLOT "$_\n" foreach(@scriptPlot);
    close GPLOT;
    system("cat $tmpScriptFile >> $plt_script");

    print "GnuPlot Script File Generated.\n";

    system("gnuplot $plt_script >/dev/null 2>&1");

    chdir "$rundir";

    my $oriEPS = "$script_path/temp/$outputEPS";
    chomp(my $time = `date +%F-%H-%M-%S`);
    my ($name, $path) = fileparse($csvFile, '.csv');
    chop($path);
    my $newEPS = "$path/$UnitHash{$unit}\_$time\_$name.eps";
    rename "$oriEPS", "$newEPS";

    rmtree("$script_path/temp");

    print "EPS file has been written to $newEPS.\n";
}

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
