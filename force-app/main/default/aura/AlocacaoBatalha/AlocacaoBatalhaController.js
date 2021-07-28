({
  init: function (component, event, helper) {
    // chamado quando a página carregar e executar
    alert("Carregou");
    helper.setColumns(component);
    helper.fetchData(component);
  },
  handleClick: function (component, event, helper) {}
});
