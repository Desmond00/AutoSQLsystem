var count=0;
function all1(obj) 
{
    if($(obj).is(":checked")){
        //alert("disabling");
        $("input[name='attribute']").prop("checked", false);
        $("input[name='attribute']").prop("disabled", true);
        count += 1;
    }
    else
    {
        $("input[name='attribute']").prop("disabled", false);
        count -= 1;
    }
}

function confirm()
{
    if(count > 0)
    {
        document.attributeForm.action="operations";
        return true;
    }
    else
    {
        document.getElementById("error").innerHTML = "<font class=\"reply\">@@FIRST SELECT THE ATTRIBUTES</font>";
        return false;
    }
}

function tap(obj)
{
    if($(obj).is(":checked"))
        count += 1;
    else
        count -=1;
}