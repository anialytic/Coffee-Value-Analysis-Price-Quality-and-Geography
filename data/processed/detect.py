import chardet

with open("coffee-cleaned.csv", "rb") as f:
    result = chardet.detect(f.read(10000)) 
print(result)