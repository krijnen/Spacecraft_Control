classdef pd_q < pd
    % Linear controller for the outer loop of the quaternion representation
    % of the spacecraft.
    properties
        ref_q = [0 0 0 1]'
    end
    methods
        function self = control(self, x)
            self.v = -1.6*self.error(x) - 3.2*x(5:7);
            self.er1 = self.error(x);
        end        
        function self = setref_d(self, ref)
            % Set a new reference. ref is in degrees, translated to rads
            % and thereafter translated to quaternions.
            ref = pi/180.*ref;
            self.ref_q = [  sin(ref(1)/2)*cos(ref(2)/2)*cos(ref(3)/2) - cos(ref(1)/2)*sin(ref(2)/2)*sin(ref(3)/2);
                            cos(ref(1)/2)*sin(ref(2)/2)*cos(ref(3)/2) + sin(ref(1)/2)*cos(ref(2)/2)*sin(ref(3)/2);
                            cos(ref(1)/2)*cos(ref(2)/2)*sin(ref(3)/2) - sin(ref(1)/2)*sin(ref(2)/2)*cos(ref(3)/2);
                            cos(ref(1)/2)*cos(ref(2)/2)*cos(ref(3)/2) + sin(ref(1)/2)*sin(ref(2)/2)*sin(ref(3)/2)];
        end
        function error = error(self, x)
            % Determine error quaternions. First three are used to
            % determine the control action
            qc = self.ref_q;            
            error = [ qc(4) qc(3) -qc(2) -qc(1); -qc(3) qc(4) qc(1) -qc(2);
                qc(2) -qc(1) qc(4) -qc(3); qc(1) qc(2) qc(3) qc(4)] * x(1:4);
            error = error(1:3);
        end
    end
end