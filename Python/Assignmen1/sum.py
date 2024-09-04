'''Write a python code to return the product of two integers only if the product is equal to or lower than 1000. Otherwise, return their sum.'''
import re 

def sum_or_product(num1, num2):
    product = num1 * num2
    if product <= 1000:
        return product
    else:
        return num1 + num2

def get_integer_input(prompt):
    while True:
        val = (input(prompt))
        pattern = "^[0-9]*$"
        result = re.match(pattern,val)
        if result:
            return int(val)
        else:
            print("Enter valid value again") 

n1 = get_integer_input("Enter 1st number: ")
n2 = get_integer_input("Enter 2nd number: ")

result = sum_or_product(n1,n2)
print("result = ", result)