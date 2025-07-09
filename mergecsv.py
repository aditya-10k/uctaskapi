import pandas as pd

# Read both CSV files
df1 = pd.read_csv("omdb_movies1.csv")
df2 = pd.read_csv("omdb_movies.csv")

# Combine both
merged_df = pd.concat([df1, df2], ignore_index=True)

# Drop duplicates based on 'imdbID' column (or any key column you trust)
final_df = merged_df.drop_duplicates(subset="Title")

# Save to new CSV
final_df.to_csv("moviedata.csv", index=False)

print("✅ Merged and saved as 'merged_no_duplicates.csv'")
