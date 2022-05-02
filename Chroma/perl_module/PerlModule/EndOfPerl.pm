#!/usr/bin/perl

package EndOfPerl;

require GaugeFix;
require CheckArgs;

#####################################################
#######   main function, print need
#####################################################

sub print_body{

## 判断函数的参数个数，如果参数个数不对的话报错
$para_no=@_;
if($para_no!=8)
{
print "Parameter number wrong: this function have 8 parameter, but read $para_no!";
exit;
}
CheckArgs::checkList(@_);

$ns=$_[0];
$nt=$_[1];
$conf=$_[2];
$hyp_smear=$_[3];
$gauge_type=$_[4];

$save_cfg_head=$_[5];
$conf_type=$_[6];
$conf_path=$_[7];

my($fixed_exist, $conf_path_gfix)=GaugeFix::fixed_exist($conf, $hyp_smear, $gauge_type, $save_cfg_head);




#    <elem>
#      <Name>ERASE_QUDA_MULTIGRID_SUBSPACE_v2</Name>
#      <Frequency>1</Frequency>
#      <NamedObject>
#         <object_id>quda_mg_subspace</object_id>
#      </NamedObject>
#    </elem>

print <<"EOF";

  </InlineMeasurements>
    <nrow>$ns $ns $ns $nt</nrow>
</Param>

  <RNG>
    <Seed>
      <elem>11</elem>
      <elem>11</elem>
      <elem>11</elem>
      <elem>0</elem>
    </Seed>
  </RNG>

EOF

if($fixed_exist){
print <<"EOF";

  <Cfg>
    <cfg_type>SCIDAC</cfg_type>
    <cfg_file>$conf_path_gfix</cfg_file>
    <parallel_io>true</parallel_io>
  </Cfg>
EOF
}
else
{
print <<"EOF";

  <Cfg>
    <cfg_type>${conf_type}</cfg_type>
    <cfg_file>$conf_path</cfg_file>
    <parallel_io>true</parallel_io>
  </Cfg>
EOF
}

print <<"EOF";

</chroma>
EOF
}

1;
