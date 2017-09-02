mv .gitignore /tmp/gitignore
echo '*' > .gitignore

echo >> .gitignore
find . -maxdepth 1 -name ".*" -type f | sed -e 's|^\.\/||' | sort | sed -e 's|^|!|' >> .gitignore

echo >> .gitignore
find . -maxdepth 1 -type f | sed -e 's|^\.\/||' | egrep "^[^.]" | sort | sed -e 's|^|!|' >> .gitignore

for subdir in `ls -d .[^.]*/ | grep -v \.git`; do
    echo >> .gitignore
    find $subdir | sed -e 's|^.\/||' | sed -e 's|^|!|' >> .gitignore
done

for subdir in `ls -d [^.]*/`; do
    echo >> .gitignore
    find $subdir | grep -v \.git | sed -e 's|^.\/||' | sed -e 's|^|!|' >> .gitignore
done
