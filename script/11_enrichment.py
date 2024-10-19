#!/usr/bin/env python
# coding: utf-8

# In[1]:


#matplotlib.use('Agg')
import pandas as pd
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


dataname="201117-NPM"
inputname="SRR12107011"
ref_gene="susScr11"


# In[3]:


#DataFrame
df = pd.read_csv(''+dataname+'/peak_annotation/'+dataname+'_peaks.annotated.txt', sep="\t")
df_input = pd.read_csv(''+inputname+'/peak_annotation/'+inputname+'_peaks.annotated.txt', sep="\t")


# In[4]:


df.head()


# In[5]:


df_input.head()


# In[6]:


#delete useless characters in df
df["Annotation"].replace('\(.*?\)', '', regex=True, inplace=True)
df["Annotation"].replace('\./d*', '', regex=True, inplace=True)
df["Annotation"].replace(' $', '', regex=True, inplace=True)
df["Annotation"].replace('promoter-', '', regex=True, inplace=True)
df["Annotation"].replace('TTS', 'TES', regex=True, inplace=True)
df["Annotation"].unique()


# In[7]:


#delete useless character in df_input
df_input["Annotation"].replace('\(.*?\)', '', regex=True, inplace=True)
df_input["Annotation"].replace('\./d*', '', regex=True, inplace=True)
df_input["Annotation"].replace(' $', '', regex=True, inplace=True)
df_input["Annotation"].replace('promoter-', '', regex=True, inplace=True)
df_input["Annotation"].replace('TTS', 'TES', regex=True, inplace=True)
df_input["Annotation"].unique()


# In[8]:


vc1 = df['Annotation'].value_counts()
vc1


# In[9]:


vc2 = df['Annotation'].value_counts()
vc2


# In[10]:


dc = pd.DataFrame({'sample_peaks':df['Annotation'].value_counts(), 'input_peaks':df_input['Annotation'].value_counts()})
dc


# In[11]:


index = list(dc.index)
print(index)


# In[12]:


dc = dc.drop(index=['TES .2', 'TES .3','TSS .2','TSS .3','non-coding','non-coding .2','intron .2'])


# In[13]:


dc


# In[14]:


#enrichment = ratio of sample_peaks in the region / ratio of input_peals in the region
dc['sample_ratio'] = dc['sample_peaks'] / dc['sample_peaks'].sum()
dc['input_ratio'] = dc['input_peaks'] / dc['input_peaks'].sum()
dc['enrichment'] = dc['sample_ratio'] / dc['input_ratio']
dc


# In[15]:


#output of image data
label = dc.index
x = range(0,7)
plt.bar(x, dc['enrichment'], tick_label=label, width=0.5)
plt.rcParams["font.size"] = 8
plt.title("201117-NPM_rep1")
plt.ylabel("enrichment")
plt.xlabel("region name")
#plt.show()
plt.savefig("enrichment_201117-NPM_rep1.png", bbox_inches='tight')


# In[ ]:




