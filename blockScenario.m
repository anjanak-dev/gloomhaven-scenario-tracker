function blockScenario(location)
    arguments
        location string {matlab.unittest.internal.mustBeTextScalar}
    end
    
    load('data/gloomTree.mat', 'G');
    location = utils.findValidLocation(G, location);
    G.Nodes(findnode(G, location), 'IsComplete') = ...
        table("Blocked", 'VariableNames', "IsComplete");
    save('data/gloomTree.mat', 'G');
    plotGloom(G);
end