#!/usr/bin/perl

package SaveReadPropagator;
require CheckArgs;

#####################################################
#######   保存的propagators是不是存在
#####################################################

sub saved_prop_exist{ # param: $fixed_exist

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=2)
    {
    print "Parameter number wrong: this function have 2 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $save_prop_path=$_[0];
    $save_prop_name=$_[1];

    ## saved props exist or not
    $saved_exist= -e "${save_prop_path}/${save_prop_name}";

    return $saved_exist

} # sub fixed_exist


#####################################################
#######   QIO version
#####################################################

sub QIO_save{

  ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=4)
    {
    print "Parameter number wrong: this function have 4 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $prop_id=$_[0];
    $parallel_io=$_[1]; # true or false
    $save_prop_path=$_[2];
    $save_prop_name=$_[3];

    $saved_exist= -e "${save_prop_path}/${save_prop_name}";
    
if($saved_exist)
{
print <<"EOF";

EOF
}
else
{
print <<"EOF";
  <elem>
    <annotation>
      Write the named object
    </annotation>
    <Name>QIO_WRITE_NAMED_OBJECT</Name>
    <Frequency>1</Frequency>
    <NamedObject>
      <object_id>$prop_id</object_id>
      <object_type>LatticePropagator</object_type>
    </NamedObject>
    <File>
      <file_name>${save_prop_path}/${save_prop_name}</file_name>
      <file_volfmt>SINGLEFILE</file_volfmt>
      <parallel_io>$parallel_io</parallel_io>
    </File>
  </elem>

EOF

}

} # end QIO save


########################################################
sub QIO_read{

  ## 判断函数的参数个数，如果参数个数不对的话报错
  $para_no=@_;
  if($para_no!=3)
  {
  print "Parameter number wrong: this function have 3 parameter, but read $para_no!";
  exit;
  }
  CheckArgs::checkList(@_);

  $parallel_io=$_[0]; # true or false
  $save_prop_path=$_[1];
  $save_prop_name=$_[2];

  $saved_exist= -e "${save_prop_path}/${save_prop_name}";
  
if($saved_exist)
{

print <<"EOF"; 
    <elem>
      <annotation>
        Read the prop
      </annotation>
      <Name>QIO_READ_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <object_id>${save_prop_name}</object_id>
        <object_type>LatticePropagator</object_type>
      </NamedObject>
      <File>
        <file_name>${save_prop_path}/${save_prop_name}</file_name>
        <parallel_io>$parallel_io</parallel_io>
      </File>
    </elem>

EOF
}
else
{
  print "Cannot find the saved propagators: ${save_prop_path}/${save_prop_name}";
  exit;
}
return $save_prop_name;

} # end QIO read


#####################################################
#######   inline version
#####################################################

sub inline_save{

  ## 判断函数的参数个数，如果参数个数不对的话报错
  $para_no=@_;
  if($para_no!=4)
  {
  print "Parameter number wrong: this function have 4 parameter, but read $para_no!";
  exit;
  }
  CheckArgs::checkList(@_);

  $prop_id=$_[0];
  $io_num=$_[1]; # io的进程数，我建议取时间方向的计算进程数
  $save_prop_path=$_[2];
  $save_prop_name=$_[3];

  $saved_exist= -e "${save_prop_path}/${save_prop_name}";

if($saved_exist)
{
print <<"EOF";

EOF
}
else
{
print <<"EOF";
    <elem>
        <Name>SAVE_PROPAGATOR</Name>
        <Frequency>1</Frequency>
        <io_num>$io_num</io_num>
        <endian>false</endian>
        <PropName>${save_prop_path}/${save_prop_name}</PropName>
        <NamedObject>
            <prop_id>$prop_id</prop_id>
        </NamedObject>
    </elem>

EOF

}

} # end inline save


########################################################

sub inline_read{

  ## 判断函数的参数个数，如果参数个数不对的话报错
  $para_no=@_;
  if($para_no!=9)
  {
  print "Parameter number wrong: this function have 9 parameter, but read $para_no!";
  exit;
  }
  CheckArgs::checkList(@_);

  $io_num=$_[0]; # true or false
  $save_prop_path=$_[1];
  $save_prop_name=$_[2];
  $ix=$_[3];
  $iy=$_[4];
  $iz=$_[5];
  $it0=$_[6];
  $ns=$_[7];
  $nt=$_[8];

  ## 用不到，为了骗过chroma的
  $smear_size=4;
  $smear_iter=30;
  $smear_mom=2;


  $saved_exist= -e "${save_prop_path}/${save_prop_name}";

if($saved_exist)
{
print <<"EOF";
    <elem>
      <Name>MAKE_SOURCE</Name>
      <Frequency>1</Frequency>
      <Param>
        <version>6</version>
        <Source>
            <version>1</version>
            <SourceType>MOM_GRID_SOURCE</SourceType>
            <j_decay>3</j_decay>
            <t_srce>$ix $iy $iz $it0</t_srce>
            <grid>$ns $ns $ns $nt</grid>
            <ini_mom> 0 0 0 </ini_mom>
            <SmearingParam>
              <wvf_kind>MOM_GAUSSIAN</wvf_kind>
              <wvf_param>$smear_size</wvf_param>
              <wvfIntPar>$smear_iter</wvfIntPar>
              <mom>0 0 $smear_mom 0</mom>
              <no_smear_dir>3</no_smear_dir>
              <qudaSmearingP>true</qudaSmearingP>
              <Verbose>false</Verbose>
              <checkP>false</checkP>
            </SmearingParam>
        </Source>
      </Param>
      <NamedObject>
        <gauge_id>default_gauge_field</gauge_id>
        <source_id>source_for_read</source_id>
      </NamedObject>
    </elem>

    <elem>
        <Name>READ_PROPAGATOR</Name>
        <Frequency>1</Frequency>
        <io_num>$io_num</io_num>
        <endian>false</endian>
        <PropName>${save_prop_path}/${save_prop_name}</PropName>
        <Param>
        <version>10</version>
        <quarkSpinType>FULL</quarkSpinType>
        <obsvP>false</obsvP>
        <numRetries>1</numRetries>
        <FermionAction>
        <FermAct>CLOVER</FermAct>
        <Kappa>0.115</Kappa>
        <clovCoeff>1.17</clovCoeff>
        <clovCoeffR>0.91</clovCoeffR>
        <clovCoeffT>1.07</clovCoeffT>
        <AnisoParam>
        <anisoP>true</anisoP>
        <t_dir>3</t_dir>
        <xi_0>2.464</xi_0>
        <nu>0.95</nu>
        </AnisoParam>
        <FermionBC>
        <FermBC>SIMPLE_FERMBC</FermBC>
        <boundary>1 1 1 -1</boundary>
        </FermionBC>
        </FermionAction>
        <InvertParam>
        <invType>CG_INVERTER</invType>
        <RsdCG>1.0e-12</RsdCG>
        <MaxCG>1000</MaxCG>
        </InvertParam>
        </Param>
        <NamedObject>
            <gauge_id>default_gauge_field</gauge_id>
            <source_id>source_for_read</source_id>
            <prop_id>${save_prop_name}</prop_id>
        </NamedObject>
    </elem>

  <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>source_for_read</object_id>
        </NamedObject>
    </elem>
EOF

}
else
{
  print "Cannot find the saved propagators: ${save_prop_path}/${save_prop_name}";
  exit;
}
return $save_prop_name;

} # end inline read


1;