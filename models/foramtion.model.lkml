connection: "renault-gcp-sub-react"

# include all the views
include: "/views/**/*.view"

datagroup: foramtion_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: foramtion_default_datagroup

#explore: pareto {}

#explore: ig_2j {}

#explore: data_pareto_v2 {}

explore: vin_data {}