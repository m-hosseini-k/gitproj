#!/bin/bash
cd /home/administrator/project/gitproj

while IFS= read -r line
do
  if [[ "$line" == *"type"* ]]; then
	  ntype=$(echo "$line")
  fi
done < config.txt

#while IFS= read -r line
#do
 # if [[ "$line" == *"amount"* ]]; then
          #namount=$(echo "$line")
 #fi
#done < config.txt
	namount=$(grep "amount:" config.txt | sed -e 's/.*://')
echo "$ntype"
echo "$namount"

if [[ "$ntype" == "    type:add" ]];then
	echo "ok"
	n=$(redis-cli -a '123' get n)
	echo "$n"
	n=$((n+namount))
	$(redis-cli -a '123' set n "$n")
	od -An -N1 -i /dev/random >> file1.txt
	git commit -a -m "$n commit"
	git push origin master
elif [[ "$ntype" == "    type:minus" ]]; then
        n=$(redis-cli -a '123' get n)
        echo "key n : $n"
        n=$((n-namount))
    	$(redis-cli -a '123' set n "$n")
	echo "$(redis-cli -a '123' get n)"
        od -An -N1 -i /dev/random >> file1.txt
        git commit -a -m "$n commit"
        git push origin master
    else
	    echo "wrong"
	fi
