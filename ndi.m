classdef ndi
    %%% This object contains the non linear dynamic inversion control law. 
    properties
        title = 'NDI';
        u
    end
    methods
        function self = control(self, s, v)
            % Linearizing control law
            % s = spacecraft object
            % v = desired second derivative of theta
            self.u = s.J*inv(s.N)*(v-s.N_d*s.rot) + s.OM*s.J*s.rot - s.Td;
        end
    end
end
