classdef ndi_q
    % This object contains the non linear dynamic inversion control law for
    % the innerloop control of the spacecraft in quaternions.
    properties
        title = 'NDI';
        u
        sc = spacecraft_q;
    end
    methods
        function self = control(self, x, v)
 			% Update internal model to the current state
            self.sc = self.sc.update_x(x);            
            % Linearizing control law        
            self.u = self.sc.J*(v) +  self.sc.OM*self.sc.J*self.sc.rot  - self.sc.Td;
        end
    end
end