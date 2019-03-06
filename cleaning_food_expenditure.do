   * ******************************************************************** *
   *                                                                      *
   *               Poverty Dynamics                                       *
   *               Cleaning and creating food expenditure variables       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the raw food expenditure datset and clean it.  
       ** OUTLINE:      PART 0: use the original data.
                        PART 1: Generate variables
						PART 2: Save the cleaned file

						
						
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  Feb 19 2019
       */

*******************************
*PART 0: use the original data and clean it
******************************** 
use "$RawData/food_expenditure.dta" ,clear

drop No_per_con num_item_type

 foreach var in qty_home_prod qty_pur qty_ot ot_code tot_val price_unit{
 
 replace `var'=0 if `var'==.
 }
 replace item_name=proper(item_name)
 
 replace item_name=subinstr(item_name," ","",.)
 
 replace vds_id=subinstr(vds_id,"TS","AP",.)
 
 *******************************
*PART 1: Generate variables
******************************** 


*Milk expenditure variables
*Generate variables like 
*milk_expenditure
*milk_home_produced
*milk_purchased
*milk_other_sources


gen milk_expenditure=tot_val if item_type=="Milk & Milk Prod"

gen milk_home_produced=qty_home_prod if item_type=="Milk & Milk Prod" & price_unit==0
replace milk_home_produced=qty_home_prod*price_unit if item_type=="Milk & Milk Prod" & price_unit!=0

gen milk_purchased=qty_pur if item_type=="Milk & Milk Prod" & price_unit==0
replace milk_purchased=qty_pur*price_unit if item_type=="Milk & Milk Prod" & price_unit!=0
 
gen milk_other_sources=qty_ot if item_type=="Milk & Milk Prod" & price_unit==0
replace milk_other_sources=qty_ot*price_unit if item_type=="Milk & Milk Prod" & price_unit!=0

foreach var in milk_expenditure milk_home_produced milk_purchased milk_other_sources {
replace `var'=0 if `var'==.
}

*meat_sea_food
gen meat_seafood_expenditure=tot_val if item_type=="Meat,Egg and fish" | item_type=="Seafood"

gen meat_seafood_home_produced=qty_home_prod*price_unit if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit!=0
replace meat_seafood_home_produced=qty_home_prod if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit==0

gen meat_seafood_purchased=qty_pur*price_unit if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit!=0
replace meat_seafood_purchased=qty_pur if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit==0

gen meat_seafood_other_sources=qty_ot*price_unit if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit!=0
replace meat_seafood_other_sources=qty_ot if item_type=="Meat,Egg and fish" | item_type=="Seafood" & price_unit==0

foreach var in meat_seafood_expenditure meat_seafood_home_produced meat_seafood_purchased meat_seafood_other_sources {
replace `var'=0 if `var'==.
}

*Cereals

gen cereals_expenditure=tot_val if item_type=="Cereals" & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )

gen cereals_home_produced=qty_home_prod*price_unit if item_type=="Cereals" & price_unit!=0  & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )
replace cereals_home_produced=qty_home_prod if item_type=="Cereals" & price_unit==0  & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )

gen cereals_purchased=qty_pur*price_unit if item_type=="Cereals" & price_unit!=0 & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )
replace cereals_purchased=qty_pur if item_type=="Cereals" & price_unit==0  & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )
 
gen cereals_other_sources=qty_ot*price_unit if item_type=="Cereals" & price_unit!=0 & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )
replace cereals_other_sources=qty_ot if item_type=="Cereals" & price_unit==0  & ( item_name!="PdsMaize" | item_name!="PdsRice" | item_name!="PdsWheat" )

foreach var in cereals_expenditure cereals_home_produced cereals_purchased cereals_other_sources {
replace `var'=0 if `var'==.
}

*Pulses
gen pulses_expenditure=tot_val if item_type=="Pulses" 

gen pulses_home_produced=qty_home_prod*price_unit if item_type=="Pulses" & price_unit!=0
replace pulses_home_produced=qty_home_prod if item_type=="Pulses" & price_unit==0

gen pulses_purchased=qty_pur*price_unit if item_type=="Pulses"  & price_unit!=0
replace pulses_purchased=qty_pur if item_type=="Pulses" & price_unit==0
 
gen pulses_other_sources=qty_ot*price_unit if item_type=="Pulses" & price_unit!=0
replace pulses_other_sources=qty_ot if item_type=="Pulses" & price_unit==0

foreach var in pulses_expenditure pulses_home_produced pulses_purchased pulses_other_sources {
replace `var'=0 if `var'==.
}


*Oil
gen oil_expenditure=tot_val if item_type=="oil" & ( item_name!="PdsOil")

gen oil_home_produced=qty_home_prod*price_unit if item_type=="oil" & price_unit!=0 & ( item_name!="PdsOil")
replace oil_home_produced=qty_home_prod if item_type=="oil" & price_unit==0 & ( item_name!="PdsOil")


gen oil_purchased=qty_pur*price_unit if item_type=="oil"  & price_unit!=0 & ( item_name!="PdsOil")
replace oil_purchased=qty_pur if item_type=="oil"  & price_unit==0 & ( item_name!="PdsOil")
 
gen oil_other_sources=qty_ot*price_unit if item_type=="oil" & price_unit!=0 & ( item_name!="PdsOil")
replace oil_other_sources=qty_ot if item_type=="oil"  & price_unit==0 & ( item_name!="PdsOil")

foreach var in oil_expenditure oil_home_produced oil_purchased oil_other_sources {
replace `var'=0 if `var'==.
}

*Vegetables & Fruits

gen veg_fruits_expenditure=tot_val if item_type=="Fruits&Vegetables" | item_type=="Dry fruits"

gen veg_fruits_home_produced=qty_home_prod*price_unit if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit!=0 
replace veg_fruits_home_produced=qty_home_prod if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit==0 

gen veg_fruits_purchased=qty_pur*price_unit if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit!=0 
replace veg_fruits_purchased=qty_pur if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit==0 
 
gen veg_fruits_other_sources=qty_ot*price_unit if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit!=0 
replace veg_fruits_other_sources=qty_ot if item_type=="Fruits&Vegetables" | item_type=="Dry fruits" & price_unit==0 

foreach var in veg_fruits_expenditure veg_fruits_home_produced veg_fruits_purchased veg_fruits_other_sources {
replace `var'=0 if `var'==.
}
* Beverages & Others

gen others_expenditure=tot_val if item_type=="Others" | item_type=="Beverages" & (item_name=="PdsSalt" | item_name=="PdsSugar")

gen others_home_produced=qty_home_prod*price_unit if item_type=="Others" | item_type=="Beverages" & price_unit!=0  & (item_name=="PdsSalt" | item_name=="PdsSugar")
replace others_home_produced=qty_home_prod if item_type=="Others" | item_type=="Beverages" & price_unit==0  & (item_name=="PdsSalt" | item_name=="PdsSugar")

gen others_purchased=qty_pur*price_unit if item_type=="Others" | item_type=="Beverages" & price_unit!=0 & (item_name=="PdsSalt" | item_name=="PdsSugar")
replace others_purchased=qty_pur if item_type=="Others" | item_type=="Beverages" & price_unit==0  & (item_name=="PdsSalt" | item_name=="PdsSugar")
 
gen others_other_sources=qty_ot*price_unit if item_type=="Others" | item_type=="Beverages" & price_unit!=0 & (item_name=="PdsSalt" | item_name=="PdsSugar")
replace others_other_sources=qty_ot if item_type=="Others" | item_type=="Beverages" & price_unit==0  & (item_name=="PdsSalt" | item_name=="PdsSugar")

foreach var in others_expenditure others_home_produced others_purchased others_other_sources {
replace `var'=0 if `var'==.
}


*PDS_rice, PDS_wheat,Pds_others

gen PDS_rice_expenditure=tot_val if item_name=="PdsRice" 

gen PDS_wheat_expenditure=tot_val if item_name=="PdsWheat"

gen PDS_other_expenditure=tot_val if item_name=="PdsOil" | item_name=="PdsSalt" | item_name=="PdsSugar" 

foreach var in PDS_rice_expenditure PDS_wheat_expenditure PDS_other_expenditure{
replace `var'=0 if `var'==.
}

* Food expenditure on social gatherings

gen social_food_expenditure =tot_val if strpos(item_name, "Soc.Meal")

gen social_food_purchased=qty_pur*price_unit if strpos(item_name, "Soc.Meal") & price_unit!=0
replace social_food_purchased=qty_pur if strpos(item_name, "Soc.Meal") & price_unit==0

gen social_food_home_produced=qty_home_prod*price_unit if  strpos(item_name, "Soc.Meal") & price_unit!=0
replace social_food_home_produced=qty_home_prod if  strpos(item_name, "Soc.Meal") & price_unit==0

gen social_food_others=qty_ot*price_unit if  strpos(item_name, "Soc.Meal") & price_unit!=0
replace social_food_others=qty_ot if  strpos(item_name, "Soc.Meal") & price_unit==0

foreach var in social_food_expenditure social_food_purchased  social_food_home_produced  social_food_others {
replace `var'=0 if `var'==.
}
*******************************
*PART 2: Save the cleaned file
******************************** 
gen food_expenditure=tot_val

gen food_purchased=qty_pur*price_unit if price_unit!=0
replace food_purchased=qty_pur if price_unit==0

gen  food_home_produced=qty_home_prod if price_unit==0
replace food_home_produced=qty_home_prod*price_unit if price_unit!=0

gen food_others=qty_ot*price_unit if price_unit!=0
replace food_others=qty_ot if price_unit==0

drop Item_category item_type item_name item_unit qty_home_prod qty_pur qty_ot ot_code price_unit tot_val

gen temp=vds_id+string(survey_month)

foreach var in milk_expenditure milk_home_produced milk_purchased milk_other_sources meat_seafood_expenditure meat_seafood_home_produced meat_seafood_purchased meat_seafood_other_sources /// 
               cereals_expenditure cereals_home_produced cereals_purchased cereals_other_sources pulses_expenditure pulses_home_produced pulses_purchased pulses_other_sources oil_expenditure oil_home_produced oil_purchased oil_other_sources ///
               veg_fruits_expenditure veg_fruits_home_produced veg_fruits_purchased veg_fruits_other_sources others_expenditure others_home_produced others_purchased others_other_sources ///
               PDS_rice_expenditure PDS_wheat_expenditure PDS_other_expenditure social_food_expenditure social_food_purchased social_food_home_produced social_food_others food_expenditure ///
			   food_purchased food_home_produced food_others ///
               {
			    bysort temp:egen n_`var'=sum(`var')
				bysort  temp:egen t_`var'=max(n_`var')
				drop `var'
				drop n_`var'
				rename t_`var' `var'
			
				}
				
	duplicates drop temp,force
	drop temp
	gen hh_id=substr(vds_id,1,3)+substr(vds_id,6,5)
    order hh_id vds_id survey_month year
    sort hh_id year survey_month
	bysort hh_id: gen time=_n
	order time hh_id vds_id survey_month year
	
	
 save   "$FinalData/cleaned_food_expenditure",replace
