package NonlocalQuarkME;

require CheckArgs;

sub print_body{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=13)
    {
    print "Parameter number wrong: this function have 13 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $gamma_id=$_[0]; ## 这个动量是source端的动量
    $mom_forward_prop=$_[1];
    $mom_backward_prop=$_[2];

    $forward_prop_id=$_[3];
    $backward_prop_id=$_[4];
    $gauge_id=$_[5];
    $staple_link_id=$_[6];
    
    $Lmax=$_[7];
    $bmax=$_[8];
    $Zmax=$_[9];

    $conf=$_[10];
    $t_seq=$_[11];
    $prefix=$_[12];

print <<"EOF";

     <elem>
      <annotation>
         Compute the tmddf matrix element.
      </annotation>
      <Name>TMDQuarkME</Name>
      <Param>
        <gamma_id>$gamma_id</gamma_id>
        <mom_forward_prop> 0 0 $mom_forward_prop 0 </mom_forward_prop>
        <mom_backward_prop> 0 0 $mom_backward_prop 0 </mom_backward_prop>
        <Lmax> $Lmax </Lmax>
        <bmax> $bmax </bmax>
        <Zmax> $Zmax </Zmax> 
        <src>0 0 0 0</src>
        <cfg_serial>${conf}</cfg_serial>
        <file_name>${prefix}tmd_quarkME_smear_${conf}_tseq${t_seq}_k${mom_forward_prop}${mom_backward_prop}_L${Lmax}b${bmax}z${Zmax}.dat.iog</file_name>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>  
        <forward_prop_id>
          <elem>$forward_prop_id</elem>
        </forward_prop_id>
        <backward_prop_id>
          <elem>$backward_prop_id</elem>
        </backward_prop_id>
        <staple_link_id>$staple_link_id</staple_link_id>  
     </NamedObject>     
    </elem>
EOF


}

1;
