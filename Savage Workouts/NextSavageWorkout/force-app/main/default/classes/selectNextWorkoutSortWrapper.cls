global class selectNextWorkoutSortWrapper implements Comparable {
 
    public Savage_Workout__c savg; 
    
    // Constructor
    public selectNextWorkoutSortWrapper(Savage_Workout__c sw) {
        savg = sw;
    }
    
    // Compare opportunities based on the opportunity amount.
    global Integer compareTo(Object compareTo) {
        // Cast argument to OpportunityWrapper
        selectNextWorkoutSortWrapper compareToSavage = (selectNextWorkoutSortWrapper)compareTo;
        
        // The return value of 0 indicates that both elements are equal.
        Integer returnValue = 0;
        if (savg.Total_Workouts__c > compareToSavage.savg.Total_Workouts__c) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (savg.Total_Workouts__c < compareToSavage.savg.Total_Workouts__c) {
            // Set return value to a negative value.
            returnValue = -1;
        } else if ((savg.Total_Workouts__c == null) && (compareToSavage.savg.Total_Workouts__c != null)){
            // nulls-first implementation
            returnValue = -1;
        } else if ((savg.Total_Workouts__c != null) && (compareToSavage.savg.Total_Workouts__c == null)){
            // nulls-first implementation
            returnValue = 1;
        }        
        return returnValue;       
    }
}

