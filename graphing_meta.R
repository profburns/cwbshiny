#Putting matrix back together
humpty<-tibble(variables=unique(cwbcor$variables))%>%
  left_join(rhocwb) %>% replace_na(list(rho = 1))

rhomat<-matrix(humpty$rho, nrow=19, ncol=19, byrow=T)
colnames(rhomat)<-rownames(rhomat)<-c("ID1","ID2","ID3","ID4",
                                      "ID5","ID6","ID7","OD1",
                                      "OD2","OD3","OD4","OD5",
                                      "OD6","OD7","OD8","OD9",
                                      "OD10","OD11","OD12")


group <- factor(c(
  rep("I", 7),
  rep("O", 12)
))  

metagraph <- qgraph(rhomat, 
                    graph = "glasso", 
                    sampleSize = 7387,
                    groups=group,
                    layout = "spring",
                    labels = colnames(rhomat),
                    minimum=.01,
                    tuning = 0.5, # standard tuning parameter value
                    cut=.1, 
                    legend=F,
                    label.cex=1.2,
                    threshold=T,
                    theme = "colorblind")
centralityPlot(metagraph, include=c("Strength", "Closeness", "Betweenness", "ExpectedInfluence"))
