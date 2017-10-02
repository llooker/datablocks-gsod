# DDL Statements

Use the following DDL statements as a reference and starting point for uploading our datasets into your own DB.

Note: *Our DDL statments follow redshift syntax. You may need to adjust data types and other fields as necessary for your dialect.*


```
CREATE external table datablocks_spectrum.zipcode(
   zip_code  INTEGER
  ,latitude  FLOAT
  ,longitude FLOAT
  ,city      VARCHAR(50)
  ,state     VARCHAR(2)
  ,county    VARCHAR(50)
)
row format delimited
fields terminated by ','
stored as textfile
location 's3://looker-datablocks/gsod/zipcode/';
```

```
CREATE external table datablocks_spectrum.zipcode_station(
   zip_code                      INTEGER
  ,year                          INTEGER
  ,nearest_station_id            INTEGER
  ,distance_from_nearest_station NUMERIC(13,10)
)
row format delimited
fields terminated by ','
stored as textfile
location 's3://looker-datablocks/gsod/zipcode_station/';
```

```
CREATE external table datablocks_spectrum.zcta_county_map(
   zcta5         varchar(50)
  ,state         varchar(2)
  ,county        varchar(3)
  ,geoid         varchar(5)
  ,poppt         INTEGER
  ,hupt          INTEGER
  ,areapt        INTEGER
  ,arealandpt    INTEGER
  ,zpop          INTEGER
  ,zhu           INTEGER
  ,zarea         INTEGER
  ,zarealand     INTEGER
  ,copop         INTEGER
  ,cohu          INTEGER
  ,coarea        INTEGER
  ,coarealand    INTEGER
  ,zpoppct       NUMERIC(4,1)
  ,zhupct        NUMERIC(5,2)
  ,zareapct      NUMERIC(5,2)
  ,zarealandpct  NUMERIC(5,2)
  ,copoppct      NUMERIC(4,2)
  ,cohupct       NUMERIC(4,2)
  ,coareapct     NUMERIC(4,2)
  ,coarealandpct NUMERIC(4,2)
)
row format delimited
fields terminated by ','
stored as textfile
location 's3://looker-datablocks/gsod/zcta_county_map/';
```

```
CREATE external table datablocks_spectrum.stations(
   usaf    INTEGER
  ,wban    INTEGER
  ,name    VARCHAR(30)
  ,country VARCHAR(2)
  ,fips VARCHAR(2)
  ,state   VARCHAR(2)
  ,call    VARCHAR(30)
  ,lat     FLOAT
  ,lon     FLOAT
  ,elev    NUMERIC(7,1)
  ,begin   DATETIME
  ,"end"     DATETIME
)
row format delimited
fields terminated by ','
stored as textfile
location 's3://looker-datablocks/gsod/stations/';
```

```
CREATE external table datablocks_spectrum.gsod(
stn FLOAT,
wban FLOAT,
year FLOAT,
mo FLOAT,
da FLOAT,
temp numeric(4,2),
count_temp FLOAT,
dewp numeric(4,2),
count_dewp FLOAT,
slp numeric(4,2),
count_slp FLOAT,
stp numeric(4,2),
count_stp FLOAT,
visib numeric(4,2),
count_visib FLOAT,
wdsp numeric(4,2),
count_wdsp FLOAT,
mxpsd numeric(4,2),
gust numeric(4,2),
max numeric(4,2),
flag_max VARCHAR(50),
min numeric(4,2),
flag_min VARCHAR(50),
prcp numeric(4,2),
flag_prcp VARCHAR(50),
sndp numeric(4,2),
fog FLOAT,
rain_drizzle FLOAT,
snow_ice_pellets FLOAT,
hail FLOAT,
thunder FLOAT,
tornado_funnel_cloud FLOAT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
stored as textfile
location 's3://looker-datablocks/weather/gsod/'
```
