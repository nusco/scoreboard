Feature: Sort Scores

As a Judge
I want to see the scores in reverse order
So that I can check who's winning

Scenario: Two teams post their scores
Given a team named "Code Monkeys" posts a score of 3
And a team named "Cowboy Coders" posts a score of 4
When I open the scoreboard
Then I should see "1 - Cowboy Coders"
And I should see "2 - Code Monkeys"
