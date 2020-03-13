# txt_toolkit
Practical small tools to deal with txt files.

## 1.add_feature.pl
``` 
Usage:perl add_feature.pl -i input -c1 1,2,3   -p|-pattern  sample\*.replicate\*.txt  -c2 4,5 -c3 6,7,8  -title(optional) -s|-suffix(optional) .txt  -o output
-h|--help:    print manual;
-c1:    columns constituting a unique tag in input;
-p|-pattern:    the parameter is used to search files matching the pattern;
-c2:    columns constituting the tag in files matching the pattern;
-c3:    columns of features in files matching the patten,which need to be added to the input; 
-title:    if this parameter is true, a title will be added to the output;
-s|-suffix   suffix of files matching the pattern,this parameter only works when -title is setted; 
```
If you have many files in the same format,for example,gene expression values from different RNAseq samples:  
```
sample1.txt    sample2.txt    ...    samplek.txt  
geneA    a1    geneA    a2    ...    geneA    ak  
geneB    b1    geneB    b2    ...    geneB    bk  
...            ...            ...    ...
geneN    n1    geneN    n2    ...    geneN    nk   
``` 
And you want to organize them into one file,this tool will be helpful. You just need to create a gene list file or use any other files containing the gene names with or without a title as input.The -c1,-c2 option can accept comma separated parameters when a single column in your list or your files can not provide a uniq tag. 
