clear all ;

out = dlmread('out.dta');
XOut = out(:, 1:2);
YOut = out(:, 3:3);

in = dlmread('in.dta');

train = 25;

XTrain = in(1:train, 1:2);
YTrain = in(1:train, 3:3);

XVal = in(train+1:35, 1:2);
YVal = in(train+1:35, 3:3);


for i = 3 : 7
    i
    ZTrain = hw7_transform(XTrain, i);
    ZTrain(1:1, :)
    [w, errors] = linear_regression(ZTrain, YTrain);
    train_errors = errors / size(ZTrain, 1)
    
    ZVal = hw7_transform(XVal, i);
    diff = sign(ZVal * w) ~= YVal;
    errors = sum(diff(:)!=0);
    val_errors = errors / size(ZVal, 1)

    ZOut = hw7_transform(XOut, i);
    diff = sign(ZOut * w) ~= YOut;
    errors = sum(diff(:)!=0);
    out_errors = errors / size(ZOut, 1)
    
    "--------------"
endfor





