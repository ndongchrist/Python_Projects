from cProfile import label
from tkinter import *

root = Tk()

mylabel = Label(root, text='Hello Walter')
mylabel2 = Label(root, text="My name is Akashi")

mylabel2.grid(row=0, column = 0)
mylabel.grid(row=10, column = 0)

root.mainloop()