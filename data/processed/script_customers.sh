#!/bin/bash

log_file="log.txt"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$log_file"
}

if [ ! -f customers_processed.csv ]; then
    log "Файл customers_processed.csv не найден."
    echo "Файл customers_processed.csv не найден."
    exit 1
fi

if [ $# -eq 0 ]; then
    log "Фильтр не указан."
    echo "Укажите хотя бы один фильтр, например: ./script_customers.sh Москва"
    exit 1
fi

for filter in "$@"; do

    count=$(grep -c "$filter" customers_processed.csv)

    if [ "$count" -ge 2 ]; then
        output_file="filtered_${filter}.csv"
        grep "$filter" customers_processed.csv > "$output_file"
        log "Фильтр: $filter, найдено: $count строк, файл: $output_file"
        echo "Фильтр '$filter': найдено $count строк. Сохранено в $output_file"
    else
        log "Фильтр: $filter — записей не найдено. Файл не создан."
        echo "Фильтр '$filter': записей не найдено. Пропущено."
    fi
done
