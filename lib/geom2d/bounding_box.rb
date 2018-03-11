# -*- frozen_string_literal: true -*-
#
#--
# geom2d - 2D Geometric Objects and Algorithms
# Copyright (C) 2018 Thomas Leitner <t_leitner@gmx.at>
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#++

module Geom2D

  # Represents an axis aligned bounding box.
  #
  # An empty bounding box contains just the point at origin.
  class BoundingBox

    # The minimum x-coordinate.
    attr_reader :x_min

    # The minimum y-coordinate.
    attr_reader :y_min

    # The maximum x-coordinate.
    attr_reader :x_max

    # The maximum y-coordinate.
    attr_reader :y_max

    # Creates a new BoundingBox.
    def initialize(x_min = 0, y_min = 0, x_max = 0, y_max = 0)
      @x_min = x_min
      @y_min = y_min
      @x_max = x_max
      @y_max = y_max
    end

    # Updates this bounding box to also contain the given bounding box or point.
    def add!(other)
      case other
      when BoundingBox
        @x_min = [x_min, other.x_min].min
        @y_min = [y_min, other.y_min].min
        @x_max = [x_max, other.x_max].max
        @y_max = [y_max, other.y_max].max
      when Point
        @x_min = [x_min, other.x].min
        @y_min = [y_min, other.y].min
        @x_max = [x_max, other.x].max
        @y_max = [y_max, other.y].max
      else
        raise ArgumentError, "Can only use another BoundingBox or Point"
      end
      self
    end

    # Returns a bounding box containing this bounding box and the argument.
    def add(other)
      dup.add!(other)
    end
    alias + add

    # Returns the bounding box as an array of the form [x_min, y_min, x_max, y_max].
    def to_a
      [@x_min, @y_min, @x_max, @y_max]
    end

    def inspect #:nodoc:
      "BBox[#{x_min}, #{y_min}, #{x_max}, #{y_max}]"
    end

  end

end
