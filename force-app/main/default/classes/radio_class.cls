/*** Controller ***/
public class radio_class{

    public radio_class(ApexPages.StandardController controller) {

    }

    String country = null;
         
    public PageReference test() {
        return null;
    }
    
        public radio_class() {
            
        }

                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Normal','Normal')); 
        options.add(new SelectOption('Tatkal','Tatkal')); 
         return options; 
    }
                   
    public String getCountry() {
        return country;
    }
                    
    public void setCountry(String country) { this.country = country; }
}