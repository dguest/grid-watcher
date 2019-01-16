.[] | @html "<tr>
<th> <label title=\"\(.input)\">\(.id)</label></th>" +
    ([.campaigns["a0L","d0L","e0L","a1L","d1L","e1L","a2L","d2L","e2L"] | @html "<th style=\"background-color:rgba(0,255,0,\(.done/100?))\"> \(.done) </th>
<th style=\"background-color:rgba(255,0,0,\(.failed/100?));\"> \(.failed) </th>
"] | add) + @html "</tr>"
