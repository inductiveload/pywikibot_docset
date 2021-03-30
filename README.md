# Docset for Pywikibot

Upstream docs: https://doc.wikimedia.org/pywikibot


## Set up a virtualenv (if needed)

This is done automatically if you are not in a virtualenv when you run the
`generate.sh` script.

```
cd pywikibot_docset_gen
python -m venv ./venv
source ./venv/bin/activate
pip install -r requirements.txt
```

## Generate the docset

Choose a branch (`master` or `stable`)

```
./generate.sh stable
```