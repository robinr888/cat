#!/bin/bash
app_port=${APP_PORT:-8000 }
gunicorn --bind 0.0.0.0:$app_port wsgi:app