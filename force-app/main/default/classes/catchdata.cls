public class catchdata {
    public Opportunity opp{get;set;}
    public String color{get;set;}
    public catchdata(ApexPages.StandardController controller) {
        opp = new Opportunity();
        color = 'red';
    }

    public PageReference passvalue()
{
    PageReference pageRef = new PageReference('/lightning/cmp/c__catchdata');
    pageRef.getParameters().put('c__desc',opp.Description);
    pageRef.getParameters().put('c__amount',String.valueOf(opp.Amount_in_INR__c));
    pageRef.setRedirect(true);
    return pageRef;  
}
}