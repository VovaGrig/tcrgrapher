# tcrgrapher

R package for identifying condition associated T cell clones from a single 
repertoire.

## Installation

```R
install.packages('devtools')
library(devtools)
devtools::install_github("KseniaMIPT/tcrgrapher")
```

To calculate generation probability TCRgrapher can use OLGA or SONIA. 

For detailed information about OLGA please visit
https://github.com/statbiophys/OLGA.

OLGA can be installed using pip or pip3.

```python
pip install olga
```

For detailed information about SONIA please visit
https://github.com/statbiophys/SONIA

SONIA is a python 2.7/3.6 software. It is available on PyPI and can be 
downloaded and installed through pip:

```python
pip install sonia
```

## Quick start

```R
library(tcrgrapher)
library(data.table)
sample <- fread('sample.txt')
df <- pipeline_OLGA(sample)
```

## Details

```tcrgrapher``` is the main function that takes a table with CDR3 sequences as
an input. The table should have the following columns. Order of the columns are 
not  important but the following names are necessary.

* Read.count - Number of unique reads per CDR3 sequence
* cdr3nt - CDR3 nucleotide sequence
* cdr3aa - CDR3 aminoacid sequence
* bestVGene - TRBV segment
* bestJGene - TRBJ segment

Also, the table can contain additional columns that will be kept in the output 
table.

You can find default parameters and possible options bellow.

```R
tcrgrapher(df, Q_val = 6.27, cores = 1, thres_counts = 1, N_neighbors_thres = 1, 
          p_adjust_method = "BH", chain = 'mouseTRB', stats = 'OLGA')
```
* df - data.table
* Q - Selection factor. 1/Q sequences pass selection in the thymus. The 
default value for mice is 6.27. If a human model is taken and Q is not changed 
manually Q = 27 is used
* cores - number of used cores, 1 by default
* thres_counts - Only sequences with a number of counts above this threshold
are taken into account
* N_neighbors_thres - Only sequences with a number of neighbours above the 
threshold are used to calculate generation probability
* p_adjust_method - One of the method from p.adjust from stats package. 
Possible options: "bonferroni", "holm", "hochberg", "hommel", "BH" or "fdr",
"BY", "none". "BH" is a default method.
* chain - Statistical model selection. Possible options: "mouseTRB", "humanTRB",
"humanTRA".
* stats - Tool that will be used for generation probability calculation.
Possible options: "OLGA", "SONIA". "SONIA" also calculate Q for every sequence.

Function returns the same table that was in input filtered by number
of counts and number of neighbours with additional columns. Additional columns
are the following
* D - Number of neighbors in clonoset. Neighbor is a similar sequence
with one mismatch
* VJ_n_total - Number of unique sequences with given VJ combination
* Pgen - Probability to be generated computed by OLGA
* Pgen_sum_corr - Sum of Pgen of all sequences similar to the given with one 
mismatch
* Pgen_by_VJ - Conditional probability. Sum of probabilities to be generated 
with given VJ combination
* p_val - p value under null hypothesis that number of sequence's
neighbors is not more than in the random model
* p_adjust - p value with multiple testing correction
