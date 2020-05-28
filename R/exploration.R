# Load libraries ---------------------------------------------------------------

# devtools::install_github("ikosmidis/GoldenCheetahOpenData")
library(here)
library(GoldenCheetahOpenData)
library(trackeR)

# Import the data --------------------------------------------------------------

# Get the list of athlete IDs
ids <- get_athlete_ids()

# Download workouts for a subset of athlete IDs
workouts_subset <- download_workouts(
  ids,
  pattern = "a92e", # Random string to match to GUIDs
  local_dir = here("data"), # saved to "data" sub-folder
  verbose = TRUE)

# To read the data in from a new R session without re-downloading, use:
# workouts_subset <- rebuild_db(here("data))

# Wrangle the data -------------------------------------------------------------

# Read the workouts data for each athlete ID
workouts_tidy <- read_workouts(workouts_subset)

# Create separate data sets for each athlete
athlete1 <- workouts_tidy$`0b1eae3e-a92e-4d27-b551-384ce730c71a`
athlete2 <- workouts_tidy$`cd249b74-0944-41c9-8143-c2ba92ea5754`
athlete3 <- workouts_tidy$`da92ef50-5527-4285-a1f0-dbddea700b37`

# Explore the data -------------------------------------------------------------

# Number of workout sessions per athlete ID
sapply(workouts_tidy, nsessions)

# Total duration per athlete ID in hours
sapply(workouts_tidy,
       function(x)
         round(sum(session_duration(x, duration_unit = "h")), 2))

# Training times
timeline(athlete1)