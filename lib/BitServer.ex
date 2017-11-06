defmodule BitServer do
    use Application
  @moduledoc """
  Documentation for BitServer.
  """
    def init(count, node_pid) do
        IO.inspect("Node server: #{node_pid} ")
        no_of_workers=Application.get_env(:project_1, :no_of_workers)
        IO.puts("Server process iD: #{inspect self()}")
        IO.puts("Spawnning #{no_of_workers} workers")
        spawn_workers(count,no_of_workers)
        start_recieveing(count)
    end

    def spawn_workers(count,no_of_workers) do
        if no_of_workers > 0 do
            Node.spawn(node(),BitServer,:workerminer,[count,self(),nil])
            no_of_workers=no_of_workers-1
            spawn_workers(count,no_of_workers)
        end    
    end
    def workerminer(k,server,sender \\ self()) do
        send self(),{self(),:mine}
        receive do
            {sender, :mine} -> 
                startMining(k,server,self())
        end
        workerminer(k,server,sender) 
    end

    def start_recieveing(count) do 
        receive do
            {sender, :connect} ->
                send sender, {:mine, count}
            {sender, :print, msg} -> 
                IO.inspect("#{msg}")
                send sender, {:mine, count}
            {sender, :mine} -> 
                IO.puts("Started self mine  main server......")
                startMining(count,sender,self())
        end
        start_recieveing(count) 
    end
    def startMining(k,server,sender \\ self()) do
        #This method generates random string and encodes it with SHA256
        #The module will then send msg to server when it finds that Bitcoin
        length=22
        str = :crypto.strong_rand_bytes(length) |> Base.encode64 |> binary_part(0, length)
        str = "anitha19r;" <> str
        hash=:crypto.hash(:sha256, str) |> Base.encode16
        case (String.starts_with?(hash,String.duplicate("0",k))) do
            false -> startMining(k,server,sender)
            true -> msg = str <> "    "<>hash
                    send server, {self(), :print , msg}
        end
    end
end