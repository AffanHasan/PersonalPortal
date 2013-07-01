part of contacts_book_spa;

/**
 * To populate the general dialog with add contact UI
 */
void populateGeneralDialogForAddGroup(){
  query("#general_dialog_header_content").appendHtml("<h1>" + cb_locale_data.getPropertyValue("addGroup").toUpperCase() +"</h1>");
  HtmlElement bodySection = query("#general_dialog_body");//Body of the general dialog
  bodySection.appendHtml("<label>"+ pp_comm_ui.getPropertyValue("name") + ": " +"</label>");
  InputElement groupNameInput = new InputElement();
  groupNameInput.id = "new_goup_name_input";
  groupNameInput.onChange.listen(
    (Event e){
      if(contactsBook.containsKey(groupNameInput.value)){
        window.alert(cb_locale_data.getPropertyValue("alreadyExist"));
        groupNameInput.value = "";
        clearGeneralDialogFooterAddGroup();
      }else{
        if(!groupNameInput.value.trim().isEmpty){
          clearGeneralDialogFooterAddGroup();
          populateGeneralDialogFooterAddGroup();
          return;
        }
        clearGeneralDialogFooterAddGroup();
        return;
      }
    }
  );
  bodySection.append(groupNameInput);
}

void clearGeneralDialogFooterAddGroup(){
  query("#general_dialog_footer").innerHtml = "";
}

void populateGeneralDialogFooterAddGroup(){
  HtmlElement dialogFooter = query("#general_dialog_footer");//Footer of the general dialog
  ButtonElement createGroupBtn = new ButtonElement();
  createGroupBtn.id='create_group_btn';
  createGroupBtn.text = cb_locale_data.getPropertyValue("create");
  createGroupBtn.onClick.listen(
      (Event e){
        InputElement groupNameInput = query('#new_goup_name_input');
        //Preparing request data
        JsonObject requestData = new JsonObject();
        requestData["groupName"] = groupNameInput.value;
        //Sending the post request to the server
        HttpRequest request = new HttpRequest();
        // add an event handler that is called when the request finishes
        request.onReadyStateChange.listen((_) {
          if (request.readyState == HttpRequest.DONE &&
              (request.status == 200 || request.status == 0)) {
            if(request.responseText.startsWith("saved")){//Close general dialog only if save is success full
              contactsBook[groupNameInput.value] = "";
              watchers.dispatch();
              closeGeneralDialog();
            }
            else{
            }
          }
        });
        request.open("POST", baseURL + "createNewGroup", async: false);
        request.send(json.stringify(requestData));
      }
  );
  dialogFooter.append(createGroupBtn);
}