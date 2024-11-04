CREATE VECTOR INDEX moviePosters IF NOT EXISTS
FOR (m:Movie)
ON m.posterEmbedding
OPTIONS {indexConfig: {
 `vector.dimensions`: 512,
 `vector.similarity_function`: 'cosine'
}}
