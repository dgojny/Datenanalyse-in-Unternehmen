--- Zeitbasierte Features --- Fehlt: Tageszeiten (Morgens, Mittags, Abends, Nachts)
ALTER TABLE diu.traffic_data ADD COLUMN day_of_week INT;
ALTER TABLE diu.traffic_data ADD COLUMN is_peak_hour BOOLEAN;

UPDATE diu.traffic_data
SET day_of_week = EXTRACT(DOW FROM time),
    is_peak_hour = CASE
       WHEN EXTRACT(HOUR FROM time) BETWEEN 7 AND 9 OR
            EXTRACT(HOUR FROM time) BETWEEN 17 AND 19 THEN TRUE
       ELSE FALSE
    END
WHERE day_of_week IS NULL OR is_peak_hour IS NULL;

--- Räumliche Features ---
ALTER TABLE diu.traffic_data ADD COLUMN time_to_traverse DECIMAL;

UPDATE diu.traffic_data
SET time_to_traverse = length / NULLIF(speed, 0)
WHERE time_to_traverse IS NULL;

--- Verkehrsbezogene Features --- Fehlt: Stauindikator
ALTER TABLE diu.traffic_data ADD COLUMN congestion_level VARCHAR;

UPDATE diu.traffic_data
SET congestion_level = CASE
       WHEN speed / NULLIF(freeFlow, 0) < 0.5 THEN 'High'
       WHEN speed / NULLIF(freeFlow, 0) BETWEEN 0.5 AND 0.8 THEN 'Moderate'
       ELSE 'Low'
    END
WHERE congestion_level IS NULL;

--- Anomalie-Erkennung ---
ALTER TABLE diu.traffic_data ADD COLUMN is_anomaly BOOLEAN;

UPDATE diu.traffic_data
SET is_anomaly = CASE
         WHEN speed < (SELECT AVG(speed) FROM diu.traffic_data) * 0.5 THEN TRUE
         ELSE FALSE
    END
WHERE is_anomaly IS NULL;
