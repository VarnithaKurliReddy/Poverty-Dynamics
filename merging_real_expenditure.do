   ********************************************************************** * 
   *                                                                      *
   *           Poverty Dynamics                                           *
   *           Merging cleaned food and non food expenditure data files   *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the cleaned non food and food expenditure datasets and merge them   
       ** OUTLINE:      PART 0: use the original data and merge
                        PART 1: Account of Inflation and generate real expenditures
						PART 2: Merge with the base file
                        PART 3: Generate per capita food expenditure, per capita non_food_expenditure,  per capita expenditure
						
						
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  march 4, 2019
       */

*******************************
*PART 0: Use the cleaned datasets and merge them
******************************** 
use   "$FinalData/cleaned_food_expenditure",clear
merge 1:1 hh_id time using "$FinalData/cleaned_non_food_expenditure"
keep if _merge==3
drop _merge

 save   "$FinalData/all_expenditure",replace				

 *******************************
*PART 1: Account for CPI 
******************************** 
gen state=substr(vds_id,2,2)
gen  temp=state+string(year)+string(survey_month)
save   "$FinalData/all_expenditure",replace
merge m:1 temp using "$RawData/inflation"
keep if _merge==3
drop _merge state temp cpirl cpirl2012 cpirl2012base inflationfactor

foreach var of varlist milk_expenditure milk_home_produced milk_purchased milk_other_sources meat_seafood_expenditure ///
                       meat_seafood_home_produced meat_seafood_purchased meat_seafood_other_sources cereals_expenditure cereals_home_produced cereals_purchased ///
                       cereals_other_sources pulses_expenditure pulses_home_produced pulses_other_sources oil_expenditure oil_home_produced oil_purchased oil_other_sources ///
                       veg_fruits_expenditure veg_fruits_home_produced veg_fruits_purchased veg_fruits_other_sources others_expenditure others_home_produced others_purchased others_other_sources ///
                       PDS_rice_expenditure PDS_wheat_expenditure PDS_other_expenditure social_food_expenditure social_food_purchased social_food_home_produced social_food_others food_expenditure ///
                       food_purchased food_home_produced food_others transport_expenditure medical_expenditure taxes_expenditure electricity_expenditure education_expenditure fuel_expenditure PDS_kerosene_expenditure ///
                       fuel_home_produced fuel_purchased fuel_others alcohol_expenditure alcohol_home_produced alcohol_purchased alcohol_others tobacco_expenditure tobacco_home_produced tobacco_purchased tobacco_others milling_expenditure ///
                       milling_home_produced milling_purchased milling_others social_expenditure household_durables leisure_expenditure non_food_expenditure non_food_purchased non_food_home_produced non_food_others ///
					   {
					    replace `var'= `var'/cpirl2012basefactor
						}
						
drop cpirl2012basefactor						
save   "$FinalData/all_expenditure",replace		

 *******************************
*PART 2: Merge with the base file
******************************** 		
merge m:1 hh_id year using "$RawData/base"
keep if _merge==3
drop _merge
order time survey_month year hh_id HHID vds_id VDS_ID state state_code district district_code tehsil_name tehsil_code village_name ///
village_code land_area household_size number_female number_male number_dependents dependency_ratio humansex_ratio farmer_class
sort hh_id time 
drop district_code
save   "$FinalData/all_expenditure",replace	

 *******************************
*PART 3: Generate  per capita food expenditure,  per capita non_food_expenditure,  per capita expenditure
******************************** 	
gen per_capita_exp=(non_food_expenditure+food_expenditure)/household_size
gen per_capita_f_exp=food_expenditure/household_size
gen per_capita_nf_exp=non_food_expenditure/household_size
gen ratio_f_nf=per_capita_f_exp/per_capita_nf_exp
gen ratio_nf_f=per_capita_nf_exp/per_capita_f_exp
gen ratio_f_all=per_capita_f_exp/per_capita_exp
gen ratio_nf_all=per_capita_nf_exp/per_capita_exp
save   "$FinalData/all_expenditure",replace	
