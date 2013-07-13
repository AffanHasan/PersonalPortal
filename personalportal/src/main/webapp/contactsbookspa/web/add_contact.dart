part of contacts_book_spa;

ButtonElement addContactBtn = new ButtonElement();

/**
 * To populate the general dialog with add contact UI
 */
void populateGeneralDialogForAddContact(){
  query("#general_dialog_header_content").appendHtml("<h1>" + cb_locale_data.getPropertyValue("addContact").toUpperCase() +"</h1>");
  HtmlElement bodySection = query("#general_dialog_body");
  SelectElement groupSelection = new SelectElement();
  groupSelection.id="add_contact_group_selection";
  if(!contactsBook.containsKey(cb_locale_data.getPropertyValue("uncategorizedGroup")))
    groupSelection.children.add(new OptionElement(cb_locale_data.getPropertyValue("uncategorizedGroup"), 
                                                  cb_locale_data.getPropertyValue("uncategorizedGroup"), true, true));
  for(String item in contactsBook.keys){
    groupSelection.children.add(new OptionElement(item));
  }
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
  addressDiv.id="addresses_div";
  FieldSetElement addressesFieldlSet = new FieldSetElement();
  LegendElement addressesFieldSetLegend = new LegendElement();//Legend element
  ButtonElement addressesFieldSetLegendBTN = new ButtonElement();//Legend element button
  addressesFieldSetLegendBTN.text = "⌂";
  addressesFieldSetLegendBTN.title = cb_locale_data.getPropertyValue("address");
  addressesFieldSetLegendBTN.onClick.listen(//Legend button onclick EH
      (Event e){
        LIElement addressLE = new LIElement();//Create a list element
        addressLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("address")+": </label>");
        TextAreaElement address = new TextAreaElement();
        address.style.height = "70px";
        address.style.width = "500px";
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
  
  DivElement emailSkypeDiv = new DivElement();//Create new div to hold emails and skype ids
  emailSkypeDiv.id="email_skype_div";
  FieldSetElement emailSkypeFieldSet = new FieldSetElement();
  LegendElement emailSkypeFieldSetLegend = new LegendElement();//Legend element
  ButtonElement emailBTN = new ButtonElement();//Legend element button
  emailBTN.id="add_email_btn";
  emailBTN.text="@";
  emailBTN.title = cb_locale_data.getPropertyValue("addEmail");
  emailBTN.onClick.listen(
      (Event e){
        InputElement emailInput = new InputElement(type: "email");
        emailInput.name="email_input";
        query("#emails_div").appendHtml("<label>" + cb_locale_data.getPropertyValue("addEmail") + ": " + "</label>");
        query("#emails_div").append(emailInput);
      }
  );
  
  ButtonElement skypeBTN = new ButtonElement();//Legend element button
  skypeBTN.id="add_skype_btn";
  skypeBTN.text=cb_locale_data.getPropertyValue("skypeId");
  skypeBTN.onClick.listen(
      (Event e){
        InputElement skypeInput = new InputElement();
        skypeInput.name="skype_input";
        query("#skype_div").appendHtml("<label>" + cb_locale_data.getPropertyValue("skypeId") + ": " + "</label>");
        query("#skype_div").append(skypeInput);
      }
  );

  emailSkypeFieldSetLegend.append(emailBTN);
  emailSkypeFieldSetLegend.append(skypeBTN);
  emailSkypeFieldSet.append(emailSkypeFieldSetLegend);
  emailSkypeFieldSet.appendHtml("<div id='emails_div'></div>");//Append un ordered list of addresses to fieldset
  emailSkypeFieldSet.appendHtml("<div id='skype_div'></div>");//Append un ordered list of addresses to fieldset
  emailSkypeDiv.append(emailSkypeFieldSet);
  
  DivElement additionalInfoDiv = new DivElement();//Additional info div
  additionalInfoDiv.id="additional_info_div";
  ButtonElement additionalInfoBTN = new ButtonElement();//Additional Info Button
  additionalInfoBTN.id="additional_infoBTN";
  additionalInfoBTN.text=cb_locale_data.getPropertyValue("additionalInfo");
  additionalInfoBTN.onClick.listen(
      (Event e){
        additionalInfoDiv.appendHtml("</br>");
        LIElement additionalInfoItem = new LIElement();
        InputElement additionalInfoFieldName = new InputElement();
        additionalInfoFieldName.name="additional_info_field_name";
        TextAreaElement additionalInfoText = new TextAreaElement();
        additionalInfoText.name="additional_info_txt";
        additionalInfoItem.appendHtml("<label>"+ cb_locale_data.getPropertyValue("fieldName") +": </label>");
        additionalInfoItem.append(additionalInfoFieldName);
        additionalInfoItem.append(additionalInfoText);
        query("#additional_info_list").append(additionalInfoItem);
      }
  );
  
  additionalInfoDiv.append(additionalInfoBTN);
  additionalInfoDiv.appendHtml("<ul id='additional_info_list'></ul>");
  
  bodySection.append(nameCommentDiv);//append the name & comment div to body section
  bodySection.append(phonesDiv);//append the phones div to body section
  bodySection.append(addressDiv);//append the addresses div to body section
  bodySection.append(emailSkypeDiv);//append the email skype div
  bodySection.append(additionalInfoDiv);//append the additional info div
  
  HtmlElement dialogFooter = query("#general_dialog_footer");//Footer of the general dialog
  ButtonElement addContactSaveBtn = new ButtonElement();//Save button for add contact dialog
  addContactSaveBtn.id="add_contact_save_btn";
  addContactSaveBtn.text="Save";
  addContactSaveBtn.onClick.listen(addContactSaveOperation);
  dialogFooter.append(addContactSaveBtn);
}

/**
 * Collects the data from the add contact screen validate it & then parse it into JSON and then send's it as a part of HTTP post request to the server
 * returns true if save successfull
 * */
void addContactSaveOperation(Event e, [String caller, int id]){
  JsonObject contact = new JsonObject();
  InputElement fieldInput = query("#contact_name");
  contact.name = fieldInput.value;
  fieldInput = query("#contact_comments");
  if(!fieldInput.value.isEmpty){
    contact.comments = fieldInput.value;
  }
  //Getting Cell Phones
  List<LIElement> cellPhonesList = query("#cell_phones_list").children;
  if(!cellPhonesList.isEmpty){
    JsonObject cellPhone;
    InputElement cellInput;
    for(LIElement cell in cellPhonesList){
      cellPhone = new JsonObject();
      cellInput = cell.children[1];
      if(!cellInput.value.isEmpty)
      cellPhone.comment = cellInput.value;
      cellInput = cell.children[3];
      cellPhone.network = cellInput.value;
      cellInput = cell.children[5];
      cellPhone.number = cellInput.value;
      if(!cellPhone.number.isEmpty && !cellPhone.network.isEmpty){
        if(!contact.containsKey("cellPhoneList")){
          contact.cellPhoneList = new List<JsonObject>();
        }
        contact.cellPhoneList.add(cellPhone); 
      }
    }
  }
  //Getting Land Lines
  List<LIElement> landLinesList = query("#land_lines_list").children;
  if(!landLinesList.isEmpty){
    JsonObject landLinePhone;
    InputElement landLineInput;
    for(LIElement landLine in landLinesList){
      landLinePhone = new JsonObject();
      landLineInput = landLine.children[1];
      if(!landLineInput.value.isEmpty)
      landLinePhone.comment = landLineInput.value;
      landLineInput = landLine.children[3];
      landLinePhone.country = landLineInput.value;
      landLineInput = landLine.children[5];
      landLinePhone.areaCode = landLineInput.value;
      landLineInput = landLine.children[7];
      landLinePhone.number = landLineInput.value;
      if(!landLinePhone.country.isEmpty && !landLinePhone.areaCode.isEmpty && !landLinePhone.number.isEmpty){
        if(!contact.containsKey("landLinesList"))
          contact.landLinesList = new List<JsonObject>();
        contact.landLinesList.add(landLinePhone); 
      }
    }
  }
  //Getting the addresses
  HtmlElement addressesList = query("#addresses_list");
  if(!addressesList.children.isEmpty){//If user entered an address
    JsonObject addressObject;
    InputElement input;
    for(LIElement address in addressesList.children){
      addressObject = new JsonObject();
      input = address.children[1];
      addressObject.address = input.value;
      input = address.children[3];
      if(!input.value.isEmpty)
        addressObject.comment = input.value;
      if(!addressObject.address.isEmpty){
        if(!contact.containsKey("addressesList"))
          contact.addressesList = new List<JsonObject>();
        if(!addressObject.address.isEmpty)
          contact.addressesList.add(addressObject);
      }
    }
  }
  //Getting the skypeId and email
  List<InputElement> emailInputs = document.getElementsByName("email_input");
  if(!emailInputs.isEmpty){
    for(InputElement email in emailInputs){
      if(!email.value.trim().isEmpty){
        if(!contact.containsKey("emailAddressesList")){
          contact.emailAddressesList = new List<String>();
          contact.emailAddressesList.add(email.value);
        }
        else
          contact.emailAddressesList.add(email.value);
      }
    }
  }
  List<InputElement> skypeIdInputs = document.getElementsByName("skype_input");
  if(!skypeIdInputs.isEmpty){
    for(InputElement skypeId in skypeIdInputs){
      if(!skypeId.value.trim().isEmpty){
        if(!contact.containsKey("skypeIdsList")){
          contact.skypeIdsList = new List<String>();
          contact.skypeIdsList.add(skypeId.value);
        }
        else{
          contact.skypeIdsList.add(skypeId.value);
        }
      }
    }
  }
  //Getting the additional information
  List<LIElement> addInfoItemList = query("#additional_info_list").children;
  if(addInfoItemList != null && !addInfoItemList.isEmpty){
    //We are embedding the additional info in a document becoz the lesser the number of keysz the better the performance!
    contact['additionalInfo'] = new JsonObject();
  }
  for(LIElement item in addInfoItemList){
    InputElement input = item.children[1];
    InputElement input2 = item.children[2];
    if(!input.value.isEmpty && !input2.value.isEmpty){
      //contact[input.value] = input2.value;
      (contact['additionalInfo'])[input.value] = input2.value;
    }
  }
  //Validating the contact document
  if(contact.name.isEmpty){
    window.alert(pp_comm_ui.getPropertyValue("name") + " : " + cb_locale_data.getPropertyValue("required"));
    return;
  }
  //Preparing request data
  JsonObject requestData = new JsonObject();
  //Getting group name
  SelectElement groupInput = query("#add_contact_group_selection");
  requestData["groupName"] = groupInput.value;
  List<JsonObject> contactsList;
  if(!contactsBook.containsKey(groupInput.value))
    contactsBook[groupInput.value] = "";
  if(!contactsBook[groupInput.value].isEmpty){
    contactsList = contactsBook[groupInput.value].toList();
  }
  else{
    print("Loading from server list is empty");
    loadContactsListForGroup(groupInput.value, false, null);
    contactsList = contactsBook[groupInput.value].toList();
  }
  //Assigning this contact an id for this group
  print('Caller is');print(caller);
  if(caller == 'edit_contact'){//If editing a contact
    contact['_id'] = id;
    contactsList[id] = contact;
  }
  else{//If adding a new contact
    int id = 0;
    for(JsonObject item in contactsList){//Get the biggest id value
      if(item['_id'] > id)
        id = item['_id'];
    }
    contact['_id'] = id == 0 ? 0 : ++id;
    contactsList.add(contact);
  }
  contactsList.sort(//Sorting the contacts list by name
      (a, b){
        String name1 = a['name'];
        String name2 = b['name'];
        return name1.compareTo(name2);
      }
  );
  requestData["contactsList"] = contactsList;
  //Updating the contacts list for this group
  contactsBook[groupInput.value] = contactsList;
  //Sending the post request to the server
  HttpRequest request = new HttpRequest();
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      if(request.responseText.startsWith("saved")){//Close general dialog only if save is success full
        watchers.dispatch();
        closeGeneralDialog();
      }
      else{
      }
    }
  });
  request.open("POST", baseURL + "addSingleContact", async: false);
  request.send(json.stringify(requestData));
}