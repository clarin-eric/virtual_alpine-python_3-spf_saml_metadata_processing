#!/bin/sh -ex

apk --verbose --progress update --purge
apk --verbose --progress upgrade --latest
apk --verbose --progress add --upgrade 'rsync' 'subversion' 'curl' 'libxml2-dev' 'libxslt-dev' 'libxml2' 'libxslt' 'build-base=0.4-r0' 'yaml' 'yaml-dev' 'python' 'python-dev' 'python3' 'python3-dev'
# 'python3-dev=3.4.3-r2' 'libxml2-dev=2.9.2-r1' 'libxslt-dev=1.1.28-r1' 'build-base=0.4-r0' 'python3-dev=3.4.3-r2'
# TODO: specify package version numbers
# TODO: add xmlsec

# pyvenv '/opt/Python/SPF_SAML_metadata_processing/'
# pyvenv '/opt/Python/pyff/'
stat '/tmp/SPF_SAML_metadata_processor-1.0.dev0.tar.gz'

# . '/opt/Python/SPF_SAML_metadata_processing/bin/activate'
pip3 --no-cache-dir --isolated install '/tmp/SPF_SAML_metadata_processor-1.0.dev0.tar.gz'
rm '/tmp/SPF_SAML_metadata_processor-1.0.dev0.tar.gz'

python -m 'ensurepip' --upgrade
pip --no-cache-dir --isolated install --upgrade 'setuptools' 'pip'
pip --no-cache-dir --isolated install 'pyff'
# deactivate

# . '/opt/Python/pyff/bin/activate'
# pip3 --no-cache-dir --isolated install 'pyff'
# deactivate

apk --verbose --progress del 'libxml2-dev' 'libxslt-dev' 'build-base' 'yaml-dev' 'python-dev' 'python3-dev'
apk cache --purge clean

mkdir -p '/srv/www/infra.clarin.eu/aai/'
# TODO: permissions, ownership