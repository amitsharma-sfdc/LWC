public class orgsearch1 {
    
    @AuraEnabled 
    Public static List<String> getObjList(){
        List<String> objNamesLst = new List<String>();
        List<String> fieldNamesLst = new List<String>();        
        List<Schema.SObjectType> objList = Schema.getGlobalDescribe().Values();     
        List<SelectOption> objNames = new List<SelectOption>();
        objNames.add(new SelectOption('','-- Select --'));
        for(Schema.SObjectType obj : objList)
        {
            objNames.add(new SelectOption(obj.getDescribe().getName(),obj.getDescribe().getLabel()));
            objNamesLst.add(obj.getDescribe().getName());
        }
        objNamesLst.sort();
        List<List<sObject>> sObj = new List<List<sObject>>();
        for(Integer i=0;i<objNamesLst.size();i++){
        sObj[i] = getObjectrecords(objNamesLst[i]);
            if(sObj[i] == Null)
            {
                sObj.remove(i);
            }
            }        
        return objNamesLst;
    }
    
    @AuraEnabled   
    Public static List<String> getObjectFields(String selectedrecord){    
        List<String> fieldNamesLst = new List<String>();
        List<SelectOption> fieldNames = new List<SelectOption>();
        fieldNames.add(new SelectOption('','-- Select --'));
        if(!String.isBlank(selectedrecord)){
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType ObjSchema = schemaMap.get(selectedrecord);
            Map<String, Schema.SObjectField> fieldMap = ObjSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()) 
            {  
                fieldNames.add(new SelectOption(fieldName, fieldMap.get(fieldName).getDescribe().getName()));
                fieldNamesLst.add(fieldMap.get(fieldName).getDescribe().getName());
            }
        }
        return fieldNamesLst;
    }
    
    @AuraEnabled   
    Public static List<sObject> getObjectrecords(String selectedObj){  
        List<String> recordLst = new List<String>();
        List<sObject> recordqry = new List<sObject>();        
        List<SelectOption> recordNames = new List<SelectOption>();
        //recordNames.add(new SelectOption('','-- Select --'));        
        if(!String.isBlank(selectedObj)){
            String qry = 'Select Name,Id From '+selectedObj;
            recordqry = Database.query(qry);
        }       
        return recordqry;
    }
    
    @AuraEnabled   
    Public static List<sObject> getObjectwidrecords(String selectedObj){  
        List<String> recordLst = new List<String>();
        List<sObject> recordqry = new List<sObject>();        
        String qry = 'Select Name,Id From '+selectedObj;
        recordqry = Database.query(qry);
        return recordqry;
    }    
    
    @AuraEnabled
    public static sObject getdata(String selectedObj, String selectedrecord, String selectedfield, String recordId){
        List<sObject> sob = new List<sObject>();
        String qry = 'Select '+selectedfield+' From '+selectedObj+' where Name =\'' +selectedrecord+ '\'';
        sob = Database.query(qry);
        sObject ob = sob.get(0);
        return (ob);
    }
}