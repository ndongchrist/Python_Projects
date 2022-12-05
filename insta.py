
from instagrapi import Client
from time import sleep

cl = Client()
password = input('password: ')
cl.login('ndongmochristian1', password)

comments = ['Nice Move on', 'Bravo', '👏👏🙌👏', "🙌🙌👏🙌", "❤️❤️❤️", " 😍❤️🙌🙌", "🙌🙌🔥🔥", "😇😇😇", "❤️❤️🥺🥺🥺", "🔥🔥🔥🔥"]

media_id = cl.media_id(cl.media_pk_from_url('https://www.instagram.com/p/ClmkBS7t-Wf/?igshid=YmMyMTA2M2Y='))

i = 0
while(i != 10):
   coment = cl.media_comment(media_id, comments[0])
   sleep(1)
   coment = cl.media_comment(media_id, comments[1])
   sleep(1)
   coment = cl.media_comment(media_id, comments[2])
   sleep(1)
   coment = cl.media_comment(media_id, comments[3])
   sleep(1)
   coment = cl.media_comment(media_id, comments[4])
   sleep(1)
   coment = cl.media_comment(media_id, comments[5])
   sleep(1)
   coment = cl.media_comment(media_id, comments[6])
   sleep(1)
   coment = cl.media_comment(media_id, comments[7])
   sleep(1)
   coment = cl.media_comment(media_id, comments[8])
   sleep(1)
   coment = cl.media_comment(media_id, comments[9])
   sleep(1800)
   i = i + 1

#comment =  cl.media_comment(media_id, '🙌🙌👏🙌')
