defmodule Rocketpay.Numbers do

    def sum_from_file(filename) do
        "#{filename}.csv" 
        |> File.read()
        |> handle_file()
    end

    defp handle_file({:ok, file}) do 
        result = 
            file
            |> String.split(",")
            |> Stream.map(&String.to_integer/1)
            |> Enum.sum
        
        {:ok, %{result: result}}
    end

    defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"} }

end