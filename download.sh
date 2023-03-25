#!/bin/bash

# Create temporary folder for language files
mkdir -p locales

# Download translated files from Localazy
localazy download

# Process all JSON files in locales folder
cd locales
for file in *.json; do
langCode="${file%.*}"

echo "Processing ${langCode}..."

docker run --rm --name psql -i --network host -v $(pwd):/pg-localazy postgres psql --host localhost --user postgres -t -d localazy_test << EOF

-- Set the content from file
\\set content \`cat /pg-localazy/${file}\`

-- Upsert data to database from the loaded JSON file
INSERT INTO translations(id, locale, content) SELECT key AS id, '${langCode}' AS locale, value AS content FROM json_each(:'content'::json)
ON CONFLICT(id, locale) DO UPDATE SET content = excluded.content WHERE translations.content != excluded.content;

EOF

done

# Remove the temporary folder
cd ..
rm -Rf locales
