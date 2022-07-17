import smtplib
import imapclient

smtpObj = smtplib.SMTP('smtp.gmail.com', 587) #Creating an SMTP object
smtpObj.ehlo()  #Sending a hello message to smtp server
smtpObj.starttls() # for Encryption
password = input('Enter your password: ') # google password
smtpObj.login('christianhnore2003@gmail.com', password) #login to your account
#send a message to ndekadji....
smtpObj.sendmail('christianhonore2003@gmail.com', 'ndekaji@gmail.com','Subject: Hello Kadji, Sending this email from the termimal')
smtpObj.quit()# quit when done