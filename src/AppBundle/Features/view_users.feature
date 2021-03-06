@view_user @part_from_index
Feature: View User data
  In order to find interest people to meet, I need to list them and view their profiles

  @view_user_list @view_users
  Scenario: List users
  Given I am on "http://boilerplatele.local/app_dev.php"
   When I click "Usuarios"
   Then the API url "/api/users?limit=30&offset=0&filters=language%3Des&order=hasProfilePhoto%3Ddesc%2ClastLogin%3Ddesc" should have been called
    And I should see that there are 2 pages
    And I should see the following users with there profile photo and link to the profile:
      | Emily   | Rothville  | http://api.chateagratis.local/uploads/2_medium.jpg | /usuarios/emily-2   |
      | Selena4 | West Cowes | http://api.chateagratis.local/uploads/3_medium.jpg | /usuarios/selena4-3 |
      | Mia     | Ouzinkie   | http://api.chateagratis.local/uploads/4_medium.jpg | /usuarios/mia-4     |

  @view_user_profile @view_users
  Scenario: View user profile
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
     Then the API url "/api/users?limit=30&offset=0&filters=language%3Des&order=hasProfilePhoto%3Ddesc%2ClastLogin%3Ddesc" should have been called
      And the API url "/api/users?limit=25&offset=0&filters=language%3Des%2Coutstanding%3D1" should have been called
      And I click "Emily"
      And I should see the following profile information:
        | Nombre 			| Emily     |
        | Localización      | Rothville |
        | Edad        |           | #ponemos age vacio para que no peten los test cada año
        | Sexo	            | Mujer     |
        | Estoy buscando	| Mujeres   |
      And I shouuld se the user has 35 visits

  @view_user_with_no_profile @view_users
  Scenario: View user profile
    Given I am on "http://boilerplatele.local/app_dev.php"
    When I click "Usuarios"
    Then the API url "/api/users?limit=30&offset=0&filters=language%3Des&order=hasProfilePhoto%3Ddesc%2ClastLogin%3Ddesc" should have been called
    And the API url "/api/users?limit=25&offset=0&filters=language%3Des%2Coutstanding%3D1" should have been called
    And I click "Emily"
    And I shouuld se the user has 0 visits

  @view_user_profile @view_users
  Scenario: To view users photos I need to login
    Given I am on "http://boilerplatele.local/app_dev.php"
     When I click "Usuarios"
      And I click "Emily"
     When I click on the element with css "data-behat" and "user-photos"
     Then I should be on "/usuario/login"

  @view_user_profile @view_users
  Scenario: View users photos as loged in user
    Given I am logedin and go to index
     When I click "Usuarios"
      And I click "Emily"
      And I click on the element with css "data-behat" and "user-photos"
     Then I should be on "/usuarios/2/fotos"
      And I should see 19 photos

  @view_user_profile @view_users
  Scenario: View a users photo as loged in user
    Given I am logedin and go to index
     When I click "Usuarios"
      And I click "Emily"
      And I click on the element with css "data-behat" and "user-photos"
      And I click on the first photo
     Then I should be on "/2014/02/18/53031792da81a_large.jpg"
