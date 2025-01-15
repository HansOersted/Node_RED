clear

% set MQTT parameters for publishing
brokerAddress = 'tcp://supos-demo.supos.app'; % MQTT Broker address
port = 1883; % MQTT Broker port
topic = '/pump/sensor3';
interval = 5;
total_time = 30;

% create MQTT Client
mqttClient = mqttclient(brokerAddress, Port=port);

% publish Topic
disp('Starting to publish data to pump3...');
for i = 1:total_time/interval
    % create the data to publish
    temperature = 25 + rand() * 5; % random temperature
    payload = jsonencode(struct('temperature', temperature, 'timestamp', datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss')));

    % publish
    write(mqttClient, topic, payload);

    disp(['Published to ', topic, ': ', payload]);

    % waiting for the next publish
    pause(interval);
end

clear mqttClient;
disp('Finished publishing data.');
