include Ontology


CLASSES = {}
hash = Ontology.query(" PREFIX book: <http://www.owl-ontologies.com/book.owl#>
                        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                        SELECT ?class ?label
                        WHERE { ?class a rdfs:Class .
                                ?class rdfs:label ?label
                                FILTER NOT EXISTS { ?class rdfs:subClassOf book:Format }
                              }
                      ")
hash['results']['bindings'].each do |resource|
  key = resource['label']['value'].downcase
  value = resource['class']['value']
  CLASSES[key] = value
end


FORMATS = {}
hash = Ontology.query(" PREFIX book: <http://www.owl-ontologies.com/book.owl#>
                        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                        SELECT ?class ?label
                        WHERE { ?class rdfs:subClassOf book:Format .
                                ?class rdfs:label ?label
                              }
                      ")
hash['results']['bindings'].each do |resource|
  key = resource['label']['value'].downcase
  value = resource['class']['value']
  FORMATS[key] = value
end


PROPERTIES = {}
hash = Ontology.query(" PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                        PREFIX owl: <http://www.w3.org/2002/07/owl#>
                        SELECT ?property ?label
                        WHERE { ?property a owl:ObjectProperty .
                                ?property rdfs:label ?label
                              }
                      ")
hash['results']['bindings'].each do |resource|
  key = resource['label']['value'].downcase
  value = resource['property']['value']
  PROPERTIES[key] = value
end


MODELS = {
  "http://www.owl-ontologies.com/book.owl#Author" => Author,
  "http://www.owl-ontologies.com/book.owl#Book" => Book,
  "http://www.owl-ontologies.com/book.owl#Edition" => Edition,
  "http://www.owl-ontologies.com/book.owl#Award" => Award,
  "http://www.owl-ontologies.com/book.owl#Publisher" => Publisher
}
