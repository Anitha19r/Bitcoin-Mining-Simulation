defmodule IPChk do
    def convert([head|tail]) do
        list=Tuple.to_list(head)
        #IO.inspect(list)
        chk(list)
        convert(tail)
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
                IO.puts("IP is :)   #{inspect ip}")
        end
    end
    def chk([]) do
        []
    end
 end
 #hd(elem(:inet.getif,1))
 #Tuple.to_list(:inet.getif,1)