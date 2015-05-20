Feature: I need to be able to reset my password if I forget it

  @reset_password
  Scenario: Reset a password
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Resetear contraseña"
      And I fill in "reset_password_email" with "anemail@address.com"
      And I press "Reestablecer"
     Then I should see "Se ha enviado un email a an**@add***.**. Contiene un enlace de activación que debes presionar para activar tu cuenta. "