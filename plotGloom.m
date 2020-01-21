function varargout = plotGloom(varargin)
    if nargin == 0
        load('data/gloomTree.mat', 'G');
    else
        G = varargin{1};
    end
    p = plot(G);
    highlight(p, G.Nodes.Name(matches(G.Nodes.IsComplete, "Yes")), "NodeColor","green");
    
    highlight(p, G.Nodes.Name(matches(G.Nodes.IsComplete, "Blocked")), "NodeColor","red");
    
    regularEdges = G.Edges.EndNodes(find(matches(G.Edges.Completed, "Yes")), :); %#ok<FNDSB> 
    regLength = size(regularEdges,1);
    for idx = 1:regLength
        highlight(p, regularEdges(idx,:), 'EdgeColor', 'green');    
    end
    
    dottedEdges = G.Edges.EndNodes(find((matches(G.Edges.Completed, "Yes") & matches(G.Edges.Type, "Temporal"))), :); %#ok<FNDSB> 
    dotLength = size(dottedEdges,1);
    for idx = 1:dotLength
        highlight(p, dottedEdges(idx,:), 'LineStyle', '--');
    end
    
    p.NodeFontSize = 9;
    p.MarkerSize = 7;
    p.LineWidth = 1.5;
    p.ArrowSize = 12;
    set(gcf, 'Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);
    set(gca, 'Visible', 'off');
    
%     text(p.XData+.01, p.YData+.01 ,p.NodeLabel, ...
%     'VerticalAlignment','Bottom',...
%     'HorizontalAlignment', 'left',...
%     'FontSize', 9);
% 
% p.NodeLabel = {};
    
    
    if nargout > 0
        varargout{1} = p;
    end
    
end