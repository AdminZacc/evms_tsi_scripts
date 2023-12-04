# Specify the path to your CSV file
csv_file_path <- 'tsi_data_hunters_square.csv'

# Read the CSV data from the file
data_lines <- read.csv(csv_file_path, header = FALSE, stringsAsFactors = FALSE)

# Find the index of the header line
header_index <- NULL
for (i in seq_along(data_lines$V1)) {
  if (length(data_lines$V3[i]) >= 3 && 'Date' %in% data_lines$V1[i] && 'Time' %in% data_lines$V2[i] && 'MC' %in% data_lines$V3[i]) {
    header_index <- i
    break
  }
}

# Check if the header was found
if (!is.null(header_index)) {
  # Extract the last three columns based on their positions in a JSON index
  json_index <- c('Date' = 1, 'Time' = 2, 'MC' = 3)
  last_three_columns <- data_lines[header_index + 1, json_index]

  # Regular expression to match unwanted lines
  unwanted_pattern <- 'Instrument Name:|Model Number:|Serial Number:|Test Name:|' 
                     'Start Date:|Start Time:|Duration \\(dd:hh:mm:ss\\):|' 
                     'Log Interval \\(mm:ss\\):|Number of points:|Description:|' 
                     'Statistics Channel:|Units:|Average:|Minimum:|' 
                     'Time of Minimum:|Date of Minimum:|Maximum:|' 
                     'Time of Maximum:|Date of Maximum:|TWA:|' 
                     'Calibration Sensor:|Cal factor:|Cal date:|Cal name:'

  # Extracted data without unwanted columns, empty rows, headers, and specified text
  extracted_data <- data_lines[(header_index + 1):nrow(data_lines), json_index]
  extracted_data <- extracted_data[!(grepl(unwanted_pattern, paste(extracted_data, collapse = ',')) | 
                                    apply(extracted_data, 1, function(row) all(row %in% c('Date', 'MC', 'Time')) |
                                                                 all(row %in% c('MM/dd/yyyy', 'mg/m³', 'HH:mm:ss')))), ]

  # Display the modified CSV data without headers and specified text
  cat(apply(extracted_data, 1, function(row) paste(row, collapse = '\t')), sep = '\n')
} else {
  cat("Header not found in the CSV file.\n")
}
