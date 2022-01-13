import re
mysentence='''
My name is Pamela ATABONG. I am 20 years old and reading Computer Engineering in UBA.
My school is College of Technology and my level is Level 300.
All the mates of Level300 love programming in Python and they use Regular Expressions
'''
pattern=re.compile(r'[lL]evel.\d\d\d\b')
matches=pattern.finditer(mysentence)
for match in matches:
    print(match)