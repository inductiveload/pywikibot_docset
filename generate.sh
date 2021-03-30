#! /usr/bin/env bash
#
set -e
set -x

VENV_DIR=venv

if [[ "$VIRTUAL_ENV" == "" ]]
then

    if [ ! -d "$VENV_DIR" ]
    then
        echo "Creating virtual environment in $VENV_DIR"
        python3 -m venv "$VENV_DIR"
    fi

    echo "Entering virtual env: $VENV_DIR"
    source "$VENV_DIR/bin/activate"
    pip install -r requirements.txt
fi

BRANCH=${1:-stable}

REPO="https://gerrit.wikimedia.org/r/pywikibot/core.git"
LOCALREPO="pywikibot-core"
DOCSET_NAME=Pywikibot
DOCSET=${DOCSET_NAME}.docset

rm -rf $DOCSET

git clone "$REPO" "$LOCALREPO" 2> /dev/null || git -C "$LOCALREPO" pull

cd "$LOCALREPO"
git checkout "$BRANCH"
cd docs

cat ../../theme_options.py >> conf.py

make html

doc2dash -n "$DOCSET_NAME" -d "../.."  "_build/html" --index-page "_build/html/index.html"

cd ../..
cp icons/*.png $DOCSET