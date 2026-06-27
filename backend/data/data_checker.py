import pandas as pd

df = pd.read_csv("backend\data\TEACHERS_TIME_TABLE.csv")

duplicates = df[df.duplicated(
    subset=["Teacher", "Day", "Period"],
    keep=False
)]

duplicates.to_csv("duplicate_entries.csv", index=False)

print(f"Found {len(duplicates)} duplicate rows.")
print(duplicates)
with open("duplicate_entries.csv", "w") as file:
    file.write(duplicates.to_csv(index=False))