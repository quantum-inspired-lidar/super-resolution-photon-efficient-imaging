%% gating and thresholding

% Gating
% For each reconstruction result "recoveredSPIRALtv" (128*126*20), 
% we pick usually 3 or 4 frames the mannequin located in out of the whole 20 frames for illustration.

% Thresholding
% For each frame, we perform a threshold filter and set those pixels with very small values to zero.
% The threshold is based on the mean value of the whole frame,

Mannequin_location_begin =  [9, 11, 10, 11, 11, 11, 11];
Mannequin_location_end   = [11, 14, 12, 14, 13, 14, 14];                % the frames contains the maanequin for each posture

threshhold_adjustment = [1, 1.4, 1.8, 1, 0.7, 1, 1];                    % adjusting the threshold value

for ii = 1:size(y_raw,1)
    for jj = 1:size(y_raw,2)
        
        if ~isempty(y_raw{ii,jj})
            
            % Gating
            Mannequin_frames_recovered = reconstruction_result{ii,jj}(:,:,Mannequin_location_begin(size(y_raw,2)*(ii-1)+jj):Mannequin_location_end(size(y_raw,2)*(ii-1)+jj));
            Mannequin_frames_raw = y_raw{ii,jj}(:,:,Mannequin_location_begin(size(y_raw,2)*(ii-1)+jj):Mannequin_location_end(size(y_raw,2)*(ii-1)+jj));

            % Thresholding
            for p =1:size(Mannequin_frames_raw,3) 
                
                temp = squeeze(Mannequin_frames_recovered(:,:,p));
                nonempty =  (temp~=0);
                mean_filter_recovered = sum(temp(:))/sum(nonempty(:));
                temp(temp < threshhold_adjustment(size(y_raw,2)*(ii-1)+jj)*mean_filter_recovered) = 0;
                Mannequin_frames_recovered(:,:,p) = temp;
                
            end
            
            % Obtaining the depth map by weighted average
            dep_recover = zeros(size(temp,1), size(temp,2));
            ref_recover = zeros(size(temp,1), size(temp,2));
            
            
            dep_raw = zeros(size(temp,1), size(temp,2));
            ref_raw = zeros(size(temp,1), size(temp,2));
            
            
            for xx = 1:size(Mannequin_frames_recovered,1)
                for yy = 1:size(Mannequin_frames_recovered,2)
                    for zz = 1:size(Mannequin_frames_recovered,3)
                        
                        ref_recover(xx,yy) = ref_recover(xx,yy)+Mannequin_frames_recovered(xx,yy,zz);
                        dep_recover(xx,yy) = dep_recover(xx,yy)+zz*Mannequin_frames_recovered(xx,yy,zz);
                        
                        ref_raw(xx,yy) = ref_raw(xx,yy)+Mannequin_frames_raw(xx,yy,zz);
                        dep_raw(xx,yy) = dep_raw(xx,yy)+zz*Mannequin_frames_raw(xx,yy,zz);
                        
                    end
                    
                    if ref_recover(xx,yy) ~= 0
                        dep_recover(xx,yy)=dep_recover(xx,yy)/ref_recover(xx,yy);
                    end
                    
                    if ref_raw(xx,yy) ~= 0
                        dep_raw(xx,yy)=dep_raw(xx,yy)/ref_raw(xx,yy);
                    end
                    
                end
            end
            
            % Recording
            depth_recovered{ii,jj} = dep_recover*bin*3e8/2;
            depth_raw{ii,jj} = dep_raw*bin*3e8/2;
                        
        end
            
    end
end
