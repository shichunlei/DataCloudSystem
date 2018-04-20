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


#-----------------------------------菜谱管理---------------------------
rails g scaffold recipe_classify name:string recipe_classify:references

rails g scaffold recipe name:string recipe_classify:references peoplenum:string preparetime:string cookingtime:string content:text pic:string tag:string

rails g scaffold recipe_material recipe:references mname:string mtype:integer amount:string

rails g scaffold recipe_process recipe:references pcontent:text pic:string


#-----------------------------------唐诗---------------------------
rails g scaffold tangshi name:string author:string mtype:string content:text explanation:text appreciation:text

#-----------------------------------宋词---------------------------
rails g scaffold songci name:string author:string mtype:string content:text explanation:text appreciation:text

#-----------------------------------元曲---------------------------
rails g scaffold yuanqu name:string author:string content:text explanation:text appreciation:text

#-----------------------------------论语---------------------------
rails g scaffold lunyu chapter:string name:string content:text commentary:text translation:text appreciation:text interpretation:text

#-----------------------------------孟子---------------------------
rails g scaffold mengzi chapter:string name:string content:text commentary:text translation:text appreciation:text interpretation:text

#-----------------------------------老子 - 道德经---------------------------
rails g scaffold daodejing name:string content:text commentary:text translation:text appreciation:text interpretation:text

#-----------------------------------庄子---------------------------
rails g scaffold zhuangzi chapter:string name:string content:text commentary:text translation:text appreciation:text interpretation:text

#-----------------------------------黄帝内经---------------------------
rails g scaffold huangdineijing name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------三国志---------------------------
rails g scaffold sanguozhi name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------古文观止---------------------------
rails g scaffold guwen name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------梦溪笔谈---------------------------
rails g scaffold mengxibitan name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------吕氏春秋---------------------------
rails g scaffold lvshichunqiu name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------诗经---------------------------
rails g scaffold shijing name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------山海经---------------------------
rails g scaffold shanhaijing name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------史记---------------------------
rails g scaffold shiji name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------世说新语---------------------------
rails g scaffold shishuoxinyu name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------孙子兵法---------------------------
rails g scaffold sunzibingfa name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------文心雕龙---------------------------
rails g scaffold wenxindiaolong name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------天工开物---------------------------
rails g scaffold tiangong name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------搜神记---------------------------
rails g scaffold soushenji name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------周易---------------------------
rails g scaffold zhouyi name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------鬼谷子---------------------------
rails g scaffold guiguzi name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------徐霞客游记---------------------------
rails g scaffold xuxiake name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------左传--------------------------
rails g scaffold zuozhuan name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------汉书--------------------------
rails g scaffold hanshu name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------后汉书--------------------------
rails g scaffold houhanshu name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------资治通鉴---------------------------
rails g scaffold zizhitongjian name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------笑林广记---------------------------
rails g scaffold xiaolin name:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------三十六计---------------------------
rails g scaffold sanshiliuji name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------乐府诗集---------------------------
rails g scaffold yuefu name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------本草纲目---------------------------
rails g scaffold bencao name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------金刚经---------------------------
rails g scaffold jingangjing name:string chapter:string content:text commentary:text appreciation:text translation:text interpretation:text

#-----------------------------------菜根谭---------------------------
rails g scaffold caigentan name:string content:text commentary:text translation:text appreciation:text interpretation:text

#-----------------------------------地藏经---------------------------
rails g scaffold dizangjing name:string content:text commentary:text translation:text appreciation:text interpretation:text



#-----------------------------------历史上的今天---------------------------
rails g scaffold todayhistory name:string year:integer month:integer day:integer content:text image:string

#-----------------------------------成语大全---------------------------
rails g scaffold chengyu name:string pronounce:string content:text comefrom:text antonym:string thesaurus:string example:text

#-----------------------------------谜语大全---------------------------
rails g scaffold miyu_classify name:string

rails g scaffold miyu content:string answer:string miyu_classify:references

#-----------------------------------黄历---------------------------
rails g scaffold huangli year:integer month:integer day:integer yangli:string nongli:string star:stirng taishen:string wuxing:stirng chong:string sha:string shengxiao:string jiri:string zhiri:string xiongshen:string jishenyiqu:string caishen:string xishen:string fushen:string suici:string yi:string ji:string eweek:stirng emonth:string week:string

#-----------------------------------星座---------------------------
rails g scaffold astro name:string pic:string start_date:string end_date:string
#-----------------------------------星座当天运势---------------------------
rails g scaffold today_fortune tdate:date love:integer health:integer career:integer color:string star:string number:integer summary:integer presummary:text money:integer astro:references
#-----------------------------------星座明日运势---------------------------
rails g scaffold tomorrow_fortune tdate:date love:integer health:integer career:integer color:string star:string number:integer summary:integer presummary:text money:integer astro:references
#-----------------------------------星座本周运势---------------------------
rails g scaffold week_fortune start_date:date end_date:date money:text career:text love:text health:text job:text astro:references
#-----------------------------------星座本月运势---------------------------
rails g scaffold month_fortune mdate:string summary:text money:text career:text love:text health:text astro:references
#-----------------------------------星座本年运势---------------------------
rails g scaffold year_fortune year:integer summary:text money:text career:text love:text astro:references











#--------------------------------------------------------------
