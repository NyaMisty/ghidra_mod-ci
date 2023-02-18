#!/bin/bash

target="$1" 

  set -x
  gradle --version
  for i in {1..4}; do
    gradle -PcurrentPlatformName=$target --init-script gradle/support/fetchDependencies.gradle init && break
    rm -rf .gradle
    #ps -ef | grep gradle | xargs kill -9
    rm -rf dependencies
    if command -v taskkill >/dev/null; then
      (tasklist | grep -i '[g]radle' | awk '{print $2}' | xargs -n1 taskkill -f -pid) || true
    else
      (ps -ef | grep -i '[g]radle' | awk '{print $2}' | xargs -n1 kill -9) || true
    fi
  done

