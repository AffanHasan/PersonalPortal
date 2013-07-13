library contacts_book_spa;

import 'dart:html';
import 'dart:json' as json;
import 'package:lib/cb_locale_data.dart' as cb_locale_data;
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import "package:json_object/json_object.dart";
import "package:pp_commons/pp_common_ui.dart" as pp_comm_ui;

part "add_contact.dart";
part "add_group.dart";
part "view_contact.dart";
part "edit_contact.dart";

/**
 * Holds the contacts book state
 */
JsonObject contactsBook = new JsonObject();
ButtonElement addGroupBtn = new ButtonElement();

String baseURL = "/personalportal/ContactsBook?action=";
bool showCCG = true;//Initially on application start up collapsable_contacts_grouping will be rendered
bool showCS = false;//contacts_search will be enabled only when user starts typing in the text bar

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
  
  //TODO : Render basic UI
  renderBasicUIOnFirstLoad();
  
  //TODO : Load initial data container
  loadDataContainerOnFirstLoad();
}

/**
 * To render the basic user interface div on application start up
 */
void renderBasicUIOnFirstLoad(){
  query("#application_header").appendHtml("<h1>" + cb_locale_data.getPropertyValue("contactsBook") +"</h1>");
  renderControlsPanelOnFirstLoad();
}

/**
 * To load the data_container div on application start up
 */
void loadDataContainerOnFirstLoad(){
  //DivElement data_container = query("#data_container");
  //Getting list of contacts group
  HttpRequest.getString(baseURL + "getContactsGroupList").then(
      (String responseText){
        DetailsElement group = new DetailsElement();
        String groupName;
        List<String> groupList = json.parse(responseText);//Server returns json list of contacts groups
        if(groupList.isEmpty){//If no contacts in this book
        }
        else{
          for(String groupName in groupList){
            contactsBook[groupName] = "";
            watchers.dispatch();
          }
        }
      }
  );
}

/**
 * To render the controls panel on application start up 
 */
void renderControlsPanelOnFirstLoad(){
  addContactBtn.text = "+";
  addContactBtn.title = cb_locale_data.getPropertyValue("addContact");
  addContactBtn.id = "add_contact_btn";
  addContactBtn.onClick.listen(
      (Event e){
        launchGeneralDialog();
        populateGeneralDialogForAddContact();
      }
  );
  query("#control_panel").append(addContactBtn);
  addGroupBtn.text = "⊞";
  addGroupBtn.title = cb_locale_data.getPropertyValue("addGroup");
  addGroupBtn.id = "add_contacts_group";
  addGroupBtn.onClick.listen(
      (Event e){
        launchGeneralDialog();
        populateGeneralDialogForAddGroup();
      }
  );
  query("#control_panel").append(addGroupBtn);
}

/**
 * It checks if the contactsBook Map contains a contacts list for a group name or not,
 * if not then load it from server and add it to the contactsBook map.
 * Also has an option of asynchronous or synchronous requests.
 * */
void loadContactsListForGroup(String groupName, bool asynchronous, Event event){
  if(contactsBook[groupName].isEmpty){
    if(asynchronous){
      List<JsonObject> contactsList;
      HttpRequest.getString(baseURL + "getContactsListForAGroup" + "&" + "groupName=" + groupName).then(
          (String responseText){
            contactsList = json.parse(responseText);
            contactsBook[groupName] = (contactsList == null || contactsList.isEmpty) ? new List<JsonObject>() : contactsList;
            watchers.dispatch();
          }
      );
    }else{
      //Sending the post request to the server
      HttpRequest request = new HttpRequest();
      // add an event handler that is called when the request finishes
      request.onReadyStateChange.listen((_) {
        if (request.readyState == HttpRequest.DONE &&
            (request.status == 200 || request.status == 0)) {
          List<JsonObject> contactsList;
          contactsList = json.parse(request.responseText);
          contactsBook[groupName] = (contactsList == null || contactsList.isEmpty) ? new List<JsonObject>() : contactsList;
          watchers.dispatch();
        }
      });
      request.open("GET", baseURL + "getContactsListForAGroup" + "&" + "groupName=" + groupName, async: false);
      request.send();
    }
  }
}

/**
 * To launch the general dialog use this function and pass the type of action as string parameter
 */
void launchGeneralDialog(){
 query("#overlay_shield").style.display = "inline";
 query("#general_dialog").style.display = "inline";
}

void closeGeneralDialog(){
  query("#overlay_shield").style.display = "none";
  query("#general_dialog").style.display = "none";
  query("#general_dialog_header_content").innerHtml = "";
  query("#general_dialog_body").innerHtml = "";
  query("#general_dialog_footer").innerHtml = "";
}