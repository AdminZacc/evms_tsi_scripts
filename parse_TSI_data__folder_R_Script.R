library(tidyverse)

# Specify the path to the folder containing CSV files
folder_path <- "C:/Users/elliotze/OneDrive - evms.edu/Documents/r_stuff/Parse_TSI_Data/Norfolk_TSI_csvs"

# Get a list of all CSV files in the folder
csv_files <- list.files(folder_path, pattern = "\\.csv$", full.names = TRUE)

# Loop through each CSV file
for (csv_file_path in csv_files) {
  cat("\nProcessing file:", csv_file_path, "\n")
  
  # Read and filter the CSV data
  filtered_data <- read_csv(csv_file_path, skip = 39, col_names = FALSE) %>%
    filter(!grepl('^\\s*$', X1) & grepl('\\d{1,2}/\\d{1,2}/\\d{4}', X1))
  
  # Display the modified CSV data
  cat(apply(filtered_data, 1, function(row) paste(row, collapse = '\t')), sep = '\n')
}
