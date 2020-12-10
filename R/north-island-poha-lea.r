###CLEAR BUFFERS
rm(list=ls())
###SET DIRECTORY
setwd("C:/Users/vaufe36p/Documents/R/otago-rdata")

###LOAD LIBRARIES
library(LEA)

###INPUT FILE AND CONVERSION
#LEA uses the lfmm and geno formats, and provides functions to convert from other formats (ped, vcf, ancestrymap)

##Conversion of a STACKS structure file to the lfmm and geno formats
#Manually need to add 'ID' and 'Pop' column labels to structure file
#Manually need to change file extension from structure.tsv to .str?
#FORMAT 2 = two rows per individual
#help(struct2geno)
struct2geno("main-filtered.str", ploidy = 2, FORMAT = 2, extra.row = 1, extra.column = 2) #CHANGE INPUT FILE AS NECESSARY


##Principal Component Analysis
#Run of pca
#Available options, K (the number of PCs),
#                  center and scale.
#Create files: genotypes.eigenvalues - eigenvalues,
#               genotypes.eigenvectors - eigenvectors,
#               genotypes.sdev - standard deviations,
#               genotypes.projections - projections,
#Create a pcaProject object: pc.
pc = pca("main-filtered.str.lfmm", scale = TRUE)
#help(pca)

##DETERMINE NUMBER OF PCs to use
#Plot eigenvalues
plot(pc, lwd=2, col="blue", cex = .7, xlab=("Principal components"), ylab="Eigenvalues")

#Plot PC standard deviations
plot(pc$sdev, lwd=2, col="red", cex = .7, xlab=("Principal components"), ylab="Eigenvalues")

#Perfom Tracy-Widom tests on all eigenvalues.
#create file: tuto.tracyWidom - tracy-widom test information.
#ERROR: LINE 165 DID NOT HAVE 6 ELEMENTS?
tw = tracy.widom(pc)
#help(tracy.widom)

#display p-values for the Tracy-Widom tests (first 5 pcs).
tw$pvalues[1:5]

#plot the percentage of variance explained by each component
plot(tw$percentage)

##PCA ORDINATION PLOTS
#par(mfrow=c(2,2))  #plot PCs in grid
#PCs 1 and 2
plot(pc$projections[,1:2], col="red", pch=1, lwd=1, cex=1,  xlab=("Principal component 1"), ylab="Principal component 2")
#PCs 3 and 4
plot(pc$projections[,3:4], col="red", pch=1, lwd=1, cex=1,  xlab=("Principal component 3"), ylab="Principal component 4")

#PCs 1 and 3
plot(pc$projections[,1:3], col="red", pch=1, lwd=1, cex=1,  xlab=("Principal component 1"), ylab="Principal component 3")
#PCs 2 and 3
plot(pc$projections[,2:3], col="red", pch=1, lwd=1, cex=1,  xlab=("Principal component 2"), ylab="Principal component 3")


##LEA ADMIXTURE ANALYSIS
##Inference of individual admixture coeficients using snmf
#main options
#K = number of ancestral populations
#entropy = TRUE: computes the cross-entropy criterion,
#CPU = 4 the number of CPUs.'
#CHANGE INPUT FILE AS NECESSARY
project = NULL
project = snmf("main-filtered.str.geno",
               K = 1:10,
               entropy = TRUE,
               repetitions = 10,
               project = "new",
               CPU = 4)

#plot cross-entropy criterion for all runs in the snmf project
#lowest value = best supported model
plot(project, col = "blue", pch = 19, cex = 1.2)

#COLOURS FOR SUPPLEMENT
par(mfrow=c(4,1))  #plot PCs in grid
#select the best run for K = 4
best = which.min(cross.entropy(project, K = 10))
my.colors <- c("blue1", "red1",
               "goldenrod1", "cyan", "magenta",
               "green1", "deepskyblue","yellow", "green4", "black")
barchart(project, K = 10, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)


#COLOURS FOR MAIN TEXT FIGURE 2 K = 10
#select the best run for K = 4
par(mfrow=c(4,1))  #plot PCs in grid
best = which.min(cross.entropy(project, K = 10))
my.colors <- c("blue1","gold1","red1","green4","orange","deepskyblue","lightpink","turquoise3","darkgray","lightgreen")
barchart(project, K = 10, run = best, sort.by.Q = FALSE,
         border = NA, space = 0,
         col = my.colors,
         xlab = "Individuals",
         ylab = "Ancestry proportions",
         main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order),
     labels = bp$order, las=1,
     cex.axis = .4)