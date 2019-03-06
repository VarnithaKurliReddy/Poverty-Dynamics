  * ******************************************************************** *
   *                                                                      *
   *               Poverty Dynamics                                       *
   *               Cleaning and creating food expenditure variables       *
   *                                                                      *
   * ******************************************************************** *
   * ******************************************************************** *

       /*
       ** PURPOSE:      The pupose of the do-file is to use the raw non-food expenditure datset and clean it.  
       ** OUTLINE:      PART 0: use the original data.
                        PART 1: Generate variables
						PART 2: Save the cleaned file

						
						
						
						
                      

       ** IDS VAR:     vds_id     
       ** NOTES:

       ** WRITEN BY:    Varnitha Kurli

       ** Last date modified:  Feb 20 2019
       */

*******************************
*PART 0: use the original data and clean it
******************************** 
use "$RawData/non_food_expenditure.dta" ,clear

drop Item_category item_type item_unit year

 foreach var in qty_home_prod qty_pur qty_ot ot_code tot_val{
 
 replace `var'=0 if `var'==.
 }
 replace item_name=proper(item_name)
 
 replace item_name=subinstr(item_name," ","",.)
 
 replace vds_id=subinstr(vds_id,"TS","AP",.)
 
 *******************************
*PART 1: Generate variables
******************************** 
*Medical-Medical(Domestic&Hospital)
gen medical_expenditure=tot_val if item_name=="Medical(Domestic&Hospital)" 
*Taxes-
gen taxes_expenditure=tot_val if strpos(item_name, "Tax")



*Transport-Others(BicyclePurchase),	PaidForVisaAndDubaiTicket, Travel,Petrol,Diesel,Veh.Maint.&Repairs,Travel,Petrol,Veh.Maint,Travel.Petrol,Diesel,VehicleMaintenan,
gen transport_expenditure=tot_val if strpos(item_name, "Travel") | item_name=="PaidForVisaAndDubaiTicket" | item_name=="Others(BicyclePurchase)"

*Electricity
gen electricity_expenditure=tot_val if strpos(item_name, "Electricity") | item_name=="Ele.AndWaterCharges"


*Education
gen education_expenditure=tot_val if strpos(item_name, "Education")

*Fuel
 gen fuel_expenditure=tot_val if strpos(item_name, "Lpg") | item_name=="Others(Kerosene)" | item_name=="Others(LpgGasConnection)"
 
 gen fuel_home_produced=qty_home_prod if strpos(item_name, "Lpg") | item_name=="Others(Kerosene)" | item_name=="Others(LpgGasConnection)"
 
 gen fuel_purchased=qty_pur if strpos(item_name, "Lpg") | item_name=="Others(Kerosene)" | item_name=="Others(LpgGasConnection)"
 
 gen fuel_others=qty_ot if strpos(item_name, "Lpg") | item_name=="Others(Kerosene)" | item_name=="Others(LpgGasConnection)"
*PDS_kerosene
 gen PDS_kerosene_expenditure=tot_val if strpos(item_name, "Pds")

 *Alcohol 
 gen alcohol_expenditure=tot_val if strpos(item_name, "Alcohol") | strpos(item_name, "Toddy")
 gen alcohol_home_produced=qty_home_prod if strpos(item_name, "Alcohol") | strpos(item_name, "Toddy") 
 gen alcohol_purchased=qty_pur if strpos(item_name, "Alcohol") | strpos(item_name, "Toddy")
 gen alcohol_others=qty_ot if strpos(item_name, "Alcohol") | strpos(item_name, "Toddy")
 
 *Tobacco
 gen tobacco_expenditure=tot_val if strpos(item_name, "Cig") 
 gen tobacco_home_produced=qty_home_prod if strpos(item_name, "Cig")  
 gen tobacco_purchased=qty_pur if strpos(item_name, "Cig") 
 gen tobacco_others=qty_ot if strpos(item_name, "Cig") 

 *Milling
gen milling_expenditure=tot_val if strpos(item_name, "Milling") 
gen milling_home_produced=qty_home_prod if strpos(item_name, "Milling")  
gen milling_purchased=qty_pur if strpos(item_name, "Milling") 
gen milling_others=qty_ot if strpos(item_name, "Milling") 

 *Social Gatherings
gen social_expenditure=tot_val if strpos(item_name, "Bride")
replace social_expenditure=tot_val if strpos(item_name, "Festival")
replace social_expenditure=tot_val if strpos(item_name, "Fair")
replace social_expenditure=tot_val if strpos(item_name, "Pooja")
replace social_expenditure=tot_val if strpos(item_name, "Ceremonies")
replace social_expenditure=tot_val if strpos(item_name, "Crackers")
 
*Household Durables
gen household_durables=tot_val if strpos(item_name, "Cosmetics") | strpos(item_name, "Allout")| strpos(item_name, "Bangles")| strpos(item_name, "Battery") ///
                                 | strpos(item_name, "Cell")| strpos(item_name, "Bulb")|  strpos(item_name, "Clothes")|  strpos(item_name, "Coconut") ///
							     |strpos(item_name, "Colours")| strpos(item_name, "Durables")|  strpos(item_name, "Insence")|  strpos(item_name, "Mosquito") ///
							     |strpos(item_name, "Newspaper")| strpos(item_name, "Others")|  strpos(item_name, "Toys")

*Leisure activities
gen leisure_expenditure=tot_val if strpos(item_name, "Jatra") | strpos(item_name, "Tour") | strpos(item_name, "AmountSpentForDrama") | ///
                                strpos(item_name, "AmountSpentForGpElection") |  strpos(item_name, "AyyappaMala") |  strpos(item_name, "YatraExpenses") | ///
								 strpos(item_name, "Prasadam")  |  strpos(item_name, "YogaClassFees")  |  strpos(item_name, "Temple") |  strpos(item_name, "Entertainment")
 


foreach var in medical_expenditure taxes_expenditure electricity_expenditure education_expenditure fuel_expenditure PDS_kerosene_expenditure fuel_home_produced fuel_purchased fuel_others ///
               alcohol_expenditure alcohol_home_produced  alcohol_purchased alcohol_others tobacco_expenditure tobacco_home_produced tobacco_purchased tobacco_others ///
			   milling_expenditure  milling_home_produced milling_purchased milling_others social_expenditure household_durables leisure_expenditure ///
			   {
                replace `var'=0 if `var'==.
                }

*******************************
*PART 2: Save the cleaned file
******************************** 				
gen non_food_expenditure=tot_val

gen non_food_purchased=qty_pur


gen  non_food_home_produced=qty_home_prod 


gen non_food_others=qty_ot


drop  item_name qty_home_prod qty_pur qty_ot ot_code tot_val

gen temp=vds_id+string(survey_month)	


foreach var in medical_expenditure taxes_expenditure electricity_expenditure education_expenditure fuel_expenditure PDS_kerosene_expenditure fuel_home_produced fuel_purchased fuel_others ///
               alcohol_expenditure alcohol_home_produced  alcohol_purchased alcohol_others tobacco_expenditure tobacco_home_produced tobacco_purchased tobacco_others ///
			   milling_expenditure  milling_home_produced milling_purchased milling_others social_expenditure household_durables leisure_expenditure ///
			   non_food_expenditure non_food_purchased non_food_home_produced non_food_others ///
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
	gen year="20"+substr(vds_id,4,2)
	destring year,replace
    order hh_id vds_id survey_month year
    sort hh_id year survey_month
	bysort hh_id: gen time=_n
	order time hh_id vds_id survey_month year
	
 save   "$FinalData/cleaned_non_food_expenditure",replace				
