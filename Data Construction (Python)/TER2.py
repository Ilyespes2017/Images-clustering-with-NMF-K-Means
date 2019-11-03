#!/usr/bin/env python
# coding: utf-8

# In[20]:


from PIL import Image
#ImageFile.LOAD_TRUNCATED_IMAGES = True
import os, sys
import numpy
import glob


# In[55]:


folders=glob.glob('C:/Users/utilisateur/Desktop/TER_GLOBAL/TER_Part1/Photos/*') # enregistrer la liste de tous les dossiers d'annimaux
for i in range (0,len(folders)):           # parcourir tous dossier
    folder=glob.glob(folders[i])
    pictures=glob.glob(folder[i]+'/*')   # tous les photos du dossier i
    for j in range(0,len(pictures)):
        
        dossier=folder[i].split("/")[6]+'/'    #split pour prendre le nom du fichier   
        dossierGrey='C:/Users/utilisateur/Desktop/TER_GLOBAL/TER_Part1/Photos/Grey/'+dossier+'/'
        path=dossierGrey+str(j)+'.jpg'
        if not os.path.exists(dossierGrey):
                os.mkdir(dossierGrey)
                img.save(path)

