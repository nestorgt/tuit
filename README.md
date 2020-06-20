# Tuit

## Requirements
* Xcode Version 11.5 (11E608c)
* iOS 13+

## Xcode configuration
* Page guide column at 120
* Tab With: 4 spaces
* Indent Width: 4 spaces

## Stack
* Architecture `MVVM`. Using `Services` for common implementations. Main reason is to be able to tests the bussines logic (View models / Models / Services).
* All `ViewModels` & `Services` use dependency injection to allow creation of mocks and make it more testable. 
* No 3rd party libraries,
* FRP with `Combine`.

## Testing data
* Default categories are added on `CategoryService`
* Some transactions for testing are added on `TransactionService` (only on DEBUG mode)

## Tests
There are two different targets of test, `unit-tests` for mocked and non-network dependant tests, and `integration-tests` that performs network requests to verify the API endpoints.

## Future Improvements
* Add a cache policy to `APIService` so we can request cached data in same cases but still be able to do a force refresh (on pull to refresh).
* The addition of a `Coordinator` was not really needed for this sample but would be consider if the number of screens increases.
* There is improvement room for the UI. Also would be nice to add some empty state view.

