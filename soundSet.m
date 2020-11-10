function soundMatrix = soundSet()
    cd('\Users\bpugh\Documents\MATLAB\QEA\proj1\sethHodgeSet');
    files = dir('*.wav');
    
    soundMatrix = [];
    
    for file = files'
        [data Fs] = audioread(file.name);
        soundMatrix = [soundMatrix reshape(data, 48000, 8)];
        % Do some stuff
    end
end