//Combine CP data
global datain c:\Users\wb327173\OneDrive - WBG\Downloads\ECA\GPWG\Poverty and Shared Prosperity SM2022\PIP\2017

//Chart6_KI4 data shared prosperity
import delimit using "$datain\indicator_values_country_chart6_KI4_combine.csv", clear
ren xyzdpxyzsi_spr_pcap_zg ind_
reshape wide ind_ , i( xyzdmxyzcountry xyzdmxyzyearrange xyzdmxyzinterpolation xyzdcxyzwelfaretype xyzdcxyzpppyear ) j( xyzdcxyzdistribution ) string

replace xyzdmxyzyearrange = subinstr( xyzdmxyzyearrange,"-","_",.)
reshape wide ind_b40 ind_m50 ind_premium ind_tot, i( xyzdmxyzcountry xyzdmxyzinterpolation xyzdcxyzwelfaretype xyzdcxyzpppyear ) j( xyzdmxyzyearrange ) string

isid xyzdmxyzcountry xyzdcxyzwelfaretype xyzdcxyzpppyear
ren xyzdmxyzcountry country_code
ren xyzdcxyzpppyear ppp_year
ren xyzdcxyzwelfaretype welfare_type
ren xyzdmxyzinterpolation  is_interpolated

la var country_code "Country/Economy code"
la var is_interpolated "Data is interpolated"
la var welfare_type "Welfare measured by income or consumption"
la var ppp_year "PPP Year"
ren ind_* growth_*
sort country_code welfare_type ppp_year

compress
saveold "$datain\flat_shp.dta", replace
