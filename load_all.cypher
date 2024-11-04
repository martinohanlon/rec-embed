// Loads the complete set of embeddings and creates the vector indexes

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/rec-embed/person-bio-embeddings.csv'
AS row
MATCH (p:Person {tmdbId: row.tmdbId})
CALL db.create.setNodeVectorProperty(p, 'bioEmbedding', apoc.convert.fromJsonList(row.bio_embedding));

LOAD CSV WITH HEADERS
FROM 'https://data.neo4j.com/rec-embed/movie-plot-embeddings.csv'
AS row
MATCH (m:Movie {movieId: row.movieId})
CALL db.create.setNodeVectorProperty(m, 'plotEmbedding', apoc.convert.fromJsonList(row.embedding));

LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/rec-embed/movie-poster-embeddings.csv" AS row
match (m:Movie {movieId:row.movieId})
WITH row,m
CALL db.create.setNodeVectorProperty(m, 'posterEmbedding', apoc.convert.fromJsonList(row.posterEmbedding));

CREATE VECTOR INDEX personBio IF NOT EXISTS
FOR (p:Person)
ON p.bioEmbedding
OPTIONS {indexConfig: {
 `vector.dimensions`: 1536,
 `vector.similarity_function`: 'cosine'
}};

CREATE VECTOR INDEX moviePlots IF NOT EXISTS
FOR (m:Movie)
ON m.plotEmbedding
OPTIONS {indexConfig: {
 `vector.dimensions`: 1536,
 `vector.similarity_function`: 'cosine'
}};

CREATE VECTOR INDEX moviePosters IF NOT EXISTS
FOR (m:Movie)
ON m.posterEmbedding
OPTIONS {indexConfig: {
 `vector.dimensions`: 512,
 `vector.similarity_function`: 'cosine'
}};
