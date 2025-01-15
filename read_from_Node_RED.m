
clear
time = [];
data = [];
total_time = 42;
interval = 6;

%%
% create MQTT client
mqttClient = mqttclient('tcp://supos-demo.supos.app', Port=1883);

% subscribe
subscribe(mqttClient, '/pump/sensor3');

for i = 1 : total_time/interval

    % waiting for the data
    pause(interval);
    
    % read the data
    mqttData = read(mqttClient);
    
    % collect the data
    if isempty(mqttData)
        disp("No data received from the topic /pump/sensor3.");
    else
        disp("Received MQTT Data.");
        % disp(mqttData);
        time = [time; mqttData(1,:).Time];
        data = [data; jsondecode(mqttData(1,:).Data).temperature];
    end

end

% clear the Client
clear mqttClient;
