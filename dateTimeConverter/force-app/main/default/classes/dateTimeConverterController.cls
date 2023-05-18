public with sharing class dateTimeConverterController {
    @InvocableMethod(label='dateTimeConverterController' Description='Takes a DateTime (entered as if in the timezone of the running user) and returns a string in specified format, in specified datetime. If timezone is null, uses the timezone of running user.')
    public static list<String> dateTimeConverterMethod(List<dateTimeConverter> dateTimeConverterList) {
        List<String> returnStringList = new List<String>();
        String returnString  = 'Error';
        try{
            String formatter;
            String timeZoneToUse;
            DateTime dtToConvert;
            Timezone userTZ = UserInfo.getTimeZone();
            String userTimeZone = userTZ.getId();
            Integer userOffset;
            dateTimeConverter dateTimeToConvert = dateTimeConverterList[0];
            
            //set timezone, format string, and datetime to convert
            timeZoneToUse = !String.isBlank(dateTimetoConvert.timeZoneName) ? dateTimetoConvert.timeZoneName : userTimeZone;
            formatter = dateTimetoConvert.formatString;
            dtToConvert = dateTimeToConvert.dateTimeVar;

            //since dtToConvert is evaluated in GMT, offset this by the difference between running user's time and GMT
            userOffset = userTZ.getOffset(dtToConvert)/3600000;
            dtToConvert.addHours(userOffset);

            //get return string!
            returnString = dtToConvert.format(formatter,timeZoneToUse);

        }catch(DmlException e){
            returnString = e.getMessage();
        }
        

        returnStringList.add(returnString);
        return returnStringList;
    }

    public class dateTimeConverter{
        @AuraEnabled @InvocableVariable public DateTime dateTimeVar;
        @AuraEnabled @InvocableVariable public String formatString;
        @AuraEnabled @InvocableVariable public String timeZoneName;
    }
}