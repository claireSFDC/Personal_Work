# Salesforce DateTimeConverter Flow Action: Overview

Never write a DateTime conversion formula again!

This flow action accepts a DateTime variable, a format string, and a timezone, and returns a String with the DateTime written exactly how you want! No messy formulas needed anymore!

## Input Variables

<b>dateTimeVar:</b> This is a standard dateTime variable. It can be defined as a variable in the flow, or you can use a field on a record, like Case.CreatedDate.
<br><b>timeZoneName: </b>This is the name of the timezone you would like the dateTime string to be converted to, if required. If no TimeZoneName is provided, the action will default to the timezone of the running user.
<br><b>formatString: </b>This is a string that represents how you would like your output text formatted. You can use https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html as a guide.

## Examples

Here are some examples!

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

