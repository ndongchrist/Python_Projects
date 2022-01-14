import re
mysentence = '''
My mother has phone number +2376 51 42 52 27
my father has phone number +2376.99.65.60.49
my sister has phone number +2376-99-35-71-80
my brother's number number +237659992528
'''
pattern = re.compile(r'[+2376]((| |.|-)([0-9]{2})){6}')
matches = pattern.finditer(mysentence)
for match in matches:
    print(match)
