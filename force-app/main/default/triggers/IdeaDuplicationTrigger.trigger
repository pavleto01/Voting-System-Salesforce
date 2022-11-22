trigger IdeaDuplicationTrigger on Idea__c (before insert) {
    Map<String, List<Idea__c>> ideas = new Map<String, List<Idea__c>>();

    for(Idea__c i :Trigger.new){    
        if(!ideas.containsKey(i.Name)){
            ideas.put(i.Name, new List<Idea__c>());
        }
        ideas.get(i.Name).add(i);
    }

    for(Idea__c i :[SELECT Id, Name FROM Idea__c WHERE Name IN :ideas.keySet()]){

        for(Idea__c newidea :ideas.get(i.Name)){
            newidea.addError('Duplicate idea detected!');
        }

        for(List<Idea__c> idea : ideas.values()){

            if(idea.size() > 1){
                for(Idea__c dupName :idea){
                    dupName.addError('Duplicate idea');
                }
            }
        }
    }

}