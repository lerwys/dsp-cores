filename = 'position_in.samples'
% Sirius parameters
fc = 52;
fadc = 203;

current = 0.4;
k_x = 1e6;
k_y = k_x;
k_sum = 1;

y_max = 1000;
y_step = 100;
y_samples_per_step = 30000;
y_number_of_steps = 2*y_max/y_step - 1;

x_max = 1000;
x_step = 250;
x_samples_per_step = y_samples_per_step * y_number_of_steps;
x_number_of_steps = 2*x_max/x_step -1;

y = -y_max+y_step:y_step:y_max-y_step;
y_pos = repmat(y,y_samples_per_step,1);
y_pos = y_pos(:)';

y_pos = repmat(y_pos, 1, x_number_of_steps); %repeat for each new x value

x = -x_max+x_step:x_step:x_max-x_step;
x_pos = repmat(x,x_samples_per_step,1);
x_pos = x_pos(:)';

Ts = 1/fadc;
t = 0 : Ts : Ts*length(y_pos)-Ts;

[adc_a, adc_b, adc_c, adc_d ] = bpm_4_signal(x_pos, y_pos, current, k_sum, k_y, k_x, t, fc, fadc);

%% Print file if option chosen
fileID = fopen(filename,'w');
for count = 1 : length(adc_a)
    fprintf(fileID,'%e\t%e\t%e\t%e\r\n',adc_a(count),adc_b(count), adc_c(count), adc_d(count));
end