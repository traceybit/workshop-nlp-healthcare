## ----plot-tfidf---------------------------------------------------------------------------------------------------------
# first, convert the TF-IDF to a dense matrix
tfmat <- as.matrix(tfidf_dtm)

# identify the first term and plot its histogram
hist(tfmat[, 1], main = paste0("uses of '", colnames(tfmat)[[1]], "'"))

# identify the second term and plot its histgram
hist(tfmat[ , 2], main = paste0("uses of '", colnames(tfmat)[[2]], "'"))

# plot the first two columns 
plot(tfmat[, 1:2], main = "joint uses of adverse and absolute")

## ----pca-calc-----------------------------------------------------------------------------------------------------------
## principle components analysis
# rotate the TF-IDF so the columns are articles
articles <- t(tfmat)

# calculate PCA on the rotated TF-IDF
pca <- prcomp(articles, center = TRUE, scale = TRUE)

# extract the matrix of rotations
pcmat <- as.data.frame(pca$rotation)


## -----------------------------------------------------------------------------------------------------------------------
# plot the first two principal components
with(pcmat, plot(PC1, PC2))


## -----------------------------------------------------------------------------------------------------------------------
# identify the order of documents along the first principal component
indx <- order(pcmat$PC1)

# view the titles at the extremes of the first principal component
data$title[head(indx)]
data$title[tail(indx)]

## ----second-pc----------------------------------------------------------------------------------------------------------
# identify the order of documents along the second principal component
indx <- order(pcmat$PC2)

# observe which papers are at the extremes of the second PC
data$title[ head(indx)]
data$title[ tail(indx)]

## ----third-pc-----------------------------------------------------------------------------------------------------------
# identify the order of documents along the third principal component
indx <- order(pcmat$PC3)

# observe which papers are at the extremes of the second PC
data$title[head(indx)]
data$title[tail(indx)]

## -----------------------------------------------------------------------------------------------------------------------
# source the function for identifying top terms in documents from github
source(url("https://ucdavisdatalab.github.io/workshop-nlp-healthcare/top_terms.R"))

# cbind data and the PCA rotation
plotdata <- cbind(data, pcmat)

# identify top terms for each document and attach them to the plotdata
plotdata$top_terms <- top_terms(tfidf_dtm)

# visualize the top principal components in terms of top terms
ggplot(plotdata) + aes(x=PC1, y = PC2, label = top_terms) + geom_text(check_overlap = T) 
ggplot(plotdata) + aes(x=PC2, y = PC3, label = top_terms) + geom_text(check_overlap = T) 

## plot the explained variance-----------------------------------------------------------------------------------------------------------------------


