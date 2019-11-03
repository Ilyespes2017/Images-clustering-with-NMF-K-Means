import flickrapi
import urllib.request
from PIL import Image
# Flickr api access key 
flickr=flickrapi.FlickrAPI('97c7f44a6015743ff2cbf9ea8fc6eb23', 'e7d6b6f428d87320', cache=True)

nbr_cats=600
nbr_snake=300
nbr_zebra=250
nbr_horse=600
nbr_fish=250
data=[
           ['chat',int(0.8*nbr_cats)],
           ['set of cat',int(0.2*nbr_cats)],
           ['snake',nbr_snake],
           ['zebra',nbr_zebra],
           ['horse head',int(0.5*nbr_horse)],
           ['horses',int(0.5*nbr_horse)],
           ['fishes',int(0.25*nbr_fish)],
           ['Cleidopus gloriamaris',int(0.25*nbr_fish)],
           ['stripped fish',int(0.25*nbr_fish)],
           ['shark fish',int(0.25*nbr_fish)]
          ]

for i in range(0,len(data)):
        print(i)
        photos = flickr.walk(text=data[i][0],
                     tag_mode='all',
                     tags=data[i][0],
                     extras='url_c',
                     per_page=data[i][1],           # may be you can try different numbers..
                     sort='relevance')
        urls = []
        for j, photo in enumerate(photos):
            url = photo.get('url_c')
            if(url!=None):
                urls.append(url)
        # get number of pic
            if j > data[i][1]:
                break
            
        # Download image from the url and save it to '00001.jpg'
        for k in range(0,len(urls)):
            chemin='/home/ilyessou/Bureau/TER/'+data[i][0]+'/'+str(k)+'.jpg'
            urllib.request.urlretrieve(urls[k], chemin)
            # Resize the image and overwrite it
            image = Image.open(chemin) 
            image = image.resize((100, 100), Image.ANTIALIAS)
            image.save(chemin)


