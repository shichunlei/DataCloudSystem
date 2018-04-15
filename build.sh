#!/bin/bash

#-----------------------------------系统管理---------------------------
rails g scaffold organization name:string description:string organization:references

rails g scaffold user email:string avatar:attachment name:string mobile:string reset_password_token:string reset_password_sent_at:datetime remember_created_at:datetime sign_in_count:integer current_sign_in_at:datetime last_sign_in_at:datetime current_sign_in_ip:string last_sign_in_ip:string

rails g scaffold role name:string display_name:string resource:references

rails g scaffold permission action:string subject:string description:string


#-----------------------------------汽车管理---------------------------
rails g scaffold car_brand name:string logo:string initial:string

rails g scaffold car_type name:string fullname:string parentname:string logo:string salestate:string car_brand:references

rails g scaffold car_model name:string price:string yeartype:string logo:string salestate:string car_type:references productionstate:string sizetype:string

rails g scaffold car_basic price:string saleprice:string warrantypolicy:string vechiletax:string displacement:string gearbox:string comfuelconsumption:string userfuelconsumption:string officialaccelerationtime100:string maxspeed:string seatnum:string car_model:references

rails g scaffold car_body car_model:references color:string len:string width:string height:string wheelbase:string fronttrack:string reartrack:string weight:string fullweight:string  mingroundclearance:string approachangle:string departureangle:string luggagevolume:string luggagemode:string luggageopenmode:string inductionluggage:string  doornum:string  tooftype:string  hoodtype:string  roofluggagerack:string  sportpackage:string

rails g scaffold car_engine car_model:references position:string model:string displacement:string displacementml:string intakeform:string cylinderarrangetype:string cylindernum:string valvetrain:string valvestructure:string compressionratio:string bore:string stroke:string maxhorsepower:string maxpower:string maxpowerspeed:string maxtorque:string maxtorquespeed:string fueltype:string fuelgrade:string fuelmethod:string fueltankcapacity:string cylinderheadmaterial:string cylinderbodymaterial:string environmentalstandards:string startstopsystem:string

rails g scaffold car_gearbox car_model:references gearbox:string shiftpaddles:string

rails g scaffold car_chassisbrake car_model:references bodystructure:string powersteering:string frontbraketype:string rearbraketype:string parkingbraketype:string drivemode:string airsuspension:string adjustablesuspension:string frontsuspensiontype:string rearsuspensiontype:string centerdifferentiallock:string

rails g scaffold car_safe car_model:references airbagdrivingposition:string airbagfrontpassenger:string airbagfrontside:string airbagfronthead:string airbagknee:string airbagrearside:string airbagrearhead:string safetybeltprompt:string safetybeltlimiting:string safetybeltpretightening:string frontsafetybeltadjustment:string rearsafetybelt:string tirepressuremonitoring:string zeropressurecontinued:string centrallocking:string childlock:string remotekey:string keylessentry:string keylessstart:string engineantitheft:string

rails g scaffold car_wheel car_model:references fronttiresize:string reartiresize:string sparetiretype:string hubmaterial:string

rails g scaffold car_drivingauxiliary car_model:references abs:string ebd:string brakeassist:string tractioncontrol:string esp:string eps:string automaticparking:string hillstartassist:string hilldescent:string frontparkingradar:string reversingradar:string reverseimage:string panoramiccamera:string cruisecontrol:string adaptivecruise:string gps:string automaticparkingintoplace:string ldws:string activebraking:string integralactivesteering:string nightvisionsystem:string blindspotdetection:string

rails g scaffold car_doormirror car_model:references openstyle:string electricwindow:string uvinterceptingglass:string privacyglass:string antipinchwindow:string skylightopeningmode:string skylightstype:string rearwindowsunshade:string rearsidesunshade:string rearwiper:string sensingwiper:string electricpulldoor:string rearmirrorwithturnlamp:string externalmirrormemory:string externalmirrorheating:string externalmirrorfolding:string externalmirroradjustment:string rearviewmirrorantiglare:string sunvisormirror:string

rails g scaffold car_light car_model:references headlighttype:string optionalheadlighttype:string headlightautomaticopen:string headlightautomaticclean:string headlightdelayoff:string headlightdynamicsteering:string headlightilluminationadjustment:string headlightdimming:string frontfoglight:string readinglight:string interiorairlight:string daytimerunninglight:string ledtaillight:string lightsteeringassist:string

rails g scaffold car_internalconfig car_model:references steeringwheelbeforeadjustment:string steeringwheelupadjustment:string steeringwheeladjustmentmode:string steeringwheelmemory:string steeringwheelmaterial:string steeringwheelmultifunction:string steeringwheelheating:string computerscreen:string huddisplay:string interiorcolor:string rearcupholder:string supplyvoltage:string

rails g scaffold car_seat car_model:references sportseat:string seatmaterial:string seatheightadjustment:string driverseatadjustmentmode:string auxiliaryseatadjustmentmode:string driverseatlumbarsupportadjustment:string driverseatshouldersupportadjustment:string frontseatheadrestadjustment:string rearseatadjustmentmode:string rearseatreclineproportion:string rearseatangleadjustment:string frontseatcenterarmrest:string rearseatcenterarmrest:string seatventilation:string seatheating:string seatmassage:string electricseatmemory:string childseatfixdevice:string thirdrowseat:string

rails g scaffold car_entcom car_model:references locationservice:string bluetooth:string externalaudiointerface:string builtinharddisk:string cartv:string speakernum:string audiobrand:string dvd:string cd:string consolelcdscreen:string rearlcdscreen:stirng

rails g scaffold car_aircondrefrigerator car_model:references airconditioningcontrolmode:string tempzonecontrol:string rearairconditioning:string reardischargeoutlet:string airconditioning:string airpurifyingdevice:string carrefrigerator:string

rails g scaffold car_actualtest car_model:references accelerationtime100:string brakingdistance:string


















#--------------------------------------------------------------
