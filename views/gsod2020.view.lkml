view: gsod2020 {
  sql_table_name: `bigquery-public-data.noaa_gsod.*`
    ;;

  dimension: count_dewp {
    type: number
    sql: ${TABLE}.count_dewp ;;
  }

  dimension: count_slp {
    type: number
    sql: ${TABLE}.count_slp ;;
  }

  dimension: count_stp {
    type: number
    sql: ${TABLE}.count_stp ;;
  }

  dimension: count_temp {
    type: number
    sql: ${TABLE}.count_temp ;;
  }

  dimension: count_visib {
    type: number
    sql: ${TABLE}.count_visib ;;
  }

  dimension: count_wdsp {
    type: string
    sql: ${TABLE}.count_wdsp ;;
  }

  dimension: da {
    type: string
    sql: ${TABLE}.da ;;
  }

  dimension: dewp {
    type: number
    sql: ${TABLE}.dewp ;;
  }

  dimension: flag_max {
    type: string
    sql: ${TABLE}.flag_max ;;
  }

  dimension: flag_min {
    type: string
    sql: ${TABLE}.flag_min ;;
  }

  dimension: flag_prcp {
    type: string
    sql: ${TABLE}.flag_prcp ;;
  }

  dimension: fog {
    type: string
    sql: ${TABLE}.fog ;;
  }

  dimension: gust {
    type: number
    sql: ${TABLE}.gust ;;
  }

  dimension: hail {
    type: string
    sql: ${TABLE}.hail ;;
  }

  dimension: max {
    type: number
    sql: ${TABLE}.max ;;
  }

  dimension: min {
    type: number
    sql: ${TABLE}.min ;;
  }

  dimension: mo {
    type: string
    sql: ${TABLE}.mo ;;
  }

  dimension: mxpsd {
    type: string
    sql: ${TABLE}.mxpsd ;;
  }

  dimension: prcp {
    type: number
    sql: ${TABLE}.prcp ;;
  }

  dimension: rain_drizzle {
    type: string
    sql: ${TABLE}.rain_drizzle ;;
  }

  dimension: slp {
    type: number
    sql: ${TABLE}.slp ;;
  }

  dimension: sndp {
    type: number
    sql: ${TABLE}.sndp ;;
  }

  dimension: snow_ice_pellets {
    type: string
    sql: ${TABLE}.snow_ice_pellets ;;
  }

  dimension: stn {
    type: string
    sql: ${TABLE}.stn ;;
  }

  dimension: stp {
    type: number
    sql: ${TABLE}.stp ;;
  }

  dimension: pk {
    sql: CONCAT(${year},${da},${mo},${stn}) ;;
    primary_key: yes
  }

  measure: temp {
    type: average
    sql: ${TABLE}.temp ;;
  }

  dimension: thunder {
    type: string
    sql: ${TABLE}.thunder ;;
  }

  dimension: tornado_funnel_cloud {
    type: string
    sql: ${TABLE}.tornado_funnel_cloud ;;
  }

  dimension: visib {
    type: number
    sql: ${TABLE}.visib ;;
  }

  dimension: wban {
    type: string
    sql: ${TABLE}.wban ;;
  }

  dimension: wdsp {
    type: string
    sql: ${TABLE}.wdsp ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension_group: date {
    type: time
    sql: PARSE_DATE('%m/%d/%Y',  CONCAT(${mo},"/",${da},"/",${year})) ;;
    timeframes: [date, raw]
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

# If necessary, uncomment the line below to include explore_source.
# include: "gsod-testing.model.lkml"
