#!/bin/bash

. ../secondary_functions/secondary_functions.sh

function log_generator() {
    local response=(200 201 400 401 403 404 500 501 502 503)
    local method=("GET" "POST" "PUT" "PATCH" "DELETE")
    local URL=("google" "github" "vk" "domain" "seo")
    local protocol=("HTTP/1.0", "HTTP/1.1", "HTTP/2")
    local agent=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36" ,
                "Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201" ,
                "Opera/9.80 (X11; Linux i686; Ubuntu/14.10) Presto/2.12.388 Version/12.16.2",
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A",
                "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko",
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.19582",
                "Googlebot/2.1 (+http://www.googlebot.com/bot.html)", 
                "FyberSpider (+http://www.fybersearch.com/fyberspider.php)")
    for i in {1..5};
    do
        make_log "$i"nginx
        local note=$(( $RANDOM % 901 + 100 ))
        for (( j=1; j <=$note; j++))
        do
            echo -n "$(randomIP) - - " >> 0"$i"nginx.log
            echo -n "["$(date -d "$(( 6 - $i )) day ago + $j second" "+%d/%b/%Y:%H:%M:%S %z")"] \"" >> 0"$i"nginx.log
            echo -n "${method[$(randomMU)]} / ${protocol[$(randomA)]}\" " >> 0"$i"nginx.log
            echo -n "${response[$(randomR)]} 4797 \"-\" " >> 0"$i"nginx.log
            echo -n "\"https://${URL[$(randomMU)]}.com\" " >> 0"$i"nginx.log
            echo "\"${agent[$(randomA)]}\"" >> 0"$i"nginx.log
        done
    done
}

function randomIP() {
    local randIP
    for i in {1..4};
    do
        randIP+=$(( $RANDOM % 256 ))
        randIP+="."
    done
    echo ${randIP::${#randIP} - 1}
}

function randomR() { # R-response
    echo $(( $RANDOM % 10 ))
}

function randomMU() { # MD-method and url
    echo $(( $RANDOM % 5 ))
}

function randomA() { # A-agent
    echo $(( $RANDOM % 8 ))
}

function randomP() {
    echo $(( $RANDOM % 3 ))
}

# Коды ответа
# 2xx - success
# 200(OK) - успешное выполнение запроса.
# 201(Create) - сервер выполнил запрос и создал новый ресурс.
# 4xx - client error
# 400(Bad request) - клиент отправил неверный запрос
# 401(Unauthorized) - неверная авторизация либо ауентификация от клиента
# 403(Forbidden) - запрос ресурса от клиента на который нет прав для просмотра
# 404(Not found) - запрашиваемая страница/URL - не найдены
# 5xx - server error
# 500(Iternal server error) - внутренняя проблема сервера, когда он не может обработать запрос
# 501(Not implemented) - метод запроса не поддерживается сервером
# 502(Bad gateway) - nginx сервер обработал запрос от клиента, передал его apache, а apache не смог его обработать
# 503(Service unavailable) - ресурс временно недоступен (>15 подключение одновременно с разных IP или >10 с одного IP)
