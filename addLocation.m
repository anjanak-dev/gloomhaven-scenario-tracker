function varargout = addLocation(origin, destinations)
    arguments 
        origin string {matlab.unittest.internal.mustBeTextScalar}
        destinations string {matlab.unittest.internal.mustBeTextScalarOrTextArray}
    end
    
    load('data/gloomTree.mat', "G");
    G = gloom.Location.addLocation(G, origin, destinations);
    save('data/gloomTree.mat', 'G');
    
    plotGloom(G);
    
    if nargout > 0
        varargout{1} = G;
    end
end