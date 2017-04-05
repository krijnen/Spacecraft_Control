classdef pd 
    properties
        zeta = 0.707;
        kp = [1 1 1]'; %TODO
        ref = [0 0 0]'; 
        v = [0 0 0]';
        sc = spacecraft;
        er = [0 0 0]';
    end
    methods
        function self = control(self, x)
            self.v = - self.kp .* self.error(x) - self.kd .* x(end-2:end);
            self.er = self.er + abs(self.error(x));
        end
        function kd = kd(self) %TODO
            kd = 2*self.zeta*sqrt(self.kp.*(ones(1,3)*self.sc.J)');
        end
        function self = setref_d(self, ref)
            if size(ref) == size(self.ref)
                self.ref = pi/180*ref;            
            else
                disp 'Wrong reference set' 
                ref
            end
        end
        function error = error(self, x)
            error = x(1:3) - self.ref;
        end
    end
end