#!/usr/bin/perl

#--------------------------------------------------
# wall source，需要保证两个u夸克传播子的动量是一致的，否的的话还需要考虑两个u夸克传播子不一致带来的额外的对称性效应

use lib '/public/home/weiwang/qazhang/tmd_project/PerlModule';
require SaveReadPropagator;
require GaugeFix;
require SourcePropagator;
require PropAdd;
require SinkSmear;
require EraseObject;
require HadronSpectrum;
require EndOfPerl;

$conf=$ARGV[0];
$prefix=$ARGV[1];

$quark_mass=-0.0191;
$n_src=4; # 分段的数目
$it0=0;

$ns=48;
$nt=64;
$clover=1.05088;
$StoutLinkSmearing=0;

$mg_layout="4 4 4 4";
$Residual=1e-6;

$conf_type="MILC";
$conf_path="/public/home/weiwang/configuration/milc/conf_milc/a12m130/l4864f211b600m00184m0507m628a.${conf}";

$hyp_smear=1;
$gauge_type=0;

$smear_size=4;
$smear_iter=30;
$smear_mom=2;
$Residual=1e-6;

$ix=int(rand($ns));
$iy=int(rand($ns));
$iz=int(rand($ns));
if($conf == 1000){ # check point
    $ix = 0; $iy = 0; $iz = 0;
}

## save cfgs and props
$save_cfg=0;
$save_cfg_head='/public/home/weiwang/qazhang/tmd_project/saved_cfgs_props/a12m130/save_gfixed_cfgs/l4864f211b600m00184m0507m628a';
$save_prop_path='/public/home/weiwang/qazhang/tmd_project/saved_cfgs_props/a12m130/save_combined_props';

print <<"EOF";
<?xml version="1.0"?>
<chroma>
<Param> 
  <InlineMeasurements>
EOF

## Gauge fix
$gauge_id = GaugeFix::print_body($conf, $hyp_smear, $gauge_type, $save_cfg, $save_cfg_head);

## 首先判断保存的prop是否存在
$mom = 0;
$parallel_io = "true";
$save_prop_name = "${parallel_io}_sp_prop_P${mom}_m${quark_mass}_s${ix}-${iy}-${iz}_t${it0}-${n_src}_sm${smear_size}-${smear_iter}-${smear_mom}.${conf}";
$prop_QIO_true = SaveReadPropagator::QIO_read($parallel_io, $save_prop_path, $save_prop_name);

$parallel_io = "false";
$save_prop_name = "${parallel_io}_sp_prop_P${mom}_m${quark_mass}_s${ix}-${iy}-${iz}_t${it0}-${n_src}_sm${smear_size}-${smear_iter}-${smear_mom}.${conf}";
$prop_QIO_false = SaveReadPropagator::QIO_read($parallel_io, $save_prop_path, $save_prop_name);

$io_num = 2;
$save_prop_name = "${io_num}_sp_prop_P${mom}_m${quark_mass}_s${ix}-${iy}-${iz}_t${it0}-${n_src}_sm${smear_size}-${smear_iter}-${smear_mom}.${conf}";
$prop_QIO_inline2 = SaveReadPropagator::inline_read($io_num, $save_prop_path, $save_prop_name, $ix, $iy, $iz, $it0, $ns, $nt);

$io_num = 6;
$save_prop_name = "${io_num}_sp_prop_P${mom}_m${quark_mass}_s${ix}-${iy}-${iz}_t${it0}-${n_src}_sm${smear_size}-${smear_iter}-${smear_mom}.${conf}";
$prop_QIO_inline6 = SaveReadPropagator::inline_read($io_num, $save_prop_path, $save_prop_name, $ix, $iy, $iz, $it0, $ns, $nt);


## sink smear
$prop_id = $prop_QIO_true;
$smear_prop_id = "smear_prop1";
SinkSmear::SmearedSink($prop_id, $smear_prop_id, $gauge_id, $smear_size, $smear_iter, $smear_mom);

$prop_id = $prop_QIO_false;
$smear_prop_id = "smear_prop2";
SinkSmear::SmearedSink($prop_id, $smear_prop_id, $gauge_id, $smear_size, $smear_iter, $smear_mom);

$prop_id = $prop_QIO_inline2;
$smear_prop_id = "smear_prop3";
SinkSmear::SmearedSink($prop_id, $smear_prop_id, $gauge_id, $smear_size, $smear_iter, $smear_mom);

$prop_id = $prop_QIO_true;
$smear_prop_id = "smear_prop4";
SinkSmear::SmearedSink($prop_id, $smear_prop_id, $gauge_id, $smear_size, $smear_iter, $smear_mom);



## Nucl 2pt
@mom_list = (0, 1, 2, 3, 4);
foreach $had_mom_z (@mom_list){
    ## nucleon
    $had_mom_x=0;
    $had_mom_y=0;
    $had_key="121050";
    $curr_prop_id="smear_prop1";
    $spec1_prop_id="smear_prop1";
    $spec2_prop_id="smear_prop1";
    HadronSpectrum::print_baryon($conf, $had_mom_x, $had_mom_y, $had_mom_z, $had_key, $gauge_id,
        $curr_prop_id, $spec1_prop_id, $spec2_prop_id, $prefix);
    
    ## pion
    $had_key="100111515";
    $prop1_id="smear_prop3";
    $prop2_id="smear_prop3";
    HadronSpectrum::print_meson($conf, $had_mom_x, $had_mom_y, $had_mom_z, $had_key, $gauge_id,
        $prop1_id, $prop2_id, $prefix)
}


## Module: end
EndOfPerl::print_body($ns, $nt, $conf, $hyp_smear, $gauge_type, $save_cfg_head, $conf_type, $conf_path);
