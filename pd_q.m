classdef pd_q < pd
    properties
        ref_q = [0 0 0 1]'
    end
    methods
        function self = setref_d(self, ref)
            ref = pi/180.*ref;
            self.ref_q = [  sin(ref(1)/2)*cos(ref(2)/2)*cos(ref(3)/2) - cos(ref(1)/2)*sin(ref(2)/2)*sin(ref(3)/2);
                            cos(ref(1)/2)*sin(ref(2)/2)*cos(ref(3)/2) + sin(ref(1)/2)*cos(ref(2)/2)*sin(ref(3)/2);
                            cos(ref(1)/2)*cos(ref(2)/2)*sin(ref(3)/2) - sin(ref(1)/2)*sin(ref(2)/2)*cos(ref(3)/2);
                            cos(ref(1)/2)*cos(ref(2)/2)*cos(ref(3)/2) + sin(ref(1)/2)*sin(ref(2)/2)*sin(ref(3)/2)];
        end
        function error = error(self, x)
            qc = self.ref_q;            
            error = [ qc(4) qc(3) -qc(2) -qc(1); -qc(3) qc(4) qc(1) -qc(2);
                qc(2) -qc(1) qc(4) -qc(3); qc(1) qc(2) qc(3) qc(4)] * x(1:4);
            error = error(1:3);
            error = error * pi;
        end
    end
end