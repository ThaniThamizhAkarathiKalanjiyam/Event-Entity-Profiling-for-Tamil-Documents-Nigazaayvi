#!/usr/bin/perl

while(<>) {
	chomp;
	
	push(@array,$_);
}

undef %personHash;
undef %locationHash;
undef @tempA;
undef @personarr;
undef @locationarr;

for($i = 0;$i < @array;$i++) {
	if($array[$i] =~ /B\-(INDIVIDUAL|PERSON)/) {
		#print "$array[$i]\n";
		$tag = "person";
		push(@tempA,$array[$i]);
		$d = $i+1;

		$true = 1;
		while($true) {
			if($array[$d] =~ /I\-(INDIVIDUAL|PERSON)/) { 
				#print "$array[$d]\n";
				push(@tempA,$array[$d]);
				$d++;
			}else{
				getNE(@tempA,$tag);
				$i = $d;
				undef @tempA;
				$true = 0;
			}			
			if($d > @array) {$true = 0;}
		}
	}elsif($array[$i] =~ /B\-(LOCATION|PLACE|CITY|DISTRICT|TOWN|STATE|NATION|COUNTRY|STNAME|ROAD)/) {
		#print "$array[$i]\n";
		$tag = "place";
		push(@tempA,$array[$i]);
		$d = $i+1;

		$true = 1;
		while($true) {
			if($array[$d] =~ /I\-(LOCATION|PLACE|CITY|DISTRICT|TOWN|STATE|NATION|COUNTRY|STNAME|ROAD)/) { 
				#print "$array[$d]\n";
				push(@tempA,$array[$d]);
				$d++;
			}else{
				getNE(@tempA,$tag);
				$i = $d;
				undef @tempA;
				$true = 0;
			}			
			if($d > @array) {$true = 0;}
		}
	}
}

##$personList = join "\#", keys%personHash;
###$locationList =  join "\#", keys%locationHash;
$personList = join "\#", @personarr;
$locationList =  join "\#", @locationarr;

##print "$personList<dim>$locationList\n";

sub getNE {

	$ntag = pop(@_);

	##print join "\n", @tempA,"\n";
	$ne = "";
	$position="";
	$l = @tempA;
	undef @ttmp;
	@ttmp = split(/\s+/,$tempA[0]);
	##$position="$ttmp[0]_$ttmp[1]_$ttmp[2]";
	$position="$ttmp[1]_$ttmp[2]";
	if($l > 1) {
		for($iii = 0;$iii < @tempA;$iii++) {
			@teeemp = split(/\s+/,$tempA[$iii]);
			if($l == ($iii+1)) {
				@teeempA = split(/\,/,$teeemp[6]);
				$ne = $ne."<iitk> $teeempA[0] <\/iitk>";
			}else{
				$ne .= " $teeemp[3] ";
			}
		}
	}else{
		foreach $ar (@tempA) {
			@teeemp = split(/\s+/,$ar);
			@teeempA = split(/\,/,$teeemp[6]);
			$ne = "<iitk> $teeempA[0] <\/iitk>";	
		}
	}
	$ne=~s/^\s+//;
	$ne=~s/\s+$//;

	print "$position<dim>$ne<dim>$ntag\n";

	if($ntag eq "person") {
		if(!exists $personHash{$ne}){
			$personHash{$ne}++;
			push(@personarr,$ne);
		}
	}else{
		if(!exists $locationHash{$ne}){
			$locationHash{$ne}++;
			push(@loactionarr,$ne);
		}
	}
}
