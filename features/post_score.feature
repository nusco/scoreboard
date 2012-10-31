Feature: Post Score

As a Team
I want to post my score
So that it will show up on the scoreboard

Scenario: Two teams post their scores
Given a team named "Code Monkeys" posts a score of 3
And a team named "Cowboy Coders" posts a score of 4
When I open the scoreboard
Then I should see "Code Monkeys: 3"
And I should see "Cowboy Coders: 4"

Scenario: A team posts twice
Given a team named "Code Monkeys" posts a score of 3
And a team named "Code Monkeys" posts a score of 4
When I open the scoreboard
Then I should see "Code Monkeys: 4"
And I should not see "Cowboy Coders: 3"
