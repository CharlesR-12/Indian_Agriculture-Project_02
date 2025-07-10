# Consolidated Agri-India Data Processing and Visualization Script

# This script handles loading CSV data, populating MySQL database tables,
# and generating various data visualizations for agricultural trends.

# 📌 Stage 1: Import Required Libraries
# Imports pandas for data manipulation, mysql.connector for database interaction,
# and matplotlib, seaborn, plotly for data visualization.
import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px

# 📌 Stage 2: Define MySQL Database Connection Function
# This function encapsulates the MySQL connection details.
# It connects to the 'Project2_Agri_India' database, which is expected
# to be created by the 'agri_india_sql_script'.
def connect_mysql():
    """Establishes and returns a connection to the MySQL database."""
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="123456",
        database="Project2_Agri_India" # Matches the database name in SQL script
    )

# 📌 Stage 3: Load CSV Data into DataFrame
# This stage loads your raw agricultural data from the specified CSV file
# into a Pandas DataFrame.
# IMPORTANT: Update the 'file_path' to the actual location of your CSV file.
file_path = r"E:\Guvi_Class\.venv\Mini_Projects_Data\ICRISAT-District Level Data - ICRISAT-District Level Data.csv"
try:
    df = pd.read_csv(file_path)
    print("✅ CSV Data Loaded Successfully.")
except FileNotFoundError:
    print(f"❌ Error: CSV file not found at {file_path}. Please check the path.")
    exit() # Exit if the file isn't found, as subsequent steps depend on it.

# 📌 Stage 4: Rename CSV Columns to Match Database/Project Standard
# This crucial stage renames the columns in the DataFrame to match the
# standardized naming conventions used in your MySQL database tables.
# The mapping directly corresponds to the column names in the 'agri_production'
# table defined in your SQL script.
df.rename(columns={
    'Dist Code': 'dist_code',
    'Year': 'year',
    'State Code': 'state_code',
    'State Name': 'state_name',
    'Dist Name': 'dist_name',
    'RICE AREA (1000 ha)': 'rice_area',
    'RICE PRODUCTION (1000 tons)': 'rice_production',
    'RICE YIELD (Kg per ha)': 'rice_yield',
    'WHEAT AREA (1000 ha)': 'wheat_area',
    'WHEAT PRODUCTION (1000 tons)': 'wheat_production',
    'WHEAT YIELD (Kg per ha)': 'wheat_yield',
    'SORGHUM AREA (1000 ha)': 'sorghum_area',
    'SORGHUM PRODUCTION (1000 tons)': 'sorghum_production',
    'SORGHUM YIELD (Kg per ha)': 'sorghum_yield',
    'PEARLMILLET AREA (1000 ha)': 'pearlmillet_area',
    'PEARLMILLET PRODUCTION (1000 tons)': 'pearlmillet_production',
    'PEARLMILLET YIELD (Kg per ha)': 'pearlmillet_yield',
    'MAIZE AREA (1000 ha)': 'maize_area',
    'MAIZE PRODUCTION (1000 tons)': 'maize_production',
    'MAIZE YIELD (Kg per ha)': 'maize_yield',
    'FINGERMILLET AREA (1000 ha)': 'fingermillet_area',
    'FINGERMILLET PRODUCTION (1000 tons)': 'fingermillet_production',
    'FINGERMILLET YIELD (Kg per ha)': 'fingermillet_yield',
    'BARLEY AREA (1000 ha)': 'barley_area',
    'BARLEY PRODUCTION (1000 tons)': 'barley_production',
    'BARLEY YIELD (Kg per ha)': 'barley_yield',
    'CHICKPEA AREA (1000 ha)': 'chickpea_area',
    'CHICKPEA PRODUCTION (1000 tons)': 'chickpea_production',
    'CHICKPEA YIELD (Kg per ha)': 'chickpea_yield',
    'PIGEONPEA AREA (1000 ha)': 'pigeonpea_area',
    'PIGEONPEA PRODUCTION (1000 tons)': 'pigeonpea_production',
    'PIGEONPEA YIELD (Kg per ha)': 'pigeonpea_yield',
    'GROUNDNUT AREA (1000 ha)': 'groundnut_area',
    'GROUNDNUT PRODUCTION (1000 tons)': 'groundnut_production',
    'GROUNDNUT YIELD (Kg per ha)': 'groundnut_yield',
    'SESAMUM AREA (1000 ha)': 'sesamum_area',
    'SESAMUM PRODUCTION (1000 tons)': 'sesamum_production',
    'SESAMUM YIELD (Kg per ha)': 'sesamum_yield',
    'RAPESEED AREA (1000 ha)': 'rapeseed_area',
    'RAPESEED PRODUCTION (1000 tons)': 'rapeseed_production',
    'RAPESEED YIELD (Kg per ha)': 'rapeseed_yield',
    'MUSTARD AREA (1000 ha)': 'mustard_area',
    'MUSTARD PRODUCTION (1000 tons)': 'mustard_production',
    'MUSTARD YIELD (Kg per ha)': 'mustard_yield',
    'SAFFLOWER AREA (1000 ha)': 'safflower_area',
    'SAFFLOWER PRODUCTION (1000 tons)': 'safflower_production',
    'SAFFLOWER YIELD (Kg per ha)': 'safflower_yield',
    'CASTOR AREA (1000 ha)': 'castor_area',
    'CASTOR PRODUCTION (1000 tons)': 'castor_production',
    'CASTOR YIELD (Kg per ha)': 'castor_yield',
    'LINSEED AREA (1000 ha)': 'linseed_area',
    'LINSEED PRODUCTION (1000 tons)': 'linseed_production',
    'LINSEED YIELD (Kg per ha)': 'linseed_yield',
    'SUNFLOWER AREA (1000 ha)': 'sunflower_area',
    'SUNFLOWER PRODUCTION (1000 tons)': 'sunflower_production',
    'SUNFLOWER YIELD (Kg per ha)': 'sunflower_yield',
    'SOYBEAN AREA (1000 ha)': 'soybean_area',
    'SOYBEAN PRODUCTION (1000 tons)': 'soybean_production',
    'SOYBEAN YIELD (Kg per ha)': 'soybean_yield',
    'COTTON AREA (1000 ha)': 'cotton_area',
    'COTTON PRODUCTION (1000 tons)': 'cotton_production',
    'COTTON YIELD (Kg per ha)': 'cotton_yield',
    'TOTAL OILSEEDS AREA (1000 ha)': 'oilseeds_area',
    'TOTAL OILSEEDS PRODUCTION (1000 tons)': 'oilseeds_production',
    'TOTAL OILSEEDS YIELD (Kg per ha)': 'oilseeds_yield',
    'SUGARCANE AREA (1000 ha)': 'sugarcane_area',
    'SUGARCANE PRODUCTION (1000 tons)': 'sugarcane_production',
    'SUGARCANE YIELD (Kg per ha)': 'sugarcane_yield',
    'FRUITS AREA (1000 ha)': 'fruits_area',
    'VEGETABLES AREA (1000 ha)': 'vegetables_area',
    'FRUITS AND VEGETABLES AREA (1000 ha)': 'fruits_vegetables_area',
    'POTATOES AREA (1000 ha)': 'potatoes_area',
    'ONION AREA (1000 ha)': 'onion_area',
    'FODDER AREA (1000 ha)': 'fodder_area'
}, inplace=True)
print("✅ CSV Columns Renamed to Match Project Standard.")

# 📌 Stage 5: Validate Renamed Columns
# This stage compares the DataFrame's columns after renaming with the
# expected column list, ensuring consistency before database insertion.
# The 'expected_columns_for_agri_production' list directly mirrors the
# columns defined in your 'agri_production' table in the SQL script.
expected_columns_for_agri_production = [
    'dist_code', 'year',
    'rice_area', 'rice_production', 'rice_yield',
    'wheat_area', 'wheat_production', 'wheat_yield',
    'sorghum_area', 'sorghum_production', 'sorghum_yield',
    'pearlmillet_area', 'pearlmillet_production', 'pearlmillet_yield',
    'maize_area', 'maize_production', 'maize_yield',
    'fingermillet_area', 'fingermillet_production', 'fingermillet_yield',
    'barley_area', 'barley_production', 'barley_yield',
    'chickpea_area', 'chickpea_production', 'chickpea_yield',
    'pigeonpea_area', 'pigeonpea_production', 'pigeonpea_yield',
    'groundnut_area', 'groundnut_production', 'groundnut_yield',
    'sesamum_area', 'sesamum_production', 'sesamum_yield',
    'rapeseed_area', 'rapeseed_production', 'rapeseed_yield',
    'mustard_area', 'mustard_production', 'mustard_yield',
    'safflower_area', 'safflower_production', 'safflower_yield',
    'castor_area', 'castor_production', 'castor_yield',
    'linseed_area', 'linseed_production', 'linseed_yield',
    'sunflower_area', 'sunflower_production', 'sunflower_yield',
    'soybean_area', 'soybean_production', 'soybean_yield',
    'cotton_area', 'cotton_production', 'cotton_yield',
    'oilseeds_area', 'oilseeds_production', 'oilseeds_yield',
    'sugarcane_area', 'sugarcane_production', 'sugarcane_yield',
    'fruits_area', 'vegetables_area', 'fruits_vegetables_area',
    'potatoes_area', 'onion_area', 'fodder_area'
]

csv_columns_after_rename = df.columns.tolist()
missing_columns = [col for col in expected_columns_for_agri_production if col not in csv_columns_after_rename]
extra_columns = [col for col in csv_columns_after_rename if col not in expected_columns_for_agri_production]

print("\n--- Column Validation Results ---")
print("✅ Columns Missing in DataFrame (after rename, if any):\n", missing_columns)
print("✅ Extra/Unexpected Columns in DataFrame (after rename, if any):\n", extra_columns)

if not missing_columns and not extra_columns:
    print("🎉 All DataFrame columns perfectly match the expected project doc structure for agri_production.")
else:
    print("⚠️ Mismatch still exists. Please review Stage 4 renaming and your expected columns list.")

# Reorder DataFrame columns to match the exact order of the agri_production table for insertion.
# This is crucial for the cursor.execute() method when passing a tuple of row values.
df = df[expected_columns_for_agri_production]
print("✅ DataFrame columns reordered to match 'agri_production' table schema.")

# 📌 Stage 6: Connect to MySQL Database
# Establishes the connection to your MySQL database. It assumes the database
# 'Project2_Agri_India' already exists, as created by the SQL script.
try:
    conn = connect_mysql()
    cursor = conn.cursor()
    print("\n✅ Connected to MySQL Database.")
except mysql.connector.Error as err:
    print(f"❌ Error connecting to MySQL: {err}")
    exit() # Exit if database connection fails

# 📌 Stage 7: Insert Master Data (States and Districts)
# This stage inserts unique state and district information into their respective
# master tables ('state_master' and 'district_master').
# 'INSERT IGNORE' is used to prevent errors on duplicate primary keys,
# aligning with the 'ON DUPLICATE KEY UPDATE' added in the SQL script's sample inserts.
print("\n--- Inserting Master Data ---")

# Insert Unique State Master Data into 'state_master' table
states_to_insert = df[['state_code', 'state_name']].drop_duplicates().sort_values('state_code')
for _, row in states_to_insert.iterrows():
    try:
        cursor.execute("""
            INSERT IGNORE INTO state_master (state_code, state_name)
            VALUES (%s, %s)
        """, (int(row['state_code']), row['state_name']))
    except mysql.connector.Error as err:
        print(f"❌ Error inserting state {row['state_name']}: {err}")
conn.commit()
print("✅ Unique State Master Data Inserted.")

# Insert Unique District Master Data into 'district_master' table
districts_to_insert = df[['dist_code', 'dist_name', 'state_code']].drop_duplicates().sort_values('dist_code')
for _, row in districts_to_insert.iterrows():
    try:
        cursor.execute("""
            INSERT IGNORE INTO district_master (dist_code, dist_name, state_code)
            VALUES (%s, %s, %s)
        """, (int(row['dist_code']), row['dist_name'], int(row['state_code'])))
    except mysql.connector.Error as err:
        print(f"❌ Error inserting district {row['dist_name']}: {err}")
conn.commit()
print("✅ Unique District Master Data Inserted.")

# 📌 Stage 7.5: Insert Crop Master Data
# This stage dynamically extracts unique crop names from the DataFrame's column headers
# (which correspond to the 'agri_production' table's crop columns) and inserts them
# into the 'crops' table. The 'crops' table schema is defined in the SQL script.
print("\n--- Inserting Crop Master Data ---")

# Define suffixes to remove to get base crop names
suffixes = ['_area', '_production', '_yield']
crop_names = set()

# Iterate through expected agri_production columns to find unique crop names
for col in expected_columns_for_agri_production:
    # Skip non-crop specific columns that are not actual crops (e.g., identifiers, derived metrics)
    if col in ['dist_code', 'year', 'fruits_vegetables_area']:
        continue

    found_suffix = False
    for suffix in suffixes:
        if col.endswith(suffix):
            crop_name = col.replace(suffix, '')
            if crop_name: # Ensure the crop name is not empty after stripping suffix
                crop_names.add(crop_name)
            found_suffix = True
            break
    # Handle cases for specific crops that might not follow the _area/_production/_yield pattern consistently
    # or are explicitly named without a suffix in the CSV but represent a crop.
    if not found_suffix:
        if col == 'fruits_area':
            crop_names.add('fruits')
        elif col == 'vegetables_area':
            crop_names.add('vegetables')
        elif col == 'potatoes_area':
            crop_names.add('potatoes')
        elif col == 'onion_area':
            crop_names.add('onion')
        elif col == 'fodder_area':
            crop_names.add('fodder')
        elif col == 'oilseeds_area':
            crop_names.add('oilseeds')
        elif col == 'sugarcane_area':
            crop_names.add('sugarcane')


# Sort crop names for consistent insertion order
sorted_crop_names = sorted(list(crop_names))

# Insert unique crop names into the 'crops' table.
# The 'crops' table is expected to be created by the SQL script.
for crop in sorted_crop_names:
    try:
        cursor.execute("""
            INSERT IGNORE INTO crops (crop_name) VALUES (%s)
        """, (crop,))
    except mysql.connector.Error as err:
        print(f"❌ Error inserting crop '{crop}': {err}")
conn.commit()
print("✅ Unique Crop Master Data Inserted.")

# 📌 Stage 7.6: Insert Year Master Data
# This stage extracts unique years from the DataFrame's 'year' column and
# inserts them into the 'years' table. The 'years' table schema is defined
# in the SQL script.
print("\n--- Inserting Year Master Data ---")

# Extract unique years from the DataFrame
unique_years = df['year'].drop_duplicates().sort_values().tolist()

# Insert unique years into the 'years' table.
# The 'years' table is expected to be created by the SQL script.
for year_val in unique_years:
    try:
        cursor.execute("""
            INSERT IGNORE INTO years (year) VALUES (%s)
        """, (int(year_val),))
    except mysql.connector.Error as err:
        print(f"❌ Error inserting year '{year_val}': {err}")
conn.commit()
print("✅ Unique Year Master Data Inserted.")


# 📌 Stage 8: Insert Agricultural Production Data
# This stage inserts the main agricultural production data into the 'agri_production' table.
# The column order and data types are critical here and must match the
# 'agri_production' table definition in the SQL script.
# 'INSERT IGNORE' is used to skip rows that would cause duplicate primary key errors.
# 'fillna(0)' is applied to replace any NaN (Not a Number) values with 0,
# ensuring compatibility with numerical FLOAT columns in the database.
print("\n--- Inserting Agricultural Production Data ---")
for index, row in df.iterrows():
    try:
        # Convert row to tuple, handling NaN values by filling with 0.
        # The order of values in the tuple must exactly match the column order
        # in the INSERT statement and the 'expected_columns_for_agri_production' list.
        values_to_insert = tuple(row.fillna(0).values)
        cursor.execute("""
            INSERT IGNORE INTO agri_production (
                dist_code, year, rice_area, rice_production, rice_yield, wheat_area, wheat_production, wheat_yield,
                sorghum_area, sorghum_production, sorghum_yield, pearlmillet_area, pearlmillet_production, pearlmillet_yield,
                maize_area, maize_production, maize_yield, fingermillet_area, fingermillet_production, fingermillet_yield,
                barley_area, barley_production, barley_yield, chickpea_area, chickpea_production, chickpea_yield,
                pigeonpea_area, pigeonpea_production, pigeonpea_yield, groundnut_area, groundnut_production, groundnut_yield,
                sesamum_area, sesamum_production, sesamum_yield, rapeseed_area, rapeseed_production, rapeseed_yield,
                mustard_area, mustard_production, mustard_yield, safflower_area, safflower_production, safflower_yield,
                castor_area, castor_production, castor_yield, linseed_area, linseed_production, linseed_yield,
                sunflower_area, sunflower_production, sunflower_yield, soybean_area, soybean_production, soybean_yield,
                cotton_area, cotton_production, cotton_yield, oilseeds_area, oilseeds_production, oilseeds_yield,
                sugarcane_area, sugarcane_production, sugarcane_yield, fruits_area, vegetables_area, fruits_vegetables_area,
                potatoes_area, onion_area, fodder_area
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, values_to_insert)
    except mysql.connector.Error as err:
        print(f"❌ Error inserting row {index} (dist_code: {row['dist_code']}, year: {row['year']}): {err}")
        # Optionally, you can break here or log the error more comprehensively
        # For now, it will continue to try inserting other rows.
conn.commit()
print("✅ Agricultural Production Data Inserted.")

# 📌 Stage 9: Close Database Connection
# It's important to close the database connection after all operations are complete.
if 'conn' in locals() and conn.is_connected():
    cursor.close()
    conn.close()
    print("✅ MySQL Database Connection Closed.")
else:
    print("ℹ️ Database connection was not open or already closed.")

# 📌 Stage 10: Data Visualization and Analysis
# This stage uses the loaded and processed DataFrame to create various
# data visualizations, offering insights into agricultural trends.
print("\n--- Generating Data Visualizations ---")

# Set a style for the plots for better aesthetics
sns.set_style("whitegrid")
plt.rcParams['figure.figsize'] = (10, 6) # Default figure size

# 1. Top 7 Rice Producing States (Seaborn Bar Plot)
rice_state = df.groupby('state_name')['rice_production'].sum().nlargest(7)
plt.figure()
sns.barplot(x=rice_state.values, y=rice_state.index, palette="YlGn_r") # _r reverses the colormap
plt.title("Top 7 Rice Producing States")
plt.xlabel("Rice Production (1000 tons)")
plt.ylabel("State Name")
plt.tight_layout()
plt.show()

# 2. Top 5 Wheat Producing States (Seaborn Bar & Plotly Pie)
wheat_state = df.groupby('state_name')['wheat_production'].sum().nlargest(5)
plt.figure()
sns.barplot(x=wheat_state.values, y=wheat_state.index, palette="Oranges_r")
plt.title("Top 5 Wheat Producing States")
plt.xlabel("Wheat Production (1000 tons)")
plt.ylabel("State Name")
plt.tight_layout()
plt.show()

# Plotly Pie Chart for Wheat Production Share
fig_wheat_pie = px.pie(values=wheat_state.values, names=wheat_state.index,
                       title="Wheat Production Share (%)",
                       color_discrete_sequence=px.colors.sequential.Oranges_r)
fig_wheat_pie.show()

# 3. Oilseed Production — Top 5 States (Seaborn Bar Plot)
oil_state = df.groupby('state_name')['oilseeds_production'].sum().nlargest(5)
plt.figure()
sns.barplot(x=oil_state.values, y=oil_state.index, palette='Blues_r')
plt.title("Top 5 Oilseed Producing States")
plt.xlabel("Production (1000 tons)")
plt.ylabel("State Name")
plt.tight_layout()
plt.show()

# 4. Sunflower Production — Top 7 States (Plotly Horizontal Bar)
sunflower_top_states = df.groupby('state_name')['sunflower_production'].sum().nlargest(7).reset_index()
fig_sunflower = px.bar(sunflower_top_states, x='sunflower_production', y='state_name', orientation='h',
                       title="Top 7 Sunflower Producing States",
                       color='state_name', # Color by state for distinction
                       color_discrete_sequence=px.colors.sequential.Viridis)
fig_sunflower.update_layout(yaxis_title="State Name", xaxis_title="Sunflower Production (1000 tons)")
fig_sunflower.show()

# 5. Sugarcane Production Over Time (Seaborn Line Plot)
sugarcane_trend = df.groupby('year')['sugarcane_production'].sum().reset_index()
plt.figure()
sns.lineplot(data=sugarcane_trend, x='year', y='sugarcane_production', marker='o', color='green')
plt.title("Sugarcane Production Trend Over Time")
plt.xlabel("Year")
plt.ylabel("Sugarcane Production (1000 tons)")
plt.tight_layout()
plt.show()

# 6. Rice vs Wheat Production Trend (Seaborn Line Plot)
rice_wheat_trend = df.groupby('year')[['rice_production','wheat_production']].sum().reset_index()
plt.figure()
sns.lineplot(data=rice_wheat_trend, x='year', y='rice_production', label='Rice', marker='o', color='teal')
sns.lineplot(data=rice_wheat_trend, x='year', y='wheat_production', label='Wheat', marker='o', color='darkgoldenrod')
plt.title("Rice vs Wheat Production Trend")
plt.xlabel("Year")
plt.ylabel("Production (1000 tons)")
plt.legend()
plt.tight_layout()
plt.show()

# 7. District-wise Rice Production — West Bengal (Seaborn Bar Plot)
wb_df = df[df['state_name'] == 'West Bengal']
wb_rice_production = wb_df.groupby('dist_name')['rice_production'].sum().nlargest(10)
plt.figure()
sns.barplot(x=wb_rice_production.values, y=wb_rice_production.index, palette="Greens_r")
plt.title("Rice Production — Top Districts (West Bengal)")
plt.xlabel("Rice Production (1000 tons)")
plt.ylabel("District Name")
plt.tight_layout()
plt.show()

# 8. Top 10 Wheat Production Years — Uttar Pradesh (Seaborn Bar Plot)
up_df = df[df['state_name'] == 'Uttar Pradesh']
up_wheat_by_year = up_df.groupby('year')['wheat_production'].sum().nlargest(10)
plt.figure()
sns.barplot(x=up_wheat_by_year.values, y=up_wheat_by_year.index, palette='Oranges_r')
plt.title("Top 10 Wheat Production Years — Uttar Pradesh")
plt.xlabel("Wheat Production (1000 tons)")
plt.ylabel("Year")
plt.tight_layout()
plt.show()

# 9. Finger Millet Production Trend (Seaborn Line Plot)
fingermillet_trend = df.groupby('year')['fingermillet_production'].sum().reset_index()
plt.figure()
sns.lineplot(data=fingermillet_trend, x='year', y='fingermillet_production', marker='o', color='purple')
plt.title("Finger Millet Production Trend Over Time")
plt.xlabel("Year")
plt.ylabel("Finger Millet Production (1000 tons)")
plt.tight_layout()
plt.show()

# 10. Sorghum Production — Top 7 States (Plotly Bar Plot)
sorghum_top_states = df.groupby('state_name')['sorghum_production'].sum().nlargest(7).reset_index()
fig_sorghum = px.bar(sorghum_top_states, x='state_name', y='sorghum_production',
                     title="Top 7 Sorghum Producing States",
                     color='state_name', # Color by state for distinction
                     color_discrete_sequence=px.colors.qualitative.Pastel)
fig_sorghum.update_layout(xaxis_title="State Name", yaxis_title="Sorghum Production (1000 tons)")
fig_sorghum.show()

# 11. Groundnut Production — Top 7 States (Seaborn Bar Plot)
groundnut_top_states = df.groupby('state_name')['groundnut_production'].sum().nlargest(7)
plt.figure()
sns.barplot(x=groundnut_top_states.values, y=groundnut_top_states.index, palette='Purples_r')
plt.title("Top 7 Groundnut Producing States")
plt.xlabel("Groundnut Production (1000 tons)")
plt.ylabel("State Name")
plt.tight_layout()
plt.show()

# 12. Soybean Production vs Yield Efficiency (Plotly Scatter Plot)
soybean_data = df.groupby('state_name')[['soybean_production', 'soybean_yield']].sum().reset_index()
top_5_soybean_states = soybean_data.nlargest(5, 'soybean_production')
fig_soybean = px.scatter(top_5_soybean_states, x='soybean_yield', y='soybean_production',
                         size='soybean_production', # Size of marker based on production
                         hover_name='state_name', # Show state name on hover
                         title="Top 5 Soybean States — Yield vs Production",
                         labels={'soybean_yield': 'Soybean Yield (Kg per ha)',
                                 'soybean_production': 'Soybean Production (1000 tons)'},
                         color='state_name', # Color points by state
                         color_discrete_sequence=px.colors.qualitative.Set2)
fig_soybean.show()

# 13. Area Cultivated vs Production (Rice, Wheat, Maize) — Seaborn Scatter Plot
plt.figure()
sns.scatterplot(x='rice_area', y='rice_production', data=df, label='Rice', alpha=0.6, color='blue')
sns.scatterplot(x='wheat_area', y='wheat_production', data=df, label='Wheat', alpha=0.6, color='red')
sns.scatterplot(x='maize_area', y='maize_production', data=df, label='Maize', alpha=0.6, color='green')
plt.title("Area vs Production — Rice, Wheat, Maize")
plt.xlabel("Area (1000 ha)")
plt.ylabel("Production (1000 tons)")
plt.legend()
plt.tight_layout()
plt.show()

# 14. Top 10 Districts by Rice Yield (Seaborn Bar Plot)
# Identifies and visualizes the top 10 districts with the highest recorded rice yield.
top_rice_yield_districts = df.groupby('dist_name')['rice_yield'].max().nlargest(10)
plt.figure()
sns.barplot(x=top_rice_yield_districts.values, y=top_rice_yield_districts.index, palette="YlGnBu_r")
plt.title("Top 10 Districts by Rice Yield")
plt.xlabel("Rice Yield (Kg per ha)")
plt.ylabel("District Name")
plt.tight_layout()
plt.show()

print("\n--- All Data Visualizations Generated ---")
