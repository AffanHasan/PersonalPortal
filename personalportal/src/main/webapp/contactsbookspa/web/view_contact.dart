part of contacts_book_spa;

/**
 * To populate the general dialog with the contact details
 */
void populateGeneralDialogWithContactDetails(String groupName, int index){
  launchGeneralDialog();
  List<JsonObject> contactsList = contactsBook[groupName].toList();
  contactsList.sort(//Sorting the contacts list by name
      (a, b){
        int name1 = a['_id'];
        int name2 = b['_id'];
        return name1.compareTo(name2);
      }
  );
  JsonObject contact = contactsList[index];
  print("Index : " + index.toString());
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
  if(contact.containsKey('comments')){
    nameCommentDiv.appendHtml("<label for='contact_comments'>"+cb_locale_data.getPropertyValue("comments")+": </label>");
    nameCommentDiv.appendText(contact['comments']);
  }
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
  emailSkypeFieldSetLegend.appendText(cb_locale_data.getPropertyValue("addEmail") + ', ' + cb_locale_data.getPropertyValue("skypeId"));
  emailSkypeFieldSet.append(emailSkypeFieldSetLegend);
  emailSkypeFieldSet.appendHtml("<div id='emails_div'></div>");//Append un ordered list of addresses to fieldset
  emailSkypeFieldSet.appendHtml("<div id='skype_div'></div>");//Append un ordered list of addresses to fieldset
  emailSkypeDiv.append(emailSkypeFieldSet);
  
  DivElement additionalInfoDiv = new DivElement();//Additional info div
  additionalInfoDiv.id="additional_info_div";
  additionalInfoDiv.appendHtml("<ul id='additional_info_list'></ul>");
  
  bodySection.append(nameCommentDiv);//append the name & comment div to body section
  bodySection.append(phonesDiv);//append the phones div to body section
  bodySection.append(addressDiv);//append the addresses div to body section
  bodySection.append(emailSkypeDiv);//append the email skype div
  bodySection.append(additionalInfoDiv);//append the additional info div
  
  if(contact['cellPhoneList'] != null)
    for(JsonObject cellPhoneItem in contact['cellPhoneList']){
      LIElement cellPhoneLE = new LIElement();//Create a list element
      if(cellPhoneItem.containsKey('comment')){
        cellPhoneLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
        cellPhoneLE.appendText(cellPhoneItem['comment']);
      }
      cellPhoneLE.appendText(cellPhoneItem['network'] + ' ' + cellPhoneItem['number']);
      query("#cell_phones_list").append(cellPhoneLE);//Appending this li to the unordered cell phones list
    }
  if(contact['landLinesList'] != null)
    for(JsonObject landLineItem in contact['landLinesList']){
      LIElement landLineLE = new LIElement();//Create a list element
      if(landLineItem.containsKey('comment')){
        landLineLE.appendHtml("<label>"+cb_locale_data.getPropertyValue("comments")+": </label>");
        landLineLE.appendText(landLineItem['comment']);
      }
      landLineLE.appendText(landLineItem['country'] +' '+ landLineItem['areaCode']+' '+landLineItem['number']);
      query("#land_lines_list").append(landLineLE);//Appending this li to the unordered cell phones list
    }
  if(contact['addressesList'] != null)
    for(JsonObject addressItem in contact['addressesList']){
      LIElement addressLE = new LIElement();//Create a list element
      addressLE.appendHtml("<label>   "+cb_locale_data.getPropertyValue("address")+": </label>");
      addressLE.appendText(addressItem['address']);
      if(addressItem.containsKey('comment')){
        addressLE.appendHtml("<label>"+ cb_locale_data.getPropertyValue("comments") +": </label>");
        addressLE.appendText(addressItem['comment']);
      }
      query("#addresses_list").append(addressLE);//Appending this li to the unordered cell phones list
    }
  if(contact['emailAddressesList'] != null){
    for(String emailItem in contact['emailAddressesList']){
      query("#emails_div").appendText(' $emailItem ');
    }
  }
  if(contact['skypeIdsList'] != null){
    for(String skypeId in contact['skypeIdsList']){
      query("#skype_div").appendText(' $skypeId ');
    }
  }
  if(contact.containsKey('additionalInfo')){
    for(String keyItem in contact['additionalInfo'].keys){
      query("#additional_info_list").appendText('$keyItem : ' + (contact['additionalInfo'])[keyItem]);
    }
  }
}