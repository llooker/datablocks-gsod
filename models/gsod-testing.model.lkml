connection: "brick-layer"

# include all the views
include: "/views/**/*.view"

# persist_with: gsod-testing_default_datagroup

explore: gsod2020 {
  join: stations {
    sql_on: ${stations.usaf} = ${gsod2020.stn} ;;
    relationship: many_to_many
  }
}

explore: stations {}
