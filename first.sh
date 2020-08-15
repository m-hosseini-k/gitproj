#!/bin/bash
cd /home/administrator/project/gitproj
n=$(redis-cli -a '123' get n)
counter=$(redis-cli -a '123' incr n)
od -An -N1 -i /dev/random >> file1.txt
git commit -a -m "$counter commit"
git push origin master
