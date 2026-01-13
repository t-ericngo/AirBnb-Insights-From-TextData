cd "\\Client\C$\Users\anhtu\OneDrive\[Eric Ngo_UIowa]\3rd Year\Spring 2024\BAIS 6100 Text Analytics\Project"

use BK_regdata, clear

*destring price, generate(price_num) ignore(",") force
*drop price 

*gen host_exp_month2 = host_exp_month*host_exp_month

*save BK_regdata.dta, replace


set level 90
reg3 (review_scores_rating host_about_exists host_about_vader2 host_exp_month  host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e host_response_time_withinafewhou neighborhood_overview_exists neighborhood_overview_vader2 price_num accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews) ///
 (comments_vader host_about_exists host_about_vader2 host_exp_month  host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e host_response_time_withinafewhou neighborhood_overview_exists neighborhood_overview_vader2 price_num accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews), sure

estimates store sur_BK
 
*** Table
esttab sur_BK using group02_table1.rtf, cells(b(fmt(3) star) se(par fmt(3))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N ll r2_1 r2_2) ///
 mtitles("M1-SUR for BK") ///
 coeflabels(host_about_exists "Host Info Available" host_about_vader2 "Host Info Sentiment" host_exp_month "Host Exp" host_exp_month2 "Host Exp^2" host_is_superhost_t "Super Host" host_total_listings_count "Host's Total Listings"  calculated_host_listings_count_e "Host's Total Houses"  host_response_time_withinafewhou "Host Responds in Few Hrs" description_exists "Listing Info Available" neighborhood_overview_exists "Neighborhood Desc Available" neighborhood_overview_vader2 "Neighborhood Desc Sentiment" price_num "Price" num_amenities "No. of Amenities" accommodates "Occupancy" bathrooms "No. of Baths" availability_30 "Availability Last Month" room_type_entirehomeapt "Room Type_Entire House" room_type_privateroom "Room Type_Private Room" number_of_reviews "No. of Reviews" _cons "Constant") ///
 title("Table 1. Seemingly Unrelated Regression on Airbnb Ratings & Review Sentiment in Bangkok") replace



** Coef plot
set scheme cleanplots

* Coef Plot - Unstandardized coefs
coefplot (, keep(review_scores_rating:) label(Eq1: Numeric Rating) mcolor(eltblue) ciopts(lcolor(eltblue eltblue))) /// marker & ci opts for plot 1
	 (, keep(comments_vader:) label(Eq2: Review Sentiment) mcolor(cranberry%70) ciopts(lcolor(cranberry%60 cranberry%60))), /// marker & ci opts for plot 2
	 drop(_cons) ///
	 xline(0) levels(95 90) ciopts(recast(rcap) lwidth(medthick thick)) msymbol(circle) msize(medsmall) legend(rows(1) position(6) size(small)) ///
	 order(host_about_exists host_about_vader2 host_exp_month host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e   host_response_time_withinafewhou description_exists neighborhood_overview_exists  neighborhood_overview_vader2 price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews) ///
	 coeflabels(host_about_exists = "Host Info Available" host_about_vader2 = "Host Info Sentiment" host_exp_month = "Host Exp" host_exp_month2 = "Host Exp^2" host_is_superhost_t = "Super Host" host_total_listings_count = "Host's Total Listings"  calculated_host_listings_count_e = "Host's Total Houses"  host_response_time_withinafewhou = "Host Responds in Few Hrs" description_exists = "Listing Info Available" neighborhood_overview_exists = "Neighborhood Desc Avail" neighborhood_overview_vader2 = "Neighborhood Desc Sent" price_num = "Price" num_amenities = "No. of Amenities" accommodates = "Occupancy" bathrooms = "No. of Baths" availability_30 = "Availability Last Month" room_type_entirehomeapt = "Room Type_Entire House" room_type_privateroom = "Room Type_Private Room" number_of_reviews = "No. of Reviews") ///
	 title("Figure 1A. SUR of Airbnb Ratings & Reviews in Bangkok (Unstandardized Coefs)", size(small))

* Coef plot - Standardized coefs
coefplot (, keep(review_scores_rating:) label(Eq1: Numeric Rating) mcolor(eltblue) ciopts(lcolor(eltblue eltblue))) /// marker & ci opts for plot 1
	 (, keep(comments_vader:) label(Eq2: Review Sentiment) mcolor(cranberry%70) ciopts(lcolor(cranberry%60 cranberry%60))), /// marker & ci opts for plot 2
	 drop(_cons) ///
	 xline(0) levels(95 90) ciopts(recast(rcap) lwidth(medthick thick)) msymbol(circle) msize(medsmall) legend(rows(1) position(6) size(small)) ///
	 transform(* = @/@se) ///
	 order(host_about_exists host_about_vader2 host_exp_month host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e   host_response_time_withinafewhou description_exists neighborhood_overview_exists  neighborhood_overview_vader2 price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews) ///
	 coeflabels(host_about_exists = "Host Info Available" host_about_vader2 = "Host Info Sentiment" host_exp_month = "Host Exp" host_exp_month2 = "Host Exp^2" host_is_superhost_t = "Super Host" host_total_listings_count = "Host's Total Listings"  calculated_host_listings_count_e = "Host's Total Houses"  host_response_time_withinafewhou = "Host Responds in Few Hrs" description_exists = "Listing Info Available" neighborhood_overview_exists = "Neighborhood Desc Avail" neighborhood_overview_vader2 = "Neighborhood Desc Sent" price_num = "Price" num_amenities = "No. of Amenities" accommodates = "Occupancy" bathrooms = "No. of Baths" availability_30 = "Availability Last Month" room_type_entirehomeapt = "Room Type_Entire House" room_type_privateroom = "Room Type_Private Room" number_of_reviews = "No. of Reviews") ///
	 title("Figure 1B. SUR of Airbnb Ratings & Reviews in Bangkok (Standardized Coefs)", size(small))
	 







