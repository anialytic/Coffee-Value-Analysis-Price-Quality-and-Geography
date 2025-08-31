import chardet

with open("top-rated-coffee-clean.csv", "rb") as f:
    result = chardet.detect(f.read(10000)) 
print(result)