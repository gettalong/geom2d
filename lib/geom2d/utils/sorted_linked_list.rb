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
  module Utils

    # A doubly linked list that keeps its items sorted.
    class SortedLinkedList

      include Enumerable

      # A node of the double linked list.
      class Node

        AnchorValue = Object.new #:nodoc:

        # Creates a Node object that can be used as the anchor of the doubly linked list.
        def self.create_anchor
          Node.new(AnchorValue).tap {|anchor| anchor.next_node = anchor.prev_node = anchor }
        end

        # The previous node in the list. The first node points to the anchor node.
        attr_accessor :prev_node

        # The next node in the list. The last node points to the anchor node.
        attr_accessor :next_node

        # The value of the node.
        attr_accessor :value

        # Creates a new Node for the given value, with optional previous and next nodes to point to.
        def initialize(value, prev_node = nil, next_node = nil)
          @prev_node = prev_node
          @next_node = next_node
          @value = value
        end

        # Returns +true+ if this node is an anchor node, i.e. the start and end of this list.
        def anchor?
          @value == AnchorValue
        end

        # Inserts this node before the given node.
        def insert_before(node)
          @prev_node = node.prev_node
          @next_node = node
          node.prev_node.next_node = self
          node.prev_node = self
          self
        end

        # Deletes this node from the linked list.
        def delete
          @prev_node.next_node = @next_node
          @next_node.prev_node = @prev_node
          @prev_node = @next_node = nil
          @value
        end

      end

      # Creates a new SortedLinkedList using the +comparator+ or the given block as compare
      # function.
      #
      # The comparator has to respond to +call(a, b)+ where +a+ is the value to be inserted and +b+
      # is the value to which it is compared. The return value should be +true+ if the value +a+
      # should be inserted before +b+, i.e. at the position of +b+.
      def initialize(comparator = nil, &block)
        @anchor = Node.create_anchor
        @comparator = comparator || block
      end

      # Returns +true+ if the list is empty?
      def empty?
        @anchor.next_node == @anchor
      end

      # Returns the last value in the list.
      def last
        empty? ? nil : @anchor.prev_node.value
      end

      # Yields each value in sorted order.
      #
      # If no block is given, an enumerator is returned.
      def each #:yield: value
        return to_enum(__method__) unless block_given?
        current = @anchor.next_node
        while current != @anchor
          yield(current.value)
          current = current.next_node
        end
      end

      # Returns the node with the given value, or +nil+ if no such value is found.
      def find_node(value)
        current = @anchor.next_node
        while current != @anchor
          return current if current.value == value
          current = current.next_node
        end
      end

      # Inserts the value and returns self.
      def push(value)
        insert(value)
        self
      end

      # Inserts a new node with the given value into the list (at a position decided by the compare
      # function) and returns it.
      def insert(value)
        node = Node.new(value)
        current = @anchor.next_node
        while current != @anchor
          if @comparator.call(node.value, current.value)
            return node.insert_before(current)
          end
          current = current.next_node
        end
        node.insert_before(@anchor)
      end

      # Clears the list.
      def clear
        @anchor = Node.create_anchor
      end

      # Removes the top node from the list and returns its value.
      def pop
        return nil if empty?
        @anchor.prev_node.delete
      end

      # Deletes the node with the given value from the list and returns its value.
      def delete(value)
        find_node(value)&.delete
      end

      def inspect #:nodoc:
        "#<#{self.class.name}:0x#{object_id.to_s(16).rjust(0.size * 2, '0')} #{to_a}>"
      end

    end

  end
end
