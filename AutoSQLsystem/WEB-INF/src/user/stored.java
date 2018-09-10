package user;
import connect.*;
import java.sql.*;


public class stored
{
    private String attributeNames[] = new String[100];
    private String attributeTypes[] = new String[100];
    private String tableName,email;
    private int AttributeNos;
    private int tableID;

    public void setAttributes(String names[])
    {
        System.arraycopy(names,0,attributeNames,0,names.length); 
    }

    public void setTypes(String types[])
    {
        System.arraycopy(types,0,attributeTypes,0,types.length);
    }

    public void setTableName(String tableName)
    {
        this.tableName = tableName;
    }

    public void setNos(int AttributeNos)
    {
        this.AttributeNos = AttributeNos;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String[] getAttributes()
    {
        return attributeNames;
    }

    public String[] getTypes()
    {
        return attributeTypes;
    }

    public int createTable()
    {
        try{
            int t;
            Connect ob = new Connect();
            Connection con = ob.c();
            System.out.println(this.email);
            if(listTable() == 1) {
            	PreparedStatement ps = con.prepareStatement("create table "+tableName+tableID+" (attributes varchar2(30), type varchar2(30))");
            	t = ps.executeUpdate();
            	System.out.println(t);
            	if(t == 0)
            	{
            		System.out.println("table created successfully");
            		return 1;
            	}
            	else
            	{
            		System.out.println("table creation error");        
            		return 0;
            	}            	
            }
            else {
            	System.out.println("listing of table was not successful");
            	return 0;
            }
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        return 0;
    }   

    private int listTable()throws SQLException
    {
        Connect ob = new Connect();
        Connection con = ob.c();
        PreparedStatement ps = con.prepareStatement("select max(tableid) from createdtables");
        ResultSet rs = ps.executeQuery();
        rs.next();
        tableID = rs.getInt(1)+1;
        PreparedStatement ps1 = con.prepareStatement("insert into createdtables values(?,?,?)");
        ps1.setInt(1,tableID);
        ps1.setString(2,email);
        ps1.setString(3,tableName);
        if(ps1.executeUpdate() > 0)
            return 1;
        else
            return 0;
    }

    public int insertIntoTable()
    {
        try
        {
            int flag = 1;
            Connect ob = new Connect();
            Connection con = ob.c();
            for(int i=1;i<=AttributeNos;i++)
            {
                System.out.println(i+"th row inserted");
                System.out.println(email);
                PreparedStatement ps = con.prepareStatement("insert into "+tableName+tableID+" values(?,?)");
                ps.setString(1, attributeNames[i]);
                ps.setString(2, attributeTypes[i]);
                if(!(ps.executeUpdate() > 0))
                {
                    flag = 0;
                    break;
                }
            }
            if(flag == 0)
                return 0;
            else if(flag == 1)
                return 1;
        }
        catch(Exception e)
        {
            System.out.println("Exception in insertIntoTable() " +e);
        }
        return 0;
    }
}