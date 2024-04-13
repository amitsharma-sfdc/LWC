public class accountHistoryTracking {
    
    @AuraEnabled
    public static List<Map<String,String>> trackOwnerShip(String accId){
        List<Map<String,String>> returnMapList = new List<Map<String,String>>();
        List<AccountHistory> accHist = new List<AccountHistory>();
        accHist = [SELECT Account.Name, CreatedBy.Name, CreatedDate, DataType, Field, Id,
                                  IsDeleted, NewValue, OldValue FROM AccountHistory where DataType = 'Text' and AccountId =: accId];
        if(accHist.size() > 0){
            for(AccountHistory ah :accHist){
                Map<String,String> returnMap = new Map<String,String>();
                returnMap.put('changedBy',ah.CreatedBy.Name);
                returnMap.put('OldValue',String.valueOf(ah.OldValue));
                returnMap.put('NewValue',String.valueOf(ah.NewValue));
                returnMap.put('CreatedDate', String.valueOf(ah.CreatedDate));
                returnMapList.add(returnMap);
            }
        }
        return returnMapList;
    }
}