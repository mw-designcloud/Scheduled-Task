tLeaderboard = readtable("Data/cody_leaders.csv");
json = webread(url);
tCurrentScores = struct2table(json);
tNewLeaders = array2table(tCurrentScores.score');
tNewLeaders.Properties.VariableNames = firstNames;
tNewLeaders.time = datetime("now");
tLeaderboard = [tLeaderboard; tNewLeaders];
writetable(t2,'Data/cody_leaders.csv')
