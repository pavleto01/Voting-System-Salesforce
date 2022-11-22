public with sharing class IdeaController {

    @AuraEnabled
    public static Idea__c createIdea(string Name, string Description, string Campaign){
        Idea__c Idea = new Idea__c();
        Idea.Name=Name;
        Idea.Idea_description__c=Description;
        Idea.Voting_campaign__c=Campaign;
        insert Idea;
        return Idea;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Idea__c> getIdeas() {
        List<Idea__c> ideaList = [
            SELECT Id, Name,Idea_description__c,Voting_campaign__r.Name
            FROM Idea__c
            ORDER BY Id
        ];
        return ideaList;
    }

    
  }