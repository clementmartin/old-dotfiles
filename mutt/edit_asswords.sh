#!/bin/bash

gpg2 -d passwords.gpg > passwords && rm passwords.gpg &&
vim passwords &&
gpg2 -e -r D1DFF6E2 passwords && rm passwords
