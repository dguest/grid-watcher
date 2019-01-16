.[] | @html "<tr>
<th> <label title=\"\(.input)\">\(.id)</label></th>" +
    ([.campaigns["a0L","d0L","e0L","a1L","d1L","e1L","a2L","d2L","e2L"] | . // {done:"X", failed:"X"} | @html "<th style=\"background-color:rgba(0,255,0,\(.done * 0.01))\"> \(.done) </th>
<th style=\"background-color:rgba(255,0,0,\(.failed * 0.01));\"> \(.failed) </th>
"] | add) + @html "</tr>"
