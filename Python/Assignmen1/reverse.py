def custom_length(word): 
    count = 0
    for letter in word:
        count += 1
    return count

def custom_validation(number):
    while True:
        valid = True
        for char in number:
            if not ('0' <= char <= '9'):
                valid = False
                break
        if valid:
            return number
        else:
            number = input("Please enter a valid number again ")

def reverse_digits(number):
    index = custom_length(number) - 1 
    print("Revser order for ", number , " is :" , end=" " )
    while(index>=0):
        print(number[index] , end=" ")
        index-=1
    print()
    
number = custom_validation(input("Enter a number: "))
reverse_digits(number)