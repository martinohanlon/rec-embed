LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/rec-embed/person-bio-embeddings-1k.csv'
AS row
MATCH (p:Person {tmdbId: row.tmdbId})
CALL db.create.setNodeVectorProperty(p, 'bioEmbedding', apoc.convert.fromJsonList(row.bio_embedding))