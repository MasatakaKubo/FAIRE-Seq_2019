#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import matplotlib as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


dataname1=('201117-NPM')
dataname2=('201117-nonNPM')
date=('20.11.17')
uq1 = pd.read_csv(''+date+'/annotation/uq_'+dataname1+'.bt.annotated.txt', sep='\t')
uq2 = pd.read_csv(''+date+'/annotation/uq_'+dataname2+'.bt.annotated.txt', sep='\t')
common = pd.read_csv(''+date+'/annotation/uq_'+dataname1+'_'+dataname2+'.bt.annotated.txt', sep='\t')


# In[3]:


uq1 = uq1.dropna(subset=['Annotation'])
uq2 = uq2.dropna(subset=['Annotation'])
common = common.dropna(subset=['Annotation'])


# In[4]:


uq1['Annotation'].unique()


# In[5]:


uq1['Annotation'].value_counts()


# In[6]:


uq1 = uq1.replace('\(.+\)', '', regex=True)
uq1['Annotation'].unique()


# In[7]:


uq1 = uq1.replace('TTS', 'TES', regex=True)
uq1['Annotation'].unique()


# In[8]:


uq1 = uq1.replace('\.(2|3)', '', regex=True)
uq1['Annotation'].unique()


# In[9]:


uq1 = uq1.replace('promoter-', '', regex=True)
uq1 = uq1.replace(' ', '', regex=True)
uq1['Annotation'].unique()


# In[10]:


uq1['Annotation'].value_counts()


# In[11]:


###matomete shori
uq2 = uq2.replace('\(.+\)', '', regex=True)
uq2 = uq2.replace('TTS', 'TES', regex=True)
uq2 = uq2.replace('\.(2|3)', '', regex=True)
uq2 = uq2.replace('promoter-', '', regex=True)
uq2 = uq2.replace(' ', '', regex=True)
uq2['Annotation'].value_counts()


# In[12]:


common = common.replace('\(.+\)', '', regex=True)
common = common.replace('TTS', 'TES', regex=True)
common = common.replace('\.(2|3)', '', regex=True)
common = common.replace('promoter-', '', regex=True)
common = common.replace(' ', '', regex=True)
common['Annotation'].value_counts()


# In[13]:


anno1 = uq1['Gene Name']
anno2 = uq2['Gene Name']
coanno = common['Gene Name']


# In[14]:


anno1


# In[15]:


#kyo-tu-bubun
intersect_all = set(anno1) & set(anno2)
#sa-shu-gou
uq1_all = set(anno1) - set(anno2)
uq2_all = set(anno2) - set(anno1)
print(len(intersect_all), len(uq1_all), len(uq2_all))


# In[19]:


with open('intersect_allGene.txt', 'w') as f:
    for item in intersect_all:
        f.write("{}\n".format(item))
with open('uq_NPM_allGene.txt', 'w') as f:
    for item in uq1_all:
        f.write("{}\n".format(item))
with open('uq_nonNPM_allGene.txt', 'w') as f:
    for item in uq2_all:
        f.write("{}\n".format(item))


# In[ ]:




