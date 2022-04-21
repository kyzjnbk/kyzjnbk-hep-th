package StapleWilsonLink;

require CheckArgs;


#####################################################
#######   main function, print need
#####################################################

sub print_body{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=5)
    {
    print "Parameter number wrong: this function have 5 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $Lmax=$_[0];
    $bmax=$_[1];
    $Ldir=$_[2];
    $bdir=$_[3];
    $gauge_id=$_[4];

    $staple_link_id="StapleWilsonLink_Ldir${Ldir}bdir${bdir}_Lmax${Lmax}bmax${bmax}";

print <<"EOF";    
    <elem>
        <Name>STAPLE_WILSON_LINK</Name>
        <Param>
            <Lmax> $Lmax </Lmax>
            <bmax> $bmax </bmax>
            <bdir> $bdir </bdir>
            <Ldir> $Ldir </Ldir>
        </Param>
        <NamedObject>
            <gauge_id>$gauge_id</gauge_id>
            <staple_link_id>$staple_link_id</staple_link_id>  
        </NamedObject>
    </elem>
EOF

return $staple_link_id;
}

1;