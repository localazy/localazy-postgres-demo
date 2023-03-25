#!/bin/bash

# Create temporary folder for language files
mkdir -p locales

# Run PSQL command, connect to the running PostgreSQL instance and issue SQL designed to
# return data of the table for English in key-value JSON format. 
docker run --rm --name psql --network host -v $(pwd):/pg-localazy postgres psql --host localhost --user postgres -t -d localazy_test -c "SELECT json_object_agg(translations.id  
, translations.content) FROM translations WHERE locale = 'en';" > locales/en.json

# Upload data to Localazy
localazy upload

# Remove the temporary folder
rm -Rf locales
