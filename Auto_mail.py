from email import message
import smtplib


try:
    smtpObj = smtplib.SMTP('smtp.gmail.com', 587) #Creating an SMTP object
    smtpObj.ehlo()  #Sending a hello message to smtp server
    smtpObj.starttls() # for Encryption
    password = '' # google password
    sender_email = "example_sender@gmail.com" #sender's email
    reciever_email = 'example_reciever@gmail.com' #reciever's email
    msg = input('Write your message: ') #message to be sent
    smtpObj.login(sender_email, password) #login to your account
    #send a message to ndekadji....
    smtpObj.sendmail(sender_email, reciever_email, msg)
    smtpObj.quit()# quit when done
    print('Email sent')

except Exception as ex: #if message is not sent print the following
    print("Something went wrong...", ex)
