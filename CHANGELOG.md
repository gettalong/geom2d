## 0.2.0 - 2018-12-16

### Changed

* Make Segment#intersect ~1.71x faster by avoiding unnecessary object creation
* Refactor and simplify the sorted list implementation used by the polygon
  operations, making the latter ~1.15x faster

### Fixed

* Fix off-by-one error in Polygon#ccw? calculation

## 0.1.0 - 2018-03-28

* Initial release
