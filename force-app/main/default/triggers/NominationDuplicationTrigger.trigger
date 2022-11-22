trigger NominationDuplicationTrigger on Nomination__c(before insert, before update){

    Map<String, List<Nomination__c>> noms = new Map<String, List<Nomination__c>>();

    for(Nomination__c n :Trigger.new){    
        if(!noms.containsKey(n.Name)){
            noms.put(n.Name, new List<Nomination__c>());
        }
        noms.get(n.Name).add(n);
    }

    for(Nomination__c n :[SELECT Id, Name FROM Nomination__c WHERE Name IN :noms.keySet()]){

        for(Nomination__c newNom :noms.get(n.Name)){
            newNom.addError('Duplicate nomination detected!');
        }

        for(List<Nomination__c> nominations : noms.values()){

            if(nominations.size() > 1){
                for(Nomination__c dupName :nominations){
                    dupName.addError('Duplicate name');
                }
            }
        }
    }
}