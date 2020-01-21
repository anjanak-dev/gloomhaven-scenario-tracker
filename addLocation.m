function varargout = addLocation(origin, destinations)
    arguments 
        origin string {matlab.unittest.internal.mustBeTextScalar}
        destinations string {matlab.unittest.internal.mustBeTextScalarOrTextArray}
    end
    
    edgefields = ["EndNodes","Type","Completed"];
    nodefields = ["Name", "IsComplete"];
    
    load('data/gloomTree.mat', "G");
%     load('data/fullGloomTree.mat', "fullG");
    for place = destinations
        origin = utils.findValidLocation(G, origin);
        validateNewDestination(place);
        G = G.addnode(table(place, "No", ...
            'VariableNames',nodefields));
%         fullG = fullG.addnode(place);
        G = G.addedge(table([origin, place], "Actual", "No", ...
            'VariableNames', edgefields));
%         fullG = fullG.addedge(origin, place);
    end
    save('data/gloomTree.mat', 'G');
%     save('data/fullGloomTree.mat', 'fullG');
    plot(G);
    
    if nargout > 0
        varargout{1} = G;
    end
end

function validateNewDestination(place)
    numScenario = extractBefore(place, " ");
    if isempty(str2num(numScenario))
        error("Provide a valid scenario number. Example:'1 Black Barrow'");
    end
end