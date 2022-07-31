#!/bin/bash
echo "metrics_app running..."
metrics=$( make metrics )
echo $metrics_app

if grep -iq "Warning" <<< "$metrics"; then
    echo "* METRICS_APP_ERROR contain Warning***: $metrics"
    exit 1
fi

if grep -iq "Alarm" <<< "$metrics"; then
    echo "* METRICS_APP_ERROR contain Alarm***: $metrics"
    exit 1
fi

echo "* METRICS_APP_SUCCESS *"
