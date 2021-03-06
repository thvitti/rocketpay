defmodule Rocketpay.NumbersTest do
 use ExUnit.Case, async: true
 alias Rocketpay.Numbers

 describe "sum_from_file/1" do
    filename = ""
    exp = {:error, %{message: "Invalid file!"}}
    assert Numbers.sum_from_file(filename) == exp
    
end


describe "sum_from_file/1 a" do
    test "when there is file with given name, returns the result" do
        filename = "numbers"
        response = {:ok, %{result: 37}}
        
        assert Numbers.sum_from_file(filename) == response
    end 
    
    test "when there is no file with given name, returns an error" do
        filename = nil
        response = {:error, %{message: "Invalid file!"}}
        
        assert Numbers.sum_from_file(filename) == response
    end 
    
end






end