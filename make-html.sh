#!/usr/bin/env bash

PATH=$(cat ~/.ADDPATH | paste -s -d :):${PATH}

TMP=bobo
OUT=bobo

if [[ ! -d $TMP ]] ; then mkdir $TMP ; fi

if [[ ! -f $TMP/rawpanda.json ]] ; then
    pandamon -u 'Andrea Matic' group.phys-exot*EXOT27 -j > $TMP/rawpanda.json
fi

cat ${TMP}/rawpanda.json | jq -f refiner.js | tee $TMP/refined.json

OUTFILE=$OUT/mono-h-mc.html
cat <<EOF > $OUTFILE
<b>Last Update: $(date) </b>
<table>
EOF
cat $TMP/refined.json | jq ' .[] | @html "<tr><th> \(.id) </label><th><label title=\"\(.input)\"> \(.name) </label></th><th style=\"background-color:rgba(0,255,0,\(.done/100))\"> \(.done) </th><th style=\"background-color:rgba(255,0,0,\(.failed/100));\"> \(.failed) </th><th>\(.sites)</th></tr>"' -r >> $OUTFILE

echo "</table>" >> $OUTFILE
