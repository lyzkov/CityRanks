# CityRanks 0.1.0

### Installation

Clone project from repository and run `CityRanks.pbxproj`.

### Usage

CityRanks demonstrates implementation of table view containing list of cities for recommendation purposes. User can mark city as favorite by swiping left each city cell. Favorites are kept in local device storage with no backend used.

### Data source

Application is backed by Postman mocking server. [Here](https://red-sunset-227940.postman.co/collections/7958052-6ffaf5b8-ab5e-4267-89ad-57d1b02b87c3) is very basic documentation with examples.

### Architecture

Project is organized in modules that follows VIPER architecture and CLEAN principles. Any services that can be developed independently and reused between modules are extracted into swift packages.

### Required features

- [x] Content should be backend driven. You can host one/more json file/s on gist.github.com or any other service and use it as the host of the data from your app (or any online REST alternative)
- [ ] Use UINavigationController and UITableView/UICollectionView displaying list of items. Each cell should consist of backend driven image and title. After tapping, selected content should be shown on the details screen with more information. Aside from this, there should be at least one screen presented modally
- [x] Possibility to mark the item as “favourite” and filter the list to show only favourite items.
- [x] There should be mechanism to persist favourites between app launches. You don’t have
to persist whole objects – implementation is up to you. You may use UserDefaults but
make it scalable
- [ ] Have a point of synchronization (e.g. making two concurrent network requests and
waiting for both of them to finish)
- [ ] Handle loading and error states

### Technical requirements

- [x] Do not use SwiftUI and/or Combine. We value the knowledge but for now we’re still relying on UIKit. Construct your UI in code and use Auto Layout
- [x] Do not use any 3rd party frameworks
- [x] Support the latest major iOS version plus one below (if iOS 13.x is the newest one,
please support iOS 12.x as well)
- [x] Clean code with production grade coding style
- [x] Write Unit Tests, you don’t have to test everything but please make sure your code is
testable. UI Tests are optional but nice to have
- [x] We do not enforce any design pattern – use whatever you think suits your project best.

### Considerations

- [x] The development should be approached as production code. Do not leave unnecessary comments and unused methods. Be consistent in your code
- [x] Privilege quality over quantity
- [x] Good engineering principles
- [x] Follow Apple Human Interface Guidelines
- [x] We use multiple frameworks to build apps at HSBC, splitting your code into modules is a
plus
- [x] We know that there’s a lot to handle in case of parsing images and it’s not a trivial task
without 3rd party dependencies. For the sake of this test, you don’t have to worry about caching and memory issues.
