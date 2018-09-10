function showFields()
{
    var i=1;
    var n = document.getElementById("columns").value;
    AttributeNos = n;
    document.getElementById("heads").style.display = "block";
    var tableFirst = document.getElementById("heads").innerHTML = "";
    var tableFirst = document.getElementById("heads").innerHTML = "<tr><td>COLUMN NUMBER </td><td>COLUMN NAME </td><td>COLUMN TYPE</td></tr>";
    for(i=n;i>=1;i--)
    {
        var table = document.getElementById("heads");
        var row = table.insertRow(1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        cell1.innerHTML = ""+i;
        cell2.innerHTML = "<input type=text name=\"name"+i+"\" id=\"name"+i+"\">";
        cell3.innerHTML = "<div class=\"select\"><select name=\"type"+i+"\" id=\"type"+i+"\"><option value=varchar>VARCHAR</option><option value=number>NUMBER</option></select></div>";
    }
    document.getElementById("button").innerHTML = "<input type=submit value=uploadDetails>&nbsp<input type=reset value=resetDetails onClick=showFields()>";
}