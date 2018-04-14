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

ActiveRecord::Schema.define(version: 20180414131224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "car_gearboxes", force: :cascade do |t|
    t.integer  "car_model_id"
    t.string   "gearbox",      default: ""
    t.string   "shiftpaddles", default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["car_model_id"], name: "index_car_gearboxes_on_car_model_id", using: :btree
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

  add_foreign_key "car_basics", "car_models"
  add_foreign_key "car_bodies", "car_models"
  add_foreign_key "car_engines", "car_models"
  add_foreign_key "car_gearboxes", "car_models"
  add_foreign_key "car_models", "car_types"
  add_foreign_key "car_types", "car_brands"
  add_foreign_key "organizations", "organizations"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "users", "organizations"
end
