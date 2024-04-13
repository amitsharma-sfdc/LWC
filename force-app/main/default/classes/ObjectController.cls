public class ObjectController {

        

    //Public string selectedObj {get;set;}
    //public String selectedField {get; set;}
    @AuraEnabled 
    Public static List<String> getObjList(){
        List<String> objNamesLst = new List<String>();
        List<Schema.SObjectType> objList = Schema.getGlobalDescribe().Values();     
        List<SelectOption> objNames = new List<SelectOption>();
        objNames.add(new SelectOption('','-- Select --'));
        for(Schema.SObjectType obj : objList)
        {
            objNames.add(new SelectOption(obj.getDescribe().getName(),obj.getDescribe().getLabel()));
            objNamesLst.add(obj.getDescribe().getName());
        }
        objNamesLst.sort();
        //Integer i = objNames.size();   
        //SelectOption sopn = objNames.get(i);        
        return objNamesLst;
    }
    
    @AuraEnabled   
    Public static List<String> getObjectFields(String selectedObj){    
    //public static List<SelectOption> getObjectFields() {
        List<String> fieldNamesLst = new List<String>();
        List<SelectOption> fieldNames = new List<SelectOption>();
        fieldNames.add(new SelectOption('','-- Select --'));
        if(!String.isBlank(selectedObj)){
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType ObjSchema = schemaMap.get(selectedObj);
            Map<String, Schema.SObjectField> fieldMap = ObjSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()) 
            {  
                fieldNames.add(new SelectOption(fieldName, fieldMap.get(fieldName).getDescribe().getLabel()));
                fieldNamesLst.add(fieldMap.get(fieldName).getDescribe().getLabel());
            }
        }
        return fieldNamesLst;
    }  
   
}