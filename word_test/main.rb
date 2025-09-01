# filepath: ruby-console-app/src/main.rb
require 'yaml'

def start_conversation
  puts "単語当てゲームを開始します！"
  # word_array: [Array] 答えを配列で保持
  # answer_array: [Array] 回答過程を保持、当たっている文字列は文字列、それ以外は_をstringで保持
  # count: [Integer] 残り試行回数を保持
  word_array = set_word_array
  answer_array = set_answer_array(word_array)
  count = 5
  puts word_array.join

  while count > 0
    puts answer_array.join
    puts "残り回数： #{count}"
    user_input = gets.chomp

    if is_single_alpha?(user_input)
      response = make_checked_word(word_array, answer_array, user_input)
      count -= 1
      # 全て開いたときは正解として終了する
      if response == word_array
        puts "正解です！"
        break
      end
    else
      puts "アルファベット1文字を入力してください"
      next
    end
  end

  puts "クイズを終了します。答えは #{word_array.join} でした。"
end


# 答えを作成するメソッド
# 文字列をyamlから読み込み、それを配列に格納して返す
# 例　apple → ["a", "p", "p", "l", "e"]
def set_word_array
  words = open("word_test/word.yaml") { |f| YAML.load(f) }
  words["word"][rand(words["word"].length)].chars
end

# 問題を作成するメソッド
# 回答過程を記録する配列を作成する
# 正解している文字の文字は文字、それ以外は＿を保持
# 例　apple → ["_", "_", "_", "_", "_"]
def set_answer_array(word_array)
  Array.new(word_array.length, "_")
end

# 入力されたアルファベットと一致していたらその箇所をアンダーバーからアルファベットに変換する
def make_checked_word(word_array, answer_array, answer_letter)
  word_array.each_with_index do |char, index|
    if char == answer_letter
      answer_array[index] = answer_letter
    end
  end
  answer_array
end

# 判定可能な文字列か判断するメソッド
# 今回はアルファベット1文字の縛りを付ける
def is_single_alpha?(str)
  !!(str =~ /\A[a-zA-Z]\z/)
end

# スクリプトが直接実行された場合にのみ実行する
if __FILE__ == $0
  start_conversation
end