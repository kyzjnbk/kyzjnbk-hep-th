#!/usr/bin/perl

package HadronSpectrum;
require CheckArgs;

#####################################################
#######   Baryon
#####################################################

sub print_baryon{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=10)
    {
    print "Parameter number wrong: this function have 10 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $conf=$_[0];
    $had_mom_x=$_[1];
    $had_mom_y=$_[2];
    $had_mom_z=$_[3];

    $had_key=$_[4];
    $gauge_id=$_[5];
    $curr_prop_id=$_[6];
    $spec1_prop_id=$_[7];
    $spec2_prop_id=$_[8];
    $prefix=$_[9];

    $had_xx=50-$had_mom_x;
    $had_yy=50-$had_mom_y;
    $had_zz=50-$had_mom_z;
    $had_mom="${had_xx}${had_yy}${had_zz}";
    
## For nucleon:  diquark1_id对应旁观者d夸克，diquark2_id对应旁观者u夸克，curr_quark_id对应流夸克u

print <<"EOF";
    <elem>
      <annotation>
          Compute the hadron spectrum.
          This version is a clone of the one below, however the xml output is
          written within the same chroma output file
       </annotation>
       <Name>HADRON_SPECTRUM_v2</Name>
       <Frequency>1</Frequency>
       <Param>
         <version>1</version>
         <hadron_list>$had_key</hadron_list>
         <mom_list>${had_mom}</mom_list>
         <prj_type>0</prj_type>
         <cfg_serial>${conf}</cfg_serial>
         <avg_equiv_mom>false</avg_equiv_mom>
         <time_rev>false</time_rev>
         <translate>false</translate>
        </Param>
       <NamedObject>
         <gauge_id>$gauge_id</gauge_id>
       <sink_pairs>
             <elem>
                <diquark1_id>$spec1_prop_id</diquark1_id>
                 <diquark2_id>$spec2_prop_id</diquark2_id>
                 <curr_quark_id>$curr_prop_id</curr_quark_id>                 
             </elem>
         </sink_pairs>
       </NamedObject>
        <output>${prefix}hadspec_${had_key}_cfg_${conf}_mom_${had_mom}.dat.iog</output>
      </elem>
 
EOF

}



#####################################################
#######   Meson
#####################################################

sub print_meson{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=9)
    {
    print "Parameter number wrong: this function have 9 parameter (\"\$fixed_exist\"), but read $para_no!";
    exit;
    }
    CheckArgs::checkList(@_);

    $conf=$_[0];
    $had_mom_x=$_[1];
    $had_mom_y=$_[2];
    $had_mom_z=$_[3];

    $had_key=$_[4];
    $gauge_id=$_[5];

    ## 介子的情况时<diquark12_id>分别对应介子的两个传播子，<curr_quark_id>根本没有用到
    $prop1_id=$_[6];
    $prop2_id=$_[7];
    $prefix=$_[8];

    $had_xx=50-$had_mom_x;
    $had_yy=50-$had_mom_y;
    $had_zz=50-$had_mom_z;
    $had_mom="${had_xx}${had_yy}${had_zz}";


print <<"EOF";
    <elem>
      <annotation>
          Compute the hadron spectrum.
          This version is a clone of the one below, however the xml output is
          written within the same chroma output file
       </annotation>
       <Name>HADRON_SPECTRUM_v2</Name>
       <Frequency>1</Frequency>
       <Param>
         <version>1</version>
         <hadron_list>$had_key</hadron_list>
         <mom_list>${had_mom}</mom_list>
         <prj_type>0</prj_type>
         <cfg_serial>${conf}</cfg_serial>
         <avg_equiv_mom>false</avg_equiv_mom>
         <time_rev>false</time_rev>
         <translate>false</translate>
        </Param>
       <NamedObject>
         <gauge_id>$gauge_id</gauge_id>
       <sink_pairs>
             <elem>
                <diquark1_id>$prop1_id</diquark1_id>
                 <diquark2_id>$prop2_id</diquark2_id>
                 <curr_quark_id>$prop2_id</curr_quark_id>                 
             </elem>
         </sink_pairs>
       </NamedObject>
        <output>${prefix}hadspec_${had_key}_cfg_${conf}_mom_${had_mom}.dat.iog</output>
      </elem>
 
EOF

}

1;
