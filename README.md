# slow.ns
Collection of scripts, assignments, notes, etc. for fast.ai 
(In case you were wondering, the repo name is slow . natural stupidity.  heh )

## kaggle_splitter.sh
Script to split kaggle training sets into folders for each class and a 90/10 train/validation
split, as well as a smaller subsample (of size 100 for every category).

### Usage
```
$ kaggle_splitter dirname cat_1 cat_2 ...
```
Where dirname is the name of the directory where .zip folders from kaggle were unzipped;
We are splitting the train.zip files into the directory tree shown below.
cat_1, cat_2, ... are the category names (no actual ellipses are to be used in the command above)
It is assumed that file names will be of the form cat_1.\*, cat_2.\*, etc.

### Directory Structure
```
dirname/
	|----/train
    	|       |----/cat_1
	|		|----/cat_2
	|			.
	|			.
	|			.
	|----/valid
	|		|----/cat_1
	|		|----/cat_2
	|			.
	|			.
	|			.
	|----/sample
			|----/train
			|		|----/cat_1
			|		|----/cat_2
			|				.
			|				.
			|				.
			|----/valid
					|----/cat_1
					|----/cat_2
						.
						.
						.						
```
