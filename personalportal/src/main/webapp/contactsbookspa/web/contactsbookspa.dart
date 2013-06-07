import 'dart:html';
import 'dart:json' as json;
import 'package:web_ui/web_ui.dart';

String baseURL = "http://localhost:8080/personalportal/ContactsBook?action=";
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
  //loadDataContainerOnFirstLoad();
}

/**
 * To render the basic user interface div on application start up
 */
void renderBasicUIOnFirstLoad(){
  query("#application_header").appendHtml("<h1>Contacts Book</h1>");
  renderControlsPanelOnFirstLoad();
}

/**
 * To load the data_container div on application start up
 */
void loadDataContainerOnFirstLoad(){
  DivElement data_container = query("#data_container");
  //data_container.children.clear(); commented because this was creating problems with template instantiation
  HttpRequest.getString(baseURL + "getContactsGroupList").then(
      (String responseText){
        DetailsElement group = new DetailsElement();
        String groupName;
        List<String> jsonList = json.parse(responseText);//Server returns json list of contacts groups
        if(jsonList.isEmpty)//If no contacts in this book
          query("#data_container").appendText("Contacts book is empty");
        else
          for(int i = 0; i < jsonList.length; i++ ){
            groupName = jsonList[i].toString();
            group = new DetailsElement();
            group.appendHtml("<summary>$groupName</summary>");
            query("#data_container").children.add(group);
          }
      }
  );
}

/**
 * To render the controls panel on application start up 
 */
void renderControlsPanelOnFirstLoad(){
}

/**
 * To launch the general dialog use this function and pass the type of action as string parameter
 */
void launchGeneralDialog(String action){
  query("#overlay_shield").style.display = "inline";
  query("#general_dialog").style.display = "inline";
  switch(action){
    case "addContact":
      populateGeneralDialogForAddContact();
      break;
  }
}

void closeGeneralDialog(){
  query("#overlay_shield").style.display = "none";
  query("#general_dialog").style.display = "none";
  query("#general_dialog_header_content").innerHtml = "";
  query("#general_dialog_body").innerHtml = "";
  query("#general_dialog_footer").innerHtml = "";
}

/**
 * To populate the general dialog with add contact UI
 */
void populateGeneralDialogForAddContact(){
  query("#general_dialog_header_content").appendHtml("<h1>ADD CONTACT</h1>");
}

void submitGeneralDialog(String action){
  HttpRequest request = new HttpRequest();
  request.open("POST", baseURL + action);
  request.send("document : {favoriteNumber:44,valueOfPi:3.141592,chocolate:true,horrorScope:virgo,favoriteThings:[raindrops,whiskers,mittens]}");
}