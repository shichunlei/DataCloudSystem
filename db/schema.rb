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

ActiveRecord::Schema.define(version: 20180415092253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
  add_foreign_key "organizations", "organizations"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "recipe_classifies", "recipe_classifies"
  add_foreign_key "recipe_materials", "recipes"
  add_foreign_key "recipe_processes", "recipes"
  add_foreign_key "recipes", "recipe_classifies"
  add_foreign_key "users", "organizations"
end
