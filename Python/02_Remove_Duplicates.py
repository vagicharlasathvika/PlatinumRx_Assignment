def remove_duplicates(input_string):
    result = ""
    
    for char in input_string:
        if char not in result:
            result += char
    
    return result

# Test cases
print(remove_duplicates("programming"))   
print(remove_duplicates("aabbccdd"))      
print(remove_duplicates("hello world"))   
print(remove_duplicates("data analyst"))