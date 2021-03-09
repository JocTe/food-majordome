# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_09_145341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.float "calories"
    t.string "name"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "menu_plans", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "menu_id", null: false
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_menu_plans_on_menu_id"
    t.index ["recipe_id"], name: "index_menu_plans_on_recipe_id"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "proportions", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.float "amount"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_proportions_on_ingredient_id"
    t.index ["recipe_id"], name: "index_proportions_on_recipe_id"
  end

  create_table "recipe_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.boolean "dislike"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_recipe_preferences_on_recipe_id"
    t.index ["user_id"], name: "index_recipe_preferences_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "servings"
    t.float "prep_time"
    t.bigint "review_id", null: false
    t.bigint "user_id", null: false
    t.float "score"
    t.float "health_score"
    t.float "calories"
    t.string "name"
    t.text "summary"
    t.string "image"
    t.boolean "cheap"
    t.boolean "dairy_free"
    t.boolean "gluten_free"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.boolean "healthy"
    t.boolean "pescetarian"
    t.string "cuisine"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_recipes_on_review_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "grade"
    t.text "content"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.integer "number"
    t.text "description"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "user_ingredients", force: :cascade do |t|
    t.boolean "status"
    t.bigint "ingredient_id", null: false
    t.bigint "user_id", null: false
    t.string "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_user_ingredients_on_ingredient_id"
    t.index ["user_id"], name: "index_user_ingredients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menu_plans", "menus"
  add_foreign_key "menu_plans", "recipes"
  add_foreign_key "menus", "users"
  add_foreign_key "proportions", "ingredients"
  add_foreign_key "proportions", "recipes"
  add_foreign_key "recipe_preferences", "recipes"
  add_foreign_key "recipe_preferences", "users"
  add_foreign_key "recipes", "reviews"
  add_foreign_key "recipes", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "steps", "recipes"
  add_foreign_key "user_ingredients", "ingredients"
  add_foreign_key "user_ingredients", "users"
end
