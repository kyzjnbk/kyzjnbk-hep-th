package PropAdd;

require CheckArgs;

sub print_body_AddProps{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=5)
    {
    print "Parameter number wrong: this function have 5 parameter, but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $mom=$_[0]; 
    $it0=$_[1];
    $n_src=$_[2];
    $nt=$_[3];
    $direction=$_[4];


    if($direction ne "Forward" && $direction ne "Backward" && $direction ne "Both"){
    print "The direction must be \"Forward\" or \"Backward\" or  \"Both\"!";
    exit;
    }
    
    $it_cut=$nt/$n_src;
    if($direction eq "Both") { $it_cut=$nt/(2*$n_src); }



## add propagator together


for($count=1; $count<$n_src; $count=$count+1){
  if($count==1){
    if($direction eq "Forward"){ $it=$it0+$nt/$n_src; }
    if($direction eq "Backward"){ $it=$it0-$nt/$n_src; }
    if($direction eq "Both"){ $it=$it0+$nt/$n_src; }
    if($it<0) {$it=$it+$nt; }

    $prop_f_A="prop_P${mom}_t${it0}";
    $prop_f_B="prop_P${mom}_t${it}";
    $prop_f_sum="prop_P${mom}_t${it0}+${it}";

  }
  else{
    if($direction eq "Forward"){ $it=$it0+$count*$nt/$n_src; }
    if($direction eq "Backward"){ $it=$it0-$count*$nt/$n_src; }
    if($direction eq "Both"){ $it=$it0+$count*$nt/$n_src; }
    if($it<0) {$it=$it+$nt; }

    $prop_f_A=$prop_f_sum;
    $prop_f_B="prop_P${mom}_t${it}";
    $prop_f_sum.="+${it}";
    }

  if($direction eq "Forward"){
    $tA0=$it0 + 1; $tA1=$it0 + ($count-1)*$nt/$n_src + $it_cut - 1;
    $tB0=$it0 + $count*$nt/$n_src + 1; $tB1=$it0 + $count*$nt/$n_src + $it_cut - 1;
    if($tA0<0) {$tA0=$tA0+$nt; }
    if($tB0>=$nt) {$tB0=$tB0-$nt; }
    if($tB1>=$nt) {$tB1=$tB1-$nt; }
  }
  if($direction eq "Backward"){
    $tA0=$it0 - ($count-1)*$nt/$n_src - $it_cut + 1; $tA1=$it0 - 1;
    $tB0=$it0 - $count*$nt/$n_src - $it_cut + 1; $tB1=$it0 - $count*$nt/$n_src - 1;
    if($tA0<0) {$tA0=$tA0+$nt; }
    if($tA1<0) {$tA1=$tA1+$nt; }
    if($tB0<0) {$tB0=$tB0+$nt; }
    if($tB1<0) {$tB1=$tB1+$nt; }
  }
  if($direction eq "Both"){
    $tA0=$it0 - $it_cut + 1; $tA1=$it0 + ($count-1)*$nt/$n_src + $it_cut - 1;
    $tB0=$it0 - $it_cut + $count*$nt/$n_src + 1; $tB1=$it0 + $count*$nt/$n_src + $it_cut - 1;

    if($tA0<0) {$tA0=$tA0+$nt; }
    if($tA1<0) {$tA1=$tA1+$nt; }
    if($tB0<0) {$tB0=$tB0+$nt; }
    if($tB1<0) {$tB1=$tB1+$nt; }
    if($tA1>=$nt) {$tA1=$tA1-$nt; }
    if($tB0>=$nt) {$tB0=$tB0-$nt; }
    if($tB1>=$nt) {$tB1=$tB1-$nt; }
  }

print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
        <tA>$tA0 $tA1</tA>
        <factorA>1.0</factorA>
        <propA>$prop_f_A</propA>
        <tB>$tB0 $tB1</tB>
        <factorB>1.0</factorB>
        <propB>$prop_f_B</propB>
        <propApB>$prop_f_sum</propApB>
      </NamedObject>
    </elem>

EOF
} # end $count

if($n_src==1){
  $prop_f_sum="prop_P${mom}_nsrc1_t${it0}";

  if($direction eq "Forward"){
    $tA0 = $it0 + 1;
    $tA1 = $it0 + $it_cut - 1;
  }
  if($direction eq "Backward"){
    $tA1 = $it0 - 1;
    $tA0 = $it0 - $it_cut + 1;
  }
  if($direction eq "Both"){
    $tA0 = $it0 - $it_cut + 1;
    $tA1 = $it0 + $it_cut - 1;
  }
  if($tA0<0) {$tA0=$tA0+$nt; }
  if($tA1<0) {$tA1=$tA1+$nt; }
  if($tB0<0) {$tB0=$tB0+$nt; }
  if($tB1<0) {$tB1=$tB1+$nt; }
  if($tA1>=$nt) {$tA1=$tA1-$nt; }
  if($tB0>=$nt) {$tB0=$tB0-$nt; }
  if($tB1>=$nt) {$tB1=$tB1-$nt; }

  print <<"EOF";
    <elem>
      <Name>QPROPADD_cohen</Name>
      <Frequency>1</Frequency>
      <NamedObject>
        <j_decay>3</j_decay>
        <tA>$tA0 $tA1</tA>
        <factorA>1.0</factorA>
        <propA>prop_P${mom}_t${it0}</propA>
        <tB>$tA0 $tA1</tB>
        <factorB>0.0</factorB>
        <propB>prop_P${mom}_t${it0}</propB>
        <propApB>$prop_f_sum</propApB>
      </NamedObject>
    </elem>

EOF
}

$prop_return=$prop_f_sum;

## ERASE ADDED
for( $count=1; $count<$n_src-1; $count=$count+1 ){
  if ($count==1){
    if($direction eq "Forward"){ $it=$it0+$nt/$n_src; }
    if($direction eq "Backward"){ $it=$it0-$nt/$n_src; }
    if($direction eq "Both"){ $it=$it0+$nt/$n_src; }
    if($it<0) {$it=$it+$nt; }

    $prop_f_sum="prop_P${mom}_t${it0}+${it}";
  }
  else{
    if($direction eq "Forward"){ $it=$it0+$count*$nt/$n_src; }
    if($direction eq "Backward"){ $it=$it0-$count*$nt/$n_src; }
    if($direction eq "Both"){ $it=$it0+$count*$nt/$n_src; }
    if($it<0) {$it=$it+$nt; }

    $prop_f_A=$prop_f_sum;
    $prop_f_sum.="+${it}";
  }
print <<"EOF";
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>$prop_f_sum</object_id>
        </NamedObject>
    </elem>
    
EOF
} # end $count


## ERASE ORI
for( $count=0; $count<$n_src; $count=$count+1 ){
  $t_src_del=$it0+$count*$nt/$n_src;

print <<"EOF";    
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>prop_P${mom}_t${t_src_del}</object_id>
        </NamedObject>
    </elem>
EOF

} # end $count

return $prop_return;

} # end print_body_AddProps_PointSink



1;