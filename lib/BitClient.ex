defmodule BitClient do
  @moduledoc """
  Documentation for BitCoinMiner Client.
  """

  @doc """


  ## Examples

  """

    def init(server) do
        no_of_workers=Application.get_env(:project_1, :no_of_workers)
        IO.puts("Spawnning #{no_of_workers} workers")
        spawn_workers(server,no_of_workers)
        loop(server)
        
        
    end
    def spawn_workers(server,no_of_workers) do
        if no_of_workers > 0 do
            spawned_wrkr_id= Node.spawn(node(),BitClient,:connect,[server])
            no_of_workers=no_of_workers-1
            spawn_workers(server,no_of_workers)
        end
    end
    def connect(server) do
        send server, {self(), :connect}
        loop(server)
    end
    def loop(server) do
        receive do
            {:mine, k} -> 
                startMining(k,server)
        end
        loop(server) 
    end
    def startMining(k,server) do
        length=22
        str = :crypto.strong_rand_bytes(length) |> Base.encode64 |> binary_part(0, length)
        str = "anitha19r;" <> str
        hash=:crypto.hash(:sha256, str) |> Base.encode16
        case (String.starts_with?(hash,String.duplicate("0",k))) do
            false -> startMining(k,server)
            true -> msg = str <> "    "<>hash
                    send server, {self(), :print , msg}
                    #startMining(k)
        end
    end
end
