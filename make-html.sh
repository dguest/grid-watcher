#!/usr/bin/env bash

cat <(echo "<table>") \
    <(pandamon -u 'Andrea Matic' group.phys-exot*EXOT27 -j |\
          jq '[.[] | {"name": (.taskname | split(".")[4]), "fullname": .taskname, "done": .dsinfo.pctfinished, "failed": .dsinfo.pctfailed, "input":.datasets[] | select(.type == "input") | .containername}]' |\
          jq ' .[] | @html "<tr><th><label title=\"\(.input)\"> \(.name) </label></th><th style=\"background-color:rgba(0,255,0,\(.done/100))\"> \(.done) </th><th style=\"background-color:rgba(255,0,0,\(.failed/100));\"> \(.failed) </th></tr>"' -r)\
    <(echo "</table>") > /afs/cern.ch/user/d/dguest/www/monitoring/mono-h-mc.html
