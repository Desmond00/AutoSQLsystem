var AttributeNos = -1;




function fullCheck()
{
    if(tableCheck() == 1 && fieldsCheck() == 1 && columnNamesCheck() == 1)
        return true;
    else
        return false;
}

function tableCheck()
{
    var tableName = document.getElementById("tableName").value;
    if(tableName == '' || tableName == ' ')
        errorShow("tableNameError","Enter table name");
    else if(!isNaN(tableName))
        errorShow("tableNameError","Enter valid table name");
    else
        {
            var i;
            for(i=0;i<tableName.length;i++)
            {
                var charValue = tableName.charCodeAt(i);
                if(charValue < 65 || (charValue > 90 && charValue < 97) || charValue > 122)
                    {
                        errorShow("tableNameError","Enter valid table name");
                        break;
                    }
            }
            if(i == tableName.length)
            {
                document.getElementById("tableNameError").style.display = "none";
                return 1;
            }
        }
}

function fieldsCheck()
{
    var i=0;
    var name = "";
    var type = "";
    var ret = 1;
    for(i=1;i<=AttributeNos;i++)
    {
        name = document.getElementById("name"+i).value;
        type = document.getElementById("type"+i).value;
        //alert(name + type);
        ret = dataCheck(name, type, i);
        //alert(ret);
        if(ret == 0)
            break;
    }
    if(ret == 1)
        return 1;
}

function dataCheck(name,type,pos)
{
    var i;
    //checking for name of the data
    if(name == '' || name == ' ')
    {
        errorShow("dataError","Enter column"+pos+" name");
        return 0;
    }
    else if(!isNaN(name))
    {
        errorShow("dataError","Enter valid column"+pos+" name");
        return 0;
    }
    else
    {
        for(i=0;i<name.length;i++)
        {
            var charValue = name.charCodeAt(i);
            if(charValue < 65 || (charValue > 90 && charValue < 97) || charValue > 122)
                {
                    errorShow("dataError","Enter valid column"+pos+" name");
                    return 0;
                }
        }
        if(i == name.length)
        {
            //alert(i);
            document.getElementById("dataError").style.display = "none";
            
            //checking the type field of the data only if the name part of the data is errorFree
            if(type == '' || type == ' ')
                {
                    errorShow("dataError","Enter column"+pos+" type either number or varchar");
                    return 0;
                }
            else if(!isNaN(type))
                {
                    errorShow("dataError","Enter valid column"+pos+" type either number or varchar");
                    return 0;
                }
            else
                {
                    if(type == 'number' || type == 'varchar')
                    {
                        document.getElementById("dataError").style.display = "none";
                        return 1;
                    }
                    else
                    {
                        errorShow("dataError","Enter valid column"+pos+" type either number or varchar");
                        return 0;
                    }
                }
        }
    }

    //checking for type of the data    
    
}


function columnNamesCheck()
{
    //checks whether there is any identical column names or not
    var i,j, flag = 1;
    for(i=1;i<AttributeNos;i++)
    {
        for(j=i+1;j<=AttributeNos;j++)
        {
            if(document.getElementById("name"+i).value == document.getElementById("name"+j).value)
            {
                flag = 0;
                errorShow("dataError","column"+i+" & column"+j+" has similar names which can't be allowed ");
                break;
            }
            else
                flag = 1;
        }
        if(flag == 0)
            break;
    }
    if(flag == 1)
        return 1;
}

function errorShow(showID,printString)
{
    document.getElementById(showID).style.display = "block";
    printString = "<font class=reply>"+printString+"</font>";
    document.getElementById(showID).innerHTML = printString;
}