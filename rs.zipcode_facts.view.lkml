view: rs_zipcode_facts {
  sql_table_name: datablocks_spectrum.zipcode ;;

  dimension: zipcode {
    primary_key: yes
    hidden: yes
    map_layer_name: us_zipcode_tabulation_areas
    type: zipcode
    sql: RPAD(${TABLE}.zip_code::varchar), 5, '0') ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  ## City -- needs to be updated
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: county_name {
    group_label: "County"
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  measure: count {
    hidden: yes
    type: count
  }

  set: detail {
    fields: [
      zipcode,
      latitude,
      longitude,
      city,
      state,
      county_name,
      location
    ]
  }
}
