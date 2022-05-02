package EraseObject;

#####################################################
#######   Erase 1 parameter
#####################################################

sub EraseVariable{

    ## 判断函数的参数个数，如果参数个数不对的话报错
    $para_no=@_;
    if($para_no!=1)
    {
        print "Parameter number wrong: this function have 1 parameter, but read $para_no!";
        exit;
    }

    $nameobj=$_[0];

print <<"EOF";
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>$nameobj</object_id>
        </NamedObject>
    </elem>
    
EOF

}

sub EraseList{

    foreach $nameobj (@_){

print <<"EOF";
    <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
        <object_id>$nameobj</object_id>
        </NamedObject>
    </elem>
    
EOF

    }

    
} # end sub EraseList

1;