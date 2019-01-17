@html "<tr>" +
@html "<td> <label title=\"\(.input)\">\(.name)</label></td>" +
([.campaigns["a0L","d0L","e0L","a1L","d1L","e1L","a2L","d2L","e2L"] |
  . + {statusstr:
       (
        (if .url then @html "<a href=\"\(.url)\">"
         else @html "<a>" end) + (.status // " ") + @html"</a>"),
       doneness: (.done * 0.01 ? // 0),
       dnum: (.done // " "),
       failedness: (.failed * 0.01 ? // 0),
       fnum: (.failed // " "),
       tip: (.channel + ", MC " + .campaign)} |
  @html "<td><label title=\"\(.tip)\">" + .statusstr + @html "</label></td>" +
  @html "<td style=\"background-color:rgba(0,255,0,\(.doneness))\">\(.dnum) </td>" +
  @html "<td style=\"background-color:rgba(255,0,0,\(.failedness));\"> \(.fnum) </td>"] | add) + @html "</tr>"
