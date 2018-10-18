#!/bin/bash

#Used to fill up a hard drive for something like a filesystem challenge

#mount -o loop ../Challenge/recovered /mnt

mk_tree (){
    if [[ $1 == 5 ]] ;then
        dd if=/dev/urandom of=$(dd if=/dev/urandom count=64 bs=1 status=none| md5sum | cut -d' ' -f1) count=64 bs=1 status=none
    else
        for dir_num in {1..4}
        do
            mkdir $(dd if=/dev/urandom count=64 bs=1 status=none |md5sum | cut -d' ' -f1)
        done

        for my_dir in $(find . -maxdepth 1 -type d ! -name ".")
        do
            cd $my_dir
            mk_tree $(($1 + 1))
            cd ..
        done
    fi
}

pushd /mnt

for num in {1..200}
do
    mkdir $(echo $num | md5sum | cut -d' ' -f1)
done

cur_count=0

for my_dir in $(find . -maxdepth 1 -type d ! -name ".")
do
    cur_count=$(($cur_count + 1))
    echo $cur_count

    pushd $my_dir
    mk_tree 0
    popd
done

popd
mkdir -p /mnt/k/q/c/
cp flag.gz /mnt/k/q/c/e
