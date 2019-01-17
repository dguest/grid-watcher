#!/usr/bin/env bash

echo "started job on $(date)"

DR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

TP=/tmp/$(date +%F_%H-%M)
OUT=/afs/cern.ch/user/d/dguest/www/monitoring/
if [[ ! -d $OUT ]]; then
    OUT=temp/
fi

PMON=$DR/pandamonium/pandamon
JQ=$DR/bin/jq

if [[ ! -f $JQ ]] ; then
    JQ_URL=https://github.com/stedolan/jq/releases/download/jq-1.6/
    JQ_VERS=jq-linux64
    echo "getting jq"
    wget ${JQ_URL}/${JQ_VERS}
    mkdir -p $DR/bin
    mv ${JQ_VERS} $JQ
    chmod +x $JQ
fi

# check JQ
if ! $JQ --version &> /dev/null; then
    # try local version
    if type jq &> /dev/null; then
        JQ=jq
    else
        echo "JQ not working" >&2
        exit 1
    fi
fi

PY=~dguest/public/Python2.7/bin/python2.7
if [[ -f $PY ]]; then
    echo "using hardcoded python"
    PMON="$PY $PMON";
fi

if [[ ! -d $TP ]] ; then mkdir $TP ; fi

if [[ ! -f $TP/rawpanda.json ]] ; then
    echo "run pandamon from $DR"
    $PMON -u 'Andrea Matic' group.phys-exot*EXOT27 -j > $TP/rawpanda.json
fi

echo "refine output"
cat ${TP}/rawpanda.json | $JQ -f $DR/refiner.jq > $TP/refined.json


echo "format output"
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

.badjob {
  font-weight:bold;
}

td {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

th {
  border: 2px solid #aaaaaa;
}

td:nth-child(3n+1) {
  border-right: 2px solid #aaaaaa;
}

tr:nth-child(even) {
  background-color: #00ffff11;
}
</style>
</head>
<body>
<b>Powered by <a href="https://github.com/dguest/grid-watcher">grid-watcher</a>. Last Update: $(date) </b>
<table>
<th>name</th><th colspan="3">a0L</th><th colspan="3">d0L</th><th colspan="3">e0L</th><th colspan="3">a1L</th><th colspan="3">d1L</th><th colspan="3">e1L</th><th colspan="3">a2L</th><th colspan="3">d2L</th><th colspan="3">e2L</th>
EOF
cat $TP/refined.json | $JQ -f $DR/formatter.jq -r >> $OUTFILE

cat <<EOF >> $OUTFILE
</table>
</body>
</html>
EOF

echo "done"
