SELECT jsonb_build_object(
    'type',     'FeatureCollection',
    'features', jsonb_agg(features.feature)
) FROM (
  SELECT jsonb_build_object(
    'type',       'Feature',
    'id',         gid,
    'geometry',   ST_AsGeoJSON(ST_Transform(geom,4326))::jsonb,
    'properties', to_jsonb(inputs) - 'gid' - 'geom'
  ) AS feature
  FROM (SELECT * FROM $[table:raw]) inputs) features;