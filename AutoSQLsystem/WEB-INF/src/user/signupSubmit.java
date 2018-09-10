package user;
import connect.*;
import java.sql.*;

public class signupSubmit {
	String email,pass,name,phno;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhno() {
		return phno;
	}
	public void setPhno(String phno) {
		this.phno = phno;
	}
	
	public int confirm()
	{
		//PrintWriter pw = res.getWriter();
        int t=0;
        try{
			System.out.println("here");
			System.out.println(this.phno);
        	long phno = Long.parseLong(this.phno);
        	System.out.println("after conversion");
            Connect ob = new Connect();
            Connection con = ob.c();
            PreparedStatement ps = con.prepareStatement("insert into sqlusers values(?,?,?,?)");
            ps.setString(1,this.email);
            ps.setString(2,this.pass);
            ps.setString(3,this.name);
            ps.setLong(4,phno);
            t = ps.executeUpdate();
            con.close();
        }
        catch(Exception e){
        	//pw.println(e);
        	System.out.println(e);
        }
        return t;
	}
}
