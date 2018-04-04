view: bq_gsod {
  sql_table_name: `bigquery-public-data.noaa_gsod.gsod*` ;;

  dimension: station_id {
    type: string
    sql: CASE WHEN ${wban} = '99999' THEN ${station} ELSE ${wban} END;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(cast(${station} as string), ${wban}, cast(${weather_date} as string)) ;;
  }

  dimension: station {
    hidden: yes
    type: string
    sql: ${TABLE}.stn ;;
  }

  dimension: wban {
    hidden: yes
    type: string
    sql: ${TABLE}.wban ;;
  }

  dimension: windspeed {
    group_label: "Weather Event"
#     hidden: yes
    type: string
    sql: ${TABLE}.wdsp ;;
  }

  dimension: year {
    type: string
    sql: REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d') ;;
  }

  dimension_group: weather {
    type: time
    timeframes: [date, month, month_name, year]
    sql: TIMESTAMP(concat(${TABLE}.year,'-',${month},'-',${day})) ;;
    convert_tz: no
  }

  dimension: dew_point {
    group_label: "Weather Event"
    type: number
    sql: ${TABLE}.dewp ;;
  }

  dimension: flag_prcp {
    hidden: yes
    type: string
    sql: ${TABLE}.flag_prcp ;;
  }

  dimension: max_wind_speed {
    group_label: "Weather Event"
    type: string
    sql: ${TABLE}.mxpsd ;;
  }

  dimension: gust {
    group_label: "Weather Event"
    type: number
    sql: ${TABLE}.gust ;;
  }

  dimension: visibility {
    group_label: "Weather Event"
    type: number
    sql: ${TABLE}.visib ;;
  }

  dimension: rainfall {
    type: number
    sql: case when ${TABLE}.prcp = 99.99 then null else ${TABLE}.prcp end;;
  }

  dimension: has_rainfall {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${rainfall} > 0.0 ;;
  }

  measure: total_rainfall {
    group_label: "Station"
    type: sum
    sql: ${rainfall} ;;
    value_format_name: decimal_2
  }

  measure: total_snow_inches {
    group_label: "Station"
    type: sum
    sql: ${snow};;
    value_format_name: decimal_2
  }

  measure: average_rainfall {
    type: average
    sql: ${rainfall} ;;
    value_format_name: decimal_2
  }


## Aggregated Station Counts by Year --
  measure: total_days_with_rainfall{
    type: count
    filters: {
      field: has_rainfall
      value: "yes"
    }
  }

  dimension: rain_drizzle {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.rain_drizzle = '1' ;;
  }

  dimension: fog {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.fog = '1';;
  }

  dimension: hail {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.hail = '1' ;;
  }

  dimension: snow_ice_pellets {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.snow_ice_pellets = '1' ;;
  }

  dimension: thunder {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.thunder = '1';;
  }

  dimension: tornado_funnel_cloud {
    group_label: "Event Occurrence"
    type: yesno
    sql: ${TABLE}.tornado_funnel_cloud = '1' ;;
  }

  dimension: sea_level_pressure {
    group_label: "Weather Event"
    type: number
    sql: ${TABLE}.slp ;;
  }

  dimension: snow {
    label: "Snow (inches)"
    type: number
    sql: case when ${TABLE}.sndp = 999.9 then null else ${TABLE}.sndp end;;
  }

  dimension: mean_station_pressure {
    hidden: yes
    type: number
    sql: ${TABLE}.stp ;;
  }

  dimension: temperature {
    hidden: yes
    type: number
    sql: case when ${TABLE}.temp = 9999.9 then null else ${TABLE}.temp end ;;
  }

  measure: average_temperature {
    type: average
    sql: ${temperature} ;;
    value_format_name: decimal_2
  }


  measure: min_temperature {
    type: min
    sql: ${TABLE}.min ;;
    value_format_name: decimal_2
  }

  measure: max_temperature {
    type: max
    sql: ${TABLE}.max ;;
    value_format_name: decimal_2
  }




  ## Unused Fields

  measure: count {
    type: count

  }

  dimension: month {
    hidden: yes
    type: string
    sql: ${TABLE}.mo ;;
  }

  dimension: day {
    hidden: yes
    type: string
    sql: ${TABLE}.da ;;
  }

  dimension: count_dewp {
    hidden: yes
    type: number
    sql: ${TABLE}.count_dewp ;;
  }

  dimension: count_slp {
    hidden: yes
    type: number
    sql: ${TABLE}.count_slp ;;
  }

  dimension: count_stp {
    hidden: yes
    type: number
    sql: ${TABLE}.count_stp ;;
  }

  dimension: count_temp {
    hidden: yes
    type: number
    sql: ${TABLE}.count_temp ;;
  }

  dimension: flag_max_temp {
    hidden: yes
    type: string
    sql: ${TABLE}.flag_max ;;
  }

  dimension: flag_min_temp {
    hidden: yes
    type: string
    sql: ${TABLE}.flag_min ;;
  }

  dimension: count_visib {
    hidden: yes
    type: number
    sql: ${TABLE}.count_visib ;;
  }

  dimension: count_wdsp {
    hidden: yes
    type: string
    sql: ${TABLE}.count_wdsp ;;
  }
}
