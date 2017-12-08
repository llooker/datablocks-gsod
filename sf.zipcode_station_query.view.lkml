## The Haversine formula applied to calculate the zipcode distance from the nearest Station can be found here.

## Note, the Haversine formula includes a CROSS JOIN across two large datasets.
## In order to minimize the size of the query run, we make a few assumptions about the distance between a particular zipcode and a station.


view: state_year {
  derived_table: {
    sql_trigger_value: select count(*) ;;
    sql:
      SELECT distinct year, state
              FROM GSOD.GSOD
              CROSS JOIN (
              select state
                from GSOD.ZIPCODE
                group by 1
              )
               ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

}

## An ipython notebook can be found here:
view: sql_query_for_zipcode_station {
  derived_table: {
    sql:
    CREATE TEMP FUNCTION RADIANS(x FLOAT64) AS (
        ACOS(-1) * x / 180
      );

      CREATE TEMP FUNCTION DEGREES(x FLOAT64) AS (
        180 * x / ACOS(-1)
      );

    SELECT
      zip_code, year, nearest_station_id, min(distance_in_km) as distance_from_nearest_station
      FROM (
      SELECT *
      , first_value(station_id) OVER (PARTITION BY zip_code, year ORDER BY distance_in_km asc) AS nearest_station_id
      from (
      SELECT zip_code
              , (CASE WHEN wban = '99999' THEN usaf ELSE wban END) as station_id
              , year
              , stations.name
              , stations.begin as begin_date
              , stations.`end` as end_date
              , City, lat, lon
              , 111.045* DEGREES(ACOS(COS(RADIANS(latpoint))
                         * COS(RADIANS(lat))
                         * COS(RADIANS(longpoint) - RADIANS(lon))
                         + SIN(RADIANS(latpoint))
                         * SIN(RADIANS(lat)))) AS distance_in_km

         FROM GSOD.STATIONS as stations
         CROSS JOIN (
          SELECT  latitude  AS latpoint,  longitude AS longpoint, zip_code,
            City,
            ({0}) as year,
            100.0 AS radius,
            111.045 AS distance_unit
            from GSOD.ZIPCODE
            -- where zip_code in (11211, 20171, 20170, 10009)
             where State in ('{1}')
            and latitude is not null
         ) AS p

           WHERE
           lat
             BETWEEN p.latpoint  - (p.radius / p.distance_unit)
                 AND p.latpoint  + (p.radius / p.distance_unit)
            AND lon
             BETWEEN p.longpoint - (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
                 AND p.longpoint + (p.radius / (p.distance_unit * COS(RADIANS(p.latpoint))))
            AND TO_DATE(cast(p.year as string), '%Y') between TO_DATE(begin, '%Y%m%d') and TO_DATE(`end`, '%Y%m%d')

         order by zip_code, distance_in_km asc
         )
      )
      group by 1, 2, 3
      order by zip_code, year
;;
  }
}
