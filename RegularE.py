import re
chaine = "" 
expression = r"^0[0-9]([ .-]?[0-9]{2}){4}$" 
while re.search(expression, chaine) is None:
        chaine = input("Saisissez un numéro de téléphone (valide) :")
