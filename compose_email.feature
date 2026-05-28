Feature: Gmail Compose and Send Email
  As a Gmail user, I want to compose and send emails so that I can communicate with others.

  Background:
    Given the user is logged into Gmail on a supported browser
    And the Gmail inbox page is displayed

  Scenario: Successfully send a basic email
    Given the user clicks the "Compose" button
    When the user enters a valid recipient in the To field, for example "alice@gmail.com"
    And enters "Incubyte" in the subject field
    And enters "QA test for Incubyte" in the email body
    And clicks the "Send" button
    Then a confirmation message "Message sent" should appear
    And the email should appear in Sent Mail with subject "Incubyte"

  Scenario: Attempt to send email without any recipient
    Given the user clicks "Compose"
    When the To field is left blank
    And the user enters "Incubyte" in subject and "QA test for Incubyte" in body
    And the user clicks "Send"
    Then an error should be displayed requiring at least one recipient 
    And the email should not be sent

  Scenario: Attempt to send email with invalid email address
    Given the user clicks "Compose"
    When the user enters "invalid-email" in the To field
    And enters "Incubyte" in subject and "QA test for Incubyte" in body
    And the user clicks "Send"
    Then an error message about invalid email format should appear
    And the email should not be sent

  Scenario: Sending email without a subject triggers warning
    Given the user clicks "Compose"
    When the user enters "alice@gmail.com" in the To field
    And the subject field is left empty
    And the user enters "QA test for Incubyte" in the body
    And the user clicks "Send"
    Then Gmail should prompt "Send anyway?" warning
    When the user confirms sending anyway
    Then the email should be sent successfully
    And appear in Sent Mail

  Scenario: Save draft when closing compose window
    Given the user clicks "Compose"
    When the user enters "Incubyte" in subject and "QA test for Incubyte" in body
    And the user closes the compose window without sending
    Then a draft with subject "Incubyte" should be saved in Drafts

  Scenario Outline: Email with multiple recipients and attachments
    Given the user clicks "Compose"
    When the user enters "<recipients>" in the To field
    And the user attaches "<file>"
    And the user enters "Incubyte" in subject and "QA test for Incubyte" in body
    And the user clicks "Send"
    Then the email should be sent to all recipients in "<recipients>" with the attachment "<file>"

    Examples:
      | recipients                          | file         |
      | alice@gmail.com, bob@yahoo.com      | photo.png    |
      | carol@gmail.com                     | document.pdf |

