package Nonlocal3pt;

require CheckArgs;

sub print_body_select_L{

  ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=17)
    {
    print "Parameter number wrong: this function have 15 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $gamma_id=$_[0]; ## 这个动量是source端的动量
    $mom_src=$_[1]; ## 文件名的动量应该是初末态的动量

    $hadron_key=$_[2]; 
    $FrwdProp_id=$_[3]; ## 计算那个强子就传那个强子的sequential prop
    $BkwdProp_id=$_[4];
    $gauge_id=$_[5];
    $staple_link_id=$_[6];
    
    $Lmin=$_[7];
    $Lmax=$_[8];
    $Lstep=$_[9];


    $bmax=$_[10];
    $Zmax=$_[11];

    $Ldir=$_[12];
    $bdir=$_[13];

    $conf=$_[14];
    $t_seq=$_[15];
    $prefix=$_[16];

    $mom_current=0; # forward pdf，转移动量为0

print <<"EOF";

     <elem>
      <annotation>
         Compute the tmddf matrix element.
      </annotation>
      <Name>TMDPDF</Name>
      <Param>
        <gamma_id>$gamma_id</gamma_id>
        <mom_current> 0 0 0 0 </mom_current>
        <Lmin> $Lmin </Lmin>
        <Lmax> $Lmax </Lmax>
        <Lstep> $Lstep </Lstep>
        <Ldir> $Ldir </Ldir>
        <bmax> $bmax </bmax>
        <Zmax> $Zmax </Zmax> 
        <bdir> $bdir </bdir>
        <src>0 0 0 0</src>
        <cfg_serial>${conf}</cfg_serial>
        <file_name>${prefix}tmdpdf_${hadron_key}_smear_${conf}_tseq${t_seq}_k${mom_src}_Ldir${Ldir}bdir${bdir}_L${Lmin}-${Lmax}-${Lstep}_b${bmax}z${Zmax}.dat.iog</file_name>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>  
        <FrwdProp_id>$FrwdProp_id</FrwdProp_id>
        <BkwdProp_id>$BkwdProp_id</BkwdProp_id>
        <staple_link_id>$staple_link_id</staple_link_id>  
     </NamedObject>     
    </elem>
EOF


}

sub print_body_all_L{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=15)
    {
    print "Parameter number wrong: this function have 15 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $gamma_id=$_[0]; ## 这个动量是source端的动量
    $mom_src=$_[1]; ## 文件名的动量应该是初末态的动量

    $hadron_key=$_[2]; 
    $FrwdProp_id=$_[3]; ## 计算那个强子就传那个强子的sequential prop
    $BkwdProp_id=$_[4];
    $gauge_id=$_[5];
    $staple_link_id=$_[6];
    
    $Lmax=$_[7];
    $bmax=$_[8];
    $Zmax=$_[9];

    $Ldir=$_[10];
    $bdir=$_[11];

    $conf=$_[12];
    $t_seq=$_[13];
    $prefix=$_[14];


    $mom_current=0; # forward pdf，转移动量为0

print <<"EOF";

     <elem>
      <annotation>
         Compute the tmddf matrix element.
      </annotation>
      <Name>TMDPDF</Name>
      <Param>
        <gamma_id>$gamma_id</gamma_id>
        <mom_current> 0 0 $mom_current 0 </mom_current>
        <Lmax> $Lmax </Lmax>
        <bmax> $bmax </bmax>
        <Zmax> $Zmax </Zmax> 
        <bdir> $bdir </bdir>
        <src>0 0 0 0</src>
        <cfg_serial>${conf}</cfg_serial>
        <file_name>${prefix}tmdpdf_${hadron_key}_smear_${conf}_tseq${t_seq}_k${mom_src}_Ldir${Ldir}bdir${bdir}_L${Lmax}b${bmax}z${Zmax}.dat.iog</file_name>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>  
        <FrwdProp_id>$FrwdProp_id</FrwdProp_id>
        <BkwdProp_id>$BkwdProp_id</BkwdProp_id>
        <staple_link_id>$staple_link_id</staple_link_id>  
     </NamedObject>     
    </elem>
EOF

}

1;
