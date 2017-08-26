wifi.setmode(wifi.STATION)
wifi.sta.config({ssid="Didi",pwd="hosn12345"})
wifi.sta.setip({ip="192.168.1.50",netmask="255.255.255.0",gateway="192.168.1.1"})

-- motor one
enA = 5;
in1 = 4;
in2 = 3;
-- motor two
enB = 6;
in3 = 2;
in4 = 1;
-- water pump
water=7;

gpio.mode(water,gpio.OUTPUT)

gpio.mode(enA,gpio.OUTPUT)
gpio.mode(in1,gpio.OUTPUT)
gpio.mode(in2,gpio.OUTPUT)

gpio.mode(enB,gpio.OUTPUT)
gpio.mode(in3,gpio.OUTPUT)
gpio.mode(in4,gpio.OUTPUT)

pwm.setup(enA,1000,1023)
pwm.setup(enB,1000,1023)

pwm.start(enA)
pwm.start(enB)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = ""
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        
        buf = buf.."<!DOCTYPE HTML>"
        buf = buf.."<html><head>";
        buf = buf.."<meta charset=\"utf-8\">";
        buf = buf.."<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">";
        buf = buf.."<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">";
        buf = buf.."<script src=\"https://code.jquery.com/jquery-2.1.3.min.js\"></script>";
        buf = buf.."<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\">";
        buf = buf.."</head><div class=\"container\">";
        buf = buf.."<h1>Decentralized Task Assignment</h1>";
        buf = buf.."<h3>AgentT</h3>";
        buf = buf.."<form role=\"form\">";
        buf = buf.."<div class=\"radio\">";
        buf = buf.."<label><input type=\"radio\" name=\"control\" value=\"selfcontrol\" onclick=\"this.form.submit()\">selfcontrol</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"off\" onclick=\"this.form.submit()\">off</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"forward\" onclick=\"this.form.submit()\">forward</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"backward\" onclick=\"this.form.submit()\">backward</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"clockwise\" onclick=\"this.form.submit()\">clockwise</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"counterclockwise\" onclick=\"this.form.submit()\">counterclockwise</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"WaterOn\" onclick=\"this.form.submit()\">WaterOn</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"control\" value=\"WaterOff\" onclick=\"this.form.submit()\">WaterOff</input>";
        buf = buf.."</label></div>";
        buf = buf.."</form>";
        buf = buf.."</div>";
        buf = buf.."</html>";
        
        if(_GET.control == "off")then
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.LOW);
        elseif(_GET.control == "forward")then
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.LOW);
            gpio.write(in1, gpio.HIGH);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.HIGH);
        elseif(_GET.control == "backward")then
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.LOW);
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.HIGH);
            gpio.write(in3, gpio.HIGH);
            gpio.write(in4, gpio.LOW);
        elseif(_GET.control == "clockwise")then
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.LOW);
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.HIGH);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.HIGH);            
        elseif(_GET.control == "counterclockwise")then
            gpio.write(in1, gpio.LOW);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.LOW);
            gpio.write(in4, gpio.LOW);
            gpio.write(in1, gpio.HIGH);
            gpio.write(in2, gpio.LOW);
            gpio.write(in3, gpio.HIGH);
            gpio.write(in4, gpio.LOW);
        elseif(_GET.control == "WaterOn")then
            gpio.write(water, gpio.LOW);
        elseif(_GET.control == "WaterOff")then
            gpio.write(water, gpio.HIGH);                                    
        end
        
        client:send(buf)
    end)
    conn:on("sent", function (c) c:close() end)
end)