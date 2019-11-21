@html "<tr>" +
@html "<td> <label title=\"\(.input)\">\(.name)</label></td>" +
@html "<td> <label title=\"\(.input)\">\(.id)</label></td>" +
([.campaigns["a0L","d0L","e0L"] |
  . + {statusstr:
       (
        (if (.url and .status == "broken" or .status == "exhausted") then
           @html "<a class=\"badjob\" href=\"\(.url)\">"
         elif .url then
           @html "<a href=\"\(.url)\">"
         else @html "<a>" end) + (.status // " ") + @html"</a>"),
       cellbad: (if .status == "broken" then 0.3
                 elif .status == "exhausted" then 0.1
                 else 0 end),
       doneness: (.done * 0.01 ? // 0),
       dnum: (.done // " "),
       failedness: (.failed * 0.01 ? // 0),
       fnum: (.failed // " "),
       tip: (.channel + ", MC " + .campaign)} |
  @html "<td style=\"background-color:rgba(255,0,0,\(.cellbad))\"><label title=\"\(.tip)\">" + .statusstr + @html "</label></td>" +
  @html "<td style=\"background-color:rgba(0,255,0,\(.doneness))\">\(.dnum) </td>" +
  @html "<td style=\"background-color:rgba(255,0,0,\(.failedness));\"> \(.fnum) </td>"] | add) + @html "</tr>"
