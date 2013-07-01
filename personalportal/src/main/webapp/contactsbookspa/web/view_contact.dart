part of contacts_book_spa;

/**
 * To populate the general dialog with the contact details
 */
void populateGeneralDialogWithContactDetails(String groupName, String index){
  launchGeneralDialog();
  List<JsonObject> contactsList = contactsBook[groupName].toList();
  JsonObject contact = contactsList[index];
  print(contact.toString());
  query("#general_dialog_header_content").appendHtml("<h1>" + contact['name'].toUpperCase() +"</h1>");
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
  bodySection.appendText(groupName);
  
  DivElement nameCommentDiv = new DivElement();//Create new div to hold name & comments
  nameCommentDiv.id="name_comment_div";
  nameCommentDiv.appendHtml("<label for='contact_comments'>"+cb_locale_data.getPropertyValue("comments")+": </label>");
  nameCommentDiv.appendText(contact['comments']);
  DivElement phonesDiv = new DivElement();//Create new div to hold cell phones & land lines
  phonesDiv.id="phones_div";
  FieldSetElement phonesFieldSet = new FieldSetElement();
  LegendElement phonesFiledSetLegend = new LegendElement();
  phonesFiledSetLegend.appendText(cb_locale_data.getPropertyValue("phones"));
  phonesFieldSet.append(phonesFiledSetLegend);//Append legend to field set
  phonesFieldSet.appendHtml("<ul id='cell_phones_list'></ul>");//Append un ordered list of cell phones to field set
  phonesFieldSet.appendHtml("</br><ul id='land_lines_list'></ul>");//Append un ordered list of land lines to field set
  phonesDiv.append(phonesFieldSet);//Append field set to the phones_div
  
  DivElement addressDiv = new DivElement();//Create new div to hold Adresses
  addressDiv.id="addresses_div";
  FieldSetElement addressesFieldlSet = new FieldSetElement();
  LegendElement addressesFieldSetLegend = new LegendElement();//Legend element
  addressesFieldSetLegend.appendText(cb_locale_data.getPropertyValue("addresses"));
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
  
  if(contact['cellPhoneList'] != null)
    for(JsonObject cellPhoneItem in contact['cellPhoneList']){
      LIElement cellPhoneLE = new LIElement();//Create a list element
      cellPhoneLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      cellPhoneLE.appendText(cellPhoneItem['comment']);
      cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("network")+": </label>");
      cellPhoneLE.appendText(cellPhoneItem['network']);
      cellPhoneLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
      cellPhoneLE.appendText(cellPhoneItem['number']);
      query("#cell_phones_list").append(cellPhoneLE);//Appending this li to the unordered cell phones list
    }
  if(contact['landLinesList'] != null)
    for(JsonObject landLineItem in contact['landLinesList']){
      LIElement landLineLE = new LIElement();//Create a list element
      landLineLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      landLineLE.appendText(landLineItem['comment']);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("country")+": </label>");
      landLineLE.appendText(landLineItem['country']);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("cityAreacode")+": </label>");
      landLineLE.appendText(landLineItem['areaCode']);
      landLineLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("number")+": </label>");
      landLineLE.appendText(landLineItem['number']);
      query("#land_lines_list").append(landLineLE);//Appending this li to the unordered cell phones list
    }
  if(contact['addressesList'] != null)
    for(JsonObject addressItem in contact['addressesList']){
      LIElement addressLE = new LIElement();//Create a list element
      addressLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("address")+": </label>");
      addressLE.appendText(addressItem['address']);
      addressLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
      addressLE.appendText(addressItem['comment']);
      query("#addresses_list").append(addressLE);//Appending this li to the unordered cell phones list
    }
}