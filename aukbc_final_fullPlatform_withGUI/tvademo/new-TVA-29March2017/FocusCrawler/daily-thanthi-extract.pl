open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}

for($i=0;$i<=@arr;$i++)
{
	if($arr[$i]=~/URL:/)
	{
		$value=$value.$arr[$i];

	}
	if($arr[$i]=~/<div id="ContentPlaceHolder1_ArticleDetailHeading".*>(.*)<\/div>/)
        {
		#print"$1\n";
		$value=$value.$1;
        }

	if($arr[$i]=~/<div id="ContentPlaceHolder1_ArticleDescription".*>/)
        {

                while($arr[$i]!~/<script src=/){
                        $value=$value.$arr[$i];
                        $i++;
                }
        }

#<div id="ContentPlaceHolder1_ArticleDescription"
}
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
$value =~s/\cM//g;
print"$value\n";