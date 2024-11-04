CREATE VECTOR INDEX personBio IF NOT EXISTS
FOR (p:Person)
ON p.bioEmbedding
OPTIONS {indexConfig: {
 `vector.dimensions`: 1536,
 `vector.similarity_function`: 'cosine'
}}
