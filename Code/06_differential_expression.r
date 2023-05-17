if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pasilla")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("plyranges")
library(plyranges)



if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("rtracklayer")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("apeglm")
library(apeglm)
library(pasilla)
library(DESeq2)
library(dplyr)
library(ggplot2)
library(rtracklayer)

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("plyranges")
library(plyranges)



# Setting working directory and importing neccessary files to use
directory <- "C://Users//HP//Desktop//GENOME ANALYSIS//HTSEQ Files"
setwd(directory)
prokka_modified <- read.delim("C:/Users/HP/Desktop/GENOME ANALYSIS/HTSEQ Files/prokka_modified.txt", header=FALSE, comment.char="#")
HTSEQ.combined <- read.csv("C:/Users/HP/Desktop/GENOME ANALYSIS/HTSEQ Files/HTSEQ combined.csv")
# Importing the prokka gff file with the rtracklayer package so that it picks all the column headings
prokka_Annotation <- import("prokka.gff")


sampleFiles <- grep("ERR",list.files(directory),value=TRUE)
sampleNames <- c("ERR2036629",  "ERR2036630",  "ERR2036631",  "ERR2036632", "ERR2036633")
sampleCondition <- c("Continuous",  "Continuous",  "Bioleaching",  "Bioleaching", "Continuous")

sampleTable <- data.frame(sampleName = sampleNames,
                          fileName = sampleFiles,
                          condition = sampleCondition)

sampleTable$sampleName
sampleTable$fileName
sampleTable$condition <- factor(sampleTable$condition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)


##Filter data to remove counts lower than 10
#keep <- rowSums(counts(ddsHTSeq)) >=10
#ddsHTSeq <- ddsHTSeq[keep,]

ddsHTSeq$condition
summary(ddsHTSeq)
ddsHTSeq$condition <- relevel(ddsHTSeq$condition, ref = "Continuous")

dds <- DESeq(ddsHTSeq)
res <- results(dds)
res$log2FoldChange[1:10]
summary(res)
res$padj

# LFC means log2fold cahnge, on upward and downward regulation of the genes

#resultsNames(dds)
#resOrdered <- res[order(res$pvalue),]

summary(res)

 ?results
sum(res$padj < 0.1, na.rm=TRUE)

sum(res$padj < 0.1 & abs(res$log2FoldChange)>2, na.rm=TRUE)

# Eploring and exporting result MAplots

plotMA(res,ylim=c(-3,3))

#resLFC <- lfcShrink(dds, coef="condition_Bioleaching_vs_Continuous", type="apeglm")
#resLFC

#plotMA(resLFC, ylim=c(-5,5))


## RESULTS PLOTS
# Transform count data using the variance stablilizing transform
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)

#PCA plot


plotPCA(vsd, intgroup=c("condition"))

pca

write.csv( as.data.frame(res), file="DESeq_results.csv" )

# plot volcano plot

# Reset par
par(mfrow=c(1,1))
# Make a basic volcano plot
with(res, plot(log2FoldChange, -log10(padj), pch=20, main=expression("Volcano plot: p"['value']), ylim=c(0,70),
               xlab=expression(log[2](FoldChange)), ylab=expression(-log[10](p['adj']))))
mtext("Continuous", side = 1, line=3, at=-6)
mtext("Bioleaching", side = 1, line=3, at=4)

# Add colored points: blue if padj<0.01, red if log2FC>1 and padj<0.05)
with(subset(res, padj<.01 ), points(log2FoldChange, -log10(padj), pch=20, col="blue"))
with(subset(res, padj<.01 & abs(log2FoldChange)>2), points(log2FoldChange, -log10(padj), pch=20, col="red"))

# Heat Map

# Matrix for heatmap

metaData=data.frame(id=c("ERR2036629",  "ERR2036630",  "ERR2036631",  "ERR2036632", "ERR2036633"), condition= c("Continuous",  "Continuous",  "Bioleaching",  "Bioleaching", "Continuous"))

dds1 <- DESeqDataSetFromMatrix(countData=HTSEQ.combined, 
                              colData=metaData, 
                              design=~condition, tidy=TRUE)

# arrange data according to padj values
# take top 10 and last 10 of the logfoldchange from the res deseq data and plot a heatmap on it

sum(res$padj < 0.05 & abs(res$log2FoldChange)>2, na.rm=TRUE)


# Subset the rows that meet the criteria
significant_genes <- res[res$padj < 0.1 & abs(res$log2FoldChange) > 2, ]

# View the resulting data frame
significant_genes

res_clean <- res[complete.cases(res[, c("padj", "log2FoldChange")]), ]
significant_genes <- res_clean[res_clean$padj < 0.05 & abs(res_clean$log2FoldChange) > 3.5, ]
tail(significant_genes)
new_row = rownames(significant_genes)
dds2 <- dds1[rownames(dds1) %in% new_row,]


library("pheatmap")
ntd <- normTransform(dds1)

select <- rownames(dds1) %in% new_row
df <- as.data.frame(colData(dds1)[,c("id","condition")])
pheatmap(assay(ntd)[select,], cluster_rows=TRUE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df)











