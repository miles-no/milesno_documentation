rm -rf "build"
structurizr-cli export -workspace src/milesno.dsl -format plantuml -output build/plantuml

for f in build/plantuml/*
do
  perl -i -l -p -e 'print "!pragma layout smetana" if $. == 2' "$f"
  mv "$f" "${f:0:15}${f:27}"
done

plantuml -tpng build/plantuml -o ../png
plantuml -tsvg build/plantuml -o ../svg

cp build/png/* doc/images/