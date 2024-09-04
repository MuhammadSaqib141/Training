import re

prev_number=0
for current_number in range(20):
    print(f"Current Number {current_number:4d}  Previous Number  {prev_number:4d}   Sum:  {current_number + prev_number:5d}")
    prev_number = current_number