#!/usr/bin/env bash
# shellcheck disable=SC2166
if [ -z "$ENVIRONMENT" -o "$ENVIRONMENT" == "local" ]
then
  uvicorn app:app --reload
else
  gunicorn app:app -c gunicorn.py
fi
