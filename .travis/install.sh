#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true
    
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    pyenv install 2.7.10
    pyenv virtualenv 2.7.10 conan
    pyenv rehash
    pyenv activate conan
    pip install conan
else
    pip install --user conan
fi

gem install bundler --no-document
if [ "${COVERAGE}" == '1' ] ; then export PATH=$HOME/.local/bin:$PATH && pip install --user urllib3[secure] cpp-coveralls ; fi
