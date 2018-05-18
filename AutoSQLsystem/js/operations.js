function output()
{
    var i;
    var show = "select ";
    if(attribute == "all")
    {
        show += " * from";
    }
    else
    {
        for(i=0;i<Sattr.length-1;i++)
        show = show + Sattr[i]+",";
        show = show + Sattr[i]+" from";
    }
    show += " " + table;
    var whereVal = document.whereFrm.whereVal.value;
    if(whereVal == "")
    {
        document.whereFrm.query.value = show;
        document.getElementById("error").innerHTML="Enter atribute value in above textbox to give where conditions";
    }
    else
    {
        var operators = [">","<",">=","<="];
        var whereOpr = document.whereFrm.whereOpr.value;
        var whereAtr = document.whereFrm.whereAtr.value;
        for(i=1;whereAtr!=attributes[i];i++);
        if(isNaN(whereVal))
        {
            if(types[i] == "number")
            {
                document.whereFrm.query.value = "";
                document.getElementById("error").style.display = "block";
                document.getElementById("error").innerHTML = "the type of the attribute is number which is not compatible with the entered string value";
            }
            else if(operators.indexOf(whereOpr)>-1)
            {
                document.whereFrm.query.value = "";
                document.getElementById("error").style.display = "block";
                document.getElementById("error").innerHTML = "This kind of operator is not suitable with the value and attribute";
            }
            else
            {
                show += " where "+whereAtr+whereOpr+"\'"+whereVal+"\'";
                document.whereFrm.query.value=show;
                document.getElementById("error").style.display = "none";
            }
        }
        else
        {
            if(types[i] == "number")
            {
                show += " where "+whereAtr+whereOpr+whereVal;
                document.whereFrm.query.value=show;   
                document.getElementById("error").style.display = "none";
            }
            else if(types[i] == "varchar")
            {
                show += " where "+whereAtr+whereOpr+"\'"+whereVal+"\'";
                document.whereFrm.query.value=show;
                document.getElementById("error").style.display = "none";
            }
        }
        /*else
        {
            document.getElementById("error").style.display = "none";
        }*/
    }
}