#
# This script, run_analysis.R, is used to extract data from the UCI HAR Dataset, and produce two new, tidy datasets.
# Please see the accompanying README.md and CodeBook.md files for details.
#

library(data.table) # We need data.table's fread function to read the feature data. It works much better than read.fwf.
library(dplyr) # We'll be using dplyr to manipulate the data.

#
# Constants - We're going to define a few constants we'll use later.
#

# A constant for the base directory containing the original datasets.
datasetbase <- "UCI HAR Dataset"

# The list of features we actually want, as a vector of their column indices.
selected_features <- c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126,
                       161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268,
                       269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517,
                       529, 530, 542, 543)

# The names to give the features we're keeping.
feature_names <- c("bodyaccxaxistimemean", "bodyaccyaxistimemean", "bodyacczaxistimemean", "bodyaccxaxistimestd",
                   "bodyaccyaxistimestd", "bodyacczaxistimestd", "gravityaccxaxistimemean", "gravityaccyaxistimemean",
                   "gravityacczaxistimemean", "gravityaccxaxistimestd", "gravityaccyaxistimestd",
                   "gravityacczaxistimestd", "bodyaccjerkxaxistimemean", "bodyaccjerkyaxistimemean",
                   "bodyaccjerkzaxistimemean", "bodyaccjerkxaxistimestd", "bodyaccjerkyaxistimestd",
                   "bodyaccjerkzaxistimestd", "bodygyroxaxistimemean", "bodygyroyaxistimemean",
                   "bodygyrozaxistimemean", "bodygyroxaxistimestd", "bodygyroyaxistimestd", "bodygyrozaxistimestd",
                   "bodygyrojerkxaxistimemean", "bodygyrojerkyaxistimemean", "bodygyrojerkzaxistimemean",
                   "bodygyrojerkxaxistimestd", "bodygyrojerkyaxistimestd", "bodygyrojerkzaxistimestd",
                   "bodyaccmagtimemean", "bodyaccmagtimestd", "gravityaccmagtimemean", "gravityaccmagtimestd",
                   "bodyaccjerkmagtimemean", "bodyaccjerkmagtimestd", "bodygyromagtimemean", "bodygyromagtimestd",
                   "bodygyrojerkmagtimemean", "bodygyrojerkmagtimestd", "bodyaccxaxisfreqmean", "bodyaccyaxisfreqmean",
                   "bodyacczaxisfreqmean", "bodyaccxaxisfreqstd", "bodyaccyaxisfreqstd", "bodyacczaxisfreqstd",
                   "bodyaccjerkxaxisfreqmean", "bodyaccjerkyaxisfreqmean", "bodyaccjerkzaxisfreqmean",
                   "bodyaccjerkxaxisfreqstd", "bodyaccjerkyaxisfreqstd", "bodyaccjerkzaxisfreqstd",
                   "bodygyroxaxisfreqmean", "bodygyroyaxisfreqmean", "bodygyrozaxisfreqmean", "bodygyroxaxisfreqstd",
                   "bodygyroyaxisfreqstd", "bodygyrozaxisfreqstd", "bodyaccmagfreqmean", "bodyaccmagfreqstd",
                   "bodyaccjerkmagfreqmean", "bodyaccjerkmagfreqstd", "bodygyromagfreqmean", "bodygyromagfreqstd",
                   "bodygyrojerkmagfreqmean", "bodygyrojerkmagfreqstd")

#
# Activity Labels
#
# First we want to read in the activity labels used for the observations, so we can convert the numeric values in the
# datasets into the actual names of the activities.
#

# Get the data.
activitylabels <- tbl_df(read.table(file.path(datasetbase, "activity_labels.txt"), sep = " ",
                                    col.names = c("activityid", "activityname"), colClasses = c("integer", "factor")))

# Make the activity names lowercase, and change underscores to spaces.
activitylabels <- mutate(activitylabels, activityname = gsub("_", " ", tolower(activityname)))

#
# Read Datasets
#
# Process each of the test and training datasets in turn, and merge them together.
#

# Before we start, we'll create a variable called dataset that's just an empty vector.
# We'll use it to accumulate the data from the test and training datasets.
dataset <- c()

# Now process the test and training data...
for (setname in c("test", "train")) {
  # The paths of the three files we'll be reading here.
  subject.file <- file.path(datasetbase, setname, paste("subject_", setname, ".txt", sep = ""))
  activity.file <- file.path(datasetbase, setname, paste("y_", setname, ".txt", sep = ""))
  feature.file <- file.path(datasetbase, setname, paste("X_", setname, ".txt", sep = ""))

  # First get the list of subjects.
  subjects <- tbl_df(read.table(subject.file, col.names = "subjectid", colClasses = "integer"))

  # Then get the list of activities.
  activities <- tbl_df(read.table(activity.file, col.names = "activityid", colClasses = "integer"))

  # Change activity ids to activity names by joining with activitylabels.
  activities <- activities %>% left_join(activitylabels, by = "activityid") %>% select(activityname) %>%
    mutate(activityname = as.factor(activityname))

  # Generate a vector that indicates the source (test or train) of these observations.
  origin <- tbl_df(data.frame(originaldataset = rep.int(setname, dim(subjects)[1])))

  # Now for the most important part: pull in the feature data.
  features <- tbl_df(fread(feature.file))

  # Select out only the features we want.
  features <- select(features, selected_features)

  # And give them names.
  names(features) <- feature_names

  # Bind the columns of this dataset together, and bind the resulting rows with the dataset variable.
  dataset <- rbind(dataset, tbl_df(cbind(subjects, activities, origin, features)))
}

#
# Save merged dataset.
#
# Write out the dataset we just generated that contains only the features for means and standard deviations of
# measurements.
#
write.table(dataset, file = "meanandstdfeatures.txt", row.name = FALSE)

#
# Summary Dataset
#
# Now we need to produce a second dataset that summarizes the first.
#

# First, group the dataset.
dataset <- group_by(dataset, subjectid, activityname, originaldataset)

# Now produce the summary, where we're including only the mean of each variable.
dataset <- summarize(dataset,
                     meanbodyaccxaxistimemean = mean(bodyaccxaxistimemean),
                     meanbodyaccyaxistimemean = mean(bodyaccyaxistimemean),
                     meanbodyacczaxistimemean = mean(bodyacczaxistimemean),
                     meanbodyaccxaxistimestd = mean(bodyaccxaxistimestd),
                     meanbodyaccyaxistimestd = mean(bodyaccyaxistimestd),
                     meanbodyacczaxistimestd = mean(bodyacczaxistimestd),
                     meangravityaccxaxistimemean = mean(gravityaccxaxistimemean),
                     meangravityaccyaxistimemean = mean(gravityaccyaxistimemean),
                     meangravityacczaxistimemean = mean(gravityacczaxistimemean),
                     meangravityaccxaxistimestd = mean(gravityaccxaxistimestd),
                     meangravityaccyaxistimestd = mean(gravityaccyaxistimestd),
                     meangravityacczaxistimestd = mean(gravityacczaxistimestd),
                     meanbodyaccjerkxaxistimemean = mean(bodyaccjerkxaxistimemean),
                     meanbodyaccjerkyaxistimemean = mean(bodyaccjerkyaxistimemean),
                     meanbodyaccjerkzaxistimemean = mean(bodyaccjerkzaxistimemean),
                     meanbodyaccjerkxaxistimestd = mean(bodyaccjerkxaxistimestd),
                     meanbodyaccjerkyaxistimestd = mean(bodyaccjerkyaxistimestd),
                     meanbodyaccjerkzaxistimestd = mean(bodyaccjerkzaxistimestd),
                     meanbodygyroxaxistimemean = mean(bodygyroxaxistimemean),
                     meanbodygyroyaxistimemean = mean(bodygyroyaxistimemean),
                     meanbodygyrozaxistimemean = mean(bodygyrozaxistimemean),
                     meanbodygyroxaxistimestd = mean(bodygyroxaxistimestd),
                     meanbodygyroyaxistimestd = mean(bodygyroyaxistimestd),
                     meanbodygyrozaxistimestd = mean(bodygyrozaxistimestd),
                     meanbodygyrojerkxaxistimemean = mean(bodygyrojerkxaxistimemean),
                     meanbodygyrojerkyaxistimemean = mean(bodygyrojerkyaxistimemean),
                     meanbodygyrojerkzaxistimemean = mean(bodygyrojerkzaxistimemean),
                     meanbodygyrojerkxaxistimestd = mean(bodygyrojerkxaxistimestd),
                     meanbodygyrojerkyaxistimestd = mean(bodygyrojerkyaxistimestd),
                     meanbodygyrojerkzaxistimestd = mean(bodygyrojerkzaxistimestd),
                     meanbodyaccmagtimemean = mean(bodyaccmagtimemean),
                     meanbodyaccmagtimestd = mean(bodyaccmagtimestd),
                     meangravityaccmagtimemean = mean(gravityaccmagtimemean),
                     meangravityaccmagtimestd = mean(gravityaccmagtimestd),
                     meanbodyaccjerkmagtimemean = mean(bodyaccjerkmagtimemean),
                     meanbodyaccjerkmagtimestd = mean(bodyaccjerkmagtimestd),
                     meanbodygyromagtimemean = mean(bodygyromagtimemean),
                     meanbodygyromagtimestd = mean(bodygyromagtimestd),
                     meanbodygyrojerkmagtimemean = mean(bodygyrojerkmagtimemean),
                     meanbodygyrojerkmagtimestd = mean(bodygyrojerkmagtimestd),
                     meanbodyaccxaxisfreqmean = mean(bodyaccxaxisfreqmean),
                     meanbodyaccyaxisfreqmean = mean(bodyaccyaxisfreqmean),
                     meanbodyacczaxisfreqmean = mean(bodyacczaxisfreqmean),
                     meanbodyaccxaxisfreqstd = mean(bodyaccxaxisfreqstd),
                     meanbodyaccyaxisfreqstd = mean(bodyaccyaxisfreqstd),
                     meanbodyacczaxisfreqstd = mean(bodyacczaxisfreqstd),
                     meanbodyaccjerkxaxisfreqmean = mean(bodyaccjerkxaxisfreqmean),
                     meanbodyaccjerkyaxisfreqmean = mean(bodyaccjerkyaxisfreqmean),
                     meanbodyaccjerkzaxisfreqmean = mean(bodyaccjerkzaxisfreqmean),
                     meanbodyaccjerkxaxisfreqstd = mean(bodyaccjerkxaxisfreqstd),
                     meanbodyaccjerkyaxisfreqstd = mean(bodyaccjerkyaxisfreqstd),
                     meanbodyaccjerkzaxisfreqstd = mean(bodyaccjerkzaxisfreqstd),
                     meanbodygyroxaxisfreqmean = mean(bodygyroxaxisfreqmean),
                     meanbodygyroyaxisfreqmean = mean(bodygyroyaxisfreqmean),
                     meanbodygyrozaxisfreqmean = mean(bodygyrozaxisfreqmean),
                     meanbodygyroxaxisfreqstd = mean(bodygyroxaxisfreqstd),
                     meanbodygyroyaxisfreqstd = mean(bodygyroyaxisfreqstd),
                     meanbodygyrozaxisfreqstd = mean(bodygyrozaxisfreqstd),
                     meanbodyaccmagfreqmean = mean(bodyaccmagfreqmean),
                     meanbodyaccmagfreqstd = mean(bodyaccmagfreqstd),
                     meanbodyaccjerkmagfreqmean = mean(bodyaccjerkmagfreqmean),
                     meanbodyaccjerkmagfreqstd = mean(bodyaccjerkmagfreqstd),
                     meanbodygyromagfreqmean = mean(bodygyromagfreqmean),
                     meanbodygyromagfreqstd = mean(bodygyromagfreqstd),
                     meanbodygyrojerkmagfreqmean = mean(bodygyrojerkmagfreqmean),
                     meanbodygyrojerkmagfreqstd = mean(bodygyrojerkmagfreqstd))

#
# Save summary dataset.
#
# Write out the dataset we just generated that contains only the means of the selected variables, grouped by subject,
# activity, and origin.
#
write.table(dataset, file = "meanandstdfeatures_summary.txt", row.name = FALSE)
