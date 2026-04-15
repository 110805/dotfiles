#!/bin/sh
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

if [ -n "$model" ]; then
    printf "\033[0;36m%s\033[0m" "$model"
fi

if [ -n "$used" ]; then
    printf " \033[0;35mctx:%.0f%%\033[0m" "$used"
fi

if [ -n "$five_hour" ] || [ -n "$seven_day" ]; then
    printf " \033[0;33m["
    if [ -n "$five_hour" ]; then
        printf "5h:%.0f%%" "$five_hour"
    fi
    if [ -n "$five_hour" ] && [ -n "$seven_day" ]; then
        printf " "
    fi
    if [ -n "$seven_day" ]; then
        printf "7d:%.0f%%" "$seven_day"
    fi
    printf "]\033[0m"
fi

echo ""
