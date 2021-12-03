public with sharing class selectNextSavageWorkoutController {

    @AuraEnabled(cacheable = true)
    public static String selectNextWorkout(){
        //try {
            System.debug('Hi im in select next workout');
            list<Savage_Workout__c> AllWorkouts = [Select id, name, body__c, day__c, total_workouts__c FROM Savage_Workout__c order by day__c asc];
            selectNextWorkoutSortWrapper [] savagelist = new list<selectNextWorkoutSortWrapper>();
            string nextSavageWorkoutId;
            for(Savage_Workout__C sw : AllWorkouts){
                savagelist.add(new selectNextWorkoutSortWrapper(sw));
            }
            
            savagelist.sort();
            for(selectNextWorkoutSortWrapper sww : savagelist){
                System.debug(sww.savg.name + ' NUM workouts: ' + sww.savg.total_workouts__c);
            }
            nextSavageWorkoutId = Id.valueOf(savagelist[0].savg.id);
            return nextSavageWorkoutId;

        /*} catch (Exception e) {
            system.debug('problems');
        }*/
    }

}
