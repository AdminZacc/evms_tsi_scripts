import csv

output = []

# Read data from the original CSV file
with open('tsi_data_hunters_square.csv', 'r') as file:
    reader = csv.reader(file)
    for row in reader:
        # Check if the row is not empty and none of the selected columns have no data or ""
        if row and all(cell.strip() != "" for cell in (row[0], row[1], row[2])):
            output.append((row[0], row[1], row[2]))  # Select the first, second, and third columns
        if row and all(cell.strip() == r'Date|Time|MC|MM/dd/yyyy|HH:mm:ss|mg/mA' for cell in (row[0], row[1], row[2])):
            output.append((row[0], row[1], row[2]))  # Select the first, second, and third columns
# Write the selected columns to a new CSV file
with open('selected_columns_output.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(output)

print("Selected columns with non-empty values have been written to selected_columns_output.csv.")
