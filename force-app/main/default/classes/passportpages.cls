/*** Controller ***/

public class passportpages {

    public passportpages(ApexPages.StandardController controller) {

    }


    String pages = null;
         
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('36 Pages','36 Pages')); 
        options.add(new SelectOption('60 Pages','60 Pages')); 
         return options; 
    }
                   
    public String getCountry() {
        return pages;
    }
                    
    public void setCountry(String pages) { this.pages = pages; }
}