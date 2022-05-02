#!/usr/bin/perl

package SequentialPropagator;

require CheckArgs;


#####################################################
#######   main function, print Nucleon sequential
#####################################################

## 注意：在用wall source的时候，需要保证两个u夸克传播子的动量相同，否则需要考虑一个额外的对称性
## 这里$prop_spec1_id是旁观者u夸克，$prop_spec2_id是旁观者d夸克


sub print_body_NUCL_CGProp_PointSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=11)
    {
    print "Parameter number wrong: this function have 11 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $n_src=$_[0];
    $t_seq=$_[1];
    $mom_seq=$_[2];
    $bwd_quark_mass=$_[3];

    $prop_spec1_id=$_[4];
    $prop_spec2_id=$_[5];
    $gauge_id=$_[6];

    $nt=$_[7];
    $clover=$_[8];
    $Residual=$_[9];
    $StoutLinkSmearing=$_[10];

    $SeqSourceType="NUCL_ISO_UNPOL_NONREL";

## Position of the seqential source
for( $id = 0; $id < $n_src; $id = $id + 1 ){  
   #$itq=$src_position[4*$id+3]+$t_seq;
   $itq=$it0+$nt/$n_src*$id+$t_seq;
   if($itq>=$nt) {$itq-=$nt;}


## -------------------------------
##   Make sequential source
## -------------------------------
print <<"EOF";

    <elem>
      <Name>SEQSOURCE_FAST</Name>
      <SmearedProps>true</SmearedProps>
      <multi_tSinks>${itq}</multi_tSinks>
      <Frequency>1</Frequency>
      <Param>
        <version>2</version>
        <SeqSource>
          <version>1</version>
          <SeqSourceType>${SeqSourceType}</SeqSourceType>
          <j_decay>3</j_decay>
          <t_sink>0</t_sink>
          <sink_mom>0 0 $mom_seq</sink_mom>
        </SeqSource>
      </Param>
      <PropSink>
        <version>5</version>
        <Sink>
          <version>2</version>
          <SinkType>POINT_SINK</SinkType>
          <j_decay>3</j_decay>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </PropSink>
      <NamedObject>
        <prop_ids>
          <elem>$prop_spec1_id</elem>
          <elem>$prop_spec2_id</elem>
        </prop_ids>
        <seqsource_id>      
          <elem>seqsrc.id${id}</elem>
        </seqsource_id>
        <gauge_id>$gauge_id</gauge_id>
      </NamedObject>
   </elem>

EOF

} # end loop id

## -----------------------------------------
##   Add sequential source together
## -----------------------------------------
for( $id = 1; $id < $n_src; $id = $id + 1 )
{
  if($id==1){
    $seqprop_A="seqsrc.id0";
    $seqprop_sum="seqsrc.src0+src1";

  }
  else{
    $seqprop_A=$seqprop_sum;
    $seqprop_sum.="+src$id";
    }

  $tA0=$it0+$t_seq; $tA1=$it0+($id-1)*$nt/$n_src+$t_seq;
  $tB0=$it0+$id*$nt/$n_src+$t_seq;
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA0>=$nt) {$tA0=$tA0-$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }



  print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
EOF
#        <tA>$tA0 $tA1</tA>
print <<"EOF";
        <factorA>1.0</factorA>
        <propA>${seqprop_A}</propA>
EOF
#        <tB>$tB0 $tB0</tB>
print <<"EOF";
        <factorB>1.0</factorB>
        <propB>seqsrc.id${id}</propB>
        <propApB>${seqprop_sum}</propApB>
      </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
            <object_id>$seqprop_A</object_id>
        </NamedObject>
    </elem>

EOF
} # end loop id

if($n_src==1)
{
  $seqprop_sum="seqsrc.id0";
}

for( $id = 1; $id < $n_src; $id = $id + 1 )
{
print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>seqsrc.id${id}</object_id>
      </NamedObject>
  </elem>

EOF
}

## use the added seqsrc make propagator
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
          <FermAct>CLOVER</FermAct>
          <Mass>$bwd_quark_mass</Mass>
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
          <invType>QUDA_CLOVER_INVERTER_v2</invType>
          <MaxIter>1000</MaxIter>
          <CloverParams>
          <Mass>$bwd_quark_mass</Mass>
          <clovCoeff>$clover</clovCoeff>
          <AnisoParam>
            <anisoP>false</anisoP>
            <t_dir>3</t_dir>
            <xi_0>1.0</xi_0>
            <nu>1</nu>
          </AnisoParam>
            <FermionBC>
              <FermBC>SIMPLE_FERMBC</FermBC>
              <boundary>1 1 1 -1</boundary>
            </FermionBC>
          </CloverParams>
          <RsdTarget>$Residual</RsdTarget>
          <Delta>0.1</Delta>
          <RsdToleranceFactor>100</RsdToleranceFactor>            
          <AntiPeriodicT>true</AntiPeriodicT>
          <SolverType>GCR</SolverType>
          <Verbose>true</Verbose>
          <AsymmetricLinop>true</AsymmetricLinop>
          <CudaReconstruct>RECONS_12</CudaReconstruct>
          <CudaSloppyPrecision>SINGLE</CudaSloppyPrecision>
          <CudaSloppyReconstruct>RECONS_12</CudaSloppyReconstruct>
          <AutotuneDslash>false</AutotuneDslash>            
        </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>${seqprop_sum}</source_id>
      <prop_id>${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>${seqprop_sum}</object_id>
      </NamedObject>
  </elem>

EOF

return "${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}";
} # end print_body


#####################################################
#######   main function, print Nucleon sequential
#####################################################

sub print_body_NUCL_CGProp_SmearedSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=14)
    {
    print "Parameter number wrong: this function have 14 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $n_src=$_[0];
    $t_seq=$_[1];
    $mom_seq=$_[2];
    $bwd_quark_mass=$_[3];

    $prop_spec1_id=$_[4];
    $prop_spec2_id=$_[5];
    $gauge_id=$_[6];

    $nt=$_[7];
    $clover=$_[8];
    $Residual=$_[9];
    $smear_size=$_[10];
    $smear_iter=$_[11];
    $smear_mom=$_[12];
    $StoutLinkSmearing=$_[13];

    $SeqSourceType="NUCL_ISO_UNPOL_NONREL";

## Position of the seqential source
for( $id = 0; $id < $n_src; $id = $id + 1 ){  
   #$itq=$src_position[4*$id+3]+$t_seq;
   $itq=$it0+$nt/$n_src*$id+$t_seq;
   if($itq>=$nt) {$itq-=$nt;}


## -------------------------------
##   Make sequential source
## -------------------------------
print <<"EOF";
    <elem>
      <Name>SEQSOURCE_FAST</Name>
      <SmearedProps>true</SmearedProps>
      <multi_tSinks>${itq}</multi_tSinks>
      <Frequency>1</Frequency>
      <Param>
        <version>2</version>
        <SeqSource>
          <version>1</version>
          <SeqSourceType>${SeqSourceType}</SeqSourceType>
          <j_decay>3</j_decay>
          <t_sink>0</t_sink>
          <sink_mom>0 0 $mom_seq</sink_mom>
        </SeqSource>
      </Param>
      <PropSink>
        <version>5</version>
        <Sink>
          <version>2</version>
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
             <checkP>true</checkP>
          </SmearingParam>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </PropSink>
      <NamedObject>
        <prop_ids>
          <elem>$prop_spec1_id</elem>
          <elem>$prop_spec2_id</elem>
        </prop_ids>
        <seqsource_id>      
          <elem>seqsrc.id${id}</elem>
        </seqsource_id>
        <gauge_id>$gauge_id</gauge_id>
      </NamedObject>
   </elem>

EOF

} # end loop id

## -----------------------------------------
##   Add sequential source together
## -----------------------------------------
for( $id = 1; $id < $n_src; $id = $id + 1 )
{
  if($id==1){
    $seqprop_A="seqsrc.id0";
    $seqprop_sum="seqsrc.src0+src1";

  }
  else{
    $seqprop_A=$seqprop_sum;
    $seqprop_sum.="+src$id";
    }

  $tA0=$it0+$t_seq; $tA1=$it0+($id-1)*$nt/$n_src+$t_seq;
  $tB0=$it0+$id*$nt/$n_src+$t_seq;
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA0>=$nt) {$tA0=$tA0-$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }



  print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
EOF
#        <tA>$tA0 $tA1</tA>
print <<"EOF";
        <factorA>1.0</factorA>
        <propA>${seqprop_A}</propA>
EOF
#        <tB>$tB0 $tB0</tB>
print <<"EOF";
        <factorB>1.0</factorB>
        <propB>seqsrc.id${id}</propB>
        <propApB>${seqprop_sum}</propApB>
      </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
            <object_id>$seqprop_A</object_id>
        </NamedObject>
    </elem>

EOF
} # end loop id

if($n_src==1)
{
  $seqprop_sum="seqsrc.id0";
}

for( $id = 1; $id < $n_src; $id = $id + 1 )
{
print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>seqsrc.id${id}</object_id>
      </NamedObject>
  </elem>

EOF
}

## use the added seqsrc make propagator
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
          <FermAct>CLOVER</FermAct>
          <Mass>$bwd_quark_mass</Mass>
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
          <invType>QUDA_CLOVER_INVERTER_v2</invType>
          <MaxIter>1000</MaxIter>
          <CloverParams>
          <Mass>$bwd_quark_mass</Mass>
          <clovCoeff>$clover</clovCoeff>
          <AnisoParam>
            <anisoP>false</anisoP>
            <t_dir>3</t_dir>
            <xi_0>1.0</xi_0>
            <nu>1</nu>
          </AnisoParam>
            <FermionBC>
              <FermBC>SIMPLE_FERMBC</FermBC>
              <boundary>1 1 1 -1</boundary>
            </FermionBC>
          </CloverParams>
          <RsdTarget>$Residual</RsdTarget>
          <Delta>0.1</Delta>
          <RsdToleranceFactor>100</RsdToleranceFactor>            
          <AntiPeriodicT>true</AntiPeriodicT>
          <SolverType>GCR</SolverType>
          <Verbose>true</Verbose>
          <AsymmetricLinop>true</AsymmetricLinop>
          <CudaReconstruct>RECONS_12</CudaReconstruct>
          <CudaSloppyPrecision>SINGLE</CudaSloppyPrecision>
          <CudaSloppyReconstruct>RECONS_12</CudaSloppyReconstruct>
          <AutotuneDslash>false</AutotuneDslash>            
        </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>${seqprop_sum}</source_id>
      <prop_id>${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>${seqprop_sum}</object_id>
      </NamedObject>
  </elem>

EOF

return "${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}";
} # end print_body

#####################################################
#######   main function, print Nucleon sequential
#####################################################

sub print_body_NUCL_MGProp_PointSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=12)
    {
    print "Parameter number wrong: this function have 15 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $n_src=$_[0];
    $t_seq=$_[1];
    $mom_seq=$_[2];
    $bwd_quark_mass=$_[3];

    $prop_spec1_id=$_[4];
    $prop_spec2_id=$_[5];
    $gauge_id=$_[6];

    $nt=$_[7];
    $clover=$_[8];
    $Residual=$_[9];
    $StoutLinkSmearing=$_[10];
    $mg_layout=$_[11];

    $SeqSourceType="NUCL_ISO_UNPOL_NONREL";

## Position of the seqential source
for( $id = 0; $id < $n_src; $id = $id + 1 ){  
   #$itq=$src_position[4*$id+3]+$t_seq;
   $itq=$it0+$nt/$n_src*$id+$t_seq;
   if($itq>=$nt) {$itq-=$nt;}


## -------------------------------
##   Make sequential source
## -------------------------------
print <<"EOF";
    <elem>
      <Name>SEQSOURCE_FAST</Name>
      <SmearedProps>true</SmearedProps>
      <multi_tSinks>${itq}</multi_tSinks>
      <Frequency>1</Frequency>
      <Param>
        <version>2</version>
        <SeqSource>
          <version>1</version>
          <SeqSourceType>${SeqSourceType}</SeqSourceType>
          <j_decay>3</j_decay>
          <t_sink>0</t_sink>
          <sink_mom>0 0 $mom_seq</sink_mom>
        </SeqSource>
      </Param>
      <PropSink>
        <version>5</version>
        <Sink>
          <version>2</version>
          <SinkType>POINT_SINK</SinkType>
          <j_decay>3</j_decay>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </PropSink>
      <NamedObject>
        <prop_ids>
          <elem>$prop_spec1_id</elem>
          <elem>$prop_spec2_id</elem>
        </prop_ids>
        <seqsource_id>      
          <elem>seqsrc.id${id}</elem>
        </seqsource_id>
        <gauge_id>$gauge_id</gauge_id>
      </NamedObject>
   </elem>

EOF

} # end loop id

## -----------------------------------------
##   Add sequential source together
## -----------------------------------------
for( $id = 1; $id < $n_src; $id = $id + 1 )
{
  if($id==1){
    $seqprop_A="seqsrc.id0";
    $seqprop_sum="seqsrc.src0+src1";

  }
  else{
    $seqprop_A=$seqprop_sum;
    $seqprop_sum.="+src$id";
    }

  $tA0=$it0+$t_seq; $tA1=$it0+($id-1)*$nt/$n_src+$t_seq;
  $tB0=$it0+$id*$nt/$n_src+$t_seq;
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA0>=$nt) {$tA0=$tA0-$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }



print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
EOF
#        <tA>$tA0 $tA1</tA>
print <<"EOF";
        <factorA>1.0</factorA>
        <propA>${seqprop_A}</propA>
EOF
#        <tB>$tB0 $tB0</tB>
print <<"EOF";
        <factorB>1.0</factorB>
        <propB>seqsrc.id${id}</propB>
        <propApB>${seqprop_sum}</propApB>
      </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
            <object_id>$seqprop_A</object_id>
        </NamedObject>
    </elem>

EOF
} # end loop id

if($n_src==1)
{
  $seqprop_sum="seqsrc.id0";
}

for( $id = 1; $id < $n_src; $id = $id + 1 )
{
print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>seqsrc.id${id}</object_id>
      </NamedObject>
  </elem>

EOF
}

## use the added seqsrc make propagator
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
          <FermAct>CLOVER</FermAct>
          <Mass>$bwd_quark_mass</Mass>
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
          <invType>QUDA_MULTIGRID_CLOVER_INVERTER_v2</invType>
            <MULTIGRIDParams>
              <RelaxationOmegaMG>1.0</RelaxationOmegaMG>
              <RelaxationOmegaOuter>1.0</RelaxationOmegaOuter>
              <CheckMultigridSetup>true</CheckMultigridSetup>
              <Residual>1.0e-1</Residual>
              <MaxIterations>12</MaxIterations>
              <MaxCoarseIterations>1000</MaxCoarseIterations>
              <CoarseResidual>0.1</CoarseResidual>              
              <Verbosity>true</Verbosity>
              <Precision>SINGLE</Precision>
              <Reconstruct>RECONS_12</Reconstruct>
              <NullVectors>24</NullVectors>
              <GenerateNullspace>true</GenerateNullspace>
              <GenerateAllLevels>true</GenerateAllLevels>
              <CheckMultigridSetup>true</CheckMultigridSetup>
              <CycleType>MG_RECURSIVE</CycleType>
              <Pre-SmootherApplications>0</Pre-SmootherApplications>
              <Post-SmootherApplications>8</Post-SmootherApplications>
              <SchwarzType>ADDITIVE_SCHWARZ</SchwarzType>
              <Blocking>
                <elem>$mg_layout</elem>
              </Blocking>
            </MULTIGRIDParams>
            <SubspaceID>quda_mg_subspace</SubspaceID>
            <ThresholdCount>500</ThresholdCount>
            <MaxIter>1000</MaxIter>
            <CloverParams>
            <Mass>$bwd_quark_mass</Mass>
            <clovCoeff>$clover</clovCoeff>
            <AnisoParam>
              <anisoP>false</anisoP>
              <t_dir>3</t_dir>
              <xi_0>1.0</xi_0>
              <nu>1</nu>
            </AnisoParam>
              <FermionBC>
                <FermBC>SIMPLE_FERMBC</FermBC>
                <boundary>1 1 1 -1</boundary>
              </FermionBC>
            </CloverParams>
            <RsdTarget>$Residual</RsdTarget>
            <Delta>0.1</Delta>
            <RsdToleranceFactor>100</RsdToleranceFactor>            
            <AntiPeriodicT>true</AntiPeriodicT>
            <SolverType>GCR</SolverType>
            <Verbose>true</Verbose>
            <AsymmetricLinop>true</AsymmetricLinop>
            <CudaReconstruct>RECONS_12</CudaReconstruct>
            <CudaSloppyPrecision>SINGLE</CudaSloppyPrecision>
            <CudaSloppyReconstruct>RECONS_12</CudaSloppyReconstruct>
            <AutotuneDslash>false</AutotuneDslash>
         </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>${seqprop_sum}</source_id>
      <prop_id>${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>${seqprop_sum}</object_id>
      </NamedObject>
  </elem>

EOF

return "${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}";
} # end print_body

#####################################################
#######   main function, print Nucleon sequential
#####################################################

sub print_body_NUCL_MGProp_SmearedSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=15)
    {
    print "Parameter number wrong: this function have 15 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $n_src=$_[0];
    $t_seq=$_[1];
    $mom_seq=$_[2];
    $bwd_quark_mass=$_[3];

    $prop_spec1_id=$_[4];
    $prop_spec2_id=$_[5];
    $gauge_id=$_[6];

    $nt=$_[7];
    $clover=$_[8];
    $Residual=$_[9];
    $smear_size=$_[10];
    $smear_iter=$_[11];
    $smear_mom=$_[12];
    $StoutLinkSmearing=$_[13];
    $mg_layout=$_[14];

    $SeqSourceType="NUCL_ISO_UNPOL_NONREL";

## Position of the seqential source
for( $id = 0; $id < $n_src; $id = $id + 1 ){  
   #$itq=$src_position[4*$id+3]+$t_seq;
   $itq=$it0+$nt/$n_src*$id+$t_seq;
   if($itq>=$nt) {$itq-=$nt;}


## -------------------------------
##   Make sequential source
## -------------------------------
print <<"EOF";
    <elem>
      <Name>SEQSOURCE_FAST</Name>
      <SmearedProps>true</SmearedProps>
      <multi_tSinks>${itq}</multi_tSinks>
      <Frequency>1</Frequency>
      <Param>
        <version>2</version>
        <SeqSource>
          <version>1</version>
          <SeqSourceType>${SeqSourceType}</SeqSourceType>
          <j_decay>3</j_decay>
          <t_sink>0</t_sink>
          <sink_mom>0 0 $mom_seq</sink_mom>
        </SeqSource>
      </Param>
      <PropSink>
        <version>5</version>
        <Sink>
          <version>2</version>
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
             <checkP>true</checkP>
          </SmearingParam>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </PropSink>
      <NamedObject>
        <prop_ids>
          <elem>$prop_spec1_id</elem>
          <elem>$prop_spec2_id</elem>
        </prop_ids>
        <seqsource_id>      
          <elem>seqsrc.id${id}</elem>
        </seqsource_id>
        <gauge_id>$gauge_id</gauge_id>
      </NamedObject>
   </elem>

EOF

} # end loop id

## -----------------------------------------
##   Add sequential source together
## -----------------------------------------
for( $id = 1; $id < $n_src; $id = $id + 1 )
{
  if($id==1){
    $seqprop_A="seqsrc.id0";
    $seqprop_sum="seqsrc.src0+src1";

  }
  else{
    $seqprop_A=$seqprop_sum;
    $seqprop_sum.="+src$id";
    }

  $tA0=$it0+$t_seq; $tA1=$it0+($id-1)*$nt/$n_src+$t_seq;
  $tB0=$it0+$id*$nt/$n_src+$t_seq;
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA0>=$nt) {$tA0=$tA0-$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }



print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
EOF
#        <tA>$tA0 $tA1</tA>
print <<"EOF";
        <factorA>1.0</factorA>
        <propA>${seqprop_A}</propA>
EOF
#        <tB>$tB0 $tB0</tB>
print <<"EOF";
        <factorB>1.0</factorB>
        <propB>seqsrc.id${id}</propB>
        <propApB>${seqprop_sum}</propApB>
      </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
            <object_id>$seqprop_A</object_id>
        </NamedObject>
    </elem>

EOF
} # end loop id

if($n_src==1)
{
  $seqprop_sum="seqsrc.id0";
}

for( $id = 1; $id < $n_src; $id = $id + 1 )
{
print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>seqsrc.id${id}</object_id>
      </NamedObject>
  </elem>

EOF
}

## use the added seqsrc make propagator
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
          <FermAct>CLOVER</FermAct>
          <Mass>$bwd_quark_mass</Mass>
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
          <invType>QUDA_MULTIGRID_CLOVER_INVERTER_v2</invType>
            <MULTIGRIDParams>
              <RelaxationOmegaMG>1.0</RelaxationOmegaMG>
              <RelaxationOmegaOuter>1.0</RelaxationOmegaOuter>
              <CheckMultigridSetup>true</CheckMultigridSetup>
              <Residual>1.0e-1</Residual>
              <MaxIterations>12</MaxIterations>
              <MaxCoarseIterations>1000</MaxCoarseIterations>
              <CoarseResidual>0.1</CoarseResidual>              
              <Verbosity>true</Verbosity>
              <Precision>SINGLE</Precision>
              <Reconstruct>RECONS_12</Reconstruct>
              <NullVectors>24</NullVectors>
              <GenerateNullspace>true</GenerateNullspace>
              <GenerateAllLevels>true</GenerateAllLevels>
              <CheckMultigridSetup>true</CheckMultigridSetup>
              <CycleType>MG_RECURSIVE</CycleType>
              <Pre-SmootherApplications>0</Pre-SmootherApplications>
              <Post-SmootherApplications>8</Post-SmootherApplications>
              <SchwarzType>ADDITIVE_SCHWARZ</SchwarzType>
              <Blocking>
                <elem>$mg_layout</elem>
              </Blocking>
            </MULTIGRIDParams>
            <SubspaceID>quda_mg_subspace</SubspaceID>
            <ThresholdCount>500</ThresholdCount>
            <MaxIter>1000</MaxIter>
            <CloverParams>
            <Mass>$bwd_quark_mass</Mass>
            <clovCoeff>$clover</clovCoeff>
            <AnisoParam>
              <anisoP>false</anisoP>
              <t_dir>3</t_dir>
              <xi_0>1.0</xi_0>
              <nu>1</nu>
            </AnisoParam>
              <FermionBC>
                <FermBC>SIMPLE_FERMBC</FermBC>
                <boundary>1 1 1 -1</boundary>
              </FermionBC>
            </CloverParams>
            <RsdTarget>$Residual</RsdTarget>
            <Delta>0.1</Delta>
            <RsdToleranceFactor>100</RsdToleranceFactor>            
            <AntiPeriodicT>true</AntiPeriodicT>
            <SolverType>GCR</SolverType>
            <Verbose>true</Verbose>
            <AsymmetricLinop>true</AsymmetricLinop>
            <CudaReconstruct>RECONS_12</CudaReconstruct>
            <CudaSloppyPrecision>SINGLE</CudaSloppyPrecision>
            <CudaSloppyReconstruct>RECONS_12</CudaSloppyReconstruct>
            <AutotuneDslash>false</AutotuneDslash>
         </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>${seqprop_sum}</source_id>
      <prop_id>${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>${seqprop_sum}</object_id>
      </NamedObject>
  </elem>

EOF

return "${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}";
} # end print_body



#####################################################
#######   main function, print Pion sequential
#####################################################

sub print_body_PION_CGProp_PointSink{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=10)
    {
    print "Parameter number wrong: this function have 9 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);


    $n_src=$_[0];
    $t_seq=$_[1];
    $mom_seq=$_[2];
    $bwd_quark_mass=$_[3];

    $prop_spec_id=$_[4];
    $gauge_id=$_[5];

    $nt=$_[6];
    $clover=$_[7];
    $Residual=$_[8];
    $StoutLinkSmearing=$_[9];


    $SeqSourceType="MesonSeqSrc_G15";

## Position of the seqential source
for( $id = 0; $id < $n_src; $id = $id + 1 ){  
   #$itq=$src_position[4*$id+3]+$t_seq;
   $itq=$it0+$nt/$n_src*$id+$t_seq;
   if($itq>=$nt) {$itq-=$nt;}


## -------------------------------
##   Make sequential source
## -------------------------------
print <<"EOF";
    <elem>
      <Name>SEQSOURCE_FAST</Name>
      <SmearedProps>true</SmearedProps>
      <multi_tSinks>${itq}</multi_tSinks>
      <Frequency>1</Frequency>
      <Param>
        <version>2</version>
        <SeqSource>
          <version>1</version>
          <SeqSourceType>${SeqSourceType}</SeqSourceType>
          <j_decay>3</j_decay>
          <t_sink>0</t_sink>
          <sink_mom>0 0 $mom_seq</sink_mom>
        </SeqSource>
      </Param>
      <PropSink>
        <version>5</version>
        <Sink>
          <version>2</version>
          <SinkType>POINT_SINK</SinkType>
          <j_decay>3</j_decay>
          <Displacement>
            <version>1</version>
            <DisplacementType>NONE</DisplacementType>
          </Displacement>
        </Sink>
      </PropSink>
      <NamedObject>
        <prop_ids>
          <elem>$prop_spec_id</elem>
        </prop_ids>
        <seqsource_id>      
          <elem>seqsrc.id${id}</elem>
        </seqsource_id>
        <gauge_id>$gauge_id</gauge_id>
      </NamedObject>
   </elem>

EOF

} # end loop id

## -----------------------------------------
##   Add sequential source together
## -----------------------------------------
for( $id = 1; $id < $n_src; $id = $id + 1 )
{
  if($id==1){
    $seqprop_A="seqsrc.id0";
    $seqprop_sum="seqsrc.src0+src1";

  }
  else{
    $seqprop_A=$seqprop_sum;
    $seqprop_sum.="+src$id";
    }

  $tA0=$it0+$t_seq; $tA1=$it0+($id-1)*$nt/$n_src+$t_seq;
  $tB0=$it0+$id*$nt/$n_src+$t_seq;
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA0>=$nt) {$tA0=$tA0-$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }



  print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
EOF
#        <tA>$tA0 $tA1</tA>
print <<"EOF";
        <factorA>1.0</factorA>
        <propA>${seqprop_A}</propA>
EOF
#        <tB>$tB0 $tB0</tB>
print <<"EOF";
        <factorB>1.0</factorB>
        <propB>seqsrc.id${id}</propB>
        <propApB>${seqprop_sum}</propApB>
      </NamedObject>
    </elem>

    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
            <object_id>$seqprop_A</object_id>
        </NamedObject>
    </elem>

EOF
} # end loop id

if($n_src==1)
{
  $seqprop_sum="seqsrc.id0";
}

for( $id = 1; $id < $n_src; $id = $id + 1 )
{
print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>seqsrc.id${id}</object_id>
      </NamedObject>
  </elem>

EOF
}

## use the added seqsrc make propagator
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
          <FermAct>CLOVER</FermAct>
          <Mass>$bwd_quark_mass</Mass>
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
          <invType>QUDA_CLOVER_INVERTER_v2</invType>
          <MaxIter>1000</MaxIter>
          <CloverParams>
          <Mass>$bwd_quark_mass</Mass>
          <clovCoeff>$clover</clovCoeff>
          <AnisoParam>
            <anisoP>false</anisoP>
            <t_dir>3</t_dir>
            <xi_0>1.0</xi_0>
            <nu>1</nu>
          </AnisoParam>
            <FermionBC>
              <FermBC>SIMPLE_FERMBC</FermBC>
              <boundary>1 1 1 -1</boundary>
            </FermionBC>
          </CloverParams>
          <RsdTarget>$Residual</RsdTarget>
          <Delta>0.1</Delta>
          <RsdToleranceFactor>100</RsdToleranceFactor>            
          <AntiPeriodicT>true</AntiPeriodicT>
          <SolverType>GCR</SolverType>
          <Verbose>true</Verbose>
          <AsymmetricLinop>true</AsymmetricLinop>
          <CudaReconstruct>RECONS_12</CudaReconstruct>
          <CudaSloppyPrecision>SINGLE</CudaSloppyPrecision>
          <CudaSloppyReconstruct>RECONS_12</CudaSloppyReconstruct>
          <AutotuneDslash>false</AutotuneDslash>            
        </InvertParam>
    </Param>
    <NamedObject>
      <gauge_id>$gauge_id</gauge_id>
      <source_id>${seqprop_sum}</source_id>
      <prop_id>${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}</prop_id>
    </NamedObject>
  </elem>

EOF

print <<"EOF";
  <elem>
      <Name>ERASE_NAMED_OBJECT</Name>
      <Frequency>1</Frequency>
      <NamedObject>
          <object_id>${seqprop_sum}</object_id>
      </NamedObject>
  </elem>

EOF

return "${SeqSourceType}_seq_prop_m$bwd_quark_mass.p${mom_seq}.tseq${t_seq}";
} # end print_body

1;
