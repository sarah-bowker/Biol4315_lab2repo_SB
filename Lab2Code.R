#Load the package
library(Rqc)
#Get the path to the file
folder <- system.file(package="ShortRead", "extdata/E-MTAB-1147")

# feeds fastq.qz files in "folder" to quality check function
qcRes <- rqc(path = folder, pattern = ".fastq.gz", openBrowser=FALSE)
rqcCycleQualityBoxPlot(qcRes)
rqcCycleBaseCallsLinePlot(qcRes)
rqcReadFrequencyPlot(qcRes)

library(fastqcr)

# Aggregating Multiple FastQC Reports into a Data Frame 

# Demo QC directory containing zipped FASTQC reports
qc.dir <- system.file("fastqc_results", package = "fastqcr")
qc <- qc_aggregate(qc.dir)
qc

# Inspecting QC Problems


# See which modules failed in the most samples
qc_fails(qc, "module")
# Or, see which samples failed the most
qc_fails(qc, "sample")

# Building Multi QC Reports
qc_report(qc.dir, result.file = "multi-qc-report" )

# Building One-Sample QC Reports (+ Interpretation)
qc.file <- system.file("fastqc_results", "S1_fastqc.zip", package = "fastqcr")

# view the report rendered by R functions
qc_report(qc.file, result.file = "one-sample-report",
          interpret = TRUE)


library(ShortRead)

# Read the FASTQ file
fq <- readFastq("ERR11203340_1.fastq.gz")

# Trim from 3' end where quality ASCII < "5" (Q20)
fq_trimmed <- trimTailw(fq, k = 2, a = "5", halfwidth = 2)

# Save the trimmed reads
writeFastq(fq_trimmed, "ERR11203340_1_trimmed.fastq.gz", compress = TRUE)

# Run QC on trimmed reads
qc_trimmed <- rqc(path = ".", pattern = "ERR11203340_1_trimmed.fastq.gz", openBrowser = FALSE)

# Plot per-base quality after trimming
rqcCycleQualityBoxPlot(qc_trimmed)


