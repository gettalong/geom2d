# -*- frozen_string_literal: true -*-

require 'test_helper'
require 'geom2d/utils/sorted_linked_list'

describe Geom2D::Utils::SortedLinkedList do
  before do
    @list = Geom2D::Utils::SortedLinkedList.new {|a, b| a < b }
  end

  describe "insert" do
    it "inserts a value and returns its associated node" do
      node = @list.insert(1)
      assert_equal(1, node.value)
      assert(node.prev_node.anchor?)
      assert(node.next_node.anchor?)
    end

    it "uses the comparator for choosing the place to insert the value" do
      @list.insert(10)
      @list.insert(5)
      @list.insert(8)
      assert_equal([5, 8, 10], @list.to_a)
    end
  end

  it "returns whether it is empty" do
    assert(@list.empty?)
    @list.insert(5)
    refute(@list.empty?)
    @list.delete(5)
    assert(@list.empty?)
  end

  it "returns the last value in the list" do
    @list.insert(5)
    assert_equal(5, @list.last)
    @list.insert(10)
    assert_equal(10, @list.last)
    @list.insert(6)
    assert_equal(10, @list.last)
  end

  it "returns the first node found for a given value" do
    @list.push(5).push(8)
    node = @list.find_node(8)
    assert_equal(8, node.value)
    assert_equal(5, node.prev_node.value)
    assert(node.next_node.anchor?)
  end

  it "pops the top value of the list" do
    @list.push(8).push(5)
    assert_equal(8, @list.pop)
  end

  it "clears the whole list" do
    @list.push(8).push(5)
    @list.clear
    assert(@list.empty?)
  end

  it "deletes a value from the list" do
    @list.push(8).push(5)
    assert_equal(8, @list.delete(8))
  end

  it "can be inspected" do
    @list.push(8).push(5)
    assert_match(/[5, 8]/, @list.inspect)
  end
end
