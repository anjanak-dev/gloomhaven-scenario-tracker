classdef tLocation < matlab.unittest.TestCase
    
    properties
        GloomGraph = getDigraph();
    end
    
    methods(TestClassSetup)
        function testFields(testCase)
            testCase.assertEqual(gloom.Location.EdgeFields, ...
                ["EndNodes", "Type", "Completed"]);
            testCase.assertEqual(gloom.Location.NodeFields, ...
                ["Name", "IsComplete"]);
        end
    end
    
    methods(Test)
        function testAdd(testCase)
            import gloom.Location;
            G = testCase.GloomGraph;
            
            G = Location.add(G, "1 Loc", "3 dummyLocation");
            testCase.assertEqual(height(G.Nodes), 3);
            testCase.verifyEqual(G.Nodes.Name(3), {'3 dummyLocation'});
            testCase.verifyEqual(G.Nodes.IsComplete(3), "No");
            
            testCase.assertEqual(height(G.Edges), 2);
            testCase.verifyEqual(G.Edges.EndNodes(2, :), {'1 Loc', '3 dummyLocation'});
            testCase.verifyEqual(G.Edges.Type(2), "Actual");
            testCase.verifyEqual(G.Edges.Completed(2), "No");
        end
        
        function testAddInvalidLocation(testCase)
            import gloom.Location;
            G = testCase.GloomGraph;
            
            testCase.verifyError(@()Location.add(G, "invalidLocation"), ...
                "gloom:Location:LocationNotFound");
        end
        
        function testInvalidNewName(testCase)
            import gloom.Location;
            G = testCase.GloomGraph;
            
            testCase.verifyError(@()Location.add(G, "1 Loc", "invalidname"), ...
                "gloom:Location:InvalidLocationName");
        end
        
        function testFindLocation(testCase)
            import gloom.Location;
            G = testCase.GloomGraph;
            testCase.verifyEqual(Location.findValidLocation(G, "1"), "1 Loc");
            testCase.verifyEqual(Location.findValidLocation(G, "2 L"), "2 Loc");
        end
        
        function testFindLocationDuplicate(testCase)
            import gloom.Location;
            G = testCase.GloomGraph;
            testCase.verifyError(@()...
                Location.findValidLocation(G, "Loc"), ...
                'gloom:Location:DuplicateMatch');
        end
    end
end

function G = getDigraph
    edgetable = table(["1 Loc", "2 Loc"], "Actual", "No", ...
        'VariableNames', ["EndNodes", "Type", "Completed"]);
    nodetable = table(["1 Loc"; "2 Loc"], ["No"; "No"], ...
        'VariableNames', ["Name", "IsComplete"]);
    G = digraph(edgetable, nodetable);
end