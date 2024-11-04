MATCH (p:Person{name: 'Lillian Gish'})

CALL db.index.vector.queryNodes('personBio', 6, p.bioEmbedding)
YIELD node, score

RETURN node.name, node.bio, score;