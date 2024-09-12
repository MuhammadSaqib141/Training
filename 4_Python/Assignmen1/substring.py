def custom_length(word): 
    count = 0
    for letter in word:
        count += 1
    return count

def find_occurrence(sentence, word):
    often_appeared = 0
    word_length = custom_length(word)
    sentence_length = custom_length(sentence)
    index = 0
    while index < sentence_length:
        if sentence[index:index + word_length] == word:
            often_appeared += 1
        index += 1
    print(f"{word} is appeared {often_appeared} times")
        
str_x = input("Enter sentence: ")
word = input("Enter word you want to find: ")

find_occurrence(str_x, word)