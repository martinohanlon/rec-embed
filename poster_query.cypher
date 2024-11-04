MATCH (m:Movie{title: 'Babe'})

CALL db.index.vector.queryNodes('moviePosters', 6, m.posterEmbedding)
YIELD node, score

RETURN node.title, node.poster, score;