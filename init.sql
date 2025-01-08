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

CREATE TABLE diu.environment_variables (
    key VARCHAR NOT NULL,
    value JSONB NOT NULL
);

CREATE TABLE diu.analytics_general_stats (
                                             olr VARCHAR NOT NULL,
                                             avg_speed DOUBLE PRECISION,
                                             std_speed DOUBLE PRECISION,
                                             min_speed DOUBLE PRECISION,
                                             "25%_speed" DOUBLE PRECISION,
                                             med_speed DOUBLE PRECISION,
                                             "75%_speed" DOUBLE PRECISION,
                                             max_speed DOUBLE PRECISION,
                                             avg_speeduncapped DOUBLE PRECISION,
                                             std_speeduncapped DOUBLE PRECISION,
                                             min_speeduncapped DOUBLE PRECISION,
                                             "25%_speeduncapped" DOUBLE PRECISION,
                                             med_speeduncapped DOUBLE PRECISION,
                                             "75%_speeduncapped" DOUBLE PRECISION,
                                             max_speeduncapped DOUBLE PRECISION,
                                             avg_freeflow DOUBLE PRECISION,
                                             std_freeflow DOUBLE PRECISION,
                                             min_freeflow DOUBLE PRECISION,
                                             "25%_freeflow" DOUBLE PRECISION,
                                             med_freeflow DOUBLE PRECISION,
                                             "75%_freeflow" DOUBLE PRECISION,
                                             max_freeflow DOUBLE PRECISION,
                                             avg_jamfactor DOUBLE PRECISION,
                                             std_jamfactor DOUBLE PRECISION,
                                             min_jamfactor DOUBLE PRECISION,
                                             "25%_jamfactor" DOUBLE PRECISION,
                                             med_jamfactor DOUBLE PRECISION,
                                             "75%_jamfactor" DOUBLE PRECISION,
                                             max_jamfactor DOUBLE PRECISION,
                                             avg_confidence DOUBLE PRECISION,
                                             std_confidence DOUBLE PRECISION,
                                             min_confidence DOUBLE PRECISION,
                                             "25%_confidence" DOUBLE PRECISION,
                                             med_confidence DOUBLE PRECISION,
                                             "75%_confidence" DOUBLE PRECISION,
                                             max_confidence DOUBLE PRECISION,
                                             avg_time_to_traverse DOUBLE PRECISION,
                                             std_time_to_traverse DOUBLE PRECISION,
                                             min_time_to_traverse DOUBLE PRECISION,
                                             "25%_time_to_traverse" DOUBLE PRECISION,
                                             med_time_to_traverse DOUBLE PRECISION,
                                             "75%_time_to_traverse" DOUBLE PRECISION,
                                             max_time_to_traverse DOUBLE PRECISION
);

CREATE TABLE diu.traffic_patters_cluster (
                                              olr VARCHAR NOT NULL,
                                              cluster INT,
                                              shape JSONB,
                                              method VARCHAR
);

INSERT INTO diu.environment_variables (key, value)
VALUES
    ('GRAFANA_INIT_GEOMAPS', '[{"lat": 52.126933, "lng": 8.6851887}, {"lat": 51.9080392, "lng": 8.3882146}]'::JSONB);

CREATE USER grafanareader WITH PASSWORD '';

GRANT USAGE ON SCHEMA diu TO grafanareader;
GRANT SELECT ON diu.analytics_general_stats TO grafanareader;
GRANT SELECT ON diu.environment_variables TO grafanareader;
GRANT SELECT ON diu.traffic_data TO grafanareader;
GRANT SELECT ON diu.traffic_incidents TO grafanareader;
GRANT SELECT ON diu.traffic_regional_cluster TO grafanareader;
GRANT SELECT ON diu.traffic_patters_cluster TO grafanareader;
GRANT SELECT ON diu.weather_astronomy_forecasts TO grafanareader;
GRANT SELECT ON diu.weather_observations TO grafanareader;
GRANT SELECT ON diu.weather_alerts TO grafanareader;
ALTER ROLE grafanareader SET search_path = 'diu';

