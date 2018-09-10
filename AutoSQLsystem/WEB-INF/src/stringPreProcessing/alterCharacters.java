package stringPreProcessing;
import java.util.regex.Pattern;
import java.util.regex.Matcher;;
public class alterCharacters {
	
	
	public String removeSpecialCharactersFromFirst(String str) {
		Pattern p = Pattern.compile("\\p{L}");
		Matcher m = p.matcher(str);
		if (m.find()) {
		    str = str.substring(m.start(), str.length());
		}
		return str;
	}
	
	public String modifyForUpload(String fileName) {
 	   fileName = fileName.substring(0, fileName.lastIndexOf(".")).replaceAll("[ .-]","_")+fileName.substring(fileName.lastIndexOf("."), fileName.length());
 	   fileName = this.removeSpecialCharactersFromFirst(fileName);
 	   return fileName;
	}
	
	public static boolean isNumeric(String str)  
	{  
	  try  
	  {  
	    double d = Double.parseDouble(str);  
	  }  
	  catch(NumberFormatException nfe)  
	  {  
	    return false;  
	  }  
	  return true;  
	}
}
