# diss-template

Template und Skript zum Generieren von PDF Dokumenten aus Pandoc Markdown Dateien. Das Bash-Skript konvertiert die Eingabedatei `index.md` (z. B. aus Ulysses exportiert) mittels Pandoc in eine TeX Datei. Dabei wird zusätzlich BibLaTeX und Pandoc Crossref eingsetzt und auf `diss-template.latex` zurückgegriffen. Danach wird eine PDF mit LuaLaTeX generiert. Neben automatischen Verwaltung der Zitation und Bibliografie werden Register (Sachregister und Personenregister) und ein Glossar erzeugt.
