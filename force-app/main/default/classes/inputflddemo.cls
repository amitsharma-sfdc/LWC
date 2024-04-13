public class inputflddemo {

    public Contact con{get;set;}
    public inputflddemo(ApexPages.StandardController controller) {
        con=new Contact();

    }


public PageReference passvalue()
{
    //PageReference pageRef = page.GridDemo;
    PageReference pageRef = new PageReference('/lightning/cmp/c__vflightening');
    //pageRef.getParameters().put('id',con.Accountid);
    pageRef.setRedirect(true);
    return pageRef;  
}
}