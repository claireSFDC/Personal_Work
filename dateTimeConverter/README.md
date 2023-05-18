# Salesforce DateTimeConverter Flow Action: Overview

<i>Never write a DateTime conversion formula again!</i>

This flow action accepts a DateTime variable, a format string, and a timezone, and returns a String with the DateTime written exactly how you want! No messy formulas needed anymore!


<img width="600" alt="exampledatetime" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/0cee6c16-c569-4ba0-ab70-469c628c40b7">


Go from this...

<code>CASE(WEEKDAY(DATEVALUE({!dateTimeVar} -4/24)),
1, "Sunday",
2, "Monday",
3, "Tuesday",
4, "Wednesday",
5, "Thursday",
6, "Friday",
7, "Saturday",
"")
 & " " &
CASE(MONTH(DATEVALUE({!dateTimeVar} -4/24 )),
1, "January",
2, "February", 
3, "March",
4, "April",
5, "May",
6, "June", 
7, "July",
8, "August",
9, "September",
10, "October",
11, "November",
12, "December", "")
& " " &
TEXT(DAY(DATEVALUE({!dateTimeVar} - 4/24)))
&", " &
TEXT(YEAR(DATEVALUE({!dateTimeVar} - 4/24)))
& " " &
IF(VALUE(MID(TEXT({!dateTimeVar} - 4/24), 12, 2)) >12, TEXT(VALUE(MID(TEXT({!dateTimeVar} - 4/24), 12, 2)) -12), MID(TEXT({!dateTimeVar} - 4/24), 12, 2))
& ":"&
MID(TEXT({!dateTimeVar} - 4/24), 15, 2)
& " " &
IF( VALUE(MID(TEXT({!dateTimeVar} - 4/24), 12, 2)) > 11, "PM", "AM")
  </code>
  <br>
...to this!<br>
<img width="600" alt="tothis!" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/2532ff65-fefc-42bb-8640-eeb9d8973414">


## Input Variables

<b>dateTimeVar:</b> This is a standard dateTime variable. It can be defined as a variable in the flow, or you can use a field on a record, like Case.CreatedDate.
<br><b>timeZoneName: </b>This is the name of the timezone you would like the dateTime string to be converted to, if required. If no TimeZoneName is provided, the action will default to the timezone of the running user.
<br><b>formatString: </b>This is a string that represents how you would like your output text formatted. You can use https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html as a guide.

## Examples

Here are some examples of inputs and their respective outputs.

<table>
  <tr>
    <th>dateTimeVar</th>
    <th>formatString</th>
    <th>timeZoneName</th>
    <th>Running User's TimeZone</th>
    <th>OUTCOME</th>
  </tr>
  <tr>
    <td>1/5/2023 5:30pm</td>
    <td>h:mm a M/d/yyyy</td>
    <td>America/Los_Angeles</td>
    <td>America/New_York</td>
    <td>2:30 PM 1/5/2023</th>
  </tr>
    <tr>
    <td>9/17/2019 7:15am</td>
    <td>EEE, d MMM yyyy HH:mm:ss</td>
    <td>America/Los_Angeles</td>
    <td>America/New_York</td>
    <td>Fri, 17 Sep 2021 04:15:00</th>
  </tr>
  <tr>
    <td>5/6/2009 2:31 PM</td>
    <td>yyyy-MM-dd HH:mm</td>
    <td>America/Los_Angeles</td>
    <td>America/New_York</td>
    <td>2009-05-06 11:31</th>
  </tr>
    <tr>
    <td>4/11/2025 1:00 AM</td>
    <td>yyyy-MM-dd HH:mm</td>
    <td>Asia/Kolkata</td>
    <td>America/New_York</td>
    <td>11 April 2025 India Standard Time</th>
  </tr>
  </table>
  
  
## Flow Example

1. Create a flow that calls the apex Action, <b>dateTimeConverterController</b>
<br><img width="200" alt="flowOverView" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/dc00db7f-255d-4229-b150-ecff6687b448">
<br>
2. Set the inputs. (Specified DateTime, the required format, and the timezone.)
<br><img width="600" alt="inputVariables" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/fd2fc887-46a4-4336-b626-690c2943603e">
<br>
3. Run the flow, and see the outcome!
<br><img width="500" alt="resultdatetime" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/82b1f47c-1c36-47dd-9d08-e37f80e1a27d">

## The Code

<pre>
<code>
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
</code>
</pre>

## Test Class

<pre>
<code>
@isTest
public with sharing class dateTimeConverterTest {
    @IsTest
    static void testDateTimeConverter(){

        Profile systemadminprofile = [Select id, name from profile where name = 'System Administrator'];

        User newUser = new User(
            LastName = 'dateTimeConverterTest',
            username = 'dateTimeConverterTest@sf.com',
            email = 'dateTimeConverterTest@sf.com.invalid',
            alias = 'dxtxc',
            CommunityNickname = 'dateTimeConverterTest',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/New_York',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            profileid = systemadminprofile.id
        );
        insert newUser;

        Test.startTest();
        System.runAs(newUser){
            dateTimeConverterController.dateTimeConverter dtToTest = new dateTimeConverterController.dateTimeConverter();
            List<dateTimeConverterController.dateTimeConverter> dtToTestList = new List<dateTimeConverterController.dateTimeConverter>();
            List<String> results = new List<String>();

            Datetime myDateTime = Datetime.newInstance(2023, 2, 27, 5, 30, 0);

            dtToTest.dateTimeVar = myDateTime;
            dtToTest.formatString = 'yyyy-MM-dd h:mm a';
            dtToTest.timeZoneName = 'America/Los_Angeles';
            
            dtToTestList.add(dtToTest);
            
            //Test positive
            results = dateTimeConverterController.dateTimeConverterMethod(dtToTestList);
            System.assertEquals('2023-02-27 2:30 AM', results[0]);
         

            Test.stopTest();
            }
        
    }
}
</code>
</pre>
