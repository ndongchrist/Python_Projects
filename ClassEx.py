import re
Msg = '''
My mother has phone number +237651425227
my father has phone number +2376.99.65.60.49
my sister has phone number +2376-99-35-71-80
my brother's number number +237659992528
'''
chain = r"^+2376([.- ]?[0-9]{2}){4}$"
ChainCom = re.compile(chain)
matches = ChainCom.finditer(Msg)
for match in matches:
    print(match)