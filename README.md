# README

I have built out each of the restful endpoints as the instructions mentioned building a restful API, however in a real
life situation I'm not sure that we would give the client the ability to delete, create, or update the data. Or maybe
we would :).

Usage Instructions

* Heroku app is here: [https://hotel-engine-movie-api.herokuapp.com/api/v1/movies](https://hotel-engine-movie-api.herokuapp.com/api/v1/movies)

* Routing - Everything is namespaced inside `/api/v1`. Example: `/api/v1/movies`

* Index action
  - `/movies` will show all movies that are currently saved in the database. (This would not be a sustainable model, but
  got me started.)
  - Several parameters are accepted including `page`, `query` and `sort`.
  - The page param will work with the movie api pagination and will return 20 results per page.
  - The query param is a text search that takes into account all original, translated, alternative names and titles.
  - The sort param accepts any options that ActiveRecord `order` accepts. Ex: 'asc' or 'desc'.
  - If a search has been performed prior then there will be a search record created and cached results. Currently, there
  is no cache buster, but that could be added hourly or nightly or whatever.
  - If the search has never been performed, the request is passed through to the movie api and the results saved to the
  db as well as a search object saved.

* Show action
  - `/movies/#{id}` will retrieve one movie by the `api_id`. If we have it locally, then we return the JSON data for
  this object. If not, we search the movie api for an object matching this id.

* The update/create/delete actions will work as you would expect. I wasn't sure whether these were requirements, since
they would only have affect on our local db and not on the upstream movie api.

* ...
