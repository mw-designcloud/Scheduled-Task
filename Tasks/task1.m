tLeaderboard = readtable("Data/cody_leaders.csv");
url = "https://www.mathworks.com/matlabcentral/cody/players?term=id%3A173294+OR+id%3A734801+OR+id%3A5349647+OR+id%3A17355128+OR+id%3A1887879+OR+id%3A17719399+OR+id%3A12862873+OR+id%3A15363629+OR+id%3A615500+OR+id%3A10491973&format=json";
json = webread(url);
tCurrentScores = struct2table(json);
tNewLeaders = array2table(tCurrentScores.score');
names = string(tCurrentScores.nickname');
firstNames = regexprep(names," .*","");
tNewLeaders.Properties.VariableNames = firstNames;
tNewLeaders.time = datetime("now");
tLeaderboard = [tLeaderboard; tNewLeaders];
writetable(tLeaderboard,'Data/cody_leaders.csv')
