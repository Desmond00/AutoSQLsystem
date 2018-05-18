package user;
import connect.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class signupSubmit {
	String email,pass,name;
	int phno;
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
	public int getPhno() {
		return phno;
	}
	public void setPhno(int phno) {
		this.phno = phno;
	}
	
	int confirm()
	{
        int t=0;
        try{
            Connect ob = new Connect();
            Connection con = ob.c();
            PreparedStatement ps = con.prepareStatement("insert into sqlusers values(?,?,?,?)");
            ps.setString(1,this.email);
            ps.setString(2,this.pass);
            ps.setString(3,this.name);
            ps.setInt(4,this.phno);
            t = ps.executeUpdate();
            con.close();
        }
        catch(Exception e){}
        return t;
	}
}
