classdef Location
    properties
        Number int64
        Name string
        Origins string
        Destinations string
        Notes string
    end
    
    methods
        function this = Location(scenarioNumber, name, origins, destinations)
            this.Number = scenarioNumber;
            this.Name = name;
            
            if nargin > 2
                this.Origins = origins;
            end
            
            if nargin > 3
                this.Destinations = destinations;
            end
        end
    end
end