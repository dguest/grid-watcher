[.[] |
{
    "id": (.taskname | split(".")[3]),
    "name": (.taskname | split(".")[4]),
    "fullname": .taskname,
    "done": .dsinfo.pctfinished,
    "failed": .dsinfo.pctfailed,
    "input": [
            .datasets[] | select(.type == "input") | .containername][0],
    "sites": [.datasets[].site] | join(" "),
    "grouping": (.taskname | split(".") | .[5] = .[5][:-1] | join(".")),
    "revision": (.taskname | split(".")[5] | .[-1:]),
    "campaign": (.taskname | split(".")[5] | .[-2:-1])
}] |
    [.[] | . + {channel: (.grouping | split(".")[5] | .[:2])}] |
    group_by(.grouping) |
    [.[] | max_by(.revision)] |
    group_by(.id) |
    [.[] | {
        id: .[0].id,
        input: .[0].input,
        campaigns: [
                .[] | {(.campaign + .channel):{done,failed,revision}}
        ] | add,
    }
    ]
