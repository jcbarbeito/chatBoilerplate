@view_user
Feature: View User data
  In order to find interest people to meet, I need to list them and view their profiles

  @view_user_list
  Scenario: List users
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
    And The tile is "Lista de usuarios, haz amigos y encuentra tu media naranja"
    And The meta data is:
      | description | Encuentra gente interesante para conocer, comparte fotos y chatea con ell@s |
    Then the API url "/api/users?limit=30&offset=0&filters=language%3Des" should have been called
    And I should see 30 users
    And I should see that there are 2 pages
    And I should see the following users with there profile photo and link to the profile:
      | Emily   | Rothville  | http://api.chateagratis.local/uploads/2_medium.jpg | /usuarios/emily-2   |
      | Selena4 | West Cowes | http://api.chateagratis.local/uploads/3_medium.jpg | /usuarios/selena4-3 |
      | Mia     | Ouzinkie   | http://api.chateagratis.local/uploads/4_medium.jpg | /usuarios/mia-4     |

  @view_user_profile
  Scenario: View user profile
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
      And I click "Emily"
     Then The tile is "Información personal de Emily"
      And The meta data is:
        | description | Información personal de Emily, ve fotos y chatea gratis con Emily |
      And  I should see the following profile information:
        | Nombre de usuario | Emily     |
        | Localización      | Rothville |
        | Edad              |           | #ponemos age vacio para que no peten los test cada año
        | Genero            | Mujer     |
        | Estoy buscando	| Mujeres   |
      And I should see the cover "Canales de los cuales es propietario" and container "channels" and the table:
        | sfdg   |
        | Canada |
      And I should see the cover "Canales de los cuales es moderador" and container "channels_moderator" and the table:
        | sfdg   |
        | Canada |
      And I should see the cover "Canales de los cuales es fan" and container "channels_fan" and the table:
        | Columbia |

  @view_user_profile
  Scenario: To view users photos I need to login
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
      And I click "Emily"
     Then The tile is "Información personal de Emily"
      And The meta data is:
        | description | Información personal de Emily, ve fotos y chatea gratis con Emily |
     When I click "Fotos"
     Then I should be on "/usuario/login"

  @view_user_profile
  Scenario: View users photos as loged in user
    Given I am logedin
      And I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
      And I click "Emily"
      And I click "Fotos"
     Then I should be on "/usuarios/2/fotos"
      And I should see "Fotos de Emily"
      And I should see 19 photos

  @view_user_profile
  Scenario: View a users photo as loged in user
    Given I am logedin
      And I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
      And I click "Emily"
      And I click "Fotos"
      And I click on the first photo
     Then I should be on "/usuarios/2/foto/495"
      And I should see "Jefazo"