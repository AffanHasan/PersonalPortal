library contacts_book_locale_data;

import 'dart:html';
import 'dart:json' as json;

String cbBaseURL = "/personalportal/ContactsBook?action=" ;
Map cbLocaleDataMap = new Map();

String getPropertyValue(String propertyName){
  if(cbLocaleDataMap.isEmpty){
    //TODO : Check if the current user locale value entry exists in the web storage, if not then get the current locale the from server
    if(window.sessionStorage['locale'].toString() == 'null'){
      HttpRequest request = new HttpRequest(); // create a new XHR
      // add an event handler that is called when the request finishes
      request.onReadyStateChange.listen((_) {
        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
          // data saved OK.
          window.sessionStorage['locale'] = request.responseText;
        }
      });
      var url = "/personalportal/CommonAccessPoint?action=" + "getLoggedInUserLocale";
      request.open("GET", url, async: false);
      request.send(""); // perform the sync GET
    }
    return getData(propertyName);
  } else{//If map is not empty
    //Check if the locale value matches with the web storage locale value
    if(cbLocaleDataMap['user_locale'] == window.sessionStorage['locale']){
      return cbLocaleDataMap[propertyName];//Returning the required property value 
    }else {//If maps locale value is not equal to the web storage locale value
      return getData();
    }
  }
}

String getData(String propertyName){
  //TODO : Check if for the current user locale the data in web storage exist or not
  if(window.sessionStorage["cb_locale_data_" + window.sessionStorage['locale'].toString()] == null){
    //TODO : If not then load the data from the server and store it into the local storage
    
    HttpRequest request = new HttpRequest(); // create a new XHR
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
          (request.status == 200 || request.status == 0)) {
        // data saved OK.
        window.sessionStorage["cb_locale_data_" + window.sessionStorage['locale'].toString()] = request.responseText;
      }
    });
    var url = cbBaseURL + "getCBLocaleWiseData";
    request.open("GET", url, async: false);
    request.send(""); // perform the sync GET
    
    //Populate the map with the portal wide common properties data from web storage
    cbLocaleDataMap.clear();
    cbLocaleDataMap = json.parse(window.sessionStorage["cb_locale_data_" + window.sessionStorage['locale'].toString()]);
    cbLocaleDataMap['user_locale'] = window.sessionStorage['locale'];
    return cbLocaleDataMap[propertyName];//Returning the required property value
  }else{
    //If for the current user locale the data in web storage exist
    //Populate the map with the portal wide common properties data from web storage
    cbLocaleDataMap.clear();
    cbLocaleDataMap = json.parse(window.sessionStorage["cb_locale_data_" + window.sessionStorage['locale'].toString()]);
    cbLocaleDataMap['user_locale'] = window.sessionStorage['locale'];
    return cbLocaleDataMap[propertyName];//Returning the required property value
  }
}