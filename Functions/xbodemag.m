function xbodemag(...
    sys,linewidth,sw_linestyle,freq_Hz,N_freq,sw_freqGrid_lin,SW_absMag)
% function xbodemag(sys,linewidth,sw_linestyle,freq_Hz,N_freq,sw_freqGrid_lin)
% sys: cell array
%
% ============================================================
%   multi-objective optimal Q-filter design in (D)DOBs
%   Copyright 2008-, Xu Chen. All rights reserved
%   Author(s): Xu Chen xuchen@cal.berkeley.edu
% ============================================================
% 2011-04-26

ni = nargin;
error( nargchk(1, 7, ni) );
if ni<7
    SW_absMag = 0;
end
if ni<6
    sw_freqGrid_lin = 0;
end
if ni<5
    N_freq = 10000;
end
if ni<4
    SW_FREQ = 0;
else
    SW_FREQ = 1;
end
if ni<3
    sw_linestyle = 'linestyleOn';
end
if ni<2
    linewidth = 1.5;
end
if ni<1
    error('No inputs')
end

% edit rgb
linecolor = {...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0],...
    'b','r',[0 0.5 0],'m',[0 0.75 0.75],[0.87 0.49 0]};
% linecolor = {...    
%     rgb('Blue'),rgb('Red'),rgb('Cyan'),rgb('Magenta'),rgb('Orange'),rgb('DeepPink'),...
%     rgb('Blue'),rgb('Red'),rgb('LightGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black'),...
%     rgb('Blue'),rgb('Red'),rgb('DarkGreen'),rgb('Magenta'),rgb('Orange'),rgb('Black')};
% linecolor = {'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g',...
%     'b','r','m','k','c','g'};
if strncmpi(sw_linestyle,'linestyleOn',11)
linestyle = {'-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.',...
    '-','--',':','-.'};
else
    linestyle = {'-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',...
    '-','-','-','-',};
end
% if ~exist('linewidth','var')
%     linewidth = 1.5;
% end
if ~iscell(sys)
    sys = {sys};
end
N = length(sys);
for ii = 1:N
    if ii == 1
        if SW_FREQ
            if sw_freqGrid_lin
                freq_Hz_range = linspace(1,freq_Hz,N_freq);
            else
                freq_Hz_range = logspace(1,log10(freq_Hz),N_freq);
            end
%             freq_Hz_range = logspace(1,log10(freq_Hz*2*pi),1000);
            [freq_in_hz,mag] = xmag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_Hz_range,SW_absMag);
        else
            [freq_in_hz,mag] = xmag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth);
        end
        min_mag = min(mag);
        max_mag = max(mag);
    else
        if SW_FREQ
            if sw_freqGrid_lin
            freq_Hz_range = linspace(1,freq_Hz,N_freq);
            else
            freq_Hz_range = logspace(1,log10(freq_Hz),N_freq);
            end
%             freq_Hz_range = logspace(1,log10(freq_Hz*2*pi),1000);
            [freq_in_hz,mag]=xmag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_Hz_range,SW_absMag);
        else
            [freq_in_hz,mag]=xmag(...
                sys{ii},linecolor{ii},linestyle{ii},linewidth,freq_in_hz);
        end
        min_mag = min([min(mag),min_mag]);
        max_mag = max([max_mag,max(mag)]);
    end
    hold on
end
if sw_freqGrid_lin
    set( gca, 'xlim',  [min(freq_in_hz) max(freq_in_hz)]);
else
    if 1
        set( gca, 'xlim',  [min(freq_in_hz) max(freq_in_hz)]);
    else
        set( gca, 'xlim',  [max([min(freq_in_hz),1]) max(freq_in_hz)]);
    end
end
if min_mag < -100
    min_mag = -80;
end
if SW_absMag
    if min_mag < 0
        min_mag = min_mag-1;
    end
else
    min_mag = min_mag-1;
end
if SW_absMag
    max_mag = max_mag*1.2;
else
    max_mag = max_mag+2;
end

set( gca, 'ylim', [min_mag,max_mag]);
