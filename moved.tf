moved {
  from = azurerm_role_assignment.this
  to   = azurerm_role_assignment.this[0]
}
