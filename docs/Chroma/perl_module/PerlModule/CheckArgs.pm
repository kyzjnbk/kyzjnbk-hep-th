package CheckArgs;

## 检查一个列表中有没有空元素
sub checkList{

    $count=0;
    foreach $arg (@_){
        if($arg eq ""){
            print "第${count}个参数为空!";
            exit;
        }
        $count+=1;
    }
}


1;