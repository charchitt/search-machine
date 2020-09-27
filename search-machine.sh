#!/bin/bash 

#1. machines are defined according to author
#2. difficulty may differ according to your skills 

base="https://www.vulnhub.com"
echo "what type of machine you are looking for ? Enter the number accordingly: "
echo "[0]: easy"
echo "[1]: medium/intermediate"
echo "[2]: hard"
echo "[3]: oscp like"
echo "[4]: web-application"
read -p "Enter number: " types


main() {
query="https://www.vulnhub.com/?q=$1"
result=$(curl -s $query | grep -i "results" | sed 's/[^0-9]//g' | sed -e 's/^2//' -e 's/2$//')
echo "no. of machines found: $result"
a=$(($result/12))
b=$(($result%12))


if [[ $b -eq 0 ]]; then
	page=a
else	
	page=$((a+1))
fi


for ((k=1;k<=$page;k++))
do
	list=($(curl -s "$query&page=$k" | grep -i "/entry" | cut -d "\"" -f 2 | grep entry | uniq | grep -v download ))
	for i in ${list[@]}
	do
		echo "$base$i"
	done
	echo ..................
done
}

case $types in
	"0")
		main "easy"
		;;
	"1")
		main "medium"
		;;
	"2")	
		main "hard"
		;;
	"3")
		main "oscp"
		;;
	"4")
		main "web"
		;;
	*)
esac	
	


