#!/usr/bin/env ruby

$use_tree=true
# $verbose=true
$verbose=false

require_relative '../parser_test_helper'
require_relative '../../src/core/emitters/js-emitter'
require_relative '../../src/core/emitters/c-emitter'

class EmitterTest < ParserBaseTest

  include ParserTestHelper

  def assert_result_emitted x,r
    # $use_tree=true
    # @parser.dont_interpret!
    # parse x
    # interpretation= @parser.interpretation || Interpretation.new
    # @parser.full_tree
    # NativeEmitter.new.emit interpretation,run:true
    # assert_result_is x,r # Make sure that at least the interpretation works
    assert_equals parse_tree(x,emit:true),r #parse_tree(r,emit:true)
  end

  def test_js_emitter #NEEDS TREE
    # skip if not $use_tree
    assert_result_emitted "x=5;increase x",6
  end


  def test_int_setter #NEEDS TREE
    # skip if not $use_tree
    assert_result_emitted "x=5;puts x",5
  end


  def test_type_cast
    # verbose
    assert_result_is "2.3",2.3
    parse "int z=2.3 as int"
    assert_equals result,2
    # parse "x='5';int z=x as int"
  end


  def test_printf
    # skip
    $use_tree=true
    @parser.dont_interpret!
    # parse "printf 'hi' "
    # parse "printf hello world"
    parse "printf 'hello world'",false
    # parse "printf('hi')"
    # parse "x=nil;printf 'hi'"
    # parse "x=7"#";printf 'hi'"
    # parse "x=false"#";printf 'hi'"
    interpretation= @parser.interpretation || Interpretation.new
    @parser.full_tree
    # @parser.show_tree
    # parse "x='hi';printf('hi')"
    # NativeEmitter.new.emit interpretation,run:true
    result=NativeCEmitter.new.emit interpretation,run:true
    assert_equals result,"hello world"
    # assert "type of x is string"
  end


  def test_printf_1
    assert_result_emitted "printf 'hello world'",'hello world'
  end

  def test_function
    # assert_result_is "i=7;i minus one",6
    assert_result_emitted "i=7;i minus one",6
    # parse_file "examples/factorial.e"
  end

  def test_setter
    # skip
    $use_tree=true
    @parser.dont_interpret!
    # parse "x='ho';printf x"
    parse "x='ho';puts x"
    interpretation= @parser.interpretation || Interpretation.new
    # @parser.full_tree
    @parser.show_tree
    # parse "x='hi';printf('hi')"
    NativeCEmitter.new.emit interpretation,run:true
    # NativeEmitter.new.emit interpretation,run:true
    # assert "type of x is string"
  end

end
