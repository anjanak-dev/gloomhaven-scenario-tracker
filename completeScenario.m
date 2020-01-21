function completeScenario(location)
    arguments
        location string
    end
    
    load('data/gloomTree.mat', 'G');
    load('data/completed.mat', 'completedArray');
    
    location = utils.findValidLocation(G, location);
    
    previous = string.empty;
    if ~isempty(completedArray)
        previous = completedArray(end);
    end
    completedArray(end+1) = location;
    
    edgefields = ["EndNodes","Type","Completed"];

    G.Nodes(findnode(G, location), 'IsComplete') = table("Yes", 'VariableNames', "IsComplete");   
    
    if ~isempty(previous)
        if G.findedge(previous, location) ~= 0 
            G.Edges(findedge(G, previous, location), "Completed") = table("Yes", 'VariableName',"Completed");
        else
            G = G.addedge(table([previous, location], "Temporal", "Yes", ...
                'VariableNames', edgefields));
        end
    end
    
    save('data/gloomTree.mat', 'G');
    save('data/completed.mat', 'completedArray');
    plotGloom(G);
end