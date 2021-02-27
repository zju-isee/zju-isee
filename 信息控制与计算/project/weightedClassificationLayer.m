classdef weightedClassificationLayer < nnet.layer.ClassificationLayer
    
    properties
        % Row vector of weights corresponding to the classes in the
        % training data.
        ClassWeights
    end
    
    methods
        function layer = weightedClassificationLayer(classWeights, name)
            % layer = weightedClassificationLayer(classWeights) creates a
            % weighted cross entropy loss layer. classWeights is a row
            % vector of weights corresponding to the classes in the order
            % that they appear in the training data.
            %
            % layer = weightedClassificationLayer(classWeights, name)
            % additionally specifies the layer name.
            
            % Set class weights.
            layer.ClassWeights = classWeights;
            
            % Set layer name.
            if nargin == 2
                layer.Name = name;
            end
            
            % Set layer description
            layer.Description = 'Weighted cross entropy';
        end
        
        function loss = forwardLoss(layer, Y, T)
            % loss = forwardLoss(layer, Y, T) returns the weighted cross
            % entropy loss between the predictions Y and the training
            % targets T.
            
            N = size(Y,4);
            Y = squeeze(Y);
            T = squeeze(T);
            W = layer.ClassWeights;
    
            loss = -sum(W*(T.*log(Y)))/N;
        end
        
        function dLdY = backwardLoss(layer, Y, T)
            % dLdX = backwardLoss(layer, Y, T) returns the derivatives of
            % the weighted cross entropy loss with respect to the
            % predictions Y.
            
            [~,~,K,N] = size(Y);
            Y = squeeze(Y);
            T = squeeze(T);
            W = layer.ClassWeights;
            
            dLdY = -(W'.*T./Y)/N;
            dLdY = reshape(dLdY,[1 1 K N]);
        end
    end
end

