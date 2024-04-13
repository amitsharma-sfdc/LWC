public class AnimalLocator {
    //@AuraEnabled
    public static String getAnimalNameById(Integer passed_ID) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        List<Object> animals = new List<Object>();
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            animals = (List<Object>) results.get('animals');
        }
        String str = animals[passed_ID].toString();
        return str;
    }
}