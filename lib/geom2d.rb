# -*- frozen_string_literal: true -*-
#
#--
# geom2d - 2D Geometric Objects and Algorithms
# Copyright (C) 2018 Thomas Leitner <t_leitner@gmx.at>
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#++

# = Geom2D - Objects and Algorithms for 2D Geometry in Ruby
#
# This library implements objects for 2D geometry, like points, line segments, arcs, curves and so
# on, as well as algorithms for these objects, like line-line intersections and arc approximation by
# Bezier curves.
module Geom2D

  autoload(:Point, 'geom2d/point')
  autoload(:Segment, 'geom2d/segment')
  autoload(:Polygon, 'geom2d/polygon')
  autoload(:PolygonSet, 'geom2d/polygon_set')

  autoload(:BoundingBox, 'geom2d/bounding_box')
  autoload(:Algorithms, 'geom2d/algorithms')

  autoload(:Utils, 'geom2d/utils')
  autoload(:VERSION, 'geom2d/version')

end
