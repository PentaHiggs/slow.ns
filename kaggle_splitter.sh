#!/bin/bash

# Usage:
# If data is in directory catsdogs, and the categories are cat and dog, then proper command is
# $ kaggle_splitter.sh catsdogs cat dog
# 
# Future version will hopefully decipher category names from file names without manual input

echo "Creating train / valid / sample splits for "$1

# Initialize directory skeleton (without categories)
# Train should already exist.
mkdir $1/valid $1/sample
mkdir $1/sample/train $1/sample/valid

for var in ${@:2}
do
	mkdir $1/train/$var $1/valid/$var
	mkdir $1/sample/train/$var $1/sample/valid/$var
	
	echo "Moving $var files to directory"
	# Move all files in category $var to $1/$var.  They are initially all in $1/train/
	mkdir $1/$var
	cd $1/train/
	find . -name $var".*" -exec mv -v -t ../$var/ {} +
	#find $1/train/ -name $var".*" -exec mv -v -t ../$var {} +
	cd -

	echo "Copying $var into sample"
	# Copy some into sample
	mkdir $1/sample/$var
	for file in $(ls -p $1/$var | grep -v / | tail -100 )
	do	
		cp $1/$var/$file $1/sample/$var/
	done

	echo "Splitting $var sample"
	# Train/valid split sample
	for file in $(ls -p $1/sample/$var | grep -v / | tail -10)
	do
		mv $1/sample/$var/$file $1/sample/valid/$var
	done
	
	echo "Emptying $1/sample/$var"
	# Send rest into $1/sample/$var into train
	for file in $(ls -p $1/sample/$var | grep -v /)
	do
		mv $1/sample/$var/$file $1/sample/train/$var
	done
	
	# Delete now empty temporary directory
	rmdir $1/sample/$var

	echo "Calculating train/valid split for main data for $var"
	# Train/valid split regular, 10% validation
	numfiles=$(ls 2>/dev/null -Ub1 -- * | wc -l)
	numvalid=$(($numfiles/10))

	echo "Moving validation set for $var"
	for file in $(ls -p $1/$var | grep -v / | tail -$numvalid)
	do
		mv $1/$var/$file $1/valid/$var
	done

	echo "Emptying $1/$var "
	# Send rest into $1/train/$var
	for file in $(ls -p $1/$var | grep -v / )
	do	
		mv $1/$var/$file $1/train/$var
	done
	
	# This directory should now be empty
	rmdir $1/$var
done
