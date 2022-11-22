trigger RestrictIdeaVoteTrigger on Votes_for_idea__c (before insert) {
    Map<String, List<Votes_for_idea__c>> ideas = new Map<String, List<Votes_for_idea__c>>();

    for(Votes_for_idea__c i :Trigger.new){    
        if(!ideas.containsKey(i.Unique__c)){
            ideas.put(i.Unique__c, new List<Votes_for_idea__c>());
        }
        ideas.get(i.Unique__c).add(i);
    }

    for(Votes_for_idea__c i :[SELECT Id, Unique__c FROM Votes_for_idea__c WHERE Unique__c IN :ideas.keySet()]){

        for(Votes_for_idea__c newidea :ideas.get(i.Unique__c)){
            newidea.addError('Duplicate vote detected!');
        }

        for(List<Votes_for_idea__c> idea : ideas.values()){

            if(idea.size() > 1){
                for(Votes_for_idea__c dupName :idea){
                    dupName.addError('User already voted');
                }
            }
        }
    }
}
