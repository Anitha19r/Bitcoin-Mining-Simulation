DISTRIBUTED OPERATING SYSTEM- BITCOIN MINING PROJECT
Authors:
1)    Anitha Ranganathan - anitha19r - 76783421
2)    Sweta Thapliyal – Sthapliyal - 35436779

Requirements:
The following needs to be installed in the system:
1)    Elixir

Installation and Configuration:
1.    The mix.exs configuration has the node name for server and clients, also the name for the terminal to be connected. You can also configure the number of workers that you wish to spawn. So, these node names are picked up from there.
2.    To install the project, just download the project folder ‘project_1’ and then do build it using the commands:
a.    cd project_1
b.    mix escript.build

Usage:
1.    Server side:   ./project k
‘k’ here indicates the number of preceding zeros(integer value) you want to compute on the client
2.    Client side: ./project  IP
‘IP’ indicates the IP address of the server that is mining the coins and is the one that you wish to connect
Once this is done, the server and client will start mining bitcoins simultaneously. If you want just the server to mine coins, that is also possible. You just have to run the server side script.

Implementation Details:
1.    Work Unit:
- The string generation in our project for mining bitcoins uses an iterative approach, with a fixed string length of 22 alphanumeric characters as it gives us 32^36 permutations.
- Using the iterative approach we avoid collision by lowering repeated generation of same strings.
-Thus, we make it horizontally scalable.



2.    Result of running the program for 4 preceding 0s:


Anithas-MacBook-Pro:project_1 anitharanganathan$ ./project_1 4
**************** SERVER IS UP! HAPPY MINING :) *************
"Node server: server1@192.168.0.11 "
Server process iD: #PID<0.75.0>
Spawnning 1000 workers
"anitha19r;1LSC4jhZL/VvUZ31PBRwPo    00005225CF6FBFDB9F2DFF1BC1053E390BA3ECBAF113BA658E324962F547F511"
"anitha19r;lkM10zhsUNOsBa2BuomY26    00002AB87D562BE1661FB1711545745B20E984EA0AA0935749D820220EFD5766"
"anitha19r;5DYYPqS8WZsNcIVHiQjEW3    00007F425AD483E02041576FEDC82FC4385DD2BDABB209D35A8E23F0D627A404"
"anitha19r;mZNFb0Fe0E0rP/1bSn+/HA    00002028422838B4EEE9C571C4A52194F60363A718C2E5A92D54C812E9F48DFB"
"anitha19r;gwKkSywUC1gieHIBIkwJTP    0000344A0BC3B2400E7568CA00E241DC1D3B7252382F247CDD04E000DA514B99"
"anitha19r;VZwdo+M/eHEDrGBsIvNtOW    0000166A75E41DE0B2CA1B33A18EA96D5BFA99F8ACD75C585CA59133BEF3941A"
"anitha19r;3G+A5mwll0NGlGBPfdisxL    000083D1376BE1D7125CD0514E818238A8F190C0BCF6F1CB579877092F2AB1FF"
"anitha19r;7rtMfwMMfzThfLfuX3hM03    0000162DB76C30CF16CF65920AC1FE5D3D6932E24835F046CCF6023960876919"
"anitha19r;1B3i/Pizfpy7B0f6zAqJWo    00001B9F83C6060CBBB520ACB7001C6BD4D0ED67183A24893E4F74F15E6A4F38"
While checking the CPU utilization for the same on a single 4 core machine I got 374% CPU utilization (fluctuation between 350-379).
While running this with server on a quad core machine and 2 clients on 2 separate machines having $ physical and 8 logical cores with 1000 workers spawned on each client, the CPU utilization for server machine was around 355% and that of the other two machines was 100% on each core.
The following is the result on running the same on a 8 core machine.
PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
14989 exx       20   0 4139488  38456   6512 S 794.0  0.1  13:51.95 beam.smp

PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
15110 exx       20   0 4140592  45976   6484 S 396.3  0.1   0:46.48 beam.smp
14989 exx       20   0 4138464  38420   6512 S 365.4  0.1  34:47.36 beam.smp


3.    The running time for the above as reported by time for the above, i.e. run time ./project1 5 and report the time :

Anithas-MacBook-Pro:project_1 anitharanganathan$ time ./project_1 5
**************** SERVER IS UP! HAPPY MINING :) *************
self pid is: #PID<0.75.0>
"Node server: server@192.168.0.11 "
Server process iD: #PID<0.75.0>
Spawnning 10 workers
"anitha19r;jA/fsYGMQfqRe71L1X4UH5    00000DA8CD8C4C1B335728B39E3575F6A52D69EDE0DCF4827BB29199066E5A39"
"anitha19r;cWJbWh7JUti6gdq3/x08X3    0000014D485D5380DC282138757905117CC2863BDCD186CA37D49B9F026E0DF7"
"anitha19r;sADTOMn/NLSRaN2BXQskIC    000009582DF57F7DD7BC8DFCCF1AD4BB6EC95113D7B363C4FEDBFEB0E1D06B96"
"anitha19r;M4iWKXG3doFuuAYGn39SDA    0000038EFB7B966752634C3F94D1D93FB3FD0F151B91DDCDB147208FF492EB1C"
"anitha19r;PJLPz4C46e/bCqN3/T4n8I    00000745BCBC2E6BC7BE99872B9E0D8D15B93417CCB2B3E4A2447A2962B247D4"
"anitha19r;IiFFN2KPibqfDhy7GB0uCP    0000062550B6FC7D49951F510FA18E5DB6167066D88D789D05C86677FFFE55E6"
"anitha19r;Cu5/8vMupThIOWa2pW7J+N    00000F56BDCFAACF76A2F76C733C1E6AA5C4B3DDC36DE1A6D0498DE6DE3E1D7D"
"anitha19r;+jR4PtDkVzC4QCVTkbJk7Y    00000B88E6B2780623C246C7E97CE0B5FE4F87F1A21F3D06DB4E79EBFE87DC56"
"anitha19r;wP1sq5pFlJK6KOmX1k0pnH    00000BDDD816E9AEFC0E83F84945EA5991AE9FA5B90FEC9282150EF21D6FF78D"
"anitha19r;7es4AVcuRUWQcHg5Faat5v    00000BF10F92F34BBC847AC34984115F90C7A5BC3126C252D6350956B5C7B692"
"anitha19r;B3NF4lW9pGRcesuQv28Add    000008647CC695A746CA509D47B818A6332E63C37D86A0B6E51CEF872A9EAE17"
"anitha19r;0rsg+nahfFR5tsSl4dITm2    00000CDE032505278AD75EE143A62F80DDA40CDC94429A69FE2AD2BE95790233"
"anitha19r;5S6dS28uVETRSSbS5ZUKl8    000005A2C6EE9B25911AA372E3AB2526353B5D9A31607EA4C6CFE75593F67376"
"anitha19r;4DM0fl2IuTLW68Lll7fm9p    00000E60205DEB35DC53ADC777CBBDCB5F0796C5C5C68F8C3E0115DD3E2A8425"
"anitha19r;KfhPdsa4ulFIQBg6nRFmJY    000007A3610D163E1A9610B50AE5CD7ED5582CCF175F4E15AF02904045BF1B53"
"anitha19r;/xvxWYlYzbtdiPczx/ayls    00000C40036B70ACC97123E95835E58BF6DE899518C88332BDC84C107C68B4B8"
"anitha19r;s9jm1/ZusmZ30afAtVqnqy    0000072793E8BE4D7A08737FA545E04CB130FF1B37B27D68C401534C217ADA58"
"anitha19r;VKUols+xYE4ZMsJ/wSZe+c    00000B7C8EEA85FA6DA6E21FB910A9062F44E3A33F5C07F4BE1E51436EDB9992"
"anitha19r;nIuWwxqTi5ZnTfJ8Laqb9+    000005198865DA1F8494FA02BBB68195EB72693CFA41CEABD1351ECF96B105D7"
"anitha19r;pv9cRF6NK6MW1eO0TciEWH    00000985BD1C9F7F6F4C274329420D7551EDDA6B8E1BAB2CFA2C37B11EFD4973"
"anitha19r;kVmVn+e/Vd+Q/dW+JqOoQN    00000C1CCA5475F467DC5A2DC1DFEBF9F3C7F33141B25BFC42167F111983D62A"
"anitha19r;+xx7hp8POqToHSz5g2kvvM    0000062452A6AAC00DA67BBD2E469518B34293E1AAC6A1977324112B2B644ACC"
"anitha19r;Rp/8J/MSi6ViBS8ej/XxbR    0000009B0F2846C7911FBC8BAAA6B944C46522EDAC54B907107BA1DF8BE13C28"
"anitha19r;fOHkLJwIIU7QTBtehkF3HR    000003CAF98ECDB2F9D9A2E95F7B26E05D164260F8E6CF91EA94DF697534D424"
"anitha19r;H0pRCpJ/5JfrntlOjn+mFi    00000B44F8C459527452BCC53662CBBF078D3F358F05FAAA5B9C31BD575C5F18"
"anitha19r;gYHMLGxMi0nYw0Kw8T++iS    0000070B0FE678F6CA62FFDD1AB7DA55ED61973B5E1F2F6F66D1C10018323B8E"
"anitha19r;Q7bKtmxhg8tEPtoPmVBtp4    000006A45FC95D69C51C78775B0CD9A16AE5F3A4C5D960478614EF219E74209F"
^C

real    1m25.332s
user    5m22.073s
sys    0m52.968s

The ratio of CPU time to REAL TIME
= 3.7743

The same for a 8 core machine is;

real    4m45.006s
user    35m11.512s
sys    0m12.388s
The ratio of CPU time to REAL TIME
= 9 approx


4.    The coin with the most number of leading 0s that we were able to find:
We could mine the coin with ‘8’ zeroes as maximum in our quad core PC. However, I have not maintained a copy of that, so posting the copy of 7
"anitha19r;/AtKpmtJxyBdUWPMRlgXtx    00000007BECF66B83579D70E5F0F5093478703322B60103F3F41966A0F1E872F"
5.    The largest number of working machines we tested our code on was with 5 machines (4 miners and one master).



