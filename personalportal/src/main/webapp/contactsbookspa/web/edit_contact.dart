part of contacts_book_spa;

/**
 * To populate the general dialog with add contact UI
 */
void populateGeneralDialogForEditContact(String groupName, int index){
  launchGeneralDialog();
  List<JsonObject> contactsList = contactsBook[groupName].toList();
  JsonObject contact;
  for(JsonObject item in contactsList){
    if(item['_id'] == index){
      contact = item;
      break;
    }
  }
  query("#general_dialog_header_content").appendHtml("<h1>" + contact['name'].toUpperCase() +"</h1>");
  HtmlElement bodySection = query("#general_dialog_body");
  SelectElement groupSelection = new SelectElement();
  groupSelection.id="add_contact_group_selection";
  groupSelection.children.add(new OptionElement(groupName));
  for(String item in contactsBook.keys){
    if(item != groupName)
      groupSelection.children.add(new OptionElement(item));
  }
  if(!contactsBook.containsKey(cb_locale_data.getPropertyValue("uncategorizedGroup")))
    groupSelection.children.add(new OptionElement(cb_locale_data.getPropertyValue("uncategorizedGroup"), 
                                                  cb_locale_data.getPropertyValue("uncategorizedGroup"), true, true));
  bodySection.appendHtml("<label for='add_contact_group_selection'>Group: </label>");
  bodySection.append(groupSelection);//Add Group selection combo to pop up body section
  
  DivElement nameCommentDiv = new DivElement();//Create new div to hold name & comments
  nameCommentDiv.id="name_comment_div";
  TextInputElement namefield = new TextInputElement();
  namefield.id="contact_name";
  namefield.value = contact['name'];
  nameCommentDiv.appendHtml("<label for='contact_name'>"+pp_comm_ui.getPropertyValue("name")+": </label>");
  nameCommentDiv.append(namefield);//append name input & it's label
  TextAreaElement contactCommentsTextArea = new TextAreaElement();//Create a comment text area
  contactCommentsTextArea.id="contact_comments";
  contactCommentsTextArea.value = (contact['comments'] == null) ? "" : contact['comments'];
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
  addContactSaveBtn.onClick.listen(
      (Event e){
        print('Calling addContactSaveOperation params null, edit_contact, $index');
        addContactSaveOperation(null, "edit_contact", index);
      }
  );
  dialogFooter.append(addContactSaveBtn);
  
  //Populating the pre filled input fields depending upon the contact data
  if(contact['cellPhoneList'] != null)
    for(JsonObject cellPhoneItem in contact['cellPhoneList']){
      LIElement cellPhoneLE = new LIElement();//Create a list element
      cellPhoneLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      InputElement comment = new InputElement();
      comment.name="cell_comment";
      comment.value = (cellPhoneItem['comment'] == null) ? "" : cellPhoneItem['comment'];
      cellPhoneLE.append(comment);
      cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("network")+": </label>");
      InputElement network = new InputElement(type: "tel");
      network.name="cell_network";
      network.value = cellPhoneItem['network'];
      cellPhoneLE.append(network);
      cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
      InputElement number = new InputElement(type: "tel");
      number.name="cell_number";
      number.value = cellPhoneItem['number'];
      cellPhoneLE.append(number);
      query("#cell_phones_list").append(cellPhoneLE);//Appending this li to the unordered cell phones list
    }
  if(contact['landLinesList'] != null)
    for(JsonObject landLineItem in contact['landLinesList']){
      LIElement landLineLE = new LIElement();//Create a list element
      landLineLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      InputElement comment = new InputElement();
      comment.name="land_line_comment";
      comment.value = (landLineItem['comment'] == null) ? "" : landLineItem['comment'];
      landLineLE.append(comment);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("country")+": </label>");
      InputElement country = new InputElement(type: "tel");
      country.name="line_country";
      country.value = landLineItem['country'];
      landLineLE.append(country);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("cityAreacode")+": </label>");
      InputElement areaCode = new InputElement(type: "tel");
      areaCode.name="area_code";
      areaCode.value = landLineItem['areaCode'];
      landLineLE.append(areaCode);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
      InputElement number = new InputElement(type: "tel");
      number.name="line_number";
      number.value = landLineItem['number'];
      landLineLE.append(number);
      query("#land_lines_list").append(landLineLE);//Appending this li to the unordered cell phones list
    }
  if(contact['addressesList'] != null)
    for(JsonObject addressItem in contact['addressesList']){
      LIElement addressLE = new LIElement();//Create a list element
      addressLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("address")+": </label>");
      TextAreaElement address = new TextAreaElement();
      address.style.height = "70px";
      address.style.width = "500px";
      address.name="address_txt";
      address.value = addressItem['address'];
      addressLE.append(address);//append address input
      addressLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      InputElement comment = new InputElement();
      comment.name="address_comment";
      comment.value = addressItem['comment'] == null ? "" : addressItem['comment'];
      addressLE.append(comment);//append comment input
      query("#addresses_list").append(addressLE);//Appending this li to the unordered cell phones list
    }
  if(contact['emailAddressesList'] != null){
    for(String emailItem in contact['emailAddressesList']){
      InputElement emailInput = new InputElement(type: "email");
      emailInput.name="email_input";
      emailInput.value = emailItem;
      query("#emails_div").appendHtml("<label>" + cb_locale_data.getPropertyValue("addEmail") + ": " + "</label>");
      query("#emails_div").append(emailInput);
    }
  }
  if(contact['skypeIdsList'] != null){
    for(String skypeId in contact['skypeIdsList']){
      InputElement skypeInput = new InputElement();
      skypeInput.name="skype_input";
      skypeInput.value = skypeId;
      query("#skype_div").appendHtml("<label>" + cb_locale_data.getPropertyValue("skypeId") + ": " + "</label>");
      query("#skype_div").append(skypeInput);
    }
  }
  if(contact.containsKey('additionalInfo')){
    for(String keyItem in contact['additionalInfo'].keys){
      additionalInfoDiv.appendHtml("</br>");
      LIElement additionalInfoItem = new LIElement();
      InputElement additionalInfoFieldName = new InputElement();
      additionalInfoFieldName.name="additional_info_field_name";
      additionalInfoFieldName.value = keyItem;
      TextAreaElement additionalInfoText = new TextAreaElement();
      additionalInfoText.name="additional_info_txt";
      additionalInfoText.value= contact['additionalInfo'][keyItem];
      
      additionalInfoItem.appendHtml("<label>"+ cb_locale_data.getPropertyValue("fieldName") +": </label>");
      additionalInfoItem.append(additionalInfoFieldName);
      additionalInfoItem.append(additionalInfoText);
      query("#additional_info_list").append(additionalInfoItem);
    }
  }
}