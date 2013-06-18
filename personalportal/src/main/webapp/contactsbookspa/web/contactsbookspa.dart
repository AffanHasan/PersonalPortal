import 'dart:html';
import 'dart:json' as json;
import 'package:lib/cb_locale_data.dart' as cb_locale_data;
import 'package:web_ui/web_ui.dart';
import "package:json_object/json_object.dart";
import "package:pp_commons/pp_common_ui.dart" as pp_comm_ui;

/**
 * Holds the contacts book state
 */
JsonObject contactsBook = new JsonObject();
ButtonElement addContactBtn = new ButtonElement();
ButtonElement addGroupBtn = new ButtonElement();

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
  DivElement data_container = query("#data_container");
  HttpRequest.getString(baseURL + "getContactsGroupList").then(
      (String responseText){
        DetailsElement group = new DetailsElement();
        String groupName;
        List<String> jsonList = json.parse(responseText);//Server returns json list of contacts groups
        if(jsonList.isEmpty){//If no contacts in this book
          //query("#data_container").appendText("Contacts book is empty");
        }
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
        window.alert("Under construction");
      }
  );
  query("#control_panel").append(addGroupBtn);
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

/**
 * To populate the general dialog with add contact UI
 */
void populateGeneralDialogForAddContact(){
  query("#general_dialog_header_content").appendHtml("<h1>" + cb_locale_data.getPropertyValue("addContact").toUpperCase() +"</h1>");
  HtmlElement bodySection = query("#general_dialog_body");
  SelectElement groupSelection = new SelectElement();
  groupSelection.id="add_contact_group_selection";
  groupSelection.children.add(new OptionElement("uncategorized", "uncategorized", true, true));
  bodySection.appendHtml("<label for='add_contact_group_selection'>Group: </label>");
  bodySection.append(groupSelection);//Add Group selection combo to pop up body section
  
  DivElement nameCommentDiv = new DivElement();//Create new div to hold name & comments
  nameCommentDiv.id="name_comment_div";
  TextInputElement namefield = new TextInputElement();
  namefield.id="contact_name";
  namefield.placeholder = "";
  nameCommentDiv.appendHtml("<label for='contact_name'>"+pp_comm_ui.getPropertyValue("name")+": </label>");
  nameCommentDiv.append(namefield);//append name input & it's label
  TextAreaElement contactCommentsTextArea = new TextAreaElement();//Create a comment text area
  contactCommentsTextArea.id="contact_comments";
  contactCommentsTextArea.placeholder = "";
  nameCommentDiv.appendHtml("<label for='contact_comments'>"+cb_locale_data.getPropertyValue("comments")+": </label>");
  nameCommentDiv.append(contactCommentsTextArea);//append name input & it's label
  
  DivElement phonesDiv = new DivElement();//Create new div to hold cell phones & land lines
  phonesDiv.id="phones_div";
  FieldSetElement phonesFieldSet = new FieldSetElement();
  LegendElement phonesFiledSetLegend = new LegendElement();
  ButtonElement addCellPhoneBtn = new ButtonElement();//Add cell phone button
  addCellPhoneBtn.id="add_cell_phone_btn";
  addCellPhoneBtn.text="📶";
  addCellPhoneBtn.title=cb_locale_data.getPropertyValue("addCell");
  addCellPhoneBtn.onClick.listen(
      (Event e){
        LIElement cellPhoneLE = new LIElement();//Create a list element
        cellPhoneLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
        InputElement comment = new InputElement();
        comment.name="cell_comment";
        cellPhoneLE.append(comment);
        cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("network")+": </label>");
        InputElement network = new InputElement(type: "tel");
        network.name="cell_network";
        cellPhoneLE.append(network);
        cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
        InputElement number = new InputElement(type: "tel");
        number.name="cell_number";
        cellPhoneLE.append(number);
        query("#cell_phones_list").append(cellPhoneLE);//Appending this li to the unordered cell phones list
      }
  );
  ButtonElement addLandLineBtn = new ButtonElement();//Add cell phone button
  addLandLineBtn.id="add_land_line_btn";
  addLandLineBtn.text="☎";
  addLandLineBtn.title=cb_locale_data.getPropertyValue("addLandLine");
  addLandLineBtn.onClick.listen(
      (Event e){
        LIElement landLineLE = new LIElement();//Create a list element
        landLineLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
        InputElement comment = new InputElement();
        comment.name="land_line_comment";
        landLineLE.append(comment);
        landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("country")+": </label>");
        InputElement country = new InputElement(type: "tel");
        country.name="line_country";
        landLineLE.append(country);
        landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("cityAreacode")+": </label>");
        InputElement areaCode = new InputElement(type: "tel");
        areaCode.name="area_code";
        landLineLE.append(areaCode);
        landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
        InputElement number = new InputElement(type: "tel");
        number.name="line_number";
        landLineLE.append(number);
        query("#land_lines_list").append(landLineLE);//Appending this li to the unordered cell phones list
      }
  );
  phonesFiledSetLegend.append(addCellPhoneBtn);//Append land line button to legend
  phonesFiledSetLegend.append(addLandLineBtn);//Append cell phone button to legend
  phonesFieldSet.append(phonesFiledSetLegend);//Append legend to field set
  phonesFieldSet.appendHtml("<ul id='cell_phones_list'></ul>");//Append un ordered list of cell phones to field set
  phonesFieldSet.appendHtml("</br><ul id='land_lines_list'></ul>");//Append un ordered list of land lines to field set
  phonesDiv.append(phonesFieldSet);//Append field set to the phones_div
  
  DivElement addressDiv = new DivElement();//Create new div to hold Adresses
  phonesDiv.id="addresses_div";
  FieldSetElement addressesFieldlSet = new FieldSetElement();
  LegendElement addressesFieldSetLegend = new LegendElement();//Legend element
  ButtonElement addressesFieldSetLegendBTN = new ButtonElement();//Legend element button
  addressesFieldSetLegendBTN.text = "⌂";
  addressesFieldSetLegendBTN.onClick.listen(//Legend button onclick EH
      (Event e){
        LIElement addressLE = new LIElement();//Create a list element
        addressLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("address")+": </label>");
        TextAreaElement address = new TextAreaElement();
        address.name="address_txt";
        addressLE.append(address);//append address input
        addressLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
        InputElement comment = new InputElement();
        comment.name="address_comment";
        addressLE.append(comment);//append comment input
        query("#addresses_list").append(addressLE);//Appending this li to the unordered cell phones list
      }
  );
  addressesFieldSetLegend.append(addressesFieldSetLegendBTN);
  addressesFieldlSet.append(addressesFieldSetLegend);
  addressesFieldlSet.appendHtml("<ul id='addresses_list'></ul>");//Append un ordered list of addresses to fieldset
  addressDiv.append(addressesFieldlSet);//append fieldset to addressDiv
  
  bodySection.append(nameCommentDiv);//append the name & comment div to body section
  bodySection.append(phonesDiv);//append the phones div to body section
  bodySection.append(addressDiv);//append the addresses div to body section
  
  HtmlElement dialogFooter = query("#general_dialog_footer");//Footer of the general dialog
  ButtonElement addContactSaveBtn = new ButtonElement();//Save button for add contact dialog
  addContactSaveBtn.id="add_contact_save_btn";
  addContactSaveBtn.text="Save";
  addContactSaveBtn.onClick.listen(//Add contact save operation
      (Event e){
        JsonObject contact = new JsonObject();
        InputElement fieldInput = query("#contact_name");
        contact.name = fieldInput.value;
        fieldInput = query("#contact_comments");
        contact.comments = fieldInput.value;
        List<LIElement> cellPhonesList = query("#cell_phones_list").children;
        if(!cellPhonesList.isEmpty){
          contact.cellPhoneList = new List<JsonObject>();
          JsonObject cellPhone;
          InputElement cellInput;
          for(LIElement cell in cellPhonesList){
            cellPhone = new JsonObject();
            cellInput = cell.children[1];
            cellPhone.comment = cellInput.value;
            cellInput = cell.children[3];
            cellPhone.network = cellInput.value;
            cellInput = cell.children[5];
            cellPhone.number = cellInput.value;
            contact.cellPhoneList.add(cellPhone); 
          }
        }
        //Getting group name
        SelectElement groupInput = query("#add_contact_group_selection");
        JsonObject requestData = new JsonObject();
        requestData[groupInput.value] = contact;
        print(json.stringify(requestData));
        //Sending the post request to the server
        HttpRequest request = new HttpRequest();
        request.open("POST", baseURL + "addSingleContact", async: true);
        request.send(json.stringify(requestData));
        closeGeneralDialog();
      }
  );
  dialogFooter.append(addContactSaveBtn);
}