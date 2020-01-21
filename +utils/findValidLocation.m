function node = findValidLocation(G, location)
    locStrings = string(G.Nodes.Name);
    idx = contains(lower(locStrings), lower(location));
    node = locStrings(idx);
    if isempty(node)
        error("Invalid location.")
    end
end