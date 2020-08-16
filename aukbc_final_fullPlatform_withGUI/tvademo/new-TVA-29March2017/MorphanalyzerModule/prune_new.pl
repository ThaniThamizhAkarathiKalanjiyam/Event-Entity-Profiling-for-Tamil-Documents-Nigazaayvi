#!/usr/bin/perl

##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai. 

##AUKBC Tamil Morph Analyser Light Weight  v1.0 website:  http://au-kbc.org/nlp


##AUKBC Tamil Morph Analyser Light Weight v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

###AUKBC Tamil Morph Analyser Light Weight v1.0 is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##Please see the GNU General Public License  available at http://www.gnu.org/licenses for further license details
##


while(<>){
	chomp;
	if($_ eq undef) { print "\n"; next; }
	my ($wrd, @aarr)=split(/\t+/,$_);

	@tempA = split(/\,/,$aarr[0]);

	$tempA[0] ="<iitk>$tempA[0]<\/iitk>" if($tempA[0] !~/^\&/);

	$aarr[0] = join "\,", @tempA;
	$aarr[0] =~ s/\,$//;
	
	$aarr[0] =~ s/\|(.+?)\,/\|<iitk>$1<\/iitk>\,/g;

	print "<iitk>$wrd<\/iitk>\t", join "\t", @aarr, "\n";
}