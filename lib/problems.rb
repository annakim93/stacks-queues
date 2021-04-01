require_relative './stack.rb'
require 'set'

# Time Complexity: O(n)
# >> iterate through each char in the input string
# Space Complexity: O(n)
# >> At worst, storing half of the chars in the input string in stack
#
# PSEUDOCODE:
# Different types of braces
# We can use a stack to store the opening braces
# Once we hit a closing brace, we can pop off the stack
# the popped item must be the same type of brace
# otherwise, unbalanced
# Can also be unbalanced if stack is not empty when finished iterating through input string

OPENING_BRACES = Set['{', '[', '(']

def balanced(string)
  return true if string.empty?
  seen_opening_braces = Stack.new

  string.each_char do |brace|
    if OPENING_BRACES.include?(brace)
      seen_opening_braces.push(brace)
    elsif brace == ']'
      return false unless seen_opening_braces.pop == '['
    elsif brace == '}'
      return false unless seen_opening_braces.pop == '{'
    elsif brace == ')'
      return false unless seen_opening_braces.pop == '('
    end
  end

  return seen_opening_braces.empty?
end

# Time Complexity: ?
# Space Complexity: ?
#
# PSEUDOCODE:
# Assumptions:
# >> input only contains valid numbers and operators
# >> assume nums are integers

OPERATORS = Set['+', '-', '*', '/', '**']

def eval_helper(first_num, second_num, operator)
  case operator
  when '+'
    result = first_num + second_num
  when '-'
    result = first_num - second_num
  when '*'
    result = first_num * second_num
  when '/'
    result = first_num / second_num
  when '**'
    result = first_num ** second_num
  end

  return result
end

def evaluate_postfix(postfix_expression)
  expression_stack = Stack.new
  postfix_expression.each_char do |char|
    if OPERATORS.include?(char)
      second_num = expression_stack.pop
      first_num = expression_stack.pop
      result_num = eval_helper(first_num.to_i, second_num.to_i, char)
      expression_stack.push(result_num)
    else
      expression_stack.push(char)
    end
  end

  final = expression_stack.pop
  if expression_stack.empty?
    return final
  else
    raise ArgumentError, 'invalid input'
  end
end
