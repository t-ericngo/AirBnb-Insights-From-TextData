cd "Enter Working Directory Here"

use SF_regdata.dta, clear

*destring price, generate(price_num) force

*drop price amenities

*gen host_exp_month2 = host_exp_month*host_exp_month

*save SF_regdata.dta, replace


set level 90
reg3 (review_scores_rating host_about_exists host_about_vader host_exp_month  host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e host_response_time_withinafewhou description_exists neighborhood_overview_exists neighborhood_overview_vader price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt  room_type_privateroom number_of_reviews) ///
 (review_vader host_about_exists host_about_vader host_exp_month  host_exp_month2 host_is_superhost_t host_total_listings_count  calculated_host_listings_count_e host_response_time_withinafewhou description_exists neighborhood_overview_exists neighborhood_overview_vader price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt  room_type_privateroom number_of_reviews), sure

estimates store sur_SF
 
*** Regression Table
esttab sur_SF using group02_table2_SF.rtf, cells(b(fmt(3) star) se(par fmt(3))) starlevels(* 0.10 ** 0.05 *** 0.01) stats(N ll r2_1 r2_2) ///
 mtitles("M1-SUR for SF") ///
 coeflabels(host_about_exists "Host Info Available" host_about_vader "Host Info Sentiment" host_exp_month "Host Exp" host_exp_month2 "Host Exp^2" host_is_superhost_t "Super Host" host_total_listings_count "Host's Total Listings"  calculated_host_listings_count_e "Host's Total Houses"  host_response_time_withinafewhou "Host Responds in Few Hrs" description_exists "Listing Info Available" neighborhood_overview_exists "Neighborhood Desc Available" neighborhood_overview_vader "Neighborhood Desc Sentiment" price_num "Price" num_amenities "No. of Amenities" accommodates "Occupancy" bathrooms "No. of Baths" availability_30 "Availability Last Month" room_type_entirehomeapt "Room Type_Entire House" room_type_privateroom "Room Type_Private Room" number_of_reviews "No. of Reviews" _cons "Constant") ///
 title("Table 2. Seemingly Unrelated Regression on Airbnb Ratings & Review Sentiment in San Francisco") replace



** Coef plot
set scheme cleanplots

* Unstandardized coefs
coefplot (, keep(review_scores_rating:) label(Eq1: Numeric Rating) mcolor(eltblue) ciopts(lcolor(eltblue eltblue))) /// marker & ci opts for plot 1
	 (, keep(review_vader:) label(Eq2: Review Sentiment) mcolor(cranberry%70) ciopts(lcolor(cranberry%60 cranberry%60))), /// marker & ci opts for plot 2
	 drop(_cons) ///
	 xline(0) levels(95 90) ciopts(recast(rcap) lwidth(medthick thick)) msymbol(circle) msize(medsmall) legend(rows(1) position(6) size(small)) ///
	 order(host_about_exists host_about_vader host_exp_month host_exp_month2 host_is_superhost_t host_total_listings_count calculated_host_listings_count_e host_response_time_withinanhour description_exists neighborhood_overview_exists neighborhood_overview_vader price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews ) ///
	 coeflabels(host_about_exists = "Host Info Available" host_about_vader = "Host Info Sentiment" host_exp_month =  "Host Exp" host_exp_month2 = "Host Exp^2" host_is_superhost_t = "Super Host" host_total_listings_count = "Host's Total Listings"  calculated_host_listings_count_e = "Host's Total Houses"  host_response_time_withinafewhou = "Host Responds in Few Hrs" description_exists = "Listing Info Available" neighborhood_overview_exists = "Neighborhood Desc Avail" neighborhood_overview_vader = "Neighborhood Desc Sent" price_num = "Price" num_amenities = "No. of Amenities" accommodates = "Occupancy" bathrooms = "No. of Baths" availability_30 = "Availability Last Month" room_type_entirehomeapt = "Room Type_Entire House" room_type_privateroom = "Room Type_Private Room" number_of_reviews = "No. of Reviews") ///
	 title("Figure 2A. SUR of Airbnb Ratings & Reviews in San Fran (Unstandardized Coefs)", size(small))


* Standardized coefs
coefplot (, keep(review_scores_rating:) label(Eq1: Numeric Rating) mcolor(eltblue) ciopts(lcolor(eltblue eltblue))) /// marker & ci opts for plot 1
	 (, keep(review_vader:) label(Eq2: Review Sentiment) mcolor(cranberry%70) ciopts(lcolor(cranberry%60 cranberry%60))), /// marker & ci opts for plot 2
	 drop(_cons) ///
	 xline(0) levels(95 90) ciopts(recast(rcap) lwidth(medthick thick)) msymbol(circle) msize(medsmall) legend(rows(1) position(6) size(small)) ///
	 transform(* = @/@se) ///
	 order(host_about_exists host_about_vader host_exp_month host_exp_month2 host_is_superhost_t host_total_listings_count calculated_host_listings_count_e host_response_time_withinanhour description_exists neighborhood_overview_exists neighborhood_overview_vader price_num num_amenities accommodates bathrooms availability_30 room_type_entirehomeapt room_type_privateroom number_of_reviews ) ///
	 coeflabels(host_about_exists = "Host Info Available" host_about_vader = "Host Info Sentiment" host_exp_month =  "Host Exp" host_exp_month2 = "Host Exp^2" host_is_superhost_t = "Super Host" host_total_listings_count = "Host's Total Listings"  calculated_host_listings_count_e = "Host's Total Houses"  host_response_time_withinafewhou = "Host Responds in Few Hrs" description_exists = "Listing Info Available" neighborhood_overview_exists = "Neighborhood Desc Avail" neighborhood_overview_vader = "Neighborhood Desc Sent" price_num = "Price" num_amenities = "No. of Amenities" accommodates = "Occupancy" bathrooms = "No. of Baths" availability_30 = "Availability Last Month" room_type_entirehomeapt = "Room Type_Entire House" room_type_privateroom = "Room Type_Private Room" number_of_reviews = "No. of Reviews") ///
	 title("Figure 2B. SUR of Airbnb Ratings & Reviews in San Fran (Standardized Coefs)", size(small))




