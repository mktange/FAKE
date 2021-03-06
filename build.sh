#!/usr/bin/env bash

if test "$OS" = "Windows_NT"
then
  # use .Net

  .paket/paket.exe restore
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    exit $exit_code
  fi

  [ ! -e build.fsx ] && .paket/paket.exe update
  [ ! -e build.fsx ] && packages/build/FAKE/tools/FAKE.exe init.fsx
  packages/build/FAKE/tools/FAKE.exe $@ --fsiargs -d:MONO build.fsx
else  
  mono .paket/paket.exe restore
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    exit $exit_code
  fi

  [ ! -e build.fsx ] && mono .paket/paket.exe update
  [ ! -e build.fsx ] && mono packages/build/FAKE/tools/FAKE.exe init.fsx
  mono packages/build/FAKE/tools/FAKE.exe $@ --fsiargs -d:MONO build.fsx
fi
