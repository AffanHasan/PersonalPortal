// Auto-generated from contactsbookspa.html.
// DO NOT EDIT.

library contacts_book_spa;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'dart:html';
import 'dart:json' as json;
import 'package:lib/cb_locale_data.dart' as cb_locale_data;
import 'package:web_ui/web_ui.dart';
import 'package:web_ui/watcher.dart' as watchers;
import 'package:json_object/json_object.dart';
import 'package:pp_commons/pp_common_ui.dart' as pp_comm_ui;
part '../add_contact.dart';
part '../add_group.dart';


// Original code


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
// Additional generated code
void init_autogenerated() {
  var __root = autogenerated.document.body;
  final __html0 = new autogenerated.Element.tag('template'), __html1 = new autogenerated.Element.html('<details>\n            <summary></summary>\n            <ul></ul>\n          </details>'), __html2 = new autogenerated.Element.html('<li>\n                <span name="contact_name"></span>\n                <span name="contact_comments"></span>\n              </li>');
  var __e10, __e11;
  var __t = new autogenerated.Template(__root);
  __e10 = __root.nodes[7].nodes[3];
  __t.conditional(__e10, () => showCCG, (__t) {
    var __e9;
    __e9 = __html0.clone(true);
    __t.loop(__e9, () => contactsBook.keys, ($list, $index, __t) {
      var groupName = $list[$index];
      var __e1, __e7, __e8;
      __e8 = __html1.clone(true);
      __e1 = __e8.nodes[1];
      var __binding0 = __t.contentBind(() => groupName, false);
      __e1.nodes.add(__binding0);
      __t.listen(__e1.onClick, ($event) { loadContactsListForGroup('$groupName', true, $event); });
      __e7 = __e8.nodes[3];
      __t.bind(() => groupName,  (__e) { __e7.id = '${__e.newValue}_contacts_list'; }, false);
      __t.loopIterateAttr(__e7, () => contactsBook['$groupName'], ($list, $index, __t) {
        var contact = $list[$index];
        var __e3, __e5, __e6;
        __e6 = __html2.clone(true);
        __e3 = __e6.nodes[1];
        var __binding2 = __t.contentBind(() => contact['name'], false);
        __e3.nodes.add(__binding2);
        __e5 = __e6.nodes[3];
        var __binding4 = __t.contentBind(() =>  contact['comments'] == null ? "" : contact['comments'] , false);
        __e5.nodes.add(__binding4);
      __t.addAll([new autogenerated.Text(' \n              '),
          __e6,
          new autogenerated.Text(' \n            ')]);
      });
      __t.bind(() => groupName,  (__e) { __e8.id = '${__e.newValue}_group'; }, false);
    __t.addAll([new autogenerated.Text('\n          '),
        __e8,
        new autogenerated.Text('\n        ')]);
    });
  __t.addAll([new autogenerated.Text('\n        '),
      __e9,
      new autogenerated.Text('\n      ')]);
  });

  __e11 = __root.nodes[11].nodes[1].nodes[3];
  __t.listen(__e11.onClick, ($event) { closeGeneralDialog(); });
  __t.create();
  __t.insert();
}

//@ sourceMappingURL=contactsbookspa.dart.map