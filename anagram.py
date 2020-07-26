def is_anagram(string1: str, string2: str) -> bool:
    '''
    Function that checks if two strings are anagrams.
    Solution: count the character numbers for each string and compare them.
    Alternative solution could be sorting to strings and comparing them,
    but this solution is slower than previous one ( O(n) vs O(n log n) ).
    '''

    # first rule: strings' lengths must be equal for anagramity
    if len(string1) != len(string2):
        return False

    char_count = [0] * 256

    for char in string1:
        char_count[ord(char)]+=1
    for char in string2:
        char_count[ord(char)]-=1

    for count in char_count:
        if count > 0:
            # number of all characters must be equal
            return False
    return True
