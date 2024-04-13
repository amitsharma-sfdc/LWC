/*** Controller ***/

public class yesno {

    public yesno(ApexPages.StandardController controller) {

    }


    String yesno = null;
         
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Yes','Yes')); 
        options.add(new SelectOption('No','No')); 
         return options; 
    }
                   
    public String getCountry() {
        return yesno;
    }
                    
    public void setCountry(String yesno) { this.yesno = yesno; }
}