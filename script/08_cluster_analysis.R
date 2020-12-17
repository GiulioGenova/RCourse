#' ---
#' title: "Cluster Analysis - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---


library(forcats)
library(dplyr)
library(tidyr)
library(ggplot2)
library(magrittr)
library(lubridate)
library(cluster)
library(dendextend)
library(factoextra)
library(ggpubr)

#' # Read data
df=read.csv("data/soil_data.csv")

df = select(df, landuse, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg, clay, sand)


#' # Preliminary analysis

fct_count(df$landuse,sort = T)
fct_count(df$texture,sort = T)

df = filter(df,#landuse == "Orchards",
            ! texture %in% c("Ls3","Slu","Lu","Sl4","Lt3"))

fct_count(df$texture,sort = T)


df_n <- df %>% group_by(landuse) %>% 
  summarise(n=n(),
            Cu_below_25 = sum(cu<=25),
            Cu_above_25 = sum(cu>25),
            Cu_above_50 = sum(cu>50),
            Cu_above_100 = sum(cu>100),
            Cu_above_200 = sum(cu>200),
            Cu_above_400 = sum(cu>400))

df_stats <- df %>% group_by(landuse) %>% 
  summarise_at(vars(cu,som,ph,p,k,clay,sand),
               list(
                 min = ~min(.,na.rm = T),
                 q1= ~quantile(.,na.rm = T)[2],
                 mean = ~mean(.,na.rm = T),
                 q3= ~quantile(.,na.rm = T)[4],
                 max  = ~max(.,na.rm = T)
               )
  )# %>% gather(key,value,-TipoColtura)


#' Filter for high values of copper
df_high_cu <- df %>% group_by(landuse) %>%
  filter(cu >= 200) 

df_high_cu %>% summarise(min=min(cu,na.rm = T),
                         q1=quantile(cu,na.rm = T)[2],
                         mean=mean(cu,na.rm = T),
                         q3=quantile(cu,na.rm = T)[4],
                         max=max(cu,na.rm = T),
                         n=n())



#' Some exploratory plots

df %>% 
  ggplot(aes(x=cu))+
  geom_density()+
  facet_wrap(~landuse,scales = "free")+
  theme_minimal()

df %>% 
  ggplot(aes(x=ph))+
  geom_density()+
  facet_wrap(~landuse,scales = "free")+
  theme_minimal()

df %>% 
  ggplot(aes(x=clay))+
  geom_density()+
  facet_wrap(~landuse,scales = "free")+
  theme_minimal()


#' # Cluster Analysis

df_orch = filter(df,landuse == "Orchards") %>%
  mutate(landuse = as.factor(landuse),texture = as.factor(texture))

asym=c(1,2)# 23 wich columns in the db will be treated as asymmetric binary

#' create a dissimilarity matrix
dist = daisy(df_orch , metric="gower",type=list(asym=asym))


#' run the hierarchical clustering function to get an object hclust
hc = hclust(dist,method = "complete")

# dist = daisy(df_orch,metric="euclidean",stand = T)
# hc = hclust(dist,method = "ward.D")

#' within sum of square to decide how many clusters to create

wss = fviz_nbclust(df_orch,diss = dist,FUNcluster = hcut,method = "wss")

wss

k=5 # number of clusters

#' cut dendogram based on how many clusters

dend<- hc %>% as.dendrogram %>%
  dendextend::set("branches_k_color", k=k) %>% 
  dendextend::set("branches_lwd", 1.2) %>%
  dendextend::set("labels",NULL)

#' and plot it
plot(dend)

#' wrtie dendrogram plot

png("output/dend_4_orchards.png", width=1000, height=600, res=120)
plot(dend,main = "4 Clusters orchards ")
dev.off()

#' add clusters to original dataframe

cluster = cutree(hc,k)
cluster = tibble::enframe(cluster,name=NULL,value="cluster")
df_orch_c = bind_cols(df_orch,cluster)

#' check how many samples per cluster

fct_count(factor(df_orch_c$cluster),sort = T)

#' # Plot
#' plot boxplots of clusters

box_clust_orch = df_orch_c %>%
  #gather(Var, value,-cluster,-landuse) %>%
  pivot_longer(!contains(c("landuse","cluster","texture")),
               names_to = "Var", values_to = "value") %>% 
  ggplot(aes(y = value, x = as.factor(cluster) ))+
  ggtitle("Boxplot of the main soil characteristics for each cluster. Orchards")+
  xlab("clusters")+ylab(NULL)+
  geom_boxplot()+
  facet_wrap(~Var,scales = "free")+#,nrow = 2,ncol = 5
  theme_classic()


box_clust_orch
