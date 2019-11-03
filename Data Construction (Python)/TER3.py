#!/usr/bin/env python
# coding: utf-8

# In[1]:


from PIL import Image
import csv
import os, sys
import numpy
import glob
import scipy.io as sio

#ImageFile.LOAD_TRUNCATED_IMAGES = True


# In[2]:


folders=glob.glob('/home/ilyessou/Bureau/GreyPics/*')
liste=[]
for i in range (0,len(folders)):           
    folder=glob.glob(folders[i])
    pictures=glob.glob(folder[0]+'/*')   # tous les photos du dossier i
    for j in range(0,len(pictures)):
        img=Image.open(pictures[j]) 
        img=img.resize((25, 25), Image.ANTIALIAS)
        imgarr=numpy.array(img).reshape(625)
        #imgarr = numpy.insert(imgarr,i)
        imgarr = numpy.append(imgarr, i+1) # Pour rajouter une dernierre colonne pour supervisé
        liste.append(imgarr)


# In[3]:


matrix=numpy.array(liste)


# In[4]:


sio.savemat('data_set.mat',{'matrix':matrix});    #### .mat


# In[26]:


matrix.shape

