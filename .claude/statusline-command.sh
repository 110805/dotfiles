#!/bin/sh
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

if [ -n "$model" ]; then
    printf "\033[0;36m%s\033[0m" "$model"
fi

if [ -n "$used" ]; then
    printf " \033[0;35mctx:%.0f%%\033[0m" "$used"
fi

if [ -n "$five_hour" ] || [ -n "$seven_day" ]; then
    printf " \033[0;33m["
    first=1
    if [ -n "$five_hour" ]; then
        printf "5h:%.0f%%" "$five_hour"
        if [ -n "$five_hour_reset" ]; then
            abs=$(date -d "@$five_hour_reset" +"%H:%M" 2>/dev/null)
            [ -n "$abs" ] && printf " | %s" "$abs"
        fi
        first=0
    fi
    if [ -n "$seven_day" ]; then
        [ "$first" -eq 0 ] && printf ", "
        printf "7d:%.0f%%" "$seven_day"
        if [ -n "$seven_day_reset" ]; then
            abs=$(date -d "@$seven_day_reset" +"%a" 2>/dev/null)
            [ -n "$abs" ] && printf " | %s" "$abs"
        fi
    fi
    printf "]\033[0m"
fi

echo ""
