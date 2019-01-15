#!/usr/bin/env bash

PATH=$(cat ~/.ADDPATH | paste -s -d :):${PATH}

cat <(echo "<b>Last Update: " $(date) "</b>") \
    <(echo "<table>") \
    <(pandamon -u 'Andrea Matic' group.phys-exot*EXOT27 -j |\
          jq '[.[] | {"id": (.taskname | split(".")[3]), "name": (.taskname | split(".")[4]), "fullname": .taskname, "done": .dsinfo.pctfinished, "failed": .dsinfo.pctfailed, "input": [.datasets[] | select(.type == "input") | .containername][0]}]' |\
          jq ' .[] | @html "<tr><th> \(.id) </label><th><label title=\"\(.input)\"> \(.name) </label></th><th style=\"background-color:rgba(0,255,0,\(.done/100))\"> \(.done) </th><th style=\"background-color:rgba(255,0,0,\(.failed/100));\"> \(.failed) </th><th>\(.fullname)</th></tr>"' -r)\
    <(echo "</table>") > /afs/cern.ch/user/d/dguest/www/monitoring/mono-h-mc.html
