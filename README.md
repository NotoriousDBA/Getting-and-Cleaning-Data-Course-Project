# Getting-and-Cleaning-Data-Course-Project
This repo contains the following files for the course project for the "Getting and Cleaning Data" course on Coursera:

* README.md - This file.
* run_analysis.R - The R source file used to produce the two tidy datasets specified by the project instructions.
* CodeBook.md - Descriptions of the variables contained in the original UCI HAR dataset, and the two datasets produced by run_analysis.R, as well as an explanation of the methodology used to produce the new datasets.

What this repo does *not* contain: this repo does not contain the original UCI HAR dataset, which can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

---
### How to use these files

1. Download the UCI HAR dataset (link above).
2. Unzip it in the directory containing run_analysis.R.
3. Execute run\_analysis.R, with the working directory set to the directory where both run_analysis.R and the unzipped UCI HAR dataset reside.

The above will produce two text files as output:

* meanandstdfeatures.txt - The subset of "features" (variables) from the original dataset that represent the means and standard deviations of the calculated measurements, joined with the subject and activity data which are stored separately in the originals. In addition, while the original dataset is split into test and training datasets, this dataset merges them back together.
* meanandstdfeatures_summary.txt - The same content as meanandstdfeatures.txt, but summarized by subject and activity, with the mean of each of the extracted variables.