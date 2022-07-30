import os
from gtts import gTTS
import PyPDF2

pdftextF = open('pdftextfile.txt', 'w')


pdfname = 'Charle Severance'
pdfFileOdj = open(pdfname+'.pdf', 'rb')
pdfReader = PyPDF2.PdfFileReader(pdfFileOdj)
pdftext = PyPDF2.PdfFileWriter()
for i in range(0, pdfReader.numPages):
    pageObj = pdfReader.getPage(i)
    print(type(pdftext.addPage(pageObj)))



language = 'en'
VoiceObj = gTTS(text = pdftextF, lang=language)
VoiceObj.save(pdfname+'.mp3')


