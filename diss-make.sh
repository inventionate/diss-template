#!/bin/bash

# Dissertation setzen
# Copyright 2016 Fabian Mundt

# Pandoc ausführen
pandoc -s -S --bibliography bibliography.bib --biblatex --filter $HOME/.cabal/bin/pandoc-crossref index.md -M cref=TRUE -o zeit-raum-studium.tex --latex-engine=lualatex --template=diss-template

# Bilder fixieren
sed -i '' 's/begin{figure}\[htbp\]/begin{figure}\[H\]/g' zeit-raum-studium.tex

# Bilder ggf. drehen
sed -i '' '/rotate-start/ {
    N
    N
    s/rotate-start\n.*\n.*/begin{sidewaysfigure}[H]/g
    }' zeit-raum-studium.tex

sed -i '' '/end{figure}/ {
    N
    N
    /\rotate-end/ {
        N
        s/end{figure}\n.*\rotate-end/end{sidewaysfigure}/g
    }
}' zeit-raum-studium.tex

# Tabellen nicht trimmern
# sed -i '' 's/@{}//g' 'zeit-raum-studium.tex'

# Überprüfen, ob der gesamte Prozess ausgeführt werden soll (-a)
while getopts ":a" opt; do
  case $opt in
    a)
        # LuaLaTeX ausführen
        lualatex zeit-raum-studium.tex

        # Zitate setzen
        biber zeit-raum-studium.bcf

        # Index erstellen
        makeglossaries zeit-raum-studium

        # Index erstellen
        splitindex -M texindy zeit-raum-studium

        # Finales Dokument setzen (zweima, um die Verzeichnisse zu generieren)
        lualatex zeit-raum-studium.tex
        lualatex zeit-raum-studium.tex
        ;;
  esac
done

lualatex zeit-raum-studium.tex
