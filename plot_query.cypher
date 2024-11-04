MATCH (m:Movie {title: 'Toy Story'})

CALL db.index.vector.queryNodes('moviePlots', 6, m.plotEmbedding)
YIELD node, score

RETURN node.title, node.plot, score