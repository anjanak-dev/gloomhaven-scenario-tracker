classdef Location
    properties(Constant)
        EdgeFields = ["EndNodes","Type","Completed"];
        NodeFields = ["Name", "IsComplete"];
    end
    
    methods(Static)
        function G = addLocation(G, origin, destinations)
            arguments
                G digraph
                origin string {matlab.unittest.internal.mustBeTextScalar}
                destinations string {matlab.unittest.internal.mustBeTextScalarOrTextArray}
            end
            
            for place = destinations
                G = gloom.Location.add(G, origin, place);
            end
        end
        
        function node = findValidLocation(G, location)
            locStrings = string(G.Nodes.Name);
            idx = contains(lower(locStrings), lower(location));
            node = locStrings(idx);
            if isempty(node)
                error('gloom:Location:LocationNotFound', ...
                    'The location: %s could not be found', location);
            end
            
            if ~isscalar(node)
                error('gloom:Location:DuplicateMatch', ...
                    ['"%s" is not a unique enough identifier. ' ...
                    'Multiple locations matching this identifier' ...
                    'were found.'], location);
            end
        end
        
        function G = add(G, origin, place)
            edgefields = gloom.Location.EdgeFields;
            nodefields = gloom.Location.NodeFields;
            
            origin = gloom.Location.findValidLocation(G, origin);
            validateNewDestination(place);
            
            G = G.addnode(table(place, "No", ...
                'VariableNames',nodefields));
            G = G.addedge(table([origin, place], "Actual", "No", ...
                'VariableNames', edgefields));
        end
    end
end

function validateNewDestination(place)
    numScenario = extractBefore(place, " ");
    if isempty(str2num(numScenario)) %#ok<ST2NM>
        error('gloom:Location:InvalidLocationName', ...
            '"%s" is an invalid name. Provide a valid scenario number. Example:"1 Black Barrow"', place);
    end
end