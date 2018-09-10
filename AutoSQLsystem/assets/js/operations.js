window.onload = function() {
    updateFieldValue();
  };

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
        if(types[i] == "date" || types[i] == "DATE" ) {
            show += " where "+whereAtr+whereOpr+"to_date(\'"+whereVal+"\',\'YYYY-MM-DD\')";
            console.log(show);
            document.whereFrm.query.value=show;
            document.getElementById("error").style.display = "none";
        }
        else if(isNaN(whereVal))
        {
            if(types[i] == "number" || types[i] == "NUMBER")
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
            if(types[i] == "number" || types[i] == "NUMBER")
            {
                show += " where "+whereAtr+whereOpr+whereVal;
                document.whereFrm.query.value=show;   
                document.getElementById("error").style.display = "none";
            }
            else if(types[i] == "varchar" || types[i] == "VARCHAR2")
            {
                show += " where "+whereAtr+whereOpr+"\'"+whereVal+"\'";
                document.whereFrm.query.value=show;
                document.getElementById("error").style.display = "none";
            }
        }
    }
    getResult();
}


function updateFieldValue() {
    var whereAtr = document.whereFrm.whereAtr.value;    
    for(i=1;whereAtr!=attributes[i];i++);
    console.log(types[i]);
    if(types[i] == "date" || types[i] == "DATE") {
        document.getElementById("ValueField").innerHTML = "<input type=date name=whereVal id=whereVal onchange=output() placeholder=\"Enter date to check\">";}
    else {
        document.getElementById("ValueField").innerHTML = "<input type=text name=whereVal id=whereVal placeholder=\"Enter value to check\">";}
}