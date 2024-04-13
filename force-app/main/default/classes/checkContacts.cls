public class checkContacts {
    //System.schedule('AccountSyncJobOnceInADay', '0 45 16 * * ?', new sObjectUpdateBatch());
  @AuraEnabled(cacheable=true)
  public static List<Account> getNumberOfContacts(String i) {
    i = '%' + i + '%';
    return [
      SELECT
        Id,
        Name,
        Phone,
        (SELECT Id, Name, FirstName, LastName, Email, Phone FROM Contacts)
      FROM Account
      WHERE Name LIKE :i
    ];
  }

  @AuraEnabled
  public static List<Contact> getAccountsfromContact(String recordId) {
    return [
      SELECT Id, Name, FirstName, LastName, Email, Phone
      FROM Contact
      WHERE AccountId = :recordId
    ];
  }

  @AuraEnabled
  public static String updateRecord(
    String recordId,
    String fname,
    String lname,
    String cphone,
    String cemail
  ) {
    try {
      Contact c = [
        SELECT Id, FirstName, LastName, Email, Phone
        FROM Contact
        WHERE Id = :recordId
      ];
      c.FirstName = fname;
      c.LastName = lname;
      c.Phone = cphone;
      c.Email = cemail;
      Database.SaveResult sr = Database.update(c, false);
      if (sr.isSuccess()) {
        return 'success';
      } else {
        List<Database.Error> err = sr.getErrors();
        return 'ERROR!-' + err[0].getMessage();
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  @AuraEnabled
  public static string deleteRecord(String recordId) {
    try {
      Contact c = [
        SELECT Id
        FROM Contact
        WHERE Id = :recordId
      ];
      Database.DeleteResult sr = Database.delete(c, false);
      if (sr.isSuccess()) {
        return 'success';
      } else {
        List<Database.Error> err = sr.getErrors();
        return 'ERROR!-' + err[0].getMessage();
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  @AuraEnabled
  public static String insertRecord(
    String accId,
    String fname,
    String lname,
    String cphone,
    String cemail
  ) {
    try {
      Contact c = new Contact();
      c.FirstName = String.isNotBlank(fname) ? fname : '';
      c.LastName = lname;
      c.Phone = String.isNotBlank(cphone) ? cphone : '';
      c.Email = String.isNotBlank(cemail) ? cemail : '';
      c.AccountId = accId;
      Database.SaveResult sr = Database.insert(c, false);
      if (sr.isSuccess()) {
        return 'success';
      } else {
        List<Database.Error> err = sr.getErrors();
        return 'ERROR!-' + err[0].getMessage();
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  @AuraEnabled
  public static string updateDatatable(Object data) {
    String errorMessage = '';
    List<Account> accsForUpdate = new List<Account>();
    accsForUpdate = (List<Account>) JSON.deserialize(
      JSON.serialize(data),
      List<Account>.class
    );
    System.debug('accsForUpdate' + accsForUpdate[0].Id);
    try {
      Database.SaveResult[] updateResult = Database.update(
        accsForUpdate,
        false
      );
      for (Database.SaveResult r : updateResult) {
        if (r.isSuccess()) {
          errorMessage = errorMessage + 'Success' + '\n';
        } else {
          List<Database.Error> err = r.getErrors();
          errorMessage = errorMessage + 'ERROR!-' + err[0].getMessage() + '\n';
        }
      }
      return errorMessage; //String.isBlank(errorMessage) ? 'Success' : errorMessage;
    } catch (Exception e) {
      return 'The following exception has occurred: ' + e.getMessage();
    }
  }
}