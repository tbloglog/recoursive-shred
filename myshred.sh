#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: myshred percorso"
	exit 1
fi

percorso=$1

numero_file=$(tree -aif $percorso | grep -m 1 -o -P "([0-9]+) files" | grep -o -E "[0-9]+")
numero_dir=$(tree -aif $percorso | grep -m 1 -o -P "^([0-9]+) directory" | grep -o -E "[0-9]+")

echo "Files trovati: "$numero_file
echo "Directory trovate: "$numero_dir

num=0
let numero_dir=$numero_dir+1

for i in $(tree -aif --noreport $percorso); do
	let num=$num+1
	if [ $num -le $numero_dir ]; then
		continue
	fi
	shred -n 10 -uvz $i >/dev/null 2>&1
	echo "File "$i" eliminato"
done

echo "[+]File/s Succesfully deleted!"
