#!/usr/bin/perl

package GaugeFix;
require CheckArgs;

#####################################################
#######   保存的gfixed_cfg是不是存在
#####################################################

sub fixed_exist{ # param: $fixed_exist

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=4)
    {
    print "Parameter number wrong: this function have 4 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $conf=$_[0];
    $hyp_smear=$_[1]; # do hyp smear or not, 0: not do, 1: do
    $gauge_type=$_[2]; # 0: not do gauge fixing, -1: Landau geuge, 3: Coulomb gauge
    $save_cfg_head=$_[3];

    ## saved gauge fixed conf exist or not
    $conf_path_gfix="${save_cfg_head}.${conf}.hyp${hyp_smear}.gfixed${gauge_type}";
    $fixed_exist= -e ${conf_path_gfix};

    return($fixed_exist, $conf_path_gfix);

} # sub fixed_exist


#####################################################
#######   main function, gauge fix for wall source
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

    $conf=$_[0];
    $hyp_smear=$_[1]; # do hyp smear or not, 0: not do, 1: do
    $gauge_type=$_[2]; # 0: not do gauge fixing, -1: Landau geuge, 3: Coulomb gauge

    $save_cfg=$_[3]; # 0: not save, 1: save
    $save_cfg_head=$_[4];

    ## saved gauge fixed conf exist or not
    $conf_path_gfix="${save_cfg_head}.${conf}.hyp${hyp_smear}.gfixed${gauge_type}";
    $fixed_exist= -e ${conf_path_gfix};

## start to print
if($fixed_exist)
{
print <<"EOF";

EOF

$gfixed_id="default_gauge_field";
}

else{

  if($hyp_smear>0){
print <<"EOF";
    <elem>
      <Name>LINK_SMEAR</Name>
      <Frequency>1</Frequency>
      <Param>
        <version>5</version>
        <LinkSmearingType>HYP_SMEAR</LinkSmearingType>
        <alpha1>0.75</alpha1>
        <alpha2>0.6</alpha2>
        <alpha3>0.3</alpha3>
        <num_smear>1</num_smear>
        <no_smear_dir>-1</no_smear_dir>
        <BlkMax>100</BlkMax>
        <BlkAccu>1.0e-5</BlkAccu>
      </Param>
      <NamedObject>
        <gauge_id>default_gauge_field</gauge_id>
        <linksmear_id>APE_gauge_field</linksmear_id>
      </NamedObject>
    </elem>
EOF
$gauge_id="APE_gauge_field";
  } # hyp smear or not
  else{
    $gauge_id="default_gauge_field";
  }
####################################################################
########################### gauge fixing ###########################
####################################################################

if($gauge_type!=0){
print <<"EOF";
    <elem>
      <!-- Coulomb gauge fix -->
      <Name>COULOMB_GAUGEFIX</Name>
      <Frequency>1</Frequency>
      <Param>
        <version>1</version>
        <GFAccu>1.0e-6</GFAccu>
        <GFMax>200</GFMax>
        <OrDo>false</OrDo>
        <OrPara>1.0</OrPara>
        <j_decay>$gauge_type</j_decay>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>
        <gfix_id>coulomb_gauge_field</gfix_id>
        <gauge_rot_id>gauge_rot</gauge_rot_id>
      </NamedObject>
    </elem>

EOF
$gfixed_id="coulomb_gauge_field";
} # gauge fix or not
else{
   $gfixed_id= $gauge_id;
}

if($hyp_smear==0 && $gauge_type==0) { $save_cfg=0; } # 如果没做hyp smear和gauge fix，也没有必要存下来
if($save_cfg>0){
print <<"EOF";
    <elem>
      <Name>QIO_WRITE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <object_id>$gfixed_id</object_id>
        <object_type>Multi1dLatticeColorMatrix</object_type>
      </NamedObject>
      <File>
        <file_name>$conf_path_gfix</file_name>
        <file_volfmt>SINGLEFILE</file_volfmt>
        <parallel_io>true</parallel_io>
      </File>
    </elem>

EOF
} # save cfg or not

} # end gauge_fix_not_exsit

return $gfixed_id;
} # end sub print_body



1;