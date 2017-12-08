view: sf_stations {
  sql_table_name: GSOD.STATIONS ;;

  dimension: station_id {
    primary_key: yes
    type: string
    sql: CASE WHEN ${wban} = '99999' THEN ${usaf} ELSE ${wban} END;;
  }

  dimension: usaf {
    hidden: yes
    type: string
    sql: ${TABLE}.usaf ;;
  }

  dimension: wban {
    hidden: yes
    type: string
    sql: ${TABLE}.wban ;;
  }

  dimension_group: begin {
    type: time
    convert_tz: no
    timeframes: [year, month, date]
    sql: TO_DATE(${TABLE}.begin, '%Y%m%d') ;;
  }

  dimension_group: end {
    type: time
    timeframes: [year, month, date]
    convert_tz: no
    sql: TO_DATE(${TABLE}.`end`, '%Y%m%d') ;;
  }

  dimension: call {
    type: string
    sql: ${TABLE}.call ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: elev {
    type: string
    sql: ${TABLE}.elev ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.lon ;;
  }

  dimension: location {
    type: location
    sql_latitude:${latitude};;
    sql_longitude:${longitude};;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count_distinct_station {
    type: count_distinct
    sql: ${station_id} ;;
  }
}
