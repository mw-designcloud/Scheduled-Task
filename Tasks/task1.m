% Read input data
T = readtable("Data/eth.csv");
jason = webread("https://api.coinbase.com/v2/prices/ETH-USD/spot");
Tnew = struct2table(jason.data);
Tnew.time = datetime("now");
%  Transform data to fit the input format
Tnew.amount = double(string(Tnew.amount));
Tnew.base = cellstr(Tnew.base);
Tnew.currency = cellstr(Tnew.currency);
T = [T;Tnew] % adding a row