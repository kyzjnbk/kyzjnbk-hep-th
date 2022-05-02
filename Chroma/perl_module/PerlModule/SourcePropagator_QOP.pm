package SourcePropagator_QOP;

require CheckArgs;

#####################################################
#######   wall source, MG propagator
#####################################################

sub print_body_WallSource_MGProp{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=8)
    {
    print "Parameter number wrong: this function have 8 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $mom=$_[0];
    $t_src=$_[1];
    $gauge_id=$_[2];
    $quark_mass=$_[3];
    $clover=$_[4];
    $Residual=$_[5];
    $StoutLinkSmearing=$_[6];
    $mg_layout=$_[7];
    

    $smear_size=50;
    $smear_iter=0;


## make source
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
          <t_srce>0 0 0 $t_src</t_srce>
          <ini_mom>0 0 $mom 0</ini_mom>
          <grid>1 1 1 1</grid>
          <SmearingParam>
            <wvf_kind>GAUGE_INV_GAUSSIAN</wvf_kind>
            <wvf_param>$smear_size</wvf_param>
            <wvfIntPar>$smear_iter</wvfIntPar>
            <mom>0 0 0 0</mom>
            <no_smear_dir>3</no_smear_dir>
          </SmearingParam>
      </Source>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_ori</source_id>
    </NamedObject>
  </elem>
  
  <elem>
    <Name>MAKE_SOURCE</Name>
    <Frequency>1</Frequency>
    <Param>
      <version>6</version>
      <Source>
          <version>1</version>
          <SourceType>SHELL_SOURCE</SourceType>
          <j_decay>3</j_decay>
          <t_srce>0 0 0 $t_src</t_srce>
          <SmearingParam>
            <wvf_kind>GAUGE_INV_GAUSSIAN</wvf_kind>
            <wvf_param>0</wvf_param>
            <wvfIntPar>0</wvfIntPar>
            <mom>0 0 0 0</mom>
            <no_smear_dir>3</no_smear_dir>
          </SmearingParam>
      </Source>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_dummy</source_id>
    </NamedObject>
  </elem>
EOF
print <<"EOF";
  <elem>
    <Name>QPROPADD_cohen</Name>
    <Frequency>1</Frequency>
    <NamedObject>
      <j_decay>3</j_decay>
      <tA>$t_src $t_src</tA>
      <factorA>0.0</factorA>
      <propA>src_dummy</propA>
      <tB>$t_src $t_src</tB>
      <factorB>1.0</factorB>
      <propB>src_ori</propB>
      <propApB>src_P${mom}_t${t_src}</propApB>
    </NamedObject>
  </elem>
EOF

## make propagator
print <<"EOF";
  <elem>
    <Name>PROPAGATOR</Name>
    <Frequency>1</Frequency>
    <Param>
      <version>10</version>
      <quarkSpinType>FULL</quarkSpinType>
      <obsvP>true</obsvP>
      <numRetries>1</numRetries>
        <FermionAction>
          <FermAct>UNPRECONDITIONED_CLOVER</FermAct>
          <Mass>$quark_mass</Mass>
          <clovCoeff>$clover</clovCoeff>
EOF
if($StoutLinkSmearing==0)
{
print <<"EOF";
          <FermionBC>
            <FermBC>SIMPLE_FERMBC</FermBC>
            <boundary>1 1 1 -1</boundary>
          </FermionBC>
EOF
}
elsif($StoutLinkSmearing==1)
{
print <<"EOF";
          <FermState>
              <Name>STOUT_FERM_STATE</Name>
              <rho>0.125</rho>
              <n_smear>1</n_smear>
              <orthog_dir>-1</orthog_dir>
              <FermionBC>
                <FermBC>SIMPLE_FERMBC</FermBC>
                <boundary>1 1 1 -1</boundary>
              </FermionBC>
            </FermState>
EOF
}
else{
  print "\$StoutLinkSmearing must be 0 or 1!";
  exit;
}
print <<"EOF";
        </FermionAction>
	<InvertParam>
          <invType>QOP_CLOVER_MULTIGRID_INVERTER</invType>
          <Mass>$quark_mass</Mass>
          <Clover>$clover</Clover>
          <MaxIter>2000</MaxIter>
          <Residual>$Residual</Residual>
          <ExternalSubspace>true</ExternalSubspace>
          <SubspaceId>cpu_multigrid_m$quark_mass</SubspaceId>
          <RsdToleranceFactor>1.5</RsdToleranceFactor>
          <Levels>2</Levels>
          <Blocking>
            <elem>$mg_layout</elem>
            <elem>2 2 2 1</elem>
          </Blocking>
          <NumNullVecs>24 36</NumNullVecs>
          <NumExtraVecs>0 0</NumExtraVecs>
          <NullResidual>0.4 0.4</NullResidual>
          <NullMaxIter>100 100</NullMaxIter>
          <NullConvergence>0.1 0.1</NullConvergence>
          <Underrelax>1.0 1.0</Underrelax>
          <NumPreHits>0 0</NumPreHits>
          <NumPostHits>4 4</NumPostHits>
          <CoarseMaxIter>12 12</CoarseMaxIter>
          <CoarseResidual>0.1 0.1</CoarseResidual>
        </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_P${mom}_t${t_src}</source_id>
      <prop_id>prop_P${mom}_t${t_src}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";    
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_ori</object_id>
        </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_dummy</object_id>
        </NamedObject>
    </elem>
    
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_P${mom}_t${t_src}</object_id>
        </NamedObject>
    </elem>
EOF

return "prop_P${mom}_t${t_src}";

} # end print_body_WallSource_MGProp



#####################################################
#######   point source, MG propagator
#####################################################


sub print_body_PointSource_MGProp{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=15)
    {
    print "Parameter number wrong: this function have 15 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $ix=$_[0];
    $iy=$_[1];
    $iz=$_[2];
    $t_src=$_[3];
    $ns=$_[4];
    $nt=$_[5];
    $smear_size=$_[6];
    $smear_iter=$_[7];
    $smear_mom=$_[8];

    $gauge_id=$_[9];
    $quark_mass=$_[10];
    $clover=$_[11];
    $Residual=$_[12];
    $StoutLinkSmearing=$_[13];
    $mg_layout=$_[14];
    
    $mom=0;
    
## make source
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
          <t_srce>$ix $iy $iz $t_src</t_srce>
          <ini_mom>0 0 $mom 0</ini_mom>
          <grid>$ns $ns $ns $nt</grid>
          <SmearingParam>
            <wvf_kind>MOM_GAUSSIAN</wvf_kind>
            <wvf_param>$smear_size</wvf_param>
            <wvfIntPar>$smear_iter</wvfIntPar>
            <mom>0 0 $smear_mom 0</mom>
            <no_smear_dir>3</no_smear_dir>
          </SmearingParam>
      </Source>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_ori</source_id>
    </NamedObject>
  </elem>
  
  <elem>
    <Name>MAKE_SOURCE</Name>
    <Frequency>1</Frequency>
    <Param>
      <version>6</version>
      <Source>
          <version>1</version>
          <SourceType>SHELL_SOURCE</SourceType>
          <j_decay>3</j_decay>
          <t_srce>$ix $iy $iz $t_src</t_srce>
          <SmearingParam>
            <wvf_kind>GAUGE_INV_GAUSSIAN</wvf_kind>
            <wvf_param>0</wvf_param>
            <wvfIntPar>0</wvfIntPar>
            <mom>0 0 0 0</mom>
            <no_smear_dir>3</no_smear_dir>
          </SmearingParam>
      </Source>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_dummy</source_id>
    </NamedObject>
  </elem>
EOF
print <<"EOF";
  <elem>
    <Name>QPROPADD_cohen</Name>
    <Frequency>1</Frequency>
    <NamedObject>
      <j_decay>3</j_decay>
      <tA>$t_src $t_src</tA>
      <factorA>0.0</factorA>
      <propA>src_dummy</propA>
      <tB>$t_src $t_src</tB>
      <factorB>1.0</factorB>
      <propB>src_ori</propB>
      <propApB>src_P${mom}_t${t_src}</propApB>
    </NamedObject>
  </elem>
EOF

## make propagator
print <<"EOF";
  <elem>
    <Name>PROPAGATOR</Name>
    <Frequency>1</Frequency>
    <Param>
      <version>10</version>
      <quarkSpinType>FULL</quarkSpinType>
      <obsvP>true</obsvP>
      <numRetries>1</numRetries>
        <FermionAction>
          <FermAct>UNPRECONDITIONED_CLOVER</FermAct>
          <Mass>$quark_mass</Mass>
          <clovCoeff>$clover</clovCoeff>
EOF
if($StoutLinkSmearing==0)
{
print <<"EOF";
          <FermionBC>
            <FermBC>SIMPLE_FERMBC</FermBC>
            <boundary>1 1 1 -1</boundary>
          </FermionBC>
EOF
}
elsif($StoutLinkSmearing==1)
{
print <<"EOF";
          <FermState>
              <Name>STOUT_FERM_STATE</Name>
              <rho>0.125</rho>
              <n_smear>1</n_smear>
              <orthog_dir>-1</orthog_dir>
              <FermionBC>
                <FermBC>SIMPLE_FERMBC</FermBC>
                <boundary>1 1 1 -1</boundary>
              </FermionBC>
            </FermState>
EOF
}
else{
  print "\$StoutLinkSmearing must be 0 or 1!";
  exit;
}
print <<"EOF";
        </FermionAction>
	<InvertParam>
          <invType>QOP_CLOVER_MULTIGRID_INVERTER</invType>
          <Mass>$quark_mass</Mass>
          <Clover>${clover}</Clover>
          <MaxIter>2000</MaxIter>
          <Residual>$Residual</Residual>
          <ExternalSubspace>true</ExternalSubspace>
          <SubspaceId>cpu_multigrid_m$quark_mass</SubspaceId>
          <RsdToleranceFactor>1.5</RsdToleranceFactor>
          <Levels>2</Levels>
          <Blocking>
            <elem>${mg_layout}</elem>
            <elem>2 2 2 1</elem>
          </Blocking>
          <NumNullVecs>24 36</NumNullVecs>
          <NumExtraVecs>0 0</NumExtraVecs>
          <NullResidual>0.4 0.4</NullResidual>
          <NullMaxIter>100 100</NullMaxIter>
          <NullConvergence>0.1 0.1</NullConvergence>
          <Underrelax>1.0 1.0</Underrelax>
          <NumPreHits>0 0</NumPreHits>
          <NumPostHits>4 4</NumPostHits>
          <CoarseMaxIter>12 12</CoarseMaxIter>
          <CoarseResidual>0.1 0.1</CoarseResidual>
        </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>src_P${mom}_t${t_src}</source_id>
      <prop_id>prop_P${mom}_t${t_src}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";    
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_ori</object_id>
        </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_dummy</object_id>
        </NamedObject>
    </elem>
    
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>src_P${mom}_t${t_src}</object_id>
        </NamedObject>
    </elem>
EOF

return "prop_P${mom}_t${t_src}";

} # end print_body_PointSource_CGProp




1;
