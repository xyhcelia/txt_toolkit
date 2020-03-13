#!/usr/bin/perl
use strict;
use Getopt::Long;
use vars qw($input $pattern $title $suffix $output $c1 $c2 $c3);


GetOptions(
   "h|help"=>\&USAGE,
   "i=s"=>\$input,
   "c1=s"=>\$c1,
   "p|pattern:s"=>\$pattern,
   "c2=s"=>\$c2,
   "c3=s"=>\$c3,
   "title"=>\$title,
   "s|suffix=s"=>\$suffix,
   "o=s"=>\$output,
) or USAGE();


sub USAGE{
my $usage=<<EOF;
Usage:perl $0 -i input -c1 1,2,3   -p|-pattern  sample\\*.replicate\\*.txt  -c2 4,5 -c3 6,7,8  -title(optional) -s|-suffix(optional) .txt  -o output
-h|--help:    print manual;
-c1:    columns of tag in input;
-p|-pattern:    the parametre is used to search files matching the pattern;
-c2:    columns of tag in files matching the pattern;
-c3:    columns of the features which need to be added in files match the patten;
-title:    if this parametre is true, a title will be added to the output;
-s|-suffix   this parametre only works when -title is setted;
EOF

print $usage;
exit;
}

my @c1=split(/,/,$c1);
my @c2=split(/,/,$c2);
my @c3=split(/,/,$c3);

my @files;
my %hash;
foreach my $file (glob "$pattern"){
     push(@files,$file);
     open FILE,"<$file";
     while(<FILE>){
         chomp;
         my @array=split;
         my $id;
         for my $ic2(@c2){
             $id.=$array[$ic2-1];
         }  
         for my $ic3(@c3){
             $hash{$id}{$file}{$ic3}=$array[$ic3-1];
         }
     }
     close FILE;
}

open IN,"<$input";
open OUT,">$output";

if($title==1){
    $_=<IN>;
    chomp;
    my $outitle=join("\t",@files);
    $outitle=~s/$suffix//g;
    print OUT $_,"\t",$outitle,"\n";
}else{}


while(<IN>){
    chomp;
    my @array=split;
    my $id;
    for my $ic1(@c1){
        $id.=$array[$ic1-1];
    }
    for my$file(@files){
        for my $ic3(@c3){
              if(exists($hash{$id}{$file}{$ic3})){$_.="\t".$hash{$id}{$file}{$ic3};}else{ $_.="\t--";}
        }
    }
    print OUT $_,"\n";   
}
close IN;
close OUT;
