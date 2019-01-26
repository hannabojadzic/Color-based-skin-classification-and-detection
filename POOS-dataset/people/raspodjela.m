[a,b,data] = xlsread('Regioniinteresa.csv');
data_koordinate = data(:,6)
data_name = data(:,1)
data_region = data(:,5)
counter_region = data(:,4)

i = 2
broj = size(data_koordinate)
trueCounter = 0;
falseCounter = 0;
while i~= broj(1)+1
    if exist(char(data_name{i})) == 2
    if num2str(data_region{i})=="0"
        if num2str(counter_region{i}) ~="0"
        trueCounter = trueCounter + 1;
        else
        falseCounter = falseCounter + 1;
        end
    end
    end
    i = i+1
end
trueCounter = 0.8*trueCounter
falseCounter = 0.8*falseCounter
i = 2
while i ~= broj(1) + 1
    if exist(char(data_name{i})) == 2
    if num2str(data_region{i}) == "0"
        if num2str(counter_region{i}) ~="0"
        	if trueCounter > 0
                char(data_name(i))
                %movefile(char(data_name(i)), './Train');
                movefile(char(data_name(i)), fullfile('./Train/', char(data_name(i))));
            else
                movefile(char(data_name(i)), fullfile('./Test/', char(data_name(i))));
            end
            trueCounter = trueCounter - 1;
        else
        	if falseCounter > 0
                movefile(char(data_name(i)), fullfile('./Train/', char(data_name(i))));
            else
                movefile(char(data_name(i)), fullfile('./Test/', char(data_name(i))));
            end
            falseCounter = falseCounter - 1;
        end
    end
    end
    i = i+1
end

