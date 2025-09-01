require 'minitest/autorun'
require_relative '../word_test/main.rb'

class MainTest < Minitest::Test
  def test_set_answer_array
    assert_equal ["_", "_", "_"], set_answer_array(["a", "b", "c"])
  end

  def test_make_checked_word
    word = ["a", "b", "c"]
    answer = ["_", "_", "_"]
    assert_equal ["a", "_", "_"], make_checked_word(word, answer.dup, "a")
    assert_equal ["_", "b", "_"], make_checked_word(word, answer.dup, "b")
    assert_equal ["_", "_", "c"], make_checked_word(word, answer.dup, "c")
  end

  def test_is_single_alpha
    assert is_single_alpha?("a")
    assert is_single_alpha?("Z")
    refute is_single_alpha?("ab")
    refute is_single_alpha?("1")
    refute is_single_alpha?("")
  end
end