library(tidyverse)
csv_file_path <- <Your csv file path>
filtered_data <- read_csv(csv_file_path, skip = 39, col_names = FALSE) %>%
  filter(!grepl('^\\s*$', X1) & grepl('\\d{1,2}/\\d{1,2}/\\d{4}', X1))
cat(apply(filtered_data, 1, function(row) paste(row, collapse = '\t')), sep = '\n')
