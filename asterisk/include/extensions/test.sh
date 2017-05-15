#!/bin/bash
cat voicemail.conf | tail -n 2 | head -n 1 | cut -d',' -f1 | cut -d" " -f3
