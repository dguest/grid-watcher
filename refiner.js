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
    "revision": (.taskname | split(".")[5] | split("")[-1]),
    "campaign": (.taskname | split(".")[5] | split("")[-2])
}] |
    group_by(.grouping) |
    [.[] | max_by(.revision)] |
    group_by(.id)
