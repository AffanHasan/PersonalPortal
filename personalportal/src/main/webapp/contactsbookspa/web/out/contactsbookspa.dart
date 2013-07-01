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
part '../view_contact.dart';


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
  final __html0 = new autogenerated.Element.tag('template'), __html1 = new autogenerated.Element.html('<details>\n            <summary></summary>\n            <ul></ul>\n          </details>'), __html2 = new autogenerated.Element.html('<li>\n                <a name="contact_name" href="#"></a>\n                <span name="contact_comments"></span>\n                <span style="display:none"></span>\n                <span style="display:none"></span>\n                <span style="display:none"></span>\n              </li>'), __html3 = new autogenerated.Element.html('<span template="" if="contact[\'cellPhoneList\'] != null">\n                  <span name="contact_cell_phones"></span>\n                </span>'), __html4 = new autogenerated.Element.html('<span name="cell_phone_item"></span>'), __html5 = new autogenerated.Element.html('<span template="" if="contact[\'landLinesList\'] != null">\n                  <span name="contact_land_lines"></span>\n                </span>'), __html6 = new autogenerated.Element.html('<span name="land_line_item"></span>'), __html7 = new autogenerated.Element.html('<span template="" if="contact[\'addressesList\'] != null">\n                  <span name="contact_addresses"></span>\n                </span>'), __html8 = new autogenerated.Element.html('<span name="address_item_item"></span>');
  var __e25, __e26;
  var __t = new autogenerated.Template(__root);
  __e25 = __root.nodes[7].nodes[3];
  __t.conditional(__e25, () => showCCG, (__t) {
    var __e24;
    __e24 = __html0.clone(true);
    __t.loop(__e24, () => contactsBook.keys, ($list, $index, __t) {
      var groupName = $list[$index];
      var __e1, __e22, __e23;
      __e23 = __html1.clone(true);
      __e1 = __e23.nodes[1];
      var __binding0 = __t.contentBind(() => groupName, false);
      __e1.nodes.add(__binding0);
      __t.listen(__e1.onClick, ($event) { loadContactsListForGroup('$groupName', true, $event); });
      __e22 = __e23.nodes[3];
      __t.bind(() => groupName,  (__e) { __e22.id = '${__e.newValue}_contacts_list'; }, false);
      __t.loopIterateAttr(__e22, () => contactsBook['$groupName'], ($list, $index, __t) {
        var contact = $list[$index];
        var __e10, __e15, __e20, __e21, __e3, __e5;
        __e21 = __html2.clone(true);
        __e3 = __e21.nodes[1];
        var __binding2 = __t.contentBind(() =>  contact['name'] , false);
        __e3.nodes.addAll([new autogenerated.Text('\n                  '),
            __binding2,
            new autogenerated.Text('\n                ')]);
        __t.listen(__e3.onClick, ($event) { populateGeneralDialogWithContactDetails('$groupName', contact['_id']); });
        __e5 = __e21.nodes[3];
        var __binding4 = __t.contentBind(() =>  contact['comments'] == null ? "" : contact['comments'] , false);
        __e5.nodes.add(__binding4);
        __e10 = __e21.nodes[5];
        __t.conditional(__e10, () => contact['cellPhoneList'] != null, (__t) {
          var __e8, __e9;
          __e9 = __html3.clone(true);
          __e8 = __e9.nodes[1];
          __t.loopIterateAttr(__e8, () => contact['cellPhoneList'], ($list, $index, __t) {
            var cellPhone = $list[$index];
            var __e7;
            __e7 = __html4.clone(true);
            var __binding6 = __t.contentBind(() =>  cellPhone['network'] + '-'  + cellPhone['number'] , false);
            __e7.nodes.addAll([new autogenerated.Text('\n                        '),
                __binding6,
                new autogenerated.Text('\n                      ')]);
          __t.addAll([new autogenerated.Text('\n                      '),
              __e7,
              new autogenerated.Text('\n                  ')]);
          });
        __t.add(__e9);
        });

        __e15 = __e21.nodes[7];
        __t.conditional(__e15, () => contact['landLinesList'] != null, (__t) {
          var __e13, __e14;
          __e14 = __html5.clone(true);
          __e13 = __e14.nodes[1];
          __t.loopIterateAttr(__e13, () => contact['landLinesList'], ($list, $index, __t) {
            var landLine = $list[$index];
            var __e12;
            __e12 = __html6.clone(true);
            var __binding11 = __t.contentBind(() =>  landLine['country'] + '-'  + landLine['areaCode'] + '-'  + landLine['number'] , false);
            __e12.nodes.addAll([new autogenerated.Text('\n                        '),
                __binding11,
                new autogenerated.Text('\n                      ')]);
          __t.addAll([new autogenerated.Text('\n                      '),
              __e12,
              new autogenerated.Text('\n                  ')]);
          });
        __t.add(__e14);
        });

        __e20 = __e21.nodes[9];
        __t.conditional(__e20, () => contact['addressesList'] != null, (__t) {
          var __e18, __e19;
          __e19 = __html7.clone(true);
          __e18 = __e19.nodes[1];
          __t.loopIterateAttr(__e18, () => contact['addressesList'], ($list, $index, __t) {
            var address = $list[$index];
            var __e17;
            __e17 = __html8.clone(true);
            var __binding16 = __t.contentBind(() =>  address['address'] , false);
            __e17.nodes.addAll([new autogenerated.Text('\n                        '),
                __binding16,
                new autogenerated.Text('\n                      ')]);
          __t.addAll([new autogenerated.Text('\n                      '),
              __e17,
              new autogenerated.Text('\n                  ')]);
          });
        __t.add(__e19);
        });

      __t.addAll([new autogenerated.Text('\n              '),
          __e21,
          new autogenerated.Text(' \n            ')]);
      });
      __t.bind(() => groupName,  (__e) { __e23.id = '${__e.newValue}_group'; }, false);
    __t.addAll([new autogenerated.Text('\n          '),
        __e23,
        new autogenerated.Text('\n        ')]);
    });
  __t.addAll([new autogenerated.Text('\n        '),
      __e24,
      new autogenerated.Text('\n      ')]);
  });

  __e26 = __root.nodes[11].nodes[1].nodes[3];
  __t.listen(__e26.onClick, ($event) { closeGeneralDialog(); });
  __t.create();
  __t.insert();
}

//@ sourceMappingURL=contactsbookspa.dart.map