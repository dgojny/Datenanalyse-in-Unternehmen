from dotenv import load_dotenv
import os
import numpy as np
import pandas as pd
from sqlalchemy import create_engine
from sklearn.cluster import DBSCAN
import matplotlib.pyplot as plt

load_dotenv()

db_url = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/postgres"
engine = create_engine(db_url)

sql_query = """
    SELECT DISTINCT olr, shape
    FROM diu.traffic_data;
"""
traffic_data = pd.read_sql(sql_query, engine)

def extract_points_from_shape(shape_json):
    points = []
    for segment in shape_json:
        for point in segment['points']:
            points.append((point['lng'], point['lat']))  # Reihenfolge: (lng, lat)
    return points

traffic_data['points'] = traffic_data['shape'].apply(lambda x: extract_points_from_shape(x))

all_points = []
for points in traffic_data['points']:
    all_points.extend(points)

points_df = pd.DataFrame(all_points, columns=['longitude', 'latitude'])

fig, ax = plt.subplots(figsize=(10, 10))
ax.scatter(points_df['longitude'], points_df['latitude'], color='red', s=5, label='Traffic Data')
plt.title('Verkehrsdaten mit Geometrie')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.legend()
plt.show()

coords_array = points_df[['longitude', 'latitude']].values

db = DBSCAN(eps=0.01, min_samples=5).fit(coords_array)

points_df['cluster'] = db.labels_

fig, ax = plt.subplots(figsize=(10, 10))

for cluster_id in np.unique(db.labels_):
    cluster_data = points_df[points_df['cluster'] == cluster_id]
    ax.scatter(cluster_data['longitude'], cluster_data['latitude'], label=f'Cluster {cluster_id}', s=5)

plt.title('Regionale Cluster und Verkehrsdaten')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.legend()
plt.show()
