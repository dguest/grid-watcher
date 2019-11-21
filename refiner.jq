# first we extract the useful information from the file names
[.[] |
 {
  "id": (.taskname | split(".")[3]),
  "name": (.taskname | split(".")[4]),
  taskname, status,
  "done": .dsinfo.pctfinished,
  "failed": .dsinfo.pctfailed,
  "input": [
            .datasets[] | select(.type == "input") | .containername][0],
  "sites": [.datasets[] | select(.type == "output") | .site],
  "grouping": (.taskname | split(".") | .[5] = .[5][:7] | join(".")),
  "revision": (.taskname | split(".")[5] | .[0:4] | tonumber),
  "campaign": (.taskname | split(".")[5] | .[6:7])
  }] |
# We also want to cluster by the channel, we only care about the later
# revisions for a given channel
[.[] | . + {channel: (.grouping | split(".")[5] | .[:2])}] |
group_by(.grouping) |
[.[] | max_by(.revision)] |
# Now we form groups based on the dataset id
group_by(.id) |
.[] |
{
 id: .[0].id,
 name: .[0].name,
 input: .[0].input,
 campaigns:
 [
  .[] |
  {(.campaign + .channel):
   {
    done,failed,revision,status,sites,campaign,channel,
    url: @uri "https://bigpanda.cern.ch/tasks/?taskname=\(.taskname)",
    }}
  ] | add,
 }

