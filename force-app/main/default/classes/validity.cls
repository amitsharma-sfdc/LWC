/*** Controller ***/

public class validity {

    public validity(ApexPages.StandardController controller) {

    }


    String ages = null;
         
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('10 years','10 years')); 
        options.add(new SelectOption('upto age 18','upto age 18')); 
        options.add(new SelectOption('Not Applicable','Not Applicable'));
         return options; 
    }
                   
    public String getCountry() {
        return ages;
    }
                    
    public void setCountry(String ages) { this.ages = ages; }
}