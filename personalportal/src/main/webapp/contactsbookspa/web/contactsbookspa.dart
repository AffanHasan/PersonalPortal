import 'dart:html';
import 'dart:json' as json;
import 'package:web_ui/web_ui.dart';

String baseURL = "http://localhost:8080/personalportal/ContactsBook?action=";

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
  data_container.children.clear();
  HttpRequest.getString(baseURL + "getContactsGroupList").then(
      (String responseText){
        List<String> jsonList = json.parse(responseText);
        LIElement groupsList = new LIElement();
        for(int i = 0; i < jsonList.length; i++ ){
          groupsList.children.add(new LIElement()..text = jsonList[i] );
        }
        data_container.children.add(groupsList);
      }
  );
}
