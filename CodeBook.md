# Code Book

This code book is divided into two main sections:

* Dataset Descriptions - Descriptions of the original UCI HAR dataset used as input, and of the two tidy datasets produced from it.
* Methodology - A detailed description of the transformations used to produce the new datasets from the input.

## Dataset Descriptions
#### UCI HAR Dataset
---
##### Signals and Variables
The UCI HAR Dataset was produced by having test subjects perform each of several activities while wearing a Samsung Galaxy S II smartpone. The outputs from the phone's on-board accelerometer and gyroscope were sampled and pre-processed into the following signals:

* tBodyAcc-XYZ - Body acceleration (total acceleration minus gravity), in the time domain, for each of the three axes, in standard gravitational units(g).
* tGravityAcc-XYZ - Acceleration due to gravity, in the time domain, for each of the three axes, in standard gravitational units(g).
* tBodyAccJerk-XYZ - Body acceleration (total acceleration minus gravity) jerk, in the time domain, for each of the three axes, in standard gravitational units(g).
* tBodyGyro-XYZ - Body angular velocity, in the time domain, for each of the three axes, in radians/second.
* tBodyGyroJerk-XYZ - Body angular velocity jerk, in the time domain, for each of the three axes, in radians/second.
* tBodyAccMag - The magnitude of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units(g).
* tGravityAccMag - The magnitude of acceleration due to gravity, in the time domain, in standard gravitational units(g).
* tBodyAccJerkMag - The magnitude of body acceleration (total acceleration minus gravity) jerk, in the time domain, in standard gravitational units(g).
* tBodyGyroMag - The magnitude of body angular velocity, in the time domain, in radians/second.
* tBodyGyroJerkMag - The magnitude of body angular velocity jerk, in the time domain, in radians/second.
* fBodyAcc-XYZ - Body acceleration (total acceleration minus gravity), in the frequency domain, for each of the three axes, in standard gravitational units(g).
* fBodyAccJerk-XYZ - Body acceleration (total acceleration minus gravity), in the frequency domain, for each of the three axes, in standard gravitational units(g).
* fBodyGyro-XYZ - Body angular velocity, in the frequency domain, for each of the three axes, in radians/second.
* fBodyAccMag - Body acceleration (total acceleration minus gravity), in the frequency domain, for each of the three axes, in standard gravitational units(g).
* fBodyAccJerkMag - Body acceleration (total acceleration minus gravity), in the frequency domain, for each of the three axes, in standard gravitational units(g).
* fBodyGyroMag - The magnitude of body angular velocity, in the frequency domain, in radians/second.
* fBodyGyroJerkMag - The magnitude of body angular velocity jerk, in the frequency domain, in radians/second.

The set of variables that were estimated from these signals are:

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean - The mean of acceleration due to gravity, in standard gravitational units (g).
* tBodyAccMean - The mean of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units (g).
* tBodyAccJerkMean - The mean of body acceleration (total acceleration minus gravity) jerk, in the time domain, in standard gravitational units (g).
* tBodyGyroMean - The mean of body angular velocity, in the time domain, in radians/second.
* tBodyGyroJerkMean - The mean of body angular velocity jerk, in the time domain, in radians/second.

Together, the above were used to produce 561 "features" (variables) for each observation. For complete details on each of the 561 variables, please see the documentation included with the UCI HAR dataset itself.

##### Files

The UCI HAR dataset is composed of the following files, containing the listed variables. 

* activity_labels.txt - The list of activities performed in the experiments.

   * activity id - the numeric identifier of an activity, as used in the dataset
   * activity name - the text description of the activity

* train/subject_train.txt - The subject performing the activity for each observation in the training dataset.

   * subject id - the numeric identifier of a subject

* train/y_train.txt - The activity being performed for each observation in the training dataset.

   * activity id - the numeric identifier of an activity (see activity_labels.txt above)

* train/X_train.txt - The 561 variables derived for each observation in the training dataset, as described in the previous section.

> As noted above, we we'll not describe each of the 561 variables here. Suffice it to say that the 66 that we extract and use in the new datasets are described below.

* test/subject_test.txt, test/y_test.txt, test/X_test.txt - The datafiles for the test dataset, identical to the corresponding files in the training dataset, as listed above.

#### Dataset of Means and Standard Deviations - "meanandstdfeatures.txt"

---

For this dataset the subject, activity, and feature data from UCI HAR were joined together, with only the measurements on the mean and standard deviation for each measurement extracted. In addition, the observations from the training and test datasets were merged together, and an additional variable added to indicate which of the original datasets a particular observation came from.	

The set of variables in the dataset is as follows:

Variable Number | Name | Description
----------------|------|------------
1 | subjectid | The unique numeric identifier of the test subject for whom the data were collected.
2 | activityname | The name of the activity being performed by the test subject when the observations were recorded.
3 | originaldataset | Records whether the observation was originally part of the test or training datasets.
4 | bodyaccxaxistimemean | The mean body acceleration (total acceleration minus gravity) along the X-axis, in the time domain, in standard gravitational units (g).
5 | bodyaccyaxistimemean | The mean body acceleration (total acceleration minus gravity) along the Y-axis, in the time domain, in standard gravitational units (g).
6 | bodyacczaxistimemean | The mean body acceleration (total acceleration minus gravity) along the Z-axis, in the time domain, in standard gravitational units (g).
7 | bodyaccxaxistimestd | The standard deviation of body acceleration (total acceleration minus gravity) along the X-axis, in the time domain, in standard gravitational units (g).
8 | bodyaccyaxistimestd | The standard deviation of body acceleration (total acceleration minus gravity) along the Y-axis, in the time domain, in standard gravitational units (g).
9 | bodyacczaxistimestd | The standard deviation of body acceleration (total acceleration minus gravity) along the Z-axis, in the time domain, in standard gravitational units (g).
10 | gravityaccxaxistimemean | The mean acceleration due to gravity along the X-axis, in the time domain, in standard gravitational units (g).
11 | gravityaccyaxistimemean | The mean acceleration due to gravity along the Y-axis, in the time domain, in standard gravitational units (g).
12 | gravityacczaxistimemean | The mean acceleration due to gravity along the Z-axis, in the time domain, in standard gravitational units (g).
13 | gravityaccxaxistimestd | The standard deviation of acceleration due to gravity along the X-axis, in the time domain, in standard gravitational units (g).
14 | gravityaccyaxistimestd | The standard deviation of acceleration due to gravity along the Y-axis, in the time domain, in standard gravitational units (g).
15 | gravityacczaxistimestd | The standard deviation of acceleration due to gravity along the Z-axis, in the time domain, in standard gravitational units (g).
16 | bodyaccjerkxaxistimemean | The mean of body acceleration jerk along the X-axis, in the time domain, in standard gravitational units (g).
17 | bodyaccjerkyaxistimemean | The mean of body acceleration jerk along the Y-axis, in the time domain, in standard gravitational units (g).
18 | bodyaccjerkzaxistimemean | The mean of body acceleration jerk along the Z-axis, in the time domain, in standard gravitational units (g).
19 | bodyaccjerkxaxistimestd | The standard deviation of body acceleration jerk along the X-axis, in the time domain, in standard gravitational units (g).
20 | bodyaccjerkyaxistimestd | The standard deviation of body acceleration jerk along the Y-axis, in the time domain, in standard gravitational units (g).
21 | bodyaccjerkzaxistimestd | The standard deviation of body acceleration jerk along the Z-axis, in the time domain, in standard gravitational units (g).
22 | bodygyroxaxistimemean | The mean of body angular velocity along the X-axis, in the time domain, in radians/second.
23 | bodygyroyaxistimemean | The mean of body angular velocity along the Y-axis, in the time domain, in radians/second.
24 | bodygyrozaxistimemean | The mean of body angular velocity along the Z-axis, in the time domain, in radians/second.
25 | bodygyroxaxistimestd | The standard deviation of body angular velocity along the X-axis, in the time domain, in radians/second.
26 | bodygyroyaxistimestd | The standard deviation of body angular velocity along the Y-axis, in the time domain, in radians/second.
27 | bodygyrozaxistimestd | The standard deviation of body angular velocity along the Z-axis, in the time domain, in radians/second.
28 | bodygyrojerkxaxistimemean | The mean of body angular velocity jerk along the X-axis, in the time domain, in radians/second.
29 | bodygyrojerkyaxistimemean | The mean of body angular velocity jerk along the Y-axis, in the time domain, in radians/second.
30 | bodygyrojerkzaxistimemean | The mean of body angular velocity jerk along the Z-axis, in the time domain, in radians/second.
31 | bodygyrojerkxaxistimestd | The standard deviation of body angular velocity jerk along the X-axis, in the time domain, in radians/second.
32 | bodygyrojerkyaxistimestd | The standard deviation of body angular velocity jerk along the Y-axis, in the time domain, in radians/second.
33 | bodygyrojerkzaxistimestd | The standard deviation of body angular velocity jerk along the Z-axis, in the time domain, in radians/second.
34 | bodyaccmagtimemean | The mean magnitude of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units (g).
35 | bodyaccmagtimestd | The standard deviation of the magnitude of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units (g).
36 | gravityaccmagtimemean | The mean magnitude of acceleration due to gravity, in the time domain, in standard gravitational units (g).
37 | gravityaccmagtimestd | The standard deviation of the magnitude of acceleration due to gravity, in the time domain, in standard gravitational units (g).
38 | bodyaccjerkmagtimemean | The mean magnitude of body acceleration jerk, in the time domain, in standard gravitational units (g).
39 | bodyaccjerkmagtimestd | The standard deviation of the magnitude of body acceleration jerk, in the time domain, in standard gravitational units (g).
40 | bodygyromagtimemean | The mean magnitude of body angular velocity, in the time domain, in radians/second.
41 | bodygyromagtimestd | The standard deviation of the magnitude of body angular velocity, in the time domain, in radians/second.
42 | bodygyrojerkmagtimemean | The mean of body angular velocity jerk magnitude, in the time domain, in radians/second.
43 | bodygyrojerkmagtimestd | The standard deviation of body angular velocity jerk magnitude, in the time domain, in radians/second.
44 | bodyaccxaxisfreqmean | The mean body acceleration (total acceleration minus gravity) along the X-axis, in the frequency domain, in standard gravitational units (g).
45 | bodyaccyaxisfreqmean | The mean body acceleration (total acceleration minus gravity) along the Y-axis, in the frequency domain, in standard gravitational units (g).
46 | bodyacczaxisfreqmean | The mean body acceleration (total acceleration minus gravity) along the Z-axis, in the frequency domain, in standard gravitational units (g).
47 | bodyaccxaxisfreqstd | The standard deviation of body acceleration (total acceleration minus gravity) along the X-axis, in the frequency domain, in standard gravitational units (g).
48 | bodyaccyaxisfreqstd | The standard deviation of body acceleration (total acceleration minus gravity) along the Y-axis, in the frequency domain, in standard gravitational units (g).
49 | bodyacczaxisfreqstd | The standard deviation of body acceleration (total acceleration minus gravity) along the Z-axis, in the frequency domain, in standard gravitational units (g).
50 | bodyaccjerkxaxisfreqmean | The mean of body acceleration jerk along the X-axis, in the frequency domain, in standard gravitational units (g).
51 | bodyaccjerkyaxisfreqmean | The mean of body acceleration jerk along the Y-axis, in the frequency domain, in standard gravitational units (g).
52 | bodyaccjerkzaxisfreqmean | The mean of body acceleration jerk along the Z-axis, in the frequency domain, in standard gravitational units (g).
53 | bodyaccjerkxaxisfreqstd | The standard deviation of body acceleration jerk along the X-axis, in the frequency domain, in standard gravitational units (g).
54 | bodyaccjerkyaxisfreqstd | The standard deviation of body acceleration jerk along the Y-axis, in the frequency domain, in standard gravitational units (g).
55 | bodyaccjerkzaxisfreqstd | The standard deviation of body acceleration jerk along the Z-axis, in the frequency domain, in standard gravitational units (g).
56 | bodygyroxaxisfreqmean | The mean of body angular velocity along the X-axis, in the frequency domain, in radians/second.
57 | bodygyroyaxisfreqmean | The mean of body angular velocity along the Y-axis, in the frequency domain, in radians/second.
58 | bodygyrozaxisfreqmean | The mean of body angular velocity along the Z-axis, in the frequency domain, in radians/second.
59 | bodygyroxaxisfreqstd | The standard deviation of body angular velocity along the X-axis, in the frequency domain, in radians/second.
60 | bodygyroyaxisfreqstd | The standard deviation of body angular velocity along the Y-axis, in the frequency domain, in radians/second.
61 | bodygyrozaxisfreqstd | The standard deviation of body angular velocity along the Z-axis, in the frequency domain, in radians/second.
62 | bodyaccmagfreqmean | The mean magnitude of body acceleration (total acceleration minus gravity), in the frequency domain, in standard gravitational units (g).
63 | bodyaccmagfreqstd | The standard deviation of the magnitude of body acceleration (total acceleration minus gravity), in the frequency domain, in standard gravitational units (g).
64 | bodyaccjerkmagfreqmean | The mean magnitude of body acceleration jerk, in the frequency domain, in standard gravitational units (g).
65 | bodyaccjerkmagfreqstd | The standard deviation of the magnitude of body acceleration jerk, in the frequency domain, in standard gravitational units (g).
66 | bodygyromagfreqmean | The mean of body angular velocity, in the frequency domain, in radians/second.
67 | bodygyromagfreqstd | The standard deviation of body angular velocity, in the frequency domain, in radians/second.
68 | bodygyrojerkmagfreqmean | The mean of body angular velocity jerk magnitude, in the frequency domain, in radians/second.
69 | bodygyrojerkmagfreqstd | The standard deviation of body angular velocity jerk magnitude, in the frequency domain, in radians/second.

#### Summary Dataset of Means and Standard Deviations - "meanandstdfeatures_summary.txt"

---

This dataset summarizes the preceding dataset with the mean of each variable, grouped by subject, activity, and dataset of origin.

The set of variables in the dataset is as follows:

Variable Number | Name | Description
----------------|------|------------
1 | subjectid | The unique numeric identifier of the test subject for whom the data were collected.
2 | activityname | The name of the activity being performed by the test subject when the observations were recorded.
3 | originaldataset | Records whether the observation was originally part of the test or training datasets.
4 | meanbodyaccxaxistimemean | The mean of mean body acceleration (total acceleration minus gravity) along the X-axis, in the time domain, in standard gravitational units (g).
5 | meanbodyaccyaxistimemean | The mean of mean body acceleration (total acceleration minus gravity) along the Y-axis, in the time domain, in standard gravitational units (g).
6 | meanbodyacczaxistimemean | The mean of mean body acceleration (total acceleration minus gravity) along the Z-axis, in the time domain, in standard gravitational units (g).
7 | meanbodyaccxaxistimestd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the X-axis, in the time domain, in standard gravitational units (g).
8 | meanbodyaccyaxistimestd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the Y-axis, in the time domain, in standard gravitational units (g).
9 | meanbodyacczaxistimestd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the Z-axis, in the time domain, in standard gravitational units (g).
10 | meangravityaccxaxistimemean | The mean of mean acceleration due to gravity along the X-axis, in the time domain, in standard gravitational units (g).
11 | meangravityaccyaxistimemean | The mean of mean acceleration due to gravity along the Y-axis, in the time domain, in standard gravitational units (g).
12 | meangravityacczaxistimemean | The mean of mean acceleration due to gravity along the Z-axis, in the time domain, in standard gravitational units (g).
13 | meangravityaccxaxistimestd | The mean of standard deviation of acceleration due to gravity along the X-axis, in the time domain, in standard gravitational units (g).
14 | meangravityaccyaxistimestd | The mean of standard deviation of acceleration due to gravity along the Y-axis, in the time domain, in standard gravitational units (g).
15 | meangravityacczaxistimestd | The mean of standard deviation of acceleration due to gravity along the Z-axis, in the time domain, in standard gravitational units (g).
16 | meanbodyaccjerkxaxistimemean | The mean of mean of body acceleration jerk along the X-axis, in the time domain, in standard gravitational units (g).
17 | meanbodyaccjerkyaxistimemean | The mean of mean of body acceleration jerk along the Y-axis, in the time domain, in standard gravitational units (g).
18 | meanbodyaccjerkzaxistimemean | The mean of mean of body acceleration jerk along the Z-axis, in the time domain, in standard gravitational units (g).
19 | meanbodyaccjerkxaxistimestd | The mean of standard deviation of body acceleration jerk along the X-axis, in the time domain, in standard gravitational units (g).
20 | meanbodyaccjerkyaxistimestd | The mean of standard deviation of body acceleration jerk along the Y-axis, in the time domain, in standard gravitational units (g).
21 | meanbodyaccjerkzaxistimestd | The mean of standard deviation of body acceleration jerk along the Z-axis, in the time domain, in standard gravitational units (g).
22 | meanbodygyroxaxistimemean | The mean of mean of body angular velocity along the X-axis, in the time domain, in radians/second.
23 | meanbodygyroyaxistimemean | The mean of mean of body angular velocity along the Y-axis, in the time domain, in radians/second.
24 | meanbodygyrozaxistimemean | The mean of mean of body angular velocity along the Z-axis, in the time domain, in radians/second.
25 | meanbodygyroxaxistimestd | The mean of standard deviation of body angular velocity along the X-axis, in the time domain, in radians/second.
26 | meanbodygyroyaxistimestd | The mean of standard deviation of body angular velocity along the Y-axis, in the time domain, in radians/second.
27 | meanbodygyrozaxistimestd | The mean of standard deviation of body angular velocity along the Z-axis, in the time domain, in radians/second.
28 | meanbodygyrojerkxaxistimemean | The mean of mean of body angular velocity jerk along the X-axis, in the time domain, in radians/second.
29 | meanbodygyrojerkyaxistimemean | The mean of mean of body angular velocity jerk along the Y-axis, in the time domain, in radians/second.
30 | meanbodygyrojerkzaxistimemean | The mean of mean of body angular velocity jerk along the Z-axis, in the time domain, in radians/second.
31 | meanbodygyrojerkxaxistimestd | The mean of standard deviation of body angular velocity jerk along the X-axis, in the time domain, in radians/second.
32 | meanbodygyrojerkyaxistimestd | The mean of standard deviation of body angular velocity jerk along the Y-axis, in the time domain, in radians/second.
33 | meanbodygyrojerkzaxistimestd | The mean of standard deviation of body angular velocity jerk along the Z-axis, in the time domain, in radians/second.
34 | meanbodyaccmagtimemean | The mean of mean magnitude of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units (g).
35 | meanbodyaccmagtimestd | The mean of standard deviation of the magnitude of body acceleration (total acceleration minus gravity), in the time domain, in standard gravitational units (g).
36 | meangravityaccmagtimemean | The mean of mean magnitude of acceleration due to gravity, in the time domain, in standard gravitational units (g).
37 | meangravityaccmagtimestd | The mean of standard deviation of the magnitude of acceleration due to gravity, in the time domain, in standard gravitational units (g).
38 | meanbodyaccjerkmagtimemean | The mean of mean magnitude of body acceleration jerk, in the time domain, in standard gravitational units (g).
39 | meanbodyaccjerkmagtimestd | The mean of standard deviation of the magnitude of body acceleration jerk, in the time domain, in standard gravitational units (g).
40 | meanbodygyromagtimemean | The mean of mean magnitude of body angular velocity, in the time domain, in radians/second.
41 | meanbodygyromagtimestd | The mean of standard deviation of the magnitude of body angular velocity, in the time domain, in radians/second.
42 | meanbodygyrojerkmagtimemean | The mean of mean of body angular velocity jerk magnitude, in the time domain, in radians/second.
43 | meanbodygyrojerkmagtimestd | The mean of standard deviation of body angular velocity jerk magnitude, in the time domain, in radians/second.
44 | meanbodyaccxaxisfreqmean | The mean of mean body acceleration (total acceleration minus gravity) along the X-axis, in the frequency domain, in standard gravitational units (g).
45 | meanbodyaccyaxisfreqmean | The mean of mean body acceleration (total acceleration minus gravity) along the Y-axis, in the frequency domain, in standard gravitational units (g).
46 | meanbodyacczaxisfreqmean | The mean of mean body acceleration (total acceleration minus gravity) along the Z-axis, in the frequency domain, in standard gravitational units (g).
47 | meanbodyaccxaxisfreqstd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the X-axis, in the frequency domain, in standard gravitational units (g).
48 | meanbodyaccyaxisfreqstd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the Y-axis, in the frequency domain, in standard gravitational units (g).
49 | meanbodyacczaxisfreqstd | The mean of standard deviation of body acceleration (total acceleration minus gravity) along the Z-axis, in the frequency domain, in standard gravitational units (g).
50 | meanbodyaccjerkxaxisfreqmean | The mean of mean of body acceleration jerk along the X-axis, in the frequency domain, in standard gravitational units (g).
51 | meanbodyaccjerkyaxisfreqmean | The mean of mean of body acceleration jerk along the Y-axis, in the frequency domain, in standard gravitational units (g).
52 | meanbodyaccjerkzaxisfreqmean | The mean of mean of body acceleration jerk along the Z-axis, in the frequency domain, in standard gravitational units (g).
53 | meanbodyaccjerkxaxisfreqstd | The mean of standard deviation of body acceleration jerk along the X-axis, in the frequency domain, in standard gravitational units (g).
54 | meanbodyaccjerkyaxisfreqstd | The mean of standard deviation of body acceleration jerk along the Y-axis, in the frequency domain, in standard gravitational units (g).
55 | meanbodyaccjerkzaxisfreqstd | The mean of standard deviation of body acceleration jerk along the Z-axis, in the frequency domain, in standard gravitational units (g).
56 | meanbodygyroxaxisfreqmean | The mean of mean of body angular velocity along the X-axis, in the frequency domain, in radians/second.
57 | meanbodygyroyaxisfreqmean | The mean of mean of body angular velocity along the Y-axis, in the frequency domain, in radians/second.
58 | meanbodygyrozaxisfreqmean | The mean of mean of body angular velocity along the Z-axis, in the frequency domain, in radians/second.
59 | meanbodygyroxaxisfreqstd | The mean of standard deviation of body angular velocity along the X-axis, in the frequency domain, in radians/second.
60 | meanbodygyroyaxisfreqstd | The mean of standard deviation of body angular velocity along the Y-axis, in the frequency domain, in radians/second.
61 | meanbodygyrozaxisfreqstd | The mean of standard deviation of body angular velocity along the Z-axis, in the frequency domain, in radians/second.
62 | meanbodyaccmagfreqmean | The mean of mean magnitude of body acceleration (total acceleration minus gravity), in the frequency domain, in standard gravitational units (g).
63 | meanbodyaccmagfreqstd | The mean of standard deviation of the magnitude of body acceleration (total acceleration minus gravity), in the frequency domain, in standard gravitational units (g).
64 | meanbodyaccjerkmagfreqmean | The mean of mean magnitude of body acceleration jerk, in the frequency domain, in standard gravitational units (g).
65 | meanbodyaccjerkmagfreqstd | The mean of standard deviation of the magnitude of body acceleration jerk, in the frequency domain, in standard gravitational units (g).
66 | meanbodygyromagfreqmean | The mean of mean of body angular velocity, in the frequency domain, in radians/second.
67 | meanbodygyromagfreqstd | The mean of standard deviation of body angular velocity, in the frequency domain, in radians/second.
68 | meanbodygyrojerkmagfreqmean | The mean of mean of body angular velocity jerk magnitude, in the frequency domain, in radians/second.
69 | meanbodygyrojerkmagfreqstd | The mean of standard deviation of body angular velocity jerk magnitude, in the frequency domain, in radians/second.

## Methodology
