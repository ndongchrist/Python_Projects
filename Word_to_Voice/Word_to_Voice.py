import os
from gtts import gTTS
import PyPDF2

pdftextF = open('pdftextfile.txt', 'w')


pdfname = 'Charle Severance'
pdfFileOdj = open(pdfname+'.pdf', 'rb')
pdfReader = PyPDF2.PdfFileReader(pdfFileOdj)
pdftext = PyPDF2.PdfFileWriter()
text = ''
for i in range(0, pdfReader.numPages):
    pageObj = pdfReader.getPage(i)
    pdftextF = pageObj.extract_text()
    text = text + pdftextF

pdfFileOdj.close()



language = 'en'
VoiceObj = gTTS(text = text, lang=language)
VoiceObj.save('output.mp3')
os.system('vlc output.mp3')


