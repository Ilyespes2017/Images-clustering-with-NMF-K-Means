##### Libraries
require(R.matlab);library(Rcmdr);library(FactoMineR);library(rlang);library(NMF);library(cluster);library(factoextra);library(NbClust);library(NMI);library("MixGHD");library(fpc);library(NbClust)

setwd("C:/Users/utilisateur/Desktop/S2/TER")   ## Chemain par d??faut
data_x=readMat("data_x.mat",header = FALSE)  ## Lecture de notre 
data_y=readMat("data_y.mat",header = FALSE)
finalData=data_x$data.set                          ## R??cuperation de la matrice
etiquette=data_y$traget          ## R??cuperation de la dernierre colonne (??tiquette)
                                          
options(max.print=5000)                        ## Nombre d'affichage

## Cr??ation d'un vecteur d'indices de 1 ?? 2000
v=0
for(i in 1:length(etiquette)){
  v[i] = i;
}
data_etiquette = data.frame(v,etiquette)      ## 1ere colonne pour l'indice, 2eme pour la classe 
#############Partie 1 --------Kmeans--------- ################

####### Boucle pour voir le meilleur k en fonction de crit??re du coude (avec Tot.withinss)
tot.withinss = 0
inertie.expl <- data.frame(cluster = seq(from = 1, to = 9, by = 1))
for (k in 2:9) {
  kmeans <- kmeans(finalData, centers = k, nstart = 2)
  tot.withinss[k] <- kmeans$tot.withinss
}
plot(tot.withinss)


###### Plot Coude & silohette 
fviz_nbclust(t(finalData), kmeans, method = "wss",k.max = 25)
fviz_nbclust(t(finalData), kmeans, method = "silhouette")
fviz_nbclust(tot.withinss, kmeans, method = "silhouette")

#####Kmeans
kmeans2=kmeans(finalData,centers=2, nstart = 2);
k2classification=kmeans2$cluster
dataKmeans2=data.frame(v,k2classification)
nmi2= NMI(data_etiquette,dataKmeans2)
ari2= ARI(etiquette,k2classification)

kmeans3=kmeans(finalData,centers=3, nstart = 2)
k3classification=kmeans3$cluster
dataKmeans3=data.frame(v,k3classification)
nmi3= NMI(data_etiquette,dataKmeans3)
ari3= ARI(etiquette,k3classification)

kmeans4=kmeans(finalData,centers=4, nstart = 2)
k4classification=kmeans4$cluster
dataKmeans4=data.frame(v,k4classification)
nmi4 = NMI(data_etiquette,dataKmeans4)
ari4= ARI(etiquette,k4classification)

kmeans5=kmeans(finalData,centers=5, nstart = 2)
k5classification=kmeans5$cluster
dataKmeans5=data.frame(v,k5classification)
nmi5 = NMI(data_etiquette,dataKmeans5)
ari5= ARI(etiquette,k5classification)

kmeans7=kmeans(finalData,centers=7, nstart = 2)
k7classification=kmeans7$cluster
dataKmeans7=data.frame(v,k7classification)
nmi7 = NMI(data_etiquette,dataKmeans7)
ari7= ARI(etiquette,k7classification)

####PLOT  NMI/ARI (Entre les k-means)
NMI=c(nmi2,nmi3,nmi4,nmi5,nmi7)
ARI=c(ari2,ari3,ari4,ari5,ari7)
plot(NMI,ARI,col=rainbow(5),pch=19)
legend("bottomleft", inset=.03,
       c("k-means k=2","k-means k=3","k-means k=4","k-means k=5","k-means k=7"), fill=rainbow(5), horiz=TRUE, cex=0.8)


###Plot pour k=5
plotcluster(finalData, kmeans1$cluster) 
########################## 



################# PCA ##################

pca=PCA(finalData)
fviz_pca_var(pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # ??vite le chevauchement de texte
)





#############Partie 2 --------NMF--------- ################
nmf2=nmf(finalData,2)
nmf5=nmf(finalData,5)
nmf7=nmf(finalData,7)


## Creation du vecteur de classification
W5=nmf5@fit@W     ### R??cuperation de la matrice W 
H5=nmf5@fit@H
W2=nmf2@fit@W
W7=nmf7@fit@W

### Reconstruction Matrice de NMF avec rang 5
matriceReconstruite=W5%*%H5

#### Boucle pour creer notre vecteur de classification d??duit de la matrice W de la NMF

######### Les deux boucles pour trouver le top 10 #########
f=0;index1=0
for(i in 1:2000){
  index1=max(W5[i,])
  f[i]=index1
}
f=sort(f,decreasing = TRUE)
index=0;u=0;j=0
indice=0
for (i in 1:10) {
  for(j in 1:2000){
    if(f[i]==max(W5[j,])){
      index=j
    }
   
  }
  indice[i]=index
}
##################


nmf_classification2=u;
nmf_classification5=u;
nmf_classification7=u;


#############Partie 3 --------NMI & ARI--------- ################



data_etiquette = data.frame(v,etiquette)          ## 1ere colonne pour l'indice, 2eme pour la classe


dataKmeans2=data.frame(v,k2classification)
dataKmeans5=data.frame(v,k5classification)
dataKmeans7=data.frame(v,k7classification)

data_nmf2 = data.frame(v,nmf_classification2)
data_nmf5 = data.frame(v,nmf_classification5)
data_nmf7= data.frame(v,nmf_classification7)

nmi2= NMI(data_nmf2,dataKmeans2)
nmi5= NMI(data_nmf5,dataKmeans5)
nmi7= NMI(data_nmf7,dataKmeans7)
  
ari2= ARI(nmf_classification2,k2classification)
ari5= ARI(nmf_classification5,k5classification)
ari7= ARI(nmf_classification7,k7classification)

nmiFinal=c(nmi2, nmi5, nmi7)
ariFinal=c(ari2, ari5, ari7)

plot(nmiFinal,ariFinal,col=rainbow(3),pch=19)
legend("bottomleft", inset=.03,
       c("k-means/nmf k=2","k-means/nmf k=5","k-means/nmf k=7"), fill=rainbow(3), horiz=TRUE, cex=0.8)




