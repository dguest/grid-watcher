#!/usr/bin/env bash

PATH=$(cat ~/.ADDPATH | paste -s -d :):${PATH}

TMP=bobo
OUT=bobo

if [[ ! -d $TMP ]] ; then mkdir $TMP ; fi

if [[ ! -f $TMP/rawpanda.json ]] ; then
    pandamon -u 'Andrea Matic' group.phys-exot*EXOT27 -j > $TMP/rawpanda.json
fi

cat ${TMP}/rawpanda.json | jq -f refiner.jq | tee $TMP/refined.json

OUTFILE=$OUT/mono-h-mc.html
cat <<EOF > $OUTFILE
<b>Last Update: $(date) </b>
<table>
EOF
cat $TMP/refined.json | jq -f formatter.jq -r >> $OUTFILE

echo "</table>" >> $OUTFILE
