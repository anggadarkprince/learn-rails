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

ActiveRecord::Schema.define(version: 20170918141016) do

  create_table "article_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "article_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at"
    t.index ["article_id"], name: "fk_rails_646e8d3122"
    t.index ["tag_id"], name: "fk_rails_b651172c61"
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", limit: 500, null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "status", limit: 9, default: "published"
    t.string "featured", limit: 300
    t.integer "views", default: 0
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["slug"], name: "index_articles_on_slug"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", null: false
    t.string "category", limit: 50, null: false
    t.string "description", limit: 500, null: false
    t.string "featured", limit: 300
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["slug"], name: "index_categories_on_slug"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "email", limit: 50
    t.text "comment", null: false
    t.string "status", limit: 100, default: "approved", null: false
    t.integer "votes", default: 0, null: false
    t.bigint "comment_id"
    t.bigint "user_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "slug", null: false
    t.string "tag", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tags_on_slug"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 50, null: false
    t.string "username", limit: 30, null: false
    t.string "email", limit: 50, null: false
    t.string "password", limit: 200, null: false
    t.string "avatar", limit: 300
    t.string "about", limit: 500
    t.string "role", default: "writer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "article_tags", "articles", on_delete: :cascade
  add_foreign_key "article_tags", "tags", on_delete: :cascade
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users"
  add_foreign_key "categories", "categories"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "users"
end
