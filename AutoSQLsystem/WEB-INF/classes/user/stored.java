package user;
public class stored
{
    String attributes[] = new String[10];
    String types[] = new String[10];
    public void setAttributes(String attributes[])
    {
        System.arraycopy(attributes,0,this.attributes,0,attributes.length); 
    }
    public void setTypes(String types[])
    {
        System.arraycopy(types,0,this.types,0,types.length);
    }
    public String[] getAttributes()
    {
        return attributes;
    }
    public String[] getTypes()
    {
        return types;
    }
}