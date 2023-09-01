Feature: Replace comments with et in prime numbered posts
  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def primeNumberedComments = callonce read('commentsWithSpecificWord.feature')
    * def comments = []
    * def comments = primeNumberedComments.comments_with_et
  Scenario: Replace a word in comments
    * def filteredComments = comments
    * def updatedComments = karate.map(filteredComments, function(comments){ return {id: comments.id, body: comments.body.replace(/\b(et)\b/gi, 'the')}})
    * def callForUpdatingComments = function(x){ karate.call ('replaceInComments.feature@put', {id : x.id, body : x.body});}
    * karate.forEach(updatedComments, callForUpdatingComments)
  @put
  Scenario: Update the comments
    Given path 'posts/'+ id
    And request body
    When method PUT
    Then status 200
    * def updatedResponse = response
    * print 'Updated Comments: ', updatedResponse