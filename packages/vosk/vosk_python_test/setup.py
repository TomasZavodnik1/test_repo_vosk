#!/usr/bin/env python3

from setuptools import setup, find_packages

setup(name='python-test',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages('.'),
      # Executables
      scripts=["test_simple.py"],
      setup_requires=[ 'vosk'],
      install_requires=[ 'vosk'],
     )
