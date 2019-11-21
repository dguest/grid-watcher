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
  "grouping": (.taskname | split(".") | join(".")),
  "revision": 1,
  "campaign": (.taskname | split(".")[5] | .[4:5])
  }] |
# We also want to cluster by the channel, we only care about the later
# revisions for a given channel
[.[] | . + {channel: "0L"}] |
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

