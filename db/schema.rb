# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180911014140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "iata",       default: ""
    t.string   "icao",       default: ""
    t.string   "other_name", default: ""
    t.integer  "country_id"
    t.string   "city_name",  default: ""
    t.text     "intro",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["country_id"], name: "index_airports_on_country_id", using: :btree
  end

  create_table "astros", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "pic",        default: ""
    t.string   "start_date", default: ""
    t.string   "end_date",   default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "baijiaxings", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "author",       default: ""
    t.text     "source",       default: ""
    t.text     "celebrity",    default: ""
    t.text     "distributing", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "name",               default: ""
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "author",             default: ""
    t.string   "dynasty",            default: ""
    t.string   "chapter",            default: ""
    t.string   "section",            default: ""
    t.text     "content",            default: ""
    t.text     "commentary",         default: ""
    t.text     "translation",        default: ""
    t.text     "appreciation",       default: ""
    t.text     "interpretation",     default: ""
    t.text     "background",         default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "category"
  end

  create_table "caigentans", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "car_actualtests", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "accelerationtime100", default: ""
    t.string   "brakingdistance",     default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["car_model_id"], name: "index_car_actualtests_on_car_model_id", using: :btree
  end

  create_table "car_aircondrefrigerators", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "airconditioningcontrolmode", default: ""
    t.string   "tempzonecontrol",            default: ""
    t.string   "rearairconditioning",        default: ""
    t.string   "reardischargeoutlet",        default: ""
    t.string   "airconditioning",            default: ""
    t.string   "airpurifyingdevice",         default: ""
    t.string   "carrefrigerator",            default: ""
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["car_model_id"], name: "index_car_aircondrefrigerators_on_car_model_id", using: :btree
  end

  create_table "car_basics", force: :cascade do |t|
    t.string   "price",                       default: ""
    t.string   "saleprice",                   default: ""
    t.string   "warrantypolicy",              default: ""
    t.string   "vechiletax",                  default: ""
    t.string   "displacement",                default: ""
    t.string   "gearbox",                     default: ""
    t.string   "comfuelconsumption",          default: ""
    t.string   "userfuelconsumption",         default: ""
    t.string   "officialaccelerationtime100", default: ""
    t.string   "maxspeed",                    default: ""
    t.string   "seatnum",                     default: ""
    t.integer  "car_model_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "testaccelerationtime100",     default: ""
    t.index ["car_model_id"], name: "index_car_basics_on_car_model_id", using: :btree
  end

  create_table "car_bodies", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "color",              default: ""
    t.string   "len",                default: ""
    t.string   "width",              default: ""
    t.string   "height",             default: ""
    t.string   "wheelbase",          default: ""
    t.string   "fronttrack",         default: ""
    t.string   "reartrack",          default: ""
    t.string   "weight",             default: ""
    t.string   "fullweight",         default: ""
    t.string   "mingroundclearance", default: ""
    t.string   "approachangle",      default: ""
    t.string   "departureangle",     default: ""
    t.string   "luggagevolume",      default: ""
    t.string   "luggagemode",        default: ""
    t.string   "luggageopenmode",    default: ""
    t.string   "inductionluggage",   default: ""
    t.string   "doornum",            default: ""
    t.string   "tooftype",           default: ""
    t.string   "hoodtype",           default: ""
    t.string   "roofluggagerack",    default: ""
    t.string   "sportpackage",       default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["car_model_id"], name: "index_car_bodies_on_car_model_id", using: :btree
  end

  create_table "car_brands", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "initial",    default: ""
    t.string   "logo",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "car_chassisbrakes", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "bodystructure",          default: ""
    t.string   "powersteering",          default: ""
    t.string   "frontbraketype",         default: ""
    t.string   "rearbraketype",          default: ""
    t.string   "parkingbraketype",       default: ""
    t.string   "drivemode",              default: ""
    t.string   "airsuspension",          default: ""
    t.string   "adjustablesuspension",   default: ""
    t.string   "frontsuspensiontype",    default: ""
    t.string   "rearsuspensiontype",     default: ""
    t.string   "centerdifferentiallock", default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["car_model_id"], name: "index_car_chassisbrakes_on_car_model_id", using: :btree
  end

  create_table "car_doormirrors", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "openstyle",                default: ""
    t.string   "electricwindow",           default: ""
    t.string   "uvinterceptingglass",      default: ""
    t.string   "privacyglass",             default: ""
    t.string   "antipinchwindow",          default: ""
    t.string   "skylightopeningmode",      default: ""
    t.string   "skylightstype",            default: ""
    t.string   "rearwindowsunshade",       default: ""
    t.string   "rearsidesunshade",         default: ""
    t.string   "rearwiper",                default: ""
    t.string   "sensingwiper",             default: ""
    t.string   "electricpulldoor",         default: ""
    t.string   "rearmirrorwithturnlamp",   default: ""
    t.string   "externalmirrormemory",     default: ""
    t.string   "externalmirrorheating",    default: ""
    t.string   "externalmirrorfolding",    default: ""
    t.string   "externalmirroradjustment", default: ""
    t.string   "rearviewmirrorantiglare",  default: ""
    t.string   "sunvisormirror",           default: ""
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["car_model_id"], name: "index_car_doormirrors_on_car_model_id", using: :btree
  end

  create_table "car_drivingauxiliaries", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "abs",                       default: ""
    t.string   "ebd",                       default: ""
    t.string   "brakeassist",               default: ""
    t.string   "tractioncontrol",           default: ""
    t.string   "esp",                       default: ""
    t.string   "eps",                       default: ""
    t.string   "automaticparking",          default: ""
    t.string   "hillstartassist",           default: ""
    t.string   "hilldescent",               default: ""
    t.string   "frontparkingradar",         default: ""
    t.string   "reversingradar",            default: ""
    t.string   "reverseimage",              default: ""
    t.string   "panoramiccamera",           default: ""
    t.string   "cruisecontrol",             default: ""
    t.string   "adaptivecruise",            default: ""
    t.string   "gps",                       default: ""
    t.string   "automaticparkingintoplace", default: ""
    t.string   "ldws",                      default: ""
    t.string   "activebraking",             default: ""
    t.string   "integralactivesteering",    default: ""
    t.string   "nightvisionsystem",         default: ""
    t.string   "blindspotdetection",        default: ""
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["car_model_id"], name: "index_car_drivingauxiliaries_on_car_model_id", using: :btree
  end

  create_table "car_engines", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "position",               default: ""
    t.string   "model",                  default: ""
    t.string   "displacement",           default: ""
    t.string   "displacementml",         default: ""
    t.string   "intakeform",             default: ""
    t.string   "cylinderarrangetype",    default: ""
    t.string   "cylindernum",            default: ""
    t.string   "valvetrain",             default: ""
    t.string   "valvestructure",         default: ""
    t.string   "compressionratio",       default: ""
    t.string   "bore",                   default: ""
    t.string   "stroke",                 default: ""
    t.string   "maxhorsepower",          default: ""
    t.string   "maxpower",               default: ""
    t.string   "maxpowerspeed",          default: ""
    t.string   "maxtorque",              default: ""
    t.string   "maxtorquespeed",         default: ""
    t.string   "fueltype",               default: ""
    t.string   "fuelgrade",              default: ""
    t.string   "fuelmethod",             default: ""
    t.string   "fueltankcapacity",       default: ""
    t.string   "cylinderheadmaterial",   default: ""
    t.string   "cylinderbodymaterial",   default: ""
    t.string   "environmentalstandards", default: ""
    t.string   "startstopsystem",        default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["car_model_id"], name: "index_car_engines_on_car_model_id", using: :btree
  end

  create_table "car_entcoms", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "locationservice",        default: ""
    t.string   "bluetooth",              default: ""
    t.string   "externalaudiointerface", default: ""
    t.string   "builtinharddisk",        default: ""
    t.string   "cartv",                  default: ""
    t.string   "speakernum",             default: ""
    t.string   "audiobrand",             default: ""
    t.string   "dvd",                    default: ""
    t.string   "cd",                     default: ""
    t.string   "consolelcdscreen",       default: ""
    t.string   "rearlcdscreen",          default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["car_model_id"], name: "index_car_entcoms_on_car_model_id", using: :btree
  end

  create_table "car_gearboxes", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "gearbox",      default: ""
    t.string   "shiftpaddles", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["car_model_id"], name: "index_car_gearboxes_on_car_model_id", using: :btree
  end

  create_table "car_internalconfigs", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "steeringwheelbeforeadjustment", default: ""
    t.string   "steeringwheelupadjustment",     default: ""
    t.string   "steeringwheeladjustmentmode",   default: ""
    t.string   "steeringwheelmemory",           default: ""
    t.string   "steeringwheelmaterial",         default: ""
    t.string   "steeringwheelmultifunction",    default: ""
    t.string   "steeringwheelheating",          default: ""
    t.string   "computerscreen",                default: ""
    t.string   "huddisplay",                    default: ""
    t.string   "interiorcolor",                 default: ""
    t.string   "rearcupholder",                 default: ""
    t.string   "supplyvoltage",                 default: ""
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["car_model_id"], name: "index_car_internalconfigs_on_car_model_id", using: :btree
  end

  create_table "car_lights", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "headlighttype",                   default: ""
    t.string   "optionalheadlighttype",           default: ""
    t.string   "headlightautomaticopen",          default: ""
    t.string   "headlightautomaticclean",         default: ""
    t.string   "headlightdelayoff",               default: ""
    t.string   "headlightdynamicsteering",        default: ""
    t.string   "headlightilluminationadjustment", default: ""
    t.string   "headlightdimming",                default: ""
    t.string   "frontfoglight",                   default: ""
    t.string   "readinglight",                    default: ""
    t.string   "interiorairlight",                default: ""
    t.string   "daytimerunninglight",             default: ""
    t.string   "ledtaillight",                    default: ""
    t.string   "lightsteeringassist",             default: ""
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["car_model_id"], name: "index_car_lights_on_car_model_id", using: :btree
  end

  create_table "car_models", force: :cascade do |t|
    t.string   "name",            default: ""
    t.string   "price",           default: ""
    t.string   "logo",            default: ""
    t.string   "salestate",       default: ""
    t.string   "yeartype",        default: ""
    t.string   "productionstate", default: ""
    t.string   "sizetype",        default: ""
    t.integer  "car_type_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["car_type_id"], name: "index_car_models_on_car_type_id", using: :btree
  end

  create_table "car_saves", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "airbagdrivingposition",     default: ""
    t.string   "airbagfrontpassenger",      default: ""
    t.string   "airbagfrontside",           default: ""
    t.string   "airbagfronthead",           default: ""
    t.string   "airbagknee",                default: ""
    t.string   "airbagrearside",            default: ""
    t.string   "airbagrearhead",            default: ""
    t.string   "safetybeltprompt",          default: ""
    t.string   "safetybeltlimiting",        default: ""
    t.string   "safetybeltpretightening",   default: ""
    t.string   "frontsafetybeltadjustment", default: ""
    t.string   "rearsafetybelt",            default: ""
    t.string   "tirepressuremonitoring",    default: ""
    t.string   "zeropressurecontinued",     default: ""
    t.string   "centrallocking",            default: ""
    t.string   "childlock",                 default: ""
    t.string   "remotekey",                 default: ""
    t.string   "keylessentry",              default: ""
    t.string   "keylessstart",              default: ""
    t.string   "engineantitheft",           default: ""
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["car_model_id"], name: "index_car_saves_on_car_model_id", using: :btree
  end

  create_table "car_seats", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "sportseat",                           default: ""
    t.string   "seatmaterial",                        default: ""
    t.string   "seatheightadjustment",                default: ""
    t.string   "driverseatadjustmentmode",            default: ""
    t.string   "auxiliaryseatadjustmentmode",         default: ""
    t.string   "driverseatlumbarsupportadjustment",   default: ""
    t.string   "driverseatshouldersupportadjustment", default: ""
    t.string   "frontseatheadrestadjustment",         default: ""
    t.string   "rearseatadjustmentmode",              default: ""
    t.string   "rearseatreclineproportion",           default: ""
    t.string   "rearseatangleadjustment",             default: ""
    t.string   "frontseatcenterarmrest",              default: ""
    t.string   "rearseatcenterarmrest",               default: ""
    t.string   "seatventilation",                     default: ""
    t.string   "seatheating",                         default: ""
    t.string   "seatmassage",                         default: ""
    t.string   "electricseatmemory",                  default: ""
    t.string   "childseatfixdevice",                  default: ""
    t.string   "thirdrowseat",                        default: ""
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["car_model_id"], name: "index_car_seats_on_car_model_id", using: :btree
  end

  create_table "car_types", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "fullname",     default: ""
    t.string   "parentname",   default: ""
    t.string   "logo",         default: ""
    t.string   "salestate",    default: ""
    t.integer  "car_brand_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["car_brand_id"], name: "index_car_types_on_car_brand_id", using: :btree
  end

  create_table "car_wheels", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "fronttiresize", default: ""
    t.string   "reartiresize",  default: ""
    t.string   "sparetiretype", default: ""
    t.string   "hubmaterial",   default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["car_model_id"], name: "index_car_wheels_on_car_model_id", using: :btree
  end

  create_table "chaoyeqianzais", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "chucis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "ciyuans", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "enname",     default: ""
    t.string   "area",       default: ""
    t.string   "enarea",     default: ""
    t.text     "info",       default: ""
    t.string   "flag",       default: ""
    t.text     "finfo",      default: ""
    t.text     "emblem",     default: ""
    t.text     "einfo",      default: ""
    t.string   "anthems",    default: ""
    t.string   "lyrics",     default: ""
    t.string   "compose",    default: ""
    t.text     "lrc",        default: ""
    t.text     "otherlrc",   default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "daodejings", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "daxues", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "diziguis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "driverexams", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.string   "chapter",    default: ""
    t.string   "q_type",     default: ""
    t.string   "question",   default: ""
    t.string   "option1",    default: ""
    t.string   "option2",    default: ""
    t.string   "option3",    default: ""
    t.string   "option4",    default: ""
    t.string   "pic",        default: ""
    t.string   "answer",     default: ""
    t.text     "explain",    default: ""
    t.string   "chapter_no", default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "food_nutritions", force: :cascade do |t|
    t.string   "food_name",          default: ""
    t.string   "category",           default: ""
    t.string   "heat",               default: ""
    t.string   "thiamine",           default: ""
    t.string   "calcium",            default: ""
    t.string   "protein",            default: ""
    t.string   "riboflavin",         default: ""
    t.string   "magnesium",          default: ""
    t.string   "fat",                default: ""
    t.string   "niacin",             default: ""
    t.string   "iron",               default: ""
    t.string   "carbohydrate",       default: ""
    t.string   "vc",                 default: ""
    t.string   "manganese",          default: ""
    t.string   "fiber",              default: ""
    t.string   "ve",                 default: ""
    t.string   "zinc",               default: ""
    t.string   "va",                 default: ""
    t.string   "cholesterol",        default: ""
    t.string   "copper",             default: ""
    t.string   "carotene",           default: ""
    t.string   "potassium",          default: ""
    t.string   "phosphorus",         default: ""
    t.string   "retinol_equivalent", default: ""
    t.string   "sodium",             default: ""
    t.string   "selenium",           default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "fushengliujis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "guiguzis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "gushis", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "author",       default: ""
    t.string   "mtype",        default: ""
    t.text     "content",      default: ""
    t.text     "translation",  default: ""
    t.text     "explanation",  default: ""
    t.text     "appreciation", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "dynasty",      default: ""
    t.string   "sid",          default: ""
    t.string   "tags",         default: ""
  end

  create_table "guwens", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "dynasty",        default: ""
    t.string   "sid",            default: ""
    t.string   "tags",           default: ""
    t.string   "author",         default: ""
  end

  create_table "hanshus", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",                      default: ""
    t.string   "nature",                    default: ""
    t.string   "grade",                     default: ""
    t.string   "province",                  default: ""
    t.string   "city",                      default: ""
    t.string   "area",                      default: ""
    t.string   "address",                   default: ""
    t.string   "phone",                     default: ""
    t.string   "dean",                      default: ""
    t.text     "about",                     default: ""
    t.string   "specialist",                default: ""
    t.string   "year",                      default: ""
    t.string   "department",                default: ""
    t.string   "equipment",                 default: ""
    t.integer  "bed_number",                default: -1
    t.integer  "medical_workers",           default: -1
    t.string   "honor",                     default: ""
    t.string   "annual_outpatient_service", default: ""
    t.integer  "department_number",         default: -1
    t.string   "health_insurance",          default: ""
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "houhanshus", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "huangdineijings", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "huanglis", force: :cascade do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "yangli",     default: ""
    t.string   "nongli",     default: ""
    t.string   "star",       default: ""
    t.string   "taishen",    default: ""
    t.string   "wuxing",     default: ""
    t.string   "chong",      default: ""
    t.string   "sha",        default: ""
    t.string   "shengxiao",  default: ""
    t.string   "jiri",       default: ""
    t.string   "zhiri",      default: ""
    t.string   "xiongshen",  default: ""
    t.string   "jishenyiqu", default: ""
    t.string   "caishen",    default: ""
    t.string   "xishen",     default: ""
    t.string   "fushen",     default: ""
    t.string   "suici",      default: ""
    t.string   "yi",         default: ""
    t.string   "ji",         default: ""
    t.string   "eweek",      default: ""
    t.string   "emonth",     default: ""
    t.string   "week",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "laws", force: :cascade do |t|
    t.string   "name",                default: ""
    t.string   "pub_department",      default: ""
    t.string   "reference_num",       default: ""
    t.date     "pub_date"
    t.date     "exec_date"
    t.string   "pub_timeliness",      default: ""
    t.string   "effectiveness_level", default: ""
    t.string   "regcategory",         default: ""
    t.text     "content",             default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "liaofansixuns", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "lunyus", force: :cascade do |t|
    t.string   "chapter",        default: ""
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "lvshichunqius", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mengxibitans", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mengzis", force: :cascade do |t|
    t.string   "chapter",        default: ""
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mingshus", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "miyu_classifies", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "miyus", force: :cascade do |t|
    t.string   "content",          default: ""
    t.string   "answer",           default: ""
    t.integer  "miyu_classify_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["miyu_classify_id"], name: "index_miyus_on_miyu_classify_id", using: :btree
  end

  create_table "month_fortunes", force: :cascade do |t|
    t.string   "mdate",      default: ""
    t.text     "summary",    default: ""
    t.text     "money",      default: ""
    t.text     "career",     default: ""
    t.text     "love",       default: ""
    t.text     "health",     default: ""
    t.integer  "astro_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["astro_id"], name: "index_month_fortunes_on_astro_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "contact",         default: ""
    t.string   "mobile",          default: ""
    t.string   "email",           default: ""
    t.string   "duty_paragraph",  default: ""
    t.string   "web_site",        default: ""
    t.index ["organization_id"], name: "index_organizations_on_organization_id", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "action"
    t.string   "subject"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.index ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id", using: :btree
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
    t.index ["role_id", "permission_id"], name: "index_permissions_roles_on_role_id_and_permission_id", using: :btree
    t.index ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree
  end

  create_table "qianziwens", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "recipe_classifies", force: :cascade do |t|
    t.string   "name",               default: ""
    t.integer  "recipe_classify_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["recipe_classify_id"], name: "index_recipe_classifies_on_recipe_classify_id", using: :btree
  end

  create_table "recipe_materials", force: :cascade do |t|
    t.integer  "recipe_id"
    t.string   "mname",      default: ""
    t.integer  "mtype",      default: 0
    t.string   "amount",     default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["recipe_id"], name: "index_recipe_materials_on_recipe_id", using: :btree
  end

  create_table "recipe_processes", force: :cascade do |t|
    t.integer  "recipe_id"
    t.text     "pcontent"
    t.string   "pic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_processes_on_recipe_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name",               default: ""
    t.integer  "recipe_classify_id"
    t.string   "peoplenum",          default: ""
    t.string   "preparetime",        default: ""
    t.string   "cookingtime",        default: ""
    t.text     "content",            default: ""
    t.string   "pic",                default: ""
    t.text     "tag",                default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["recipe_classify_id"], name: "index_recipes_on_recipe_classify_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sanguozhis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "sanlues", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "sanshiliujis", force: :cascade do |t|
    t.string   "name",                 default: ""
    t.string   "chapter",              default: ""
    t.string   "gallery_file_name"
    t.string   "gallery_content_type"
    t.integer  "gallery_file_size"
    t.datetime "gallery_updated_at"
    t.text     "analogy",              default: ""
    t.text     "content",              default: ""
    t.text     "commentary",           default: ""
    t.text     "comment",              default: ""
    t.text     "appreciation",         default: ""
    t.text     "translation",          default: ""
    t.text     "interpretation",       default: ""
    t.text     "story",                default: ""
    t.text     "simple_explanation",   default: ""
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "sanzijings", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shanhaijings", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shijings", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shijis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shishuoxinyus", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "snacks", force: :cascade do |t|
    t.string   "name",       default: ""
    t.text     "intro",      default: ""
    t.text     "history",    default: ""
    t.text     "practice",   default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "songcis", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "author",       default: ""
    t.string   "mtype",        default: ""
    t.text     "content",      default: ""
    t.text     "explanation",  default: ""
    t.text     "appreciation", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "soushenjis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "sunzibingfas", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "tangshis", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "author",       default: ""
    t.string   "mtype",        default: ""
    t.text     "content",      default: ""
    t.text     "explanation",  default: ""
    t.text     "appreciation", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "tags",         default: ""
    t.text     "translation",  default: ""
    t.string   "sid",          default: ""
    t.string   "dynasty",      default: ""
    t.text     "background",   default: ""
  end

  create_table "tiangongs", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "today_fortunes", force: :cascade do |t|
    t.date     "tdate"
    t.integer  "love"
    t.integer  "health"
    t.integer  "career"
    t.string   "color",      default: ""
    t.string   "star",       default: ""
    t.integer  "number"
    t.integer  "summary"
    t.text     "presummary", default: ""
    t.integer  "money"
    t.integer  "astro_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["astro_id"], name: "index_today_fortunes_on_astro_id", using: :btree
  end

  create_table "todayhistories", force: :cascade do |t|
    t.string   "name",       default: ""
    t.integer  "year",       default: 1
    t.integer  "month",      default: 1
    t.integer  "day",        default: 1
    t.string   "image",      default: ""
    t.text     "content",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tomorrow_fortunes", force: :cascade do |t|
    t.date     "tdate"
    t.integer  "love"
    t.integer  "health"
    t.integer  "career"
    t.string   "color",      default: ""
    t.string   "star",       default: ""
    t.integer  "number"
    t.integer  "summary"
    t.text     "presummary", default: ""
    t.integer  "money"
    t.integer  "astro_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["astro_id"], name: "index_tomorrow_fortunes_on_astro_id", using: :btree
  end

  create_table "universities", force: :cascade do |t|
    t.string   "universityid", default: ""
    t.string   "name",         default: ""
    t.string   "f211",         default: ""
    t.string   "f985",         default: ""
    t.string   "area",         default: ""
    t.string   "address",      default: ""
    t.string   "phone",        default: ""
    t.string   "email",        default: ""
    t.string   "level",        default: ""
    t.string   "membership",   default: ""
    t.string   "nature",       default: ""
    t.string   "schoolid",     default: ""
    t.string   "schooltype",   default: ""
    t.string   "website",      default: ""
    t.text     "shoufei",      default: ""
    t.text     "intro",        default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "mobile",                 default: "", null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "organization_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["organization_id"], name: "index_users_on_organization_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "week_fortunes", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.text     "money",      default: ""
    t.text     "career",     default: ""
    t.text     "love",       default: ""
    t.text     "health",     default: ""
    t.text     "job",        default: ""
    t.integer  "astro_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["astro_id"], name: "index_week_fortunes_on_astro_id", using: :btree
  end

  create_table "wenxindiaolongs", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "wenyanwens", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.text     "background",     default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "dynasty",        default: ""
    t.string   "sid",            default: ""
    t.string   "tags",           default: ""
  end

  create_table "world_records", force: :cascade do |t|
    t.string   "name",        default: ""
    t.string   "category",    default: ""
    t.string   "pic_url",     default: ""
    t.text     "pic_all_url", default: ""
    t.text     "content",     default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "xuxiakes", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "year_fortunes", force: :cascade do |t|
    t.integer  "year"
    t.text     "summary",    default: ""
    t.text     "money",      default: ""
    t.text     "career",     default: ""
    t.text     "love",       default: ""
    t.integer  "astro_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["astro_id"], name: "index_year_fortunes_on_astro_id", using: :btree
  end

  create_table "yuanqus", force: :cascade do |t|
    t.string   "name",         default: ""
    t.string   "author",       default: ""
    t.text     "content",      default: ""
    t.text     "explanation",  default: ""
    t.text     "appreciation", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "yuefus", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "author",         default: ""
    t.string   "dynasty",        default: ""
    t.string   "sid",            default: ""
    t.string   "tags",           default: ""
    t.text     "background",     default: ""
  end

  create_table "zengguangxianwens", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "zhongyongs", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "zhouyis", force: :cascade do |t|
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "zhuangzis", force: :cascade do |t|
    t.string   "chapter",        default: ""
    t.string   "name",           default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "translation",    default: ""
    t.text     "appreciation",   default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "parent_chapter", default: ""
  end

  create_table "zuozhuans", force: :cascade do |t|
    t.string   "name",           default: ""
    t.string   "chapter",        default: ""
    t.string   "author",         default: ""
    t.text     "content",        default: ""
    t.text     "commentary",     default: ""
    t.text     "appreciation",   default: ""
    t.text     "translation",    default: ""
    t.text     "interpretation", default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "airports", "countries"
  add_foreign_key "car_actualtests", "car_models"
  add_foreign_key "car_aircondrefrigerators", "car_models"
  add_foreign_key "car_basics", "car_models"
  add_foreign_key "car_bodies", "car_models"
  add_foreign_key "car_chassisbrakes", "car_models"
  add_foreign_key "car_doormirrors", "car_models"
  add_foreign_key "car_drivingauxiliaries", "car_models"
  add_foreign_key "car_engines", "car_models"
  add_foreign_key "car_entcoms", "car_models"
  add_foreign_key "car_gearboxes", "car_models"
  add_foreign_key "car_internalconfigs", "car_models"
  add_foreign_key "car_lights", "car_models"
  add_foreign_key "car_models", "car_types"
  add_foreign_key "car_saves", "car_models"
  add_foreign_key "car_seats", "car_models"
  add_foreign_key "car_types", "car_brands"
  add_foreign_key "car_wheels", "car_models"
  add_foreign_key "miyus", "miyu_classifies"
  add_foreign_key "month_fortunes", "astros"
  add_foreign_key "organizations", "organizations"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "recipe_classifies", "recipe_classifies"
  add_foreign_key "recipe_materials", "recipes"
  add_foreign_key "recipe_processes", "recipes"
  add_foreign_key "recipes", "recipe_classifies"
  add_foreign_key "today_fortunes", "astros"
  add_foreign_key "tomorrow_fortunes", "astros"
  add_foreign_key "users", "organizations"
  add_foreign_key "week_fortunes", "astros"
  add_foreign_key "year_fortunes", "astros"
end
