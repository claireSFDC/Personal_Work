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
  </tr>
  <tr>
    <td>a</td>
    <td>b</td>
    <td>c</td>
    <td>d</td>
  </tr>
  </table>

