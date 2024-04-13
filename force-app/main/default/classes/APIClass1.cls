//Calling SFDC API from an external application. External ------>> SFDC

@RestResource(urlMapping='/LeadCreate/')
global class APIClass1 {
    
    @HTTPPost
    global static string doPost()
    {
        String fieldvalue;
        String fieldname;
        String fname;
        String lname;
        String comp;
        
        List<String> leadList = new String[3];
        
        RestRequest req = RestContext.request; //Request that you want to get from an external system
        RestResponse res = RestContext.response; //Response that you want to send back
        
        System.debug('Param is :'+req.params);
        System.debug('Param is :'+req.requestBody);
        
        String arr = req.requestBody.toString();
        
        JSONParser parser = JSON.createParser(arr);
        while(parser.nextToken() != null)
        {
            if(parser.getCurrentToken() != JSONToken.END_OBJECT)
            {
                parser.nextValue();
                fieldname = parser.getCurrentName();
                fieldvalue = parser.getText();
                
                /*if(fieldname == 'First Name')
{
fname = parser.getText();
}
else if(fieldname == 'Last Name')
{
lname = parser.getText();
}
else if(fieldname == 'Company')
{
comp = parser.getText();
}*/
                Switch on fieldname
                {
                    when 'First Name'{
                        fname = parser.getText();                                                
                    }
                    
                    when 'Last Name'{
                        lname = parser.getText();
                    }
                    
                    when 'Company'{
                        comp = parser.getText();
                    }
                }
            }
        }
        Lead lc = new Lead(FirstName = fname, lastname = lname, Company = comp);
        insert lc;
        return lc.ID;
    }
}