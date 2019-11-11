classdef AR2 < arduinoio.LibraryBase
    %AR2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private, Constant = true)
        % lotsa commands
        AR2_CREATE = hex2dec('00');
    end
    
    properties(Access = private)
        AR2Number
    end
    
    properties(Access = private)
        Stepper
    end
    
    properties(Access = private, Constant = true)
        % Steps/radian for each stepper
        STEPPER_CONSTANT = [1/(.022368421*(pi/180));
                            1/(.018082192*(pi/180));
                            1/(.017834395*(pi/180));
                            1/(.021710526*(pi/180));
                            1/(.045901639*(pi/180));
                            1/(.046792453*(pi/180))];
    end
    
    properties(Access = protected, Constant = true)
        LibraryName = 'AR2'
        DependentLibraries = {}
        ArduinoLibraryHeaderFiles = {'AccelStepper/AccelStepper.h'}
        CppHeaderFile = fullfile(arduinoio.FilePath(mfilename('fullpath')), 'src', 'AR2Base.h')
        CppClassName = 'AR2Base'
    end

    %% Constructor
    methods(Hidden, Access = public)
        function obj = AR2(parentObj)
            %AR2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Parent = parentObj;
            
            count = getResourceCount(obj.Parent,obj.ResourceOwner);
            if count > 1
                error('You can only have 1 AR2(until you build another).');
            end
            incrementResourceCount(obj.Parent,obj.ResourceOwner);
            obj.AR2Number = getFreeResourceSlot(parentObj, obj.ResourceOwner);
            
            
            obj.Stepper(1) = AR2Stepper(obj,{'D2','D3'});
            obj.Stepper(2) = AR2Stepper(obj,{'D4','D5'});
            obj.Stepper(3) = AR2Stepper(obj,{'D6','D7'});
            obj.Stepper(4) = AR2Stepper(obj,{'D8','D9'});
            obj.Stepper(5) = AR2Stepper(obj,{'D10','D11'});
            obj.Stepper(6) = AR2Stepper(obj,{'D12','D13'});
            
            createAR2(obj);     
        end
    end
    
    %% Public Methods
    methods(Access = public)
        function doSomething(obj) 
        end
    end
    
    %% Private Methods
    methods(Access = private)
        function createAR2(obj)
            cmdID = obj.AR2_CREATE;
            inputs = [];
            sendCommand(obj,obj.LibraryName,cmdID,inputs);
        end
    end
    
    %% Helper method to related classes
    methods (Access = {?AR2Stepper})
        function output = sendAR2Command(obj, commandID, inputs)
            output = sendCommandCustom(obj, obj.LibraryName, commandID, inputs);
        end
    end
end

