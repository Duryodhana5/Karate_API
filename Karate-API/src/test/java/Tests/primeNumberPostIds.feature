Feature: Prime Number postIds
  Background:
    * url 'https://jsonplaceholder.typicode.com'
  Scenario: Fetch prime numbered postIds
    Given path 'posts'
    When method GET
    Then status 200
    * def postIds = get response[*].id
    * def isPrimeNumber =
  """
    function(number) {
      if (number <= 1) {
        return false;
      }
      for (var i = 2; i <= Math.sqrt(number); i++) {
        if (number % i === 0) {
          return false;
        }
      }
      return true;
    }
  """
    * def primeNumberedPostIds = []
    * karate.forEach(postIds, function(postIds) {if (isPrimeNumber(postIds)) {primeNumberedPostIds.push(postIds);}})
    * print 'Prime Numbered Post Ids:', primeNumberedPostIds