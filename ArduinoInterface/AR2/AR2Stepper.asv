classdef AR2Stepper
    %AR2STEPPER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        AR2STEPPER_CREATE = hex2dec('00');
    end
    
    properties(Access = private)
        ID
        Pins
        Parent
    end
    
    properties(Access = private)
        ResourceOwner = 'AR2\AR2Stepper';
    end
    
    methods
        function obj = AR2Stepper(parentObj, inputPins)
            obj.Parent = parentObj;
            obj.Pins = inputPins;
            
            count = getResourceCount(obj.Parent,obj.ResourceOwner);
            if count > 6
                error('The AR2 can only have 6 steppers.');
            end
            
            incrementResourceCount(obj.Parent,obj.ResourceOwner);
            obj.ID = getFreeResourceSlot(parentObj, obj.ResourceOwner);
            createAR2Stepper(obj,inputPins);
        end
        
        function createAR2Stepper(obj,inputPins)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            commandID = obj.AR2STEPPER_CREATE;
            
            for iLoop = inputPins
                configurePinResource(obj.Parent,iLoop{:},obj.ResourceOwner,'Reserved');
            end

            terminals = getTerminalsFromPins(obj.Parent,inputPins);
            inputs = [];
            
            sendAR2Command(obj.Parent,commandID,inputs);
        end
    end
end

