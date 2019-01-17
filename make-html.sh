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
<html>
<head>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #00ffff22;
}
</style>
</head>
<body>
<b>Last Update: $(date) </b>
<table>
<th>name</th><th colspan="3">a0L</th><th colspan="3">d0L</th><th colspan="3">e0L</th><th colspan="3">a1L</th><th colspan="3">d1L</th><th colspan="3">e1L</th><th colspan="3">a2L</th><th colspan="3">d2L</th><th colspan="3">e2L</th>
EOF
cat $TMP/refined.json | jq -f formatter.jq -r >> $OUTFILE

cat <<EOF >> $OUTFILE
</table>
</body>
</html>
EOF
