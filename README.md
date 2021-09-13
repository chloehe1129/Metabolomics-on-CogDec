# Blood metabolites predicting Mild Cognitive Impairment in the Study of Latinos-Investigation of Neurocognitive Aging

Shan He, Einat Granot-Hershkovitz, Ying Zhang, Jan Bressler, Wassim Tarraf, Bing Yu, Donglin Zeng, Sylvia Wassertheil-Smoller, Melissa Lamar, Martha Daviglus, Maria J Marquine, Jianwen Cai, Thomas Mosley, Robert Kaplan, Eric Boerwinkle, Myriam Fornage, Charles DeCarli, Bruce Kristal, Hector M Gonzalez, Tamar Sofer

### INTRODUCTION: 
We studied metabolomics-based biomarkers predicting cognitive decline and mild cognitive impairment (MCI) in U.S Hispanic/Latino population.

### METHODS: 
We tested the association between 707 blood metabolites measured in 1,451 participants from the Hispanic Community Health Study/Study of Latinos (HCHS/SOL), with MCI and global cognitive change assessed seven years later. We further used Lasso penalized regression to construct a metabolomics risk score (MRS) that predicts MCI, potentially identifying a different set of metabolites than those discovered in individual-metabolite analysis.  

### RESULTS: 
We identified 20 metabolites associated with prevalent MCI and/or global cognitive change. Six of them were novel and 14 were previously reported as associated with neurocognitive aging outcomes. The MCI MRS comprised 61 metabolites and improved prediction accuracy from 84% (minimally adjusted model) to 89% in the entire dataset and from 75% to 87% among APOE-ε4 carriers.

### What to expect in this repository：
(1) Code for constructing metabolite risk score (MRS)<br/>
(2) Metabolites weights useful for replicating MRS in other studies<br/>
(3) Summary statistics for single-metabolite association results organized by neurocognitive phenotypes and the different model adjustment <br/>

### Explanation for single-metabolite association files
(1) metabolite: the name of the metabolite measured in blood plasma, provided by Metabolon <br/>
(2) beta: the coefficient estimate resulted from survey regression analysis. This coefficient should be interpreted as the effect magnitude of the specific metabolites concentration on the outcome. (If the outcome is binary, then the magnitude is the multiplicative effect on Odds Ratio) <br/>
(3) se: the standard error of the coefficient estimate <br/>
(4) p_val: the raw p-value of the estimated effect. <br/> 
(5) metabolite_model: whether the metabolite was treated as a continuous variables or dichotomized into a binary variable, indicating whether the metabolite was observed or not in an individuals. The metabolite was treated as continuous outcome when over 75% of the sample have measurement and dichotomized when 25%-75% of the sample have measurement. <br/> 

We provide complete results produced by our association analysis pipelines, including ones that we did not consider in the manuscript, corresponding to un-identified metabolites. These are consistently annotated by Metabolon and may become useful in the future. We also provide results based on three nested regression models, and corresponding to all individuals and stratified by APOE-e4 carrier status.



