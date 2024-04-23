import pandas as pd

# Replace 'your_input_file.csv' with the actual path
input_file_path = 'filename'
output_file_path = 'header_information.csv'  # Specify the desired output file path

# Read the CSV file into a DataFrame
df = pd.read_csv(input_file_path)

# Extract information from 'Unnamed: 2' column
selected_column = 'Unnamed: 2'
selected_data = df[[selected_column]].rename(columns={selected_column: 'air monitor data'})

# Drop rows with empty values
selected_data = selected_data.dropna()

# Add a header for the data
header_info = {
    'Selected Column': selected_column,
    'Total Rows': len(selected_data),
    
}

# Output the selected data with headers and additional information to a CSV file
with open(output_file_path, 'w', newline='') as csv_file:
    csv_file.write("Header Information:\n")
    for key, value in header_info.items():
        csv_file.write(f"{key}: {value}\n")
    csv_file.write("\nSelected Data:\n")
    selected_data.to_csv(csv_file, index=False)

print(f"Selected data with headers, additional information, and empty rows removed, written to {output_file_path}")
