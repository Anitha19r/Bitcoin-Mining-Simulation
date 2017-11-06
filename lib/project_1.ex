defmodule Project1 do
  #use BitClient
  #use BitServer
  @moduledoc """
  Documentation for Project1.
  """

  @doc """
  This program will call the necessary function in case of client or server being run
  This will be done based on the command line argument being passed

  ## Examples
      ./project_1 k --> server
      ./project_1 192.168.2.17 --> client

  """
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")
  def main(argv) do
    argv |> run
  end
    def convert([head|tail]) do
    list=Tuple.to_list(head)
    #IO.inspect(list)
    ip = chk(list)
    #IO.puts(inspect ip)
    case ip do
        [] -> 
        convert(tail)
        _ -> ip
    end
           
end
def convert([]) do
    []
end
def chk([head |tail]) do
    case head do
        {127,0,0,1} ->
            chk(tail)
        {255, _,_,_} ->
            chk(tail)
        :undefined->
            chk(tail)
        _ ->
            ip=:inet.ntoa(head)
            #IO.puts("IP is :)   #{inspect ip}")
    end
end
def chk([]) do
    []
end
  
  def run(arg) do
    arg_string=List.to_string(arg)
    arg_char_list= String.to_charlist(arg_string)
    
    case :inet.parse_ipv4strict_address(arg_char_list) do
      { :error, :einval } -> 
        #checks if the input is IP address, if not start the client else start server
        IO.puts("**************** SERVER IS UP! HAPPY MINING :) *************")
        #ipadd= :inet.ntoa(elem(hd(elem(:inet.getif,1)),0))
        ipadd=convert(elem(:inet.getif,1))
        server= Atom.to_string(Application.get_env(:project_1, :server))
        ip_name =String.to_atom("#{server}@#{ipadd}")
        Node.start(ip_name)
        Node.set_cookie(node() ,:Bitcoin)
        :global.register_name(Application.get_env(:project_1, :terminal), self()) 
        :global.sync()
        Node.spawn(node(),BitServer.init(String.to_integer(List.first(arg)),node()))
      { :ok, ip } ->
        IO.puts("**************** CLIENT IS UP! HAPPY MINING :) *************")
        ipadd= convert(elem(:inet.getif,1))
        server= Atom.to_string(Application.get_env(:project_1, :server))
        client= Atom.to_string(Application.get_env(:project_1, :client))
        random=string_of_length(2)
        ip_name_sever =String.to_atom("#{server}@#{arg_string}")
        ip_name =String.to_atom("#{client}#{random}@#{ipadd}")
        IO.puts("still working on client #{ip_name}    #{ip_name_sever}")
        Node.start(ip_name)
        Node.set_cookie(node() ,:Bitcoin)
        server_connect= Node.connect(ip_name_sever) 
        :global.sync()
        term1 = :global.whereis_name(Application.get_env(:project_1, :terminal))
        IO.inspect(term1)
        Node.spawn(node(),BitClient.init(term1))
    end
  end
  def string_of_length(length) do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
  end
end
