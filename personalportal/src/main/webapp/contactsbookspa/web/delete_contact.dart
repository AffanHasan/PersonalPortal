part of contacts_book_spa;

void deleteContact(String groupName, int index){
  List<JsonObject> contactsList = contactsBook[groupName].toList();
  
  if(
      window.confirm(
                      cb_locale_data.getPropertyValue("contactDelMsg")
                      +
                      '\n'
                      +
                      (contactsList.firstWhere(
                          (e){
                            return e['_id'] == index;
                          }
                      ))['name']
                      +
                      '\n'
                      +
                      (contactsList.firstWhere(
                          (e){
                            return e['_id'] == index;
                          }
                      ))['comments']
                    )
                   ){
    contactsList.removeWhere(
        (e){
          return e['_id'] == index;
        }
    );
    //Preparing request data
    JsonObject requestData = new JsonObject();
    requestData["groupName"] = groupName;
    requestData["contactsList"] = contactsList;
    //Sending the post request to the server
    HttpRequest request = new HttpRequest();
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
          (request.status == 200 || request.status == 0)) {
        if(request.responseText.startsWith("saved")){//Close general dialog only if save is success full
          //closeGeneralDialog();
          //Updating the contacts list for this group
          contactsBook[groupName] = contactsList;
          watchers.dispatch();
        }
        else{
        }
      }
    });
    request.open("POST", baseURL + "addSingleContact", async: true);
    request.send(json.stringify(requestData));
  }
}