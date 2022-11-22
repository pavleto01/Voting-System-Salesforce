public with sharing class NominationController {

    @AuraEnabled
    public static Nomination__c createNomination(string Name, string Description,string Campaign){
      Nomination__c Nomination = new Nomination__c();
      Nomination.Name=Name;
      Nomination.Nomination_Description__c=Description;
      Nomination.Voting_campaign__c=Campaign;
        insert Nomination;
        return Nomination;
    }
  
    @AuraEnabled(cacheable=true)
    public static List<Nomination__c> getNominations(string record) {
        List<Nomination__c> nomList = [
            SELECT Id, Name
            FROM Nomination__c
            WHERE Voting_campaign__c = :record

        ];
        return nomList;
    }

    
  }