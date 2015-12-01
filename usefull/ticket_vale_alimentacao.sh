#!/bin/bash

set -e
# altere essas variaveis para os numeros verdadeiros:
cartao_restaurante=6033422237938000
cartao_alimentacao=

tmpcookie=`mktemp`
tmpfile=`mktemp`
# agarra um cookie primeiro, que essa naba percisa pra funfar
wget --quiet http://www.ticket.com.br --keep-session-cookies --save-cookies $tmpcookie -O $tmpfile

if [ x$cartao_restaurante != x ]; then
    url="http://www.ticket.com.br/portal/portalcorporativo/dpages/service/consulteseusaldo/seeBalance.jsp?chkProduto=Ticket+Restaurante&txtNumeroCartao=${cartao_restaurante}&txtOperacao=saldo_agendamentos&cardNumber=&Consultar.x=23&Consultar.y=17"
    wget --quiet --load-cookies $tmpcookie $url -O - | sed 's/^.*Saldos(/Saldo Restaurante: /; s/);.*$//'
    echo
fi

# copy'n paste programming |o/
if [ x$cartao_alimentacao != x ]; then
    url="http://www.ticket.com.br/portal/portalcorporativo/dpages/service/consulteseusaldo/seeBalance.jsp?chkProduto=Ticket+Alimentacao&txtNumeroCartao=${cartao_alimentacao}&txtOperacao=saldo_agendamentos&cardNumber=&Consultar.x=23&Consultar.y=17"
    wget --quiet --load-cookies $tmpcookie $url -O - | sed 's/^.*Saldos(/Saldo Alimentacao: /; s/);.*$//'
    echo
fi

rm -f $tmpcookie $tmpfile
