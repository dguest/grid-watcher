.[] |
@html "<tr>" +
@html "<th> <label title=\"\(.input)\">\(.name)</label></th>" +
([.campaigns["a0L","d0L","e0L","a1L","d1L","e1L","a2L","d2L","e2L"] |
  . + {statusstr:
       (
        (if .url then @html "<a href=\"\(.url)\">"
         else @html "<a>" end) + (.status // " ") + @html"</a>"),
       doneness: (.done * 0.01 ? // 0),
       dnum: (.done // " "),
       failedness: (.failed * 0.01 ? // 0),
       fnum: (.failed // " ")} |
  @html "<th>" + .statusstr + @html "</th>" +
  @html "<th style=\"background-color:rgba(0,255,0,\(.doneness))\">\(.dnum) </th>" +
  @html "<th style=\"background-color:rgba(255,0,0,\(.failedness));\"> \(.fnum) </th>"] | add) + @html "</tr>"
