CREATE TABLE diu.traffic_data (
                              time TIMESTAMPTZ NOT NULL,
                              olr VARCHAR NOT NULL,
                              name VARCHAR,
                              length INT,
                              shape JSONB,
                              speed DECIMAL,
                              speedUncapped DECIMAL,
                              freeFlow DECIMAL,
                              jamFactor DECIMAL,
                              confidence DECIMAL,
                              traversability VARCHAR,
                              subSegments JSONB
);

CREATE INDEX idx_olr_shape ON diu.traffic_data (olr, left(shape::text, 100));

CREATE TABLE diu.weather_observations (
                                      time TIMESTAMPTZ NOT NULL,
                                      countrycode VARCHAR NOT NULL,
                                      countryname VARCHAR NOT NULL,
                                      state VARCHAR,
                                      city VARCHAR NOT NULL,
                                      location JSONB,
                                      distance DECIMAL,
                                      daylight VARCHAR,
                                      description VARCHAR,
                                      skyinfo INT,
                                      skydesc VARCHAR,
                                      temperature INT,
                                      temperaturedesc VARCHAR,
                                      comfort DECIMAL,
                                      hightemperature DECIMAL,
                                      lowtemperature DECIMAL,
                                      humidity INT,
                                      dewpoint INT,
                                      precipitationprobability INT,
                                      rainfall DECIMAL,
                                      windspeed DECIMAL,
                                      winddirection INT,
                                      winddesc VARCHAR,
                                      winddescshort VARCHAR,
                                      uvindex INT,
                                      uvdesc VARCHAR,
                                      barometerpressure DECIMAL,
                                      barometertrend VARCHAR,
                                      iconid INT,
                                      iconname VARCHAR,
                                      iconlink VARCHAR,
                                      ageminutes INT,
                                      activealerts INT
);

CREATE TABLE diu.weather_alerts (
                                time TIMESTAMPTZ NOT NULL,
                                countrycode VARCHAR NOT NULL,
                                countryname VARCHAR NOT NULL,
                                state VARCHAR,
                                city VARCHAR NOT NULL,
                                location JSONB,
                                timesegments JSONB,
                                type INT
);

CREATE TABLE diu.weather_astronomy_forecasts (
                                             time TIMESTAMPTZ NOT NULL,
                                             countrycode VARCHAR NOT NULL,
                                             countryname VARCHAR NOT NULL,
                                             state VARCHAR,
                                             city VARCHAR NOT NULL,
                                             location JSONB,
                                             forecasts JSONB
);

CREATE TABLE diu.traffic_regional_cluster (
                                              olr VARCHAR NOT NULL,
                                              centroid_longitude DECIMAL,
                                              centroid_latitude DECIMAL,
                                              cluster INT,
                                              shape JSONB
);

CREATE TABLE diu.traffic_incidents (
                                       time TIMESTAMPTZ NOT NULL,
                                       olr VARCHAR,
                                       length INT,
                                       shape JSONB,
                                       id VARCHAR,
                                       hrn VARCHAR,
                                       originalid VARCHAR,
                                       originalhrn VARCHAR,
                                       starttime TIMESTAMPTZ,
                                       endtime TIMESTAMPTZ,
                                       entrytime TIMESTAMPTZ,
                                       roadcloased BOOLEAN,
                                       criticality VARCHAR,
                                       type VARCHAR,
                                       codes JSONB,
                                       description VARCHAR,
                                       summary VARCHAR,
                                       junctiontraversability VARCHAR,
                                       vehiclerestrictions JSONB
);

CREATE TABLE diu.tmp_coordinates (
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION
);

INSERT INTO diu.tmp_coordinates (lat, lng)
VALUES
    (52.126933, 8.6851887),
    (51.9080392, 8.3882146);

CREATE USER grafanareader WITH PASSWORD '';

GRANT USAGE ON SCHEMA diu TO grafanareader;
GRANT SELECT ON diu.tmp_coordinates TO grafanareader;
GRANT SELECT ON diu.traffic_data TO grafanareader;
GRANT SELECT ON diu.traffic_incidents TO grafanareader;
GRANT SELECT ON diu.traffic_regional_cluster TO grafanareader;
GRANT SELECT ON diu.weather_astronomy_forecasts TO grafanareader;
GRANT SELECT ON diu.weather_observations TO grafanareader;
GRANT SELECT ON diu.weather_alerts TO grafanareader;
ALTER ROLE grafanareader SET search_path = 'diu';

