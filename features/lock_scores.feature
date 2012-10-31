Feature: Lock Scores

As a Judge
I want the system to stop accepting new scores once a team reaches 10
So that I can declare a winner

Scenario: Declare winner
Given a team named "Cowboy Coders" posts a score of 3
And a team named "Code Monkeys" posts a score of 10
When I open the log page
Then I should see "Code Monkeys wins!"

Scenario: Posting too late
Given a team named "Cowboy Coders" posts a score of 10
When I post a score of 3
Then I should get a 405 return code
And I should see "The challenge is over"
