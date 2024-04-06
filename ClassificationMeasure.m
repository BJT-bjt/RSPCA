function [accuracy] = ClassificationMeasure(TrainX, TrainY, TestX, TestY)

    mdl = ClassificationKNN.fit(TrainX,TrainY,'NumNeighbors',1);
    predictY   =       predict(mdl, TestX);



    correct_predictions = (predictY == TestY);
    accuracy = sum(correct_predictions) / numel(TestY);

end
