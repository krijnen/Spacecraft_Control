classdef indi
    % INDI linearizing control law for the innerloop of the spacecraft using
    % euler angles
    properties
        title = 'INDI';
        u = [0 0 0]';
        theta_d = [0 0 0]';
        alpha = [0 0 0]';
        sc = spacecraft;                % Internal model
        Ts = 0.01;                       
    end
    methods
        function self = control(self, x, v)
            self.sc = self.sc.update_x(x);
            self = self.d_th(self.sc);
            du = self.sc.J*inv(self.sc.N)*(v-self.alpha);
            self.u = self.u + du;
        end
        function self = d_th(self, sc)
            f = sc.f;
            theta_d = f(1:3);                               % Use the internal spacecraft model to find theta_dot
            self.alpha = (theta_d - self.theta_d)/self.Ts;
            self.theta_d = theta_d;
        end
    end
end