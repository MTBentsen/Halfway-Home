#!/bin/sh
#sytanx: diskutil cs resizeStack [disk# see under diskutil cs list, logical volume] [size for primary partition, example 450g] [Format for secondary partition] [name for secondary partition in " "] [size of secondary partition or 0 to fill remaing drive space]

diskutil cs resizeStack disk1 470g JHFS+ "SAVE HD" 0
sudo /bin/mkdir "/Volumes/SAVE HD/~pre-trash"
sudo chmod 777 /Volumes/SAVE\ HD/
Sudo chmod 777 /Volumes/SAVE\ HD/~pre-trash
