sed -e s/\\/lib\\/closure-library/\\/..\\/closure-library/g src/db/path_test.html
find ./ -name "*.html" -exec sed -i.bak -e  s/\\/lib\\/closure-library/\\/..\\/closure-library/g {} \;
find ./ -name "*.html" -exec sed -i.bak -e  s/\\/my-deps.js/\\/..\\/my-deps.js/g {} \;
