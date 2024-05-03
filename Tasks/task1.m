function task1(option)
    % option =  
    %     "initialize" for the first pass or 
    %     "append"     for all subsequent passes

    arguments
        option string {mustBeMember(option,["initialize","append"])} = "append"
    end

    % These are the Cody profile IDs of the people we're tracking 
    profile_ids = [ ...
        173294 
        734801 
        5349647 
        17355128 
        1887879 
        17719399 
        12862873 
        15363629 
        615500 
        10491973];

    url = makeUrl(profile_ids);

    leaderboardFilename = "Data/cody_leaders.csv";

    json = webread(url);
    tCurrentScores = struct2table(json);
    tLeaderboard = array2table(tCurrentScores.score');
    names = string(tCurrentScores.nickname');
    firstNames = regexprep(names," .*","");

    tLeaderboard.Properties.VariableNames = firstNames;
    dtNow = datetime("now");
    tLeaderboard.time = dtNow;

    if option=="initialize"

        writetable(tLeaderboard,leaderboardFilename)

    elseif option=="append"

        tLeaderboardPrevious = readtable(leaderboardFilename);
        tLeaderboard = [tLeaderboardPrevious; tLeaderboard];
        writetable(tLeaderboard,leaderboardFilename)

        % Print out this leaderboard plot once a week
        dtNow.Format = "eeee";
        % if string(dtNow)=="Monday"
        %     plotLeaderboard(tLeaderboard, firstNames);
        % end

        matlab.internal.liveeditor.executeAndSave('report.mlx')
        export("report.mlx","report.md")

    end

end

function plotLeaderboard(tLeaderboard, firstNames)
    
    tt = table2timetable(tLeaderboard);
    for n = 1:width(tt)
        plot(tt.time,tt.(firstNames(n)))
        hold all
    end
    hold off
    yt = yticks;
    set(gca,YTickLabel=string(yt))
    legend(firstNames,Location="eastoutside")
    print("Scores","-dpng")

end

function url = makeUrl(profile_ids)
    % For making the RESTful call to the Cody API

    s1 = "https://www.mathworks.com/matlabcentral/cody/players?term=id%3A";
    s2 = join(string(profile_ids),"+OR+id%3A");
    s3 = "&format=json";
    url = s1 + s2 + s3;

end