({
  setColumns: function (component) {
    component.set("v.columns", [
      { label: "Batalha", fieldName: "batalha", type: "text" },
      { label: "Contato", fieldName: "contato", type: "text" },
      { label: "Tipo de contato", fieldName: "tipo", type: "text" },
      { label: "Status da batalha", fieldName: "status", type: "text" },
      {
        type: "button",
        typeAttributes: {
          label: "Abrir",
          name: "View",
          title: "Clique aqui para abrir este registro",
          disabled: false,
          value: "view",
          iconPosition: "left"
        }
      },
      {
        type: "button",
        typeAttributes: {
          label: "Editar",
          name: "Edit",
          title: "Clique aqui para editar este registro",
          disabled: false
        }
      }
    ]);
  },
  fetchData: function (component) {
    console.log(">>> RECUPERANDO DADOS DO BACKEND APEX <<<");

    var action = component.get("c.getBatalhas");

    action.setCallback(this, function (response) {
      let error = response.getError();
      let state = response.getState();

      if (state == "SUCCESS") {
        var rows = response.getReturnValue();

        for (var i = 0; i < rows.length; i++) {
          var row = rows[i];
          if (row.Contato__r && row.Batalha__r) {
            row.batalha = row.Batalha__r.Name;
            row.contato = row.Contato__r.NomeDeGuerra__c;
            row.tipo = row.Contato__r.RecordType.Name;
            row.status = row.Batalha__r.Status__c;
          }
        }
        console.log("rows", rows);
        if (rows != null) {
          component.set("v.data", rows);
        }
      }
    });

    $A.enqueueAction(action);
  }
});
