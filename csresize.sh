#!/bin/bash

sytanx: diskutil cs resizeStack [disk#] [size for primary partition, example 450g] [Format for secondary partition] [name for secondary partition in " "] [size of secondary partition or 0 to fill remaing drive space]

diskutil cs resizeSack disk1 470g JHFS+ "Save-HD" 0
