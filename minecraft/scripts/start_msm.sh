#!/bin/bash

/bin/msm start

# Run cron
crontab -u minecraft /msm/crontab
cron -f
