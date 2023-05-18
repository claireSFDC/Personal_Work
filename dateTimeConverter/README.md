# Salesforce DateTimeConverter Flow Action: Overview

Never write a DateTime conversion formula again!

This flow action accepts a DateTime variable, a format string, and a timezone, and returns a String with the DateTime written exactly how you want! No messy formulas needed anymore!

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
<img width="399" alt="tothis!" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/2532ff65-fefc-42bb-8640-eeb9d8973414">


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
    <td>'America/Los_Angeles'</td>
    <td>'America/New_York'</td>
    <td>2:30 PM 1/5/2023</th>
  </tr>
    <tr>
    <td>9/17/2019 7:15am</td>
    <td>EEE, d MMM yyyy HH:mm:ss</td>
    <td>'America/Los_Angeles'</td>
    <td>'America/New_York'</td>
    <td>Fri, 17 Sep 2021 04:15:00</th>
  </tr>
  <tr>
    <td>5/6/2009 2:31 PM</td>
    <td>yyyy-MM-dd HH:mm</td>
    <td>'America/Los_Angeles'</td>
    <td>'America/New_York'</td>
    <td>2009-05-06 11:31</th>
  </tr>
    <tr>
    <td>4/11/2025 1:00 AM</td>
    <td>yyyy-MM-dd HH:mm</td>
    <td>'Asia/Kolkata'</td>
    <td>'America/New_York'</td>
    <td>11 April 2025 India Standard Time</th>
  </tr>
  </table>
## Flow Example

1.Create a flow that calls the apex Action, <b>dateTimeConverterController</b>
<br><img width="200" alt="flowOverView" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/dc00db7f-255d-4229-b150-ecff6687b448">
<br>
2. Set the inputs, including the DateTime, the required format, and the timezone.
<br><img width="600" alt="inputVariables" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/fd2fc887-46a4-4336-b626-690c2943603e">
<br>
3. Run the flow, and see the outcome!
<br><img width="500" alt="resultdatetime" src="https://github.com/claireSFDC/Personal_Work/assets/62670451/82b1f47c-1c36-47dd-9d08-e37f80e1a27d">

