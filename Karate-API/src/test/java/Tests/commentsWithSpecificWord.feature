Feature: Filter Comments with et from Prime Numbered Post Ids
  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def primePostIds = callonce read('primeNumberPostIds.feature')
    * def postIds = []
    * def postIds = primePostIds.primeNumberedPostIds
  Scenario: Fetch comments with et
    Given path 'posts'
    When method GET
    Then status 200
    * def actualResponse = response
    * def i = 0
    * def etCommentsArray = []
    * def search = " et "
    * def withEtInComments =
    """
         function(index, args){
            while (index<args.length-1)
            {
               for(var j = 0; j<=postIds.length-1; j++)
               {
                 if(args[index].id == postIds[j])
                 {
                    if(args[index].body.toLowerCase().indexOf(search.toLowerCase()) != -1 ){
                       karate.appendTo(etCommentsArray, (args[index]))
                    }
                 }
               }
               index++
             }
            return etCommentsArray
          }
    """
    * def comments_with_et = withEtInComments(i, actualResponse)
    Then print 'Prime Numbered Posts with et in comments-----',comments_with_et