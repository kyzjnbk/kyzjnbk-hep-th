package SinkSmear;

require CheckArgs;

sub PointSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=3)
    {
    print "Parameter number wrong: this function have 3 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $prop_id=$_[0];
    $smear_prop_id=$_[1];
    $gauge_id=$_[2];
    
    $save_smear_prop=0;  # 如果保存的话，需要重新设置保存的路径
    $save_smear_prop_filename='xx';



print<<"EOF";

    <elem>
      <Name>SINK_SMEAR</Name>
      <Frequency>1</Frequency>
      <Param>
        <version>5</version>
        <Sink>
          <version>1</version>
          <SinkType>POINT_SINK</SinkType>
          <j_decay>3</j_decay>
        </Sink>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>
        <prop_id>$prop_id</prop_id>
        <smeared_prop_id>$smear_prop_id</smeared_prop_id>
      </NamedObject>
    </elem>

EOF

if($save_smear_prop)
{
## save prop
print <<"EOF";
    <elem>
      <annotation>
        Write the named object
      </annotation>
      <Name>QIO_WRITE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <object_id>$smear_prop_id</object_id>
        <object_type>LatticePropagator</object_type>
      </NamedObject>
      <File>
        <file_name>${save_smear_prop_filename}</file_name>
        <file_volfmt>SINGLEFILE</file_volfmt>
      </File>
    </elem>

EOF
}



return $smear_prop_id;

} # end PointSink




##################################################
##
#################################################

sub SmearedSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=6)
    {
    print "Parameter number wrong: this function have 6 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $prop_id=$_[0];
    $smear_prop_id=$_[1];
    $gauge_id=$_[2];

    $smear_size=$_[3];
    $smear_iter=$_[4];
    $smear_mom=$_[5];


    $save_smear_prop=0;  # 如果保存的话，需要重新设置保存的路径
    $save_smear_prop_filename='xx';
    



print<<"EOF";

   <elem>
      <Name>SINK_SMEAR</Name>
      <Frequency>1</Frequency>
      <Param>
        <version>5</version>
        <Sink>
          <version>1</version>
          <SinkType>SHELL_SINK</SinkType>
          <j_decay>3</j_decay>
          <SmearingParam>
            <wvf_kind>MOM_GAUSSIAN</wvf_kind>
            <wvf_param>$smear_size</wvf_param>
            <wvfIntPar>$smear_iter</wvfIntPar>
            <no_smear_dir>3</no_smear_dir>
            <mom>0 0 $smear_mom 0</mom>
            <qudaSmearingP>true</qudaSmearingP>
            <Verbose>false</Verbose>
            <checkP>false</checkP>
         </SmearingParam>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </Param>
      <NamedObject>
        <gauge_id>$gauge_id</gauge_id>
        <prop_id>$prop_id</prop_id>
        <smeared_prop_id>$smear_prop_id</smeared_prop_id>
      </NamedObject>
    </elem>

 
EOF

if($save_smear_prop)
{
## save prop
print <<"EOF";
    <elem>
      <annotation>
        Write the named object
      </annotation>
      <Name>QIO_WRITE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <object_id>$smear_prop_id</object_id>
        <object_type>LatticePropagator</object_type>
      </NamedObject>
      <File>
        <file_name>${save_smear_prop_filename}</file_name>
        <file_volfmt>SINGLEFILE</file_volfmt>
      </File>
    </elem>

EOF
}




return $smear_prop_id;
} # end SmearedSink

1;