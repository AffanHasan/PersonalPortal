import 'dart:html';
import 'dart:json' as json;
import 'package:web_ui/web_ui.dart';

String baseURL = "http://localhost:8080/personalportal/ContactsBook?action=";
bool showCCG = true;//Initially collapsable_contacts_grouping wil be rendered
bool showCS = false;//contacts_search will be enabled when user starts typing in the text bar

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
  
  //TODO : Render basic UI
  renderBasicUI();
  
  //TODO : Load initial data container
  loadDataContainerInitially();
}

void loadDataContainerInitially(){
  query('#control_panel').appendHtml("<h1>Contacts Book</h1>");
}

void renderBasicUI(){
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