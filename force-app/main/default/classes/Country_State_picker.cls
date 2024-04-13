public class Country_State_picker {
    
    
    public List<SelectOption> getCountriesSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));
        List<Foundation_Countries__c> cntrylist = new List<Foundation_Countries__c>();
        Map<String, Foundation_Countries__c> countries = Foundation_Countries__c.getAll();
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
        countryNames.sort();
        
        for (String countryName : countryNames) {
            Foundation_Countries__c country = countries.get(countryName);
            options.add(new SelectOption(country.country_code__c, country.Name));
        }
        return options;
    }
}