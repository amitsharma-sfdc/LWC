public class QuoteTemplate {

    @AuraEnabled
public static void getQuoteTemplate(Id recordId) {
    insertQuoteTemplate(recordId, '3D0EH2v000006PrHx');
}

public static void insertQuoteTemplate(Id recordId, Id templateId) {
    // Logic to find template Id omitted...

    PageReference pr = new PageReference('/quote/quoteTemplateDataViewer.apexp?id=' + recordId + '&summlid=' + templateId); 

    QuoteDocument qd = new QuoteDocument(); 
    Blob b = pr.getContentAsPDF();

    qd.Document = b;
    qd.QuoteId = recordId;
    insert qd;
}
}