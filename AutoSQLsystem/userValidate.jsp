<%
    String name = (String)session.getAttribute("user");
    if(name != null)
    {/*
    	String logo = "logo";
    	String user = "img/icon/user1.png";
    	String missing = "icon missing";*/
    	int i,n=1;
    	Cookie ob;
    	Cookie ck[] = request.getCookies();
    	if(ck != null)
    	{
    		for(i=0;i<ck.length;i++)
    		{
    			if(ck[i].getName().equals("count"))
    			{
    				n = Integer.parseInt(ck[i].getValue());
    				n += 1;
    				//out.println("<h3>Number of views : "+n);
        			ob = new Cookie("count",Integer.toString(n));
        			response.addCookie(ob);
        			break;	
    			}
    		}
    		if(i == ck.length)
    		{
    			//out.println("Number of views : "+n);
    			ob = new Cookie("count",Integer.toString(n));
    			response.addCookie(ob);
    		}
    	}
    	else
    	{
    		//out.println("<h3>Number of views : "+n);
    		ob = new Cookie("count",Integer.toString(n));
    		response.addCookie(ob);
    	}
    	//out.println(n);
		if(session.getAttribute("userImage") != null) {
			out.println("<a id=\"user\" class=\"button\"  href=\"user\"><img class=\"logo\" src=\""+session.getAttribute("userImage")+"\" alt=\"icon missing\" height=40 width=40 align=\"middle\">"+name+"</a>&nbsp&nbsp<a class=\"button\" id=\"logout\" href=\"logout\">Log out</a>&nbsp&nbsp"+
        		"<a class=\"button\" id=\"about\" href=\"about\">About</a>");
		}
		else
	        out.println("<a id=\"user\" class=\"button\"  href=\"user\"><img class=\"logo\" src=\"assets/img/icon/user.png\" alt=\"icon missing\" align=\"middle\">"+name+"</a>&nbsp&nbsp<a class=\"button\" id=\"logout\" href=\"logout\">Log out</a>&nbsp&nbsp"+
        		"<a class=\"button\" id=\"about\" href=\"about\">About</a>");
    }
    else
        out.println("none");
%>