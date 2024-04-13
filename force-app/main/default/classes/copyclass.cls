public class copyclass {	
    public static void armani(List<Emporio_Armani__c> empoar)
    {
   
		Emporio_Armani__c copy_i = new Emporio_Armani__c();
        for(Emporio_Armani__c ea : empoar)
        {
            for(Integer i=0; i<=empoar.size(); i++)
            {
                copy_i = empoar[i].Clone();
            }
        
            empoar.add(copy_i);
            
        }
update copy_i;           
    } 

}