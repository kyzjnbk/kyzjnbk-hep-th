package Nonlocal2pt;

require CheckArgs;

sub print_body{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=14)
    {
    print "Parameter number wrong: this function have 14 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $prop_mom=$_[0]; ## 这个动量是source端的动量, 只用在phase，因此对point source只需要保证$prop_mom-$antiprop_mom等于强子动量就可以了
    $antiprop_mom=$_[1];
    $hardon_mom=$prop_mom-$antiprop_mom;

    $prop_id=$_[2];
    $antiprop_id=$_[3];
    $gauge_id=$_[4];
    $staple_link_id=$_[5];
    
    $Lmax=$_[6];
    $bmax=$_[7];
    $Zmax=$_[8];

    $Ldir=$_[9];
    $bdir=$_[10];

    $conf=$_[11];
    $it0=$_[12];
    $prefix=$_[13];


print <<"EOF";

     <elem>
      <annotation>
         Compute the tmddf matrix element.
      </annotation>
      <Name>TMDWF</Name>
      <Param>
        <mom_s1_p1> 0 0 $prop_mom 0 </mom_s1_p1>
        <mom_s1_p2> 0 0 $antiprop_mom 0 </mom_s1_p2>
        <Lmax> $Lmax </Lmax>
        <bmax> $bmax </bmax>
        <Zmax> $Zmax </Zmax> 
        <bdir> $bdir </bdir>
        <src>0 0 0 $it0</src>
        <cfg_serial>${conf}</cfg_serial>
        <file_name>${prefix}tmdwf_smear_${conf}_src${it0}_k${hardon_mom}_Ldir${Ldir}bdir${bdir}_L${Lmax}b${bmax}z${Zmax}.dat.iog</file_name>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>  
        <s1_props_1>  
          <elem>$prop_id</elem>
        </s1_props_1>
        <s1_props_2> 
          <elem>$antiprop_id</elem>
        </s1_props_2>
        <staple_link_id>$staple_link_id</staple_link_id>  
     </NamedObject>     
    </elem>
EOF


}

1;
