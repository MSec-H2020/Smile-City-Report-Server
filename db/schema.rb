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

ActiveRecord::Schema.define(version: 2021_06_11_122533) do

  create_table "aware_devices", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.string "aware_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "blocked_by_user_id"
    t.integer "block_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_by_user_id", "block_user_id"], name: "index_blocks_on_blocked_by_user_id_and_block_user_id", unique: true
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "smile_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
  end

  create_table "coupon_uses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.boolean "isUsed"
    t.string "usedTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "point"
    t.string "imageUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "exercise_time"
    t.float "barometer_max"
    t.float "barometer_min"
    t.float "barometer_average"
    t.float "barometer_standard_deviation"
    t.integer "distance"
    t.float "speed_max"
    t.float "speed_average"
    t.float "speed_standard_deviation"
    t.integer "speed_dash_count"
    t.float "acc_x_max"
    t.float "acc_x_min"
    t.float "acc_x_average"
    t.float "acc_x_standard_deviation"
    t.integer "acc_x_rotation_count"
    t.float "acc_y_max"
    t.float "acc_y_min"
    t.float "acc_y_average"
    t.float "acc_y_standard_deviation"
    t.integer "acc_y_rotation_count"
    t.float "acc_z_max"
    t.float "acc_z_min"
    t.float "acc_z_average"
    t.float "acc_z_standard_deviation"
    t.integer "acc_z_rotation_count"
    t.bigint "smile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balanced_time"
    t.float "power"
    t.integer "rpe"
    t.float "gyro_x_max"
    t.float "gyro_x_min"
    t.float "gyro_x_ave"
    t.float "gyro_x_standard_deviation"
    t.float "gyro_y_max"
    t.float "gyro_y_min"
    t.float "gyro_y_ave"
    t.float "gyro_y_standard_deviation"
    t.float "gyro_z_max"
    t.float "gyro_z_min"
    t.float "gyro_z_ave"
    t.float "gyro_z_standard_deviation"
    t.integer "satisfaction"
    t.integer "emotion"
    t.index ["smile_id"], name: "index_exercises_on_smile_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "code"
    t.string "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inviter_id"
    t.bigint "theme_id"
    t.bigint "invited_id"
    t.boolean "joined"
    t.boolean "to_all"
    t.index ["invited_id"], name: "index_invitations_on_invited_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
    t.index ["theme_id"], name: "index_invitations_on_theme_id"
  end

  create_table "invited_user_themes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "joined"
  end

  create_table "joining_user_themes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_joining_user_themes_on_theme_id"
    t.index ["user_id"], name: "index_joining_user_themes_on_user_id"
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.string "lat"
    t.string "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.string "view"
    t.string "state"
    t.float "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "othersmiles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "smile_id"
    t.integer "user_id"
    t.string "pic_path"
    t.float "diff_degree"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode"
    t.float "first_degree"
    t.float "max_degree"
    t.float "degree"
  end

  create_table "point_summaries", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "allPoints"
    t.integer "todayPoints"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_point_summaries_on_user_id"
  end

  create_table "point_uses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "point_id"
    t.bigint "user_id"
    t.index ["point_id"], name: "index_point_uses_on_point_id"
    t.index ["user_id"], name: "index_point_uses_on_user_id"
  end

  create_table "points", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "point"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smile_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "smile_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smile_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "smile_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smile_themes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "smile_id"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["smile_id"], name: "index_smile_themes_on_smile_id"
    t.index ["theme_id"], name: "index_smile_themes_on_theme_id"
  end

  create_table "smiles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.string "pic_path"
    t.float "degree"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "back_pic_path"
    t.integer "mode"
    t.string "caption"
    t.bigint "exercise_id"
    t.index ["exercise_id"], name: "index_smiles_on_exercise_id"
  end

  create_table "theme_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "theme_id"
    t.integer "lang"
    t.string "title"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "themes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "area"
    t.string "title"
    t.string "message"
    t.string "timestmap"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.boolean "public"
    t.boolean "facing"
    t.boolean "isGanonymize", default: false, null: false
    t.boolean "is_default", default: false, null: false
    t.index ["owner_id"], name: "index_themes_on_owner_id"
  end

  create_table "user_all_points", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "all_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "today_point"
    t.index ["user_id"], name: "index_user_all_points_on_user_id"
  end

  create_table "user_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "profile_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fbtoken", limit: 500
    t.string "fbid"
    t.string "nickname"
    t.string "password"
    t.string "gender"
    t.integer "age"
    t.string "job"
    t.integer "student_id"
    t.string "user_class"
    t.integer "user_type"
    t.string "aware_id"
    t.string "area", default: "0", null: false
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["student_id", "nickname"], name: "index_users_on_student_id_and_nickname", unique: true
  end

  add_foreign_key "exercises", "smiles"
  add_foreign_key "invitations", "themes"
  add_foreign_key "invitations", "users", column: "invited_id"
  add_foreign_key "invitations", "users", column: "inviter_id"
  add_foreign_key "point_uses", "users"
  add_foreign_key "smile_themes", "smiles"
  add_foreign_key "smile_themes", "themes"
  add_foreign_key "smiles", "exercises"
  add_foreign_key "themes", "users", column: "owner_id"
  add_foreign_key "user_all_points", "users"
end
