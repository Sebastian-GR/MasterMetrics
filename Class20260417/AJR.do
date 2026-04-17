use "C:\Users\sjgom\Documents\MasterMetrics\Class20260417/ajr-aer", clear

* Data
keep if baseco == 1
describe
summ  /*Table 1*/
scatter logpgp95 avexpr , mlabel(shortnam) msymbol(none)

* Table 2
*Col 2
reg logpgp95 avexpr 
*Col 5
reg logpgp95 avexpr lat_abst  
sum avexpr

* Table 3
*Col 9
reg avexpr logem4  
*Col 10
reg avexpr logem4 lat_abst 
test logem4

* Table 4
*Col 1: panel a y b
ivregress 2sls logpgp95 (avexpr = logem4 ), first /*first reports 1st stage reg*/
*Col 2: panel a y b
ivregress 2sls logpgp95 lat_abst (avexpr = logem4) , first 


* Compare results
ivregress 2sls logpgp95 lat_abst (avexpr = logem4) 
estimates store sstage
reg avexpr lat_abst logem4 
estimates store fstage
reg logpgp95 lat_abst avexpr  
estimates store ols

estimates table sstage ols fstage, se(%7.2f) stats(N r2) b(%7.2f) 
estimates table sstage ols fstage, stats(N r2) b(%7.2f) star