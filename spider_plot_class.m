classdef spider_plot_class < matlab.graphics.chartcontainer.ChartContainer & ...
        matlab.graphics.chartcontainer.mixin.Legend
    %spider_plot_class Create a spider or radar plot with individual axes.
    %
    % Syntax:
    %   s = spider_plot_class(P)
    %   s = spider_plot_class(P, Name, Value, ...)
    %   s = spider_plot_class(parent, ___)
    %
    % Input Arguments:
    %   (Required)
    %   P                - The data points used to plot the spider chart. The
    %                      rows are the groups of data and the columns are the
    %                      data points. The axes labels and axes limits are
    %                      automatically generated if not specified.
    %                      [vector | matrix]
    %
    % Name-Value Pair Arguments:
    %   (Optional)
    %   AxesLabels       - Used to specify the label each of the axes.
    %                      [auto-generated (default) | array of strings | 'none']
    %
    %   AxesInterval     - Used to change the number of intervals displayed
    %                      between the webs.
    %                      [3 (default) | integer]
    %
    %   AxesPrecision    - Used to change the precision level on the value
    %                      displayed on the axes.
    %                      [1 (default) | integer | vector]
    %
    %   AxesDisplay      - Used to change the number of axes in which the
    %                      axes text are displayed. 'None' or 'one' can be used
    %                      to simplify the plot appearance for normalized data.
    %                      ['all' (default) | 'none' | 'one' | 'data']
    %
    %   AxesLimits       - Used to manually set the axes limits. A matrix of
    %                      2 x size(P, 2). The top row is the minimum axes
    %                      limits and the bottow row is the maximum axes limits.
    %                      [auto-scaled (default) | matrix]
    %
    %   FillOption       - Used to toggle fill color option.
    %                      ['off' (default) | 'on' | cell array of character vectors]
    %
    %   FillTransparency - Used to set fill color transparency.
    %                      [0.1 (default) | scalar in range (0, 1) | vector]
    %
    %   Color            - Used to specify the line color, specified as an RGB
    %                      triplet. The intensities must be in the range (0, 1).
    %                      [MATLAB Color (default) | RGB triplet]
    %
    %   LineStyle        - Used to change the line style of the plots.
    %                      ['-' (default) | '--' | ':' | '-.' | 'none']
    %
    %   LineWidth        - Used to change the line width, where 1 point is
    %                      1/72 of an inch.
    %                      [0.5 (default) | positive value]
    %
    %   LineTransparency - Used to set the line color transparency.
    %                      [1 (default) | scalar in range (0, 1) | vector]
    %
    %   Marker           - Used to change the marker symbol of the plots.
    %                      ['o' (default) | 'none' | '*' | 's' | 'd' | ...]
    %
    %   MarkerSize       - Used to change the marker size, where 1 point is
    %                      1/72 of an inch.
    %                      [36 (default) | positive value]
    %
    %   MarkerTransparency-Used to set the marker color transparency.
    %                      [1 (default) | scalar in range (0, 1) | vector]
    %
    %   AxesFont         - Used to change the font type of the values
    %                      displayed on the axes.
    %                      [Helvetica (default) | supported font name]
    %
    %   LabelFont        - Used to change the font type of the labels.
    %                      [Helvetica (default) | supported font name]
    %
    %   AxesFontSize     - Used to change the font size of the values
    %                      displayed on the axes.
    %                      [10 (default) | scalar value greater than zero]
    %
    %   AxesFontColor    - Used to change the font color of the values
    %                      displayed on the axes.
    %                      [black (default) | RGB triplet]
    %
    %   LabelFontSize    - Used to change the font size of the labels.
    %                      [10 (default) | scalar value greater than zero]
    %
    %   Direction        - Used to change the direction of rotation of the
    %                      plotted data and axis labels.
    %                      ['clockwise' (default) | 'counterclockwise']
    %
    %   AxesDirection    - Used to change the direction of axes.
    %                      ['normal' (default) | 'reverse' | cell array of character vectors]
    %
    %   AxesLabelsOffset - Used to adjust the position offset of the axes
    %                      labels.
    %                      [0.2 (default) | positive value]
    %
    %   AxesDataOffset   - Used to adjust the position offset of the data labels
    %                      when AxesDisplay is set to 'data'.
    %                      [0.1 (default) | positive value]
    %
    %   AxesScaling      - Used to change the scaling of the axes.
    %                      ['linear' (default) | 'log' | cell array of character vectors]
    %
    %   AxesColor        - Used to change the color of the spider axes.
    %                      [grey (default) | RGB triplet | hexadecimal color code]
    %
    %   AxesLabelsEdge   - Used to change the edge color of the axes labels.
    %                      [black (default) | RGB triplet | hexadecimal color code | 'none']
    %
    %   LegendLabels     - Used to add the labels to the legend.
    %                      [cell array of character vectors]
    %
    %   LegendHandle     - Used to customize legend settings. 
    %                      [legend handle object]
    %
    %   AxesOffset       - Used to change to axes offset from the origin.
    %                      [1 (default) | any integer less than the axes interval]
    %
    %   AxesZoom         - Used to change zoom of axes.
    %                      [0.7 (default) | scalar in range (0, 1)]
    %
    %   AxesHorzAlign    - Used to change the horizontal alignment of axes tick labels.
    %                      ['center' (default) | 'left' | 'right' | 'quadrant']
    %
    %   AxesVertAlign    - Used to change the vertical aligment of axes tick labels.
    %                      ['middle' (default) | 'top' | 'cap' | 'bottom' | 'baseline' | 'quadrant']
    %
    %   TiledLayoutHandle- Used to customize tiled layout settings. 
    %                      [tiled chart layout handle object]
    %
    %   TiledLegendHandle- Used to customize tiled legend settings. 
    %                      [legend handle object of tiled layout]
    %
    %   NextTileIter     - Iterates with consecutive tile plots. 
    %                      [1 (default)]
    %
    %   PlotVisible      - Used to change the visibility of the plotted lines and markers.
    %                      ['on' (default) | 'off']
    %
    %   AxesTickLabels   - Used to change the axes tick labels.
    %                      ['data' (default) | cell array of character vectors]
    %
    %   AxesInterpreter  - Used to change the text interpreter of axes labels and axes tick labels.
    %                      ['tex' (default) | 'latex' | 'none'  | cell array of character vectors]
    %
    %   BackgroundColor  - Used to change the color of the background.
    %                      [white (default) | RGB triplet | hexadecimal color code | 'r' | 'g' | 'b' | ...]
    %
    %   MinorGrid        - Used to toggle the minor grid.
    %                      ['off' (default) | 'on']
    %
    %   MinorGridInterval- Used to change number of minor grid lines in between the major grid lines.
    %                      [2 (default) | integer value greater than zero]
    %
    %   AxesZero         - Used to add a reference axes at value zero.
    %                      ['off' (default) | 'on']
    %
    %   AxesZeroColor    - Used to change the color of the zero reference axes.
    %                      ['black' (default) | RGB triplet | hexadecimal color code | 'r' | 'g' | 'b' | ...]
    %
    %   AxesZeroWidth    - Used to change the line width of the zero reference axes.
    %                      [2 (default) | positive value]
    %
    %   AxesRadial       - Used to toggle radial axes.
    %                      ['on' (default) | 'off']
    %
    %   AxesAngular      - Used to toggle angular axes.
    %                      ['on' (default) | 'off']
    %
    %   AxesShaded       - Used to toggle shaded area around axes.
    %                      ['off' (default) | 'on']
    %
    %   AxesShadedLimits - Used to set the limits of the shaded area. A matrix of
    %                      2 x size(P, 2). The top row is the minimum axes
    %                      limits and the bottow row is the maximum axes limits.
    %                      [AxesLimits (default) | cell array]
    %
    %   AxesShadedColor  - Used to change the color of the shaded area.
    %                      ['green' (default) | RGB triplet | hexadecimal color code | 'r' | 'g' | 'b' | cell array]
    %
    %   AxesShadedTransparency- Used to the shaded area transparency.
    %                           [0.2 (default) | vector in range (0, 1)]
    %
    %   AxesLabelsRotate - Used to rotate the axes labels to be aligned with axes.
    %                      ['off' (default) | 'on']
    %
    % Output Arguments:
    %   (Optional)
    %   s                - Returns a chart class object. These are unique
    %                      identifiers, which you can use to query and
    %                      modify properties of the spider chart.
    %                      [chart class object]
    %
    % Examples:
    %   % Example 1: Minimal number of arguments. All non-specified, optional
    %                arguments are set to their default values. Axes labels
    %                and limits are automatically generated and set.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %   s.LegendHandle.Location = 'southoutside';
    %
    %   % Example 2: Manually setting the axes limits and axes precision.
    %                All non-specified, optional arguments are set to their
    %                default values.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10]; % [min axes limits; max axes limits]
    %   s.AxesPrecision = [0, 1, 1, 1, 1];
    %
    %   % Example 3: Set fill option on. The fill transparency can be adjusted.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'};
    %   s.AxesInterval = 2;
    %   s.FillOption = {'on', 'on', 'off'};
    %   s.FillTransparency = [0.2, 0.1, 0.1];
    %
    %   % Example 4: Maximum number of arguments.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLabels = {'S1', 'S2', 'S3', 'S4', 'S5'};
    %   s.AxesInterval = 4;
    %   s.AxesPrecision = 0;
    %   s.AxesDisplay = 'one';
    %   s.AxesLimits = [1, 2, 1, 1, 1; 10, 8, 9, 5, 10];
    %   s.FillOption = 'on';
    %   s.FillTransparency =  0.2;
    %   s.Color = [1, 0, 0; 0, 1, 0; 0, 0, 1];
    %   s.LineStyle = '--';
    %   s.LineWidth = 3;
    %   s.LineTransparency = 1;
    %   s.Marker =  'd';
    %   s.MarkerSize = 10;
    %   s.MarkerTransparency = 1;
    %   s.AxesFont = 'Times New Roman';
    %   s.LabelFont = 'Times New Roman';
    %   s.AxesFontSize = 12;
    %   s.AxesFontColor = 'k';
    %   s.LabelFontSize = 10;
    %   s.Direction = 'clockwise';
    %   s.AxesDirection = {'reverse', 'normal', 'normal', 'normal', 'normal'};
    %   s.AxesLabelsOffset = 0.2;
    %   s.AxesDataOffset = 0.1;
    %   s.AxesScaling = 'linear';
    %   s.AxesOffset = 1;
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %   s.LegendHandle.Location = 'northeastoutside';
    %   s.PlotVisible = 'on';
    %   s.AxesTickLabels = 'data';
    %   s.AxesInterpreter =  'tex';
    %   s.BackgroundColor = 'w';
    %   s.MinorGrid = 'off';
    %   s.MinorGridInterval = 2;
    %   s.AxesZero = 'off';
    %   s.AxesZeroColor = 'k';
    %   s.AxesZeroWidth = 2;
    %   s.AxesRadial = 'on';
    %   s.AxesAngular = 'on';
    %   s.AxesShaded = 'off';
    %   s.AxesShadedLimits = [];
    %   s.AxesShadedColor = 'g';
    %   s.AxesShadedTransparency = 0.2;
    %   s.AxesLabelsRotate = 'on';
    %
    %   % Example 5: Excel-like radar charts.
    %
    %   D1 = [5 0 3 4 4];
    %   D2 = [2 1 5 5 4];
    %   P = [D1; D2];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesInterval = 5;
    %   s.AxesPrecision = 0;
    %   s.AxesDisplay = 'one';
    %   s.AxesLimits = [0, 0, 0, 0, 0; 5, 5, 5, 5, 5];
    %   s.FillOption = 'on';
    %   s.FillTransparency = 0.1;
    %   s.Color = [139, 0, 0; 240, 128, 128]/255;
    %   s.LineWidth = 4;
    %   s.Marker = 'none';
    %   s.AxesFontSize = 14;
    %   s.LabelFontSize = 10;
    %   s.AxesColor = [0.8, 0.8, 0.8];
    %   s.AxesLabelsEdge = 'none';
    %   s.AxesRadial = 'off';
    %   title('Excel-like Radar Chart',...
    %       'FontSize', 14);
    %   s.LegendLabels = {'D1', 'D2'};
    %
    %   % Example 6: Logarithimic scale on all axes. Axes limits and axes
    %                intervals are automatically set to factors of 10.
    %
    %   D1 = [5 3 9 1 1];
    %   D2 = [5 8 7 2 10];
    %   D3 = [8 2 1 4 100];
    %   P = [D1; D2; D3];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesInterval = 2;
    %   s.AxesPrecision = 0;
    %   s.AxesFontSize = 10;
    %   s.AxesLabels = {'Linear Scale', 'Linear Scale', 'Linear Scale', 'Linear Scale', 'Logarithimic Scale'};
    %   s.AxesScaling = {'linear', 'linear', 'linear', 'linear', 'log'};
    %   s.AxesLimits = [1, 1, 1, 1, 1; 10, 10, 10, 10, 100];
    %   s.LegendLabels = {'D1', 'D2', 'D3'};
    %
    %   % Example 7: Spider plot with tiledlayout.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   close all;
    %   figure;
    %   s1 = spider_plot_class(P);
    %   s1.LegendLabels = {'Data1a', 'Data1b', 'Data1c'};
    %   s1.AxesZoom = 1;
    %   s1.AxesHorzAlign = 'quadrant';
    %   s1.AxesVertAlign = 'quadrant';
    %   figure;
    %   s2 = spider_plot_class(P);
    %   s2.LegendLabels = {'Data2a', 'Data2b', 'Data2c'};
    %   s2.AxesZoom = 1;
    %   s2.AxesHorzAlign = 'center';
    %   s2.AxesVertAlign = 'top';
    %   figure;
    %   s3 = spider_plot_class(P);
    %   s3.LegendLabels = {'Data3a', 'Data3b', 'Data3c'};
    %   s3.AxesZoom = 1;
    %   s3.AxesHorzAlign = 'left';
    %   s3.AxesVertAlign = 'middle';
    %   s1.tiledlayout(2, 2);
    %   s1.nexttile(s1);
    %   s1.nexttile(s2);
    %   s1.nexttile(s3, 3, [1, 2]);
    %   s1.TiledLayoutHandle.TileSpacing = 'none';
    %   s1.TiledLayoutHandle.Padding = 'compact';
    %   title(s1.TiledLayoutHandle, "Spider Plots");
    %   s1.tiledlegend('FontSize', 8);
    %   s1.TiledLegendHandle.Layout.TileSpan = [1, 2];
    %   s1.TiledLegendHandle.Layout.Tile = 1;
    %
    % Example 8: Spider plot with values only on data points.
    %   
    %   D1 = [1 3 4 1 2];
    %   D2 = [5 8 7 5 9];
    %   P = [D1; D2];
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesLimits = [1, 1, 1, 1, 1; 10, 10, 10, 10, 10];
    %   s.AxesDisplay = 'data';
    %   s.AxesLabelsOffset = 0.2;
    %   s.AxesDataOffset = 0.1;
    %   s.AxesFontColor = [0, 0, 1; 1, 0, 0];
    %   s.LegendLabels = {'D1', 'D2'};
    %   s.LegendHandle.Location = 'northeastoutside';
    %
    %   % Example 9: Spider plot with shaded area around axes.
    %
    %   D1 = [5 3 9 1 2];
    %   D2 = [5 8 7 2 9];
    %   D3 = [8 2 1 4 6];
    %   P = [D1; D2; D3];
    %   axes_shaded_limits = {...
    %       [5.5, 4, 3, 2, 4; 7, 6.5, 6, 3.5, 6],...
    %       [5.5, 4, 3, 2, 4; 6, 7.0, 8, 3.0, 6]};
    %   if exist('s', 'var')
    %       delete(s);
    %   end
    %   s = spider_plot_class(P);
    %   s.AxesShaded = 'on';
    %   s.AxesShadedLimits = axes_shaded_limits;
    %   s.AxesShadedColor = {'b', 'r'};
    %   s.AxesShadedTransparency = 0.1;
    %
    % Author:
    %   Moses Yoo, (juyoung.m.yoo at gmail dot com)
    %   2022-10-08: Allow for multiple shaded regions.
    %   2022-07-27: Corrected bug where only 7 entries were allowed in
    %               spider_plot_class.
    %   2022-03-24: Add support for NaN values. Plot NaN values at origin.
    %   2022-03-23: Adjust rotated axes label alignment to be closer to axes.
    %   2022-03-21: Allow axes labels to be rotated to be aligned with axes.
    %   2022-03-17: Allow a shaded band to be plotted around the axes.
    %   2022-02-14: -Add support for reference axes at value zero.
    %               -Allow for toggling radial and angular axes on or off.
    %   2022-01-23: -Add ability to change figure/axes background color.
    %               -Allow for toggling minor grid lines.
    %   2022-01-03: Fix legend to include line and marker attributes.
    %   2021-11-24: Fix axes labels misalignment. Add option to set offset for
    %               data display values.
    %   2021-11-09: Add option to change the text interpreter of axes labels
    %               and axes tick labels.
    %   2021-11-01: -Allow for plot lines and markers to be hidden.
    %               -Allow for custom text of axes tick labels.
    %   2021-04-17: Fix data display values when log scale is set.
    %   2021-04-13: Add option to adjust line and marker transparency.
    %   2021-04-08: -Add option for data values to be displayed on axes.
    %               -Add support to adjust axes font colors.
    %   2021-03-19: -Allow legend to be global in tiledlayout.
    %               -Allow axes values to be shifted.
    %               -Allow axes zoom level to be adjusted.
    %   2021-03-17: Implement tiledlayout and nexttile compatibility.
    %   2020-12-09: Allow fill option and fill transparency for each data group.
    %   2020-12-01: Added support for adjust the axes offset from origin.
    %   2020-11-30: Allow for one data group without specified axes limits.
    %   2020-11-30: Added support for changing axes and label font type.
    %   2020-11-06: Fix bug in reverse axes direction feature.
    %   2020-10-08: Adjust axes precision to be set to one or more axis.
    %   2020-10-01: Fix legend feature with inherited legend class.
    %   2020-09-30: -Fix axes limit bug. Updated examples.
    %               -Added feature to change spider axes and axes labels edge color.
    %               -Allow logarithmic scale to be set to one or more axis.
    %               -Added feature to allow different line styles, line width,
    %                marker type, and marker sizes for the data groups.
    %               -Allow ability to reverse axes direction.
    %   2020-02-17: Major revision in converting the function into a custom
    %               chart class. New feature introduced in R2019b.
    %   2020-02-12: Fixed condition and added error checking for when only one
    %               data group is plotted.
    %   2020-01-27: Corrected bug where only 7 entries were allowed in legend.
    %   2020-01-06: Added support for tiledlayout feature introduced in R2019b.
    %   2019-11-27: Add option to change axes to logarithmic scale.
    %   2019-11-15: Add feature to customize the plot rotational direction and
    %               the offset position of the axis labels.
    %   2019-10-28: Major revision in implementing the new function argument
    %               validation feature introduced in R2019b. Replaced previous
    %               method of error checking and setting of default values.
    %   2019-10-23: Minor revision to set starting axes as the vertical line.
    %               Add customization option for font sizes and axes display.
    %   2019-10-16: Minor revision to add name-value pairs for customizing
    %               color, Marker, and line settings.
    %   2019-10-08: Another major revision to convert to name-value pairs and
    %               add color fill option.
    %   2019-09-17: Major revision to improve speed, clarity, and functionality
    %
    % Special Thanks:
    %   Special thanks to Gabriela Andrade, Andrés Garcia, Alex Grenyer,
    %   Omar Hadri, Zafar Ali, Christophe Hurlin, Roman, Mariusz Sepczuk,
    %   Mohamed Abubakr, Maruis Mueller, Nicolai, Jingwei Too,
    %   Cedric Jamet, Richard Ruff, Marie-Kristin Schreiber, Jean-Baptise
    %   Billaud, Juan Carlos Vargas Rubio, Anthony Wang, Pauline Oeuvray
    %   Oliver Nicholls, Yu-Chi Chen, Fabrizio De Caro, Waqas Ahmad,
    %   Mario Di Siena, Rebecca, Nikolaos Koutsouleris, Sergi Torres &
    %   Philipp for their feature recommendations and bug finds. A huge
    %   thanks to Jiro Doke and Sean de Wolski for demonstrating the
    %   implementation of argument validation and custom chart class
    %   introduced in R2019b.
    
    %%% Public, SetObservable Properties %%%
    properties(Access = public, SetObservable)
        % Property validation and defaults
        P (:, :) double
        AxesLabels cell % Axes labels
        LegendLabels cell % Legend labels
        LegendHandle % Legend handle
        AxesInterval (1, 1) double {mustBeInteger, mustBePositive} = 3 % Number of axes grid lines
        AxesPrecision (:, :) double {mustBeInteger, mustBeNonnegative} = 1 % Tick precision
        AxesDisplay char {mustBeMember(AxesDisplay, {'all', 'none', 'one', 'data'})} = 'all'  % Number of tick label groups shown on axes
        AxesLimits double = [] % Axes limits
        FillOption {mustBeMember(FillOption, {'on', 'off'})} = 'off' % Whether to shade data
        FillTransparency double {mustBeGreaterThanOrEqual(FillTransparency, 0), mustBeLessThanOrEqual(FillTransparency, 1)} = 0.2 % Shading alpha
        Color = get(groot,'defaultAxesColorOrder') % Color order
        LineStyle = '-' % Data line style
        LineWidth (:, :) double {mustBePositive} = 2 % Data line width
        LineTransparency double {mustBeGreaterThanOrEqual(LineTransparency, 0), mustBeLessThanOrEqual(LineTransparency, 1)} = 1 % Shading alpha
        Marker = 'o' % Data marker
        MarkerSize (:, :) double {mustBePositive} = 36 % Data marker size
        MarkerTransparency double {mustBeGreaterThanOrEqual(MarkerTransparency, 0), mustBeLessThanOrEqual(MarkerTransparency, 1)} = 1 % Shading alpha
        AxesFont char ='Helvetica' % Axes tick font type
        AxesFontColor = [0, 0, 0] % Axes font color
        LabelFont char = 'Helvetica' % Label font type
        AxesFontSize (1, 1) double {mustBePositive} = 10 % Axes tick font size
        LabelFontSize (1, 1) double {mustBePositive} = 10 % Label font size
        Direction char {mustBeMember(Direction, {'counterclockwise', 'clockwise'})} = 'clockwise'
        AxesDirection = 'normal'
        AxesLabelsOffset (1, 1) double {mustBeNonnegative} = 0.2 % Offset position of axes labels
        AxesDataOffset (1, 1) double {mustBeNonnegative} = 0.1 % Offset position of axes data labels
        AxesScaling = 'linear' % Scaling of axes
        AxesColor = [0.6, 0.6, 0.6] % Axes color
        AxesLabelsEdge = 'k' % Axes label color
        AxesOffset (1, 1) double {mustBeNonnegative, mustBeInteger} = 1 % Axes offset
        AxesZoom double {mustBeGreaterThanOrEqual(AxesZoom, 0), mustBeLessThanOrEqual(AxesZoom, 1)} = 0.7 % Axes scale
        AxesHorzAlign char {mustBeMember(AxesHorzAlign, {'center', 'left', 'right', 'quadrant'})} = 'center' % Horizontal alignment of axes labels
        AxesVertAlign char {mustBeMember(AxesVertAlign, {'middle', 'top', 'cap', 'bottom', 'baseline', 'quadrant'})} = 'middle' % Vertical alignment of axes labels
        TiledLayoutHandle % Tiled layout handle
        TiledLegendHandle % Tiled legend handle
        PlotVisible {mustBeMember(PlotVisible, {'off', 'on'})} = 'on'
        AxesTickLabels {mustBeText} = 'data'
        AxesInterpreter {mustBeText} = 'tex'
        BackgroundColor = [1, 1, 1]
        MinorGrid {mustBeMember(MinorGrid, {'off', 'on'})} = 'off'
        MinorGridInterval (1, 1) double {mustBePositive, mustBeInteger} = 2
        AxesZero {mustBeMember(AxesZero, {'off', 'on'})} = 'off'
        AxesZeroColor = [0, 0, 0];
        AxesZeroWidth (1, 1) double {mustBePositive} = 2
        AxesRadial {mustBeMember(AxesRadial, {'off', 'on'})} = 'on'
        AxesAngular {mustBeMember(AxesAngular, {'off', 'on'})} = 'on'
        AxesShaded {mustBeMember(AxesShaded, {'off', 'on'})} = 'off'
        AxesShadedLimits cell = {}
        AxesShadedColor = 'g'
        AxesShadedTransparency double {mustBeGreaterThanOrEqual(AxesShadedTransparency, 0), mustBeLessThanOrEqual(AxesShadedTransparency, 1)} = 0.2 % Shading alpha
        AxesLabelsRotate {mustBeMember(AxesLabelsRotate, {'off', 'on'})} = 'off'
    end

    %%% Private, NonCopyable, Transient Properties %%%
    properties(Access = private, NonCopyable, Transient)
        % Data line object
        DataLines = gobjects(0);
        ScatterPoints = gobjects(0);
        NanPoints = gobjects(0);
        
        % Background web object
        ThetaAxesLines = gobjects(0);
        RhoAxesLines = gobjects(0);
        RhoMinorLines = gobjects(0);
        
        % Fill shade object
        FillPatches = gobjects(0);
        AxesPatches = gobjects(0);
        
        % Web axes tick values
        AxesValues = [];
        
        % Axes label object
        AxesTextLabels = gobjects(0);
        AxesTickText = gobjects(0);
        AxesDataLabels = gobjects(0);
        
        % Initialize toggle state
        InitializeToggle = true;
        
        % NextTile iterator
        NextTileIter (1, 1) double {mustBeInteger, mustBePositive} = 1 
    end
    
    %%% Protected, Dependent, Hidden Properties %%%
    properties(Access = protected, Dependent, Hidden)
        NumDataGroups
        NumDataPoints
    end
    
    methods
        %%% Constructor Methods %%%
        function obj = spider_plot_class(parentOrP, varargin)
            % Validate number of input arguments
            narginchk(1, inf);
            
            % Check if first argument is a graphic object or data
            if isa(parentOrP, 'matlab.graphics.Graphics')
                % spider_plot_class(parent, P, Name, Value, ...)
                args = [{parentOrP, 'P'}, varargin];
            else
                % spider_plot_class(P, Name, Value, ...)
                args = [{'P', parentOrP}, varargin];
            end
            
            % Call superclass constructor method
            obj@matlab.graphics.chartcontainer.ChartContainer(args{:});
        end
        
        %%% Set Methods %%%
        function set.P(obj, value)
            % Set property
            obj.P = value;
            
            % Toggle re-initialize to true if P was changed
            obj.InitializeToggle = true; %#ok<*MCSUP>
        end
        
        function set.AxesLabels(obj, value)
            % Validate axes labels
            validateAxesLabels(value, obj.P);
            
            % Set property
            obj.AxesLabels = value;
            
            % Toggle re-initialize to true if AxesLabels was changed
            obj.InitializeToggle = true;
        end
        
        function set.LegendLabels(obj, value)
            % Validate legend labels
            validateLegendLabels(value, obj.P);
            
            % Set property
            obj.LegendLabels = value;
            obj.LegendVisible = 'on';
            
            % Set legend handle
            obj.LegendHandle = getLegend(obj);
            obj.LegendHandle.Color = obj.BackgroundColor;
            
            % Toggle re-initialize to true if LegendLabels was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesInterval(obj, value)
            % Set property
            obj.AxesInterval = value;
            
            % Toggle re-initialize to true if AxesInterval was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesPrecision(obj, value)
            % Set property
            obj.AxesPrecision = value;
            
            % Toggle re-initialize to true if AxesPrecision was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesDisplay(obj, value)
            % Set property
            obj.AxesDisplay = value;
            
            % Toggle re-initialize to true if AxesDisplay was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLimits(obj, value)
            % Set property
            obj.AxesLimits = value;
            
            % Toggle re-initialize to true if AxesLimits was changed
            obj.InitializeToggle = true;
        end
        
        function set.FillOption(obj, value)
            % Set property
            obj.FillOption = value;
            
            % Toggle re-initialize to true if FillOption was changed
            obj.InitializeToggle = true;
        end
        
        function set.FillTransparency(obj, value)
            % Set property
            obj.FillTransparency = value;
            
            % Toggle re-initialize to true if FillTransparency was changed
            obj.InitializeToggle = true;
        end
        
        function set.Color(obj, value)
            % Set property
            obj.Color = value;
            
            % Toggle re-initialize to true if Color was changed
            obj.InitializeToggle = true;
        end
        
        function set.LineStyle(obj, value)
            % Set property
            obj.LineStyle = value;
            
            % Toggle re-initialize to true if LineStyle was changed
            obj.InitializeToggle = true;
        end
        
        function set.LineWidth(obj, value)
            % Set property
            obj.LineWidth = value;
            
            % Toggle re-initialize to true if LineWidth was changed
            obj.InitializeToggle = true;
        end
        
        function set.LineTransparency(obj, value)
            % Set property
            obj.LineTransparency = value;
            
            % Toggle re-initialize to true if LineTransparency was changed
            obj.InitializeToggle = true;
        end
        
        function set.Marker(obj, value)
            % Set property
            obj.Marker = value;
            
            % Toggle re-initialize to true if Marker was changed
            obj.InitializeToggle = true;
        end
        
        function set.MarkerSize(obj, value)
            % Set property
            obj.MarkerSize = value;
            
            % Toggle re-initialize to true if MarkerSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.MarkerTransparency(obj, value)
            % Set property
            obj.MarkerTransparency = value;
            
            % Toggle re-initialize to true if MarkerTransparency was changed
            obj.InitializeToggle = true;
        end

        function set.AxesFont(obj, value)
            % Set property
            obj.AxesFont = value;
            
            % Toggle re-initialize to true if AxesFont was changed
            obj.InitializeToggle = true;
        end
        
        function set.LabelFont(obj, value)
            % Set property
            obj.LabelFont = value;
            
            % Toggle re-initialize to true if LabelFont was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesFontSize(obj, value)
            % Set property
            obj.AxesFontSize = value;
            
            % Toggle re-initialize to true if AxesFontSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesFontColor(obj, value)
            % Set property
            obj.AxesFontColor = value;
            
            % Toggle re-initialize to true if AxesFontColor was changed
            obj.InitializeToggle = true;
        end
        
        function set.LabelFontSize(obj, value)
            % Set property
            obj.LabelFontSize = value;
            
            % Toggle re-initialize to true if LabelFontSize was changed
            obj.InitializeToggle = true;
        end
        
        function set.Direction(obj, value)
            % Set property
            obj.Direction = value;
            
            % Toggle re-initialize to true if Direction was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesDirection(obj, value)
            % Set property
            obj.AxesDirection = value;
            
            % Toggle re-initialize to true if Direction was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLabelsOffset(obj, value)
            % Set property
            obj.AxesLabelsOffset = value;
            
            % Toggle re-initialize to true if AxesLabelsOffset was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesScaling(obj, value)
            % Set property
            obj.AxesScaling = value;
            
            % Toggle re-initialize to true if AxesScaling was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesColor(obj, value)
            % Set property
            obj.AxesColor = value;
            
            % Toggle re-initialize to true if AxesColor was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesLabelsEdge(obj, value)
            % Set property
            obj.AxesLabelsEdge = value;
            
            % Toggle re-initialize to true if AxesLabelsEdge was changed
            obj.InitializeToggle = true;
        end

        function set.AxesOffset(obj, value)
            % Set property
            obj.AxesOffset = value;
            
            % Toggle re-initialize to true if AxesOffset was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesZoom(obj, value)
            % Set property
            obj.AxesZoom = value;
            
            % Toggle re-initialize to true if AxesZoom was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesHorzAlign(obj, value)
            % Set property
            obj.AxesHorzAlign = value;
            
            % Toggle re-initialize to true if AxesHorzAlign was changed
            obj.InitializeToggle = true;
        end
        
        function set.AxesVertAlign(obj, value)
            % Set property
            obj.AxesVertAlign = value;
            
            % Toggle re-initialize to true if AxesVertAlign was changed
            obj.InitializeToggle = true;
        end

        function set.AxesTickLabels(obj, value)
            % Set property
            obj.AxesTickLabels = value;
            
            % Toggle re-initialize to true if AxesTickLabels was changed
            obj.InitializeToggle = true;
        end

        function set.AxesInterpreter(obj, value)
            % Set property
            obj.AxesInterpreter = value;
            
            % Toggle re-initialize to true if AxesInterpreter was changed
            obj.InitializeToggle = true;
        end

        function set.BackgroundColor(obj, value)
            % Set property
            obj.BackgroundColor = value;
            
            % Toggle re-initialize to true if BackgroundColor was changed
            obj.InitializeToggle = true;
        end

        function set.MinorGrid(obj, value)
            % Set property
            obj.MinorGrid = value;
            
            % Toggle re-initialize to true if MinorGrid was changed
            obj.InitializeToggle = true;
        end

        function set.MinorGridInterval(obj, value)
            % Set property
            obj.MinorGridInterval = value;
            
            % Toggle re-initialize to true if MinorGridInterval was changed
            obj.InitializeToggle = true;
        end

        function set.AxesZero(obj, value)
            % Set property
            obj.AxesZero = value;
            
            % Toggle re-initialize to true if AxesZero was changed
            obj.InitializeToggle = true;
        end

        function set.AxesZeroColor(obj, value)
            % Set property
            obj.AxesZeroColor = value;
            
            % Toggle re-initialize to true if AxesZeroColor was changed
            obj.InitializeToggle = true;
        end

        function set.AxesZeroWidth(obj, value)
            % Set property
            obj.AxesZeroWidth = value;
            
            % Toggle re-initialize to true if AxesZeroWidth was changed
            obj.InitializeToggle = true;
        end

        function set.AxesRadial(obj, value)
            % Set property
            obj.AxesRadial = value;
            
            % Toggle re-initialize to true if AxesRadial was changed
            obj.InitializeToggle = true;
        end

        function set.AxesAngular(obj, value)
            % Set property
            obj.AxesAngular = value;
            
            % Toggle re-initialize to true if AxesAngular was changed
            obj.InitializeToggle = true;
        end

        function set.AxesShaded(obj, value)
            % Set property
            obj.AxesShaded = value;
            
            % Toggle re-initialize to true if AxesShaded was changed
            obj.InitializeToggle = true;
        end

        function set.AxesShadedLimits(obj, value)
            % Set property
            obj.AxesShadedLimits = value;
            
            % Toggle re-initialize to true if AxesShadedLimits was changed
            obj.InitializeToggle = true;
        end

        function set.AxesShadedColor(obj, value)
            % Set property
            obj.AxesShadedColor = value;
            
            % Toggle re-initialize to true if AxesShadedColor was changed
            obj.InitializeToggle = true;
        end

        function set.AxesShadedTransparency(obj, value)
            % Set property
            obj.AxesShadedTransparency = value;
            
            % Toggle re-initialize to true if AxesShadedTransparency was changed
            obj.InitializeToggle = true;
        end
        
        %%% Get Methods %%%
        function num_data_points = get.NumDataPoints(obj)
            % Get number of data points
            num_data_points = size(obj.P, 2);
        end
        
        function num_data_groups = get.NumDataGroups(obj)
            % Get number of data groups
            num_data_groups = size(obj.P, 1);
        end
        
        function axes_labels = get.AxesLabels(obj)
            % Check if value is empty
            if isempty(obj.AxesLabels)
                % Set axes labels
                axes_labels = cellstr("Label " + (1:obj.NumDataPoints));
            else
                % Keep axes labels
                axes_labels = obj.AxesLabels;
            end
        end
        
        function legend_labels = get.LegendLabels(obj)
            % Check if value is empty
            if isempty(obj.LegendLabels)
                % Set legend labels
                legend_labels = cellstr("Data " + (1:obj.NumDataGroups));
            else
                % Keep legend labels
                legend_labels = obj.LegendLabels;
            end
        end
        
        function color = get.Color(obj)
            % Check if value is empty
            if isempty(obj.Color)
                % Set color order
                color = lines(obj.NumDataGroups);
            elseif size(obj.Color, 1) < obj.NumDataGroups
                % Set color order
                color = lines(obj.NumDataGroups);
            else
                % Keep color order
                color = obj.Color;
            end
        end
        
        function axes_limits = get.AxesLimits(obj)
            % Check if value is empty
            if isempty(obj.AxesLimits)
                axes_limits = [min(obj.P, [], 1); max(obj.P, [], 1)];
            else
                % Validate axes limits
                validateAxesLimits(obj.AxesLimits, obj.P);

                % Get property
                axes_limits = obj.AxesLimits;
            end
        end

        function axes_shaded_limits = get.AxesShadedLimits(obj)
            % Get property
            if isempty(obj.AxesShadedLimits)
                axes_shaded_limits = {obj.AxesLimits};
            else
                % Iterate through axes shaded limits
                for ii = 1:length(obj.AxesShadedLimits)
                    % Initialize
                    axes_shaded_limit = obj.AxesShadedLimits{ii};

                    % Check if the axes shaded limits same length as the number of points
                    if size(axes_shaded_limit, 1) ~= 2 || size(axes_shaded_limit, 2) ~= obj.NumDataPoints
                        error('Error: Please make sure the min and max axes shaded limits match the number of data points.');
                    end

                    % Check if within min and max axes limits
                    if any(axes_shaded_limit(1, :) < obj.AxesLimits(1, :)) ||...
                            any(axes_shaded_limit(2, :) > obj.AxesLimits(2, :))
                        error('Error: Please make sure the axes shaded limits are within the min and max axes limits.');
                    end
                end

                % Get property
                axes_shaded_limits = obj.AxesShadedLimits;
            end
        end

        function axes_shaded_color = get.AxesShadedColor(obj)
            % Check if axes shaded color is a char
            if ischar(obj.AxesShadedColor)
                % Convert to cell array of char
                obj.AxesShadedColor = cellstr(obj.AxesShadedColor);

                % Repeat cell to number of axes shaded limits groups
                obj.AxesShadedColor = repmat(obj.AxesShadedColor, length(obj.AxesShadedLimits), 1);
            elseif iscellstr(obj.AxesShadedColor)
                % Check is length is one
                if length(obj.AxesShadedColor) == 1
                    % Repeat cell to number of axes shaded limits groups
                    obj.AxesShadedColor = repmat(obj.AxesShadedColor, length(obj.AxesShadedLimits), 1);
                end
            end

            % Check if axes shaded color is valid
            if length(obj.AxesShadedColor) ~= length(obj.AxesShadedLimits)
                error('Error: Please specify the same number of axes shaded color as number of axes shaded limits groups.');
            end

            % Get property
            axes_shaded_color = obj.AxesShadedColor;
        end

        function axes_shaded_transparency = get.AxesShadedTransparency(obj)
            % Check is length is one
            if length(obj.AxesShadedTransparency) == 1
                % Repeat array to number of axes shaded limits groups
                obj.AxesShadedTransparency = repmat(obj.AxesShadedTransparency, length(obj.AxesShadedLimits), 1);
            elseif length(obj.AxesShadedTransparency) ~= length(obj.AxesShadedLimits)
                error('Error: Please specify the same number of axes shaded transparency as number axes shaded limits groups.');
            end

            % Get property
            axes_shaded_transparency = obj.AxesShadedTransparency;
        end

        function axes_precision = get.AxesPrecision(obj)
            % Check if axes precision is numeric
            if isnumeric(obj.AxesPrecision)
                % Check is length is one
                if length(obj.AxesPrecision) == 1
                    % Repeat array to number of data points
                    obj.AxesPrecision = repmat(obj.AxesPrecision, obj.NumDataPoints, 1);
                elseif length(obj.AxesPrecision) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes precision as number of data points.');
                end
            else
                error('Error: Please make sure the axes precision is a numeric value.');
            end
            
            % Get property
            axes_precision = obj.AxesPrecision;
        end
        
        function axes_scaling = get.AxesScaling(obj)
            % Check if axes scaling is valid
            if any(~ismember(obj.AxesScaling, {'linear', 'log'}))
                error('Error: Invalid axes scaling entry. Please enter in "linear" or "log" to set axes scaling.');
            end
            
            % Check if axes scaling is a cell
            if iscell(obj.AxesScaling)
                % Check is length is one
                if length(obj.AxesScaling) == 1
                    % Repeat array to number of data groups
                    obj.AxesScaling = repmat(obj.AxesScaling, obj.NumDataPoints, 1);
                elseif length(obj.AxesScaling) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes scaling as number of data points.');
                end
            else
                % Repeat array to number of data groups
                obj.AxesScaling = repmat({obj.AxesScaling}, obj.NumDataPoints, 1);
            end
            
            % Get property
            axes_scaling = obj.AxesScaling;
        end
        
        function line_style = get.LineStyle(obj)
            % Check if line style is a char
            if ischar(obj.LineStyle)
                % Convert to cell array of char
                obj.LineStyle = cellstr(obj.LineStyle);
                
                % Repeat cell to number of data groups
                obj.LineStyle = repmat(obj.LineStyle, obj.NumDataGroups, 1);
            elseif iscellstr(obj.LineStyle) %#ok<*ISCLSTR>
                % Check is length is one
                if length(obj.LineStyle) == 1
                    % Repeat cell to number of data groups
                    obj.LineStyle = repmat(obj.LineStyle, obj.NumDataGroups, 1);
                elseif length(obj.LineStyle) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line styles as number of data groups.');
                end
            else
                error('Error: Please make sure the line style is a char or a cell array of char.');
            end
            
            % Get property
            line_style = obj.LineStyle;
        end
        
        function line_width = get.LineWidth(obj)
            % Check if line width is numeric
            if isnumeric(obj.LineWidth)
                % Check is length is one
                if length(obj.LineWidth) == 1
                    % Repeat array to number of data groups
                    obj.LineWidth = repmat(obj.LineWidth, obj.NumDataGroups, 1);
                elseif length(obj.LineWidth) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line width as number of data groups.');
                end
            else
                error('Error: Please make sure the line width is a numeric value.');
            end
            
            % Get property
            line_width = obj.LineWidth;
        end
        
        function marker_style = get.Marker(obj)
            % Check if marker type is a char
            if ischar(obj.Marker)
                % Convert to cell array of char
                obj.Marker = cellstr(obj.Marker);
                
                % Repeat cell to number of data groups
                obj.Marker = repmat(obj.Marker, obj.NumDataGroups, 1);
            elseif iscellstr(obj.Marker)
                % Check is length is one
                if length(obj.Marker) == 1
                    % Repeat cell to number of data groups
                    obj.Marker = repmat(obj.Marker, obj.NumDataGroups, 1);
                elseif length(obj.Marker) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line styles as number of data groups.');
                end
            else
                error('Error: Please make sure the line style is a char or a cell array of char.');
            end
            
            % Get property
            marker_style = obj.Marker;
        end
        
        function marker_size = get.MarkerSize(obj)
            % Check if line width is numeric
            if isnumeric(obj.MarkerSize)
                if length(obj.MarkerSize) == 1
                    % Repeat array to number of data groups
                    obj.MarkerSize = repmat(obj.MarkerSize, obj.NumDataGroups, 1);
                elseif length(obj.MarkerSize) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line width as number of data groups.');
                end
            else
                error('Error: Please make sure the line width is numeric.');
            end
            
            % Get property
            marker_size = obj.MarkerSize;
        end
        
        function axes_direction = get.AxesDirection(obj)
            % Check if axes direction is a cell
            if iscell(obj.AxesDirection)
                % Check is length is one
                if length(obj.AxesDirection) == 1
                    % Repeat array to number of data points
                    obj.AxesDirection = repmat(obj.AxesDirection, obj.NumDataPoints, 1);
                elseif length(obj.AxesDirection) ~= obj.NumDataPoints
                    error('Error: Please specify the same number of axes direction as number of data points.');
                end
            else
                % Repeat array to number of data points
                obj.AxesDirection = repmat({obj.AxesDirection}, obj.NumDataPoints, 1);
            end
            
            % Get property
            axes_direction = obj.AxesDirection;
        end

        function axes_offset = get.AxesOffset(obj)
            % Check if axes offset is valid
            if obj.AxesOffset > obj.AxesInterval
                error('Error: Invalid axes offset entry. Please enter in an integer value that is between [0, axes_interval].');
            end
            
            % Get property
            axes_offset = obj.AxesOffset;
        end
        
        function fill_option = get.FillOption(obj)
            % Check if fill option is a cell
            if iscell(obj.FillOption)
                % Check is length is one
                if length(obj.FillOption) == 1
                    % Repeat array to number of data groups
                    obj.FillOption = repmat(obj.FillOption, obj.NumDataGroups, 1);
                elseif length(obj.FillOption) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of fill options as number of data groups.');
                end
            else
                % Repeat array to number of data groups
                obj.FillOption = repmat({obj.FillOption}, obj.NumDataGroups, 1);
            end
            
            % Get property
            fill_option = obj.FillOption;
        end

        function fill_transparency = get.FillTransparency(obj)
            % Check if fill transparency is numeric
            if isnumeric(obj.FillTransparency)
                % Check is length is one
                if length(obj.FillTransparency) == 1
                    % Repeat array to number of data groups
                    obj.FillTransparency = repmat(obj.FillTransparency, obj.NumDataGroups, 1);
                elseif length(obj.FillTransparency) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of fill transparency as number of data groups.');
                end
            else
                error('Error: Please make sure the fill transparency is a numeric value.');
            end
            
            % Get property
            fill_transparency = obj.FillTransparency;
        end
        
        function line_transparency = get.LineTransparency(obj)
            % Check if line transparency is numeric
            if isnumeric(obj.LineTransparency)
                % Check is length is one
                if length(obj.LineTransparency) == 1
                    % Repeat array to number of data groups
                    obj.LineTransparency = repmat(obj.LineTransparency, obj.NumDataGroups, 1);
                elseif length(obj.LineTransparency) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of line transparency as number of data groups.');
                end
            else
                error('Error: Please make sure the line transparency is a numeric value.');
            end
            
            % Get property
            line_transparency = obj.LineTransparency;
        end
        
        function marker_transparency = get.MarkerTransparency(obj)
            % Check if marker transparency is numeric
            if isnumeric(obj.MarkerTransparency)
                % Check is length is one
                if length(obj.MarkerTransparency) == 1
                    % Repeat array to number of data groups
                    obj.MarkerTransparency = repmat(obj.MarkerTransparency, obj.NumDataGroups, 1);
                elseif length(obj.MarkerTransparency) ~= obj.NumDataGroups
                    error('Error: Please specify the same number of marker transparency as number of data groups.');
                end
            else
                error('Error: Please make sure the marker transparency is a numeric value.');
            end
            
            % Get property
            marker_transparency = obj.MarkerTransparency;
        end
        
        function axes_font_color = get.AxesFontColor(obj)
            % Check if axes display is data
            if strcmp(obj.AxesDisplay, 'data')
                if size(obj.AxesFontColor, 1) ~= obj.NumDataGroups
                    % Check axes font color dimensions
                    if size(obj.AxesFontColor, 1) == 1 && size(obj.AxesFontColor, 2) == 3
                        obj.AxesFontColor = repmat(obj.AxesFontColor, obj.NumDataGroups, 1);
                    else
                        error('Error: Please specify axes font color as a RGB triplet normalized to 1.');
                    end
                end
            end
            
            % Get property
            axes_font_color = obj.AxesFontColor;
        end

        function axes_tick_text = get.AxesTickLabels(obj)
            % Check if axes tick labels is valid
            if iscell(obj.AxesTickLabels)
                if length(obj.AxesTickLabels) ~= obj.AxesInterval+1
                    error('Error: Invalid axes tick labels entry. Please enter in a cell array with the same length of axes interval + 1.');
                end
            else
                if ~strcmp(obj.AxesTickLabels, 'data')
                    error('Error: Invalid axes tick labels entry. Please enter in "data" or a cell array of desired tick labels.');
                end
            end

            % Get property
            axes_tick_text = obj.AxesTickLabels;
        end

        function axes_interpreter = get.AxesInterpreter(obj)
            % Check if axes interpreter is valid
            if any(~ismember(obj.AxesInterpreter, {'tex', 'latex', 'none'}))
                error('Error: Please enter either "tex", "latex", or "none" for axes interpreter option.');
            end

            % Check if axes interpreter is a char
            if ischar(obj.AxesInterpreter)
                % Convert to cell array of char
                obj.AxesInterpreter = cellstr(obj.AxesInterpreter);
                
                % Repeat cell to number of axes labels
                obj.AxesInterpreter = repmat(obj.AxesInterpreter, length(obj.AxesLabels), 1);
            elseif iscellstr(obj.AxesInterpreter)
                % Check is length is one
                if length(obj.AxesInterpreter) == 1
                    % Repeat cell to number of axes labels
                    obj.AxesInterpreter = repmat(obj.AxesInterpreter, length(obj.AxesLabels), 1);
                elseif length(obj.AxesInterpreter) ~= length(obj.AxesLabels)
                    error('Error: Please specify the same number of axes interpreters as number of axes labels.');
                end
            else
                error('Error: Please make sure the axes interpreter is a char or a cell array of char.');
            end
            
            % Get property
            axes_interpreter = obj.AxesInterpreter;
        end
    end
    
    methods (Access = public)
        function title(obj, title_text, varargin)
            % Get axes and title handles
            ax = getAxes(obj);
            tlt = ax.Title;
            
            % Set title string
            tlt.String = title_text;
            
            % Initialze name-value arguments
            name_arguments = varargin(1:2:end);
            value_arguments = varargin(2:2:end);
            
            % Iterate through name-value arguments
            for ii = 1:length(name_arguments)
                % Set name value pair
                name = name_arguments{ii};
                value = value_arguments{ii};
                tlt.(name) = value;
            end
        end
        
        function tiledlayout(obj, varargin)
            % Figure properties
            fig = figure;
            fig.Color = obj.BackgroundColor;
            
            % Tiled layout
            obj.TiledLayoutHandle = tiledlayout(fig, varargin{:});
            drawnow;
        end
        
        function nexttile(obj, object_handle, varargin)
            % Copy over axes
            object_axes = getAxes(object_handle);
            current_axes = copyobj(object_axes, obj.TiledLayoutHandle);
            
            % Check input variable length
            switch length(varargin)
                case 2
                    tile_location = varargin{1};
                    span = varargin{2};
                case 1
                    % Check first variable length
                    if length(varargin{1}) == 1
                        tile_location = varargin{1};
                        span = [1, 1];
                    else
                        tile_location = obj.NextTileIter;
                        span = varargin{1};
                    end
                case 0
                    tile_location = obj.NextTileIter;
                    span = [1, 1];
                otherwise
                    error("Error using nexttile. Invalid arguments.")
            end
               
            % Axes settings
            current_axes.Layout.Tile = tile_location;
            current_axes.Layout.TileSpan = span;
            
            % Iterate next tile number
            obj.NextTileIter = obj.NextTileIter + 1;
        end
        
        function tiledlegend(obj, varargin)
            % Relevant graphic handles
            current_axes = gca;
            axes_handles = findobj(obj.TiledLayoutHandle, 'Type', 'axes');
            line_handles = cell(length(axes_handles), 1);
            
            % Iterate through axes handles
            for ii = 1:length(axes_handles)
                % Find and store all line handles
                line_handles{ii} = findobj(axes_handles(ii), 'Type', 'line');
            end
            
            % Concatenate contents of array
            line_handles = vertcat(line_handles{:});
            
            % Create and store legend handle
            obj.TiledLegendHandle = legend(current_axes, line_handles(:), varargin{:});
            obj.TiledLegendHandle.Color = obj.BackgroundColor;
        end
    end
    
    methods (Access = protected)
        %%% Setup Methods %%%
        function setup(obj)
            % Figure properties
            fig = gcf;
            fig.Color = obj.BackgroundColor;
            
            % Axis properties
            scaling_factor = 1 + (1 - obj.AxesZoom);
            ax = getAxes(obj);
            ax.Color = obj.BackgroundColor;
            hold(ax, 'on');
            axis(ax, 'square');
            axis(ax, 'off');
            axis(ax, [-1, 1, -1, 1] * scaling_factor);
        end
        
        %%% Update Methods %%%
        function update(obj)
            % Check re-initialize toggle
            if obj.InitializeToggle
                % Reset graphic objects
                reset_objects(obj);
                initialize(obj);
                
                % Set initialize toggle to false
                obj.InitializeToggle = false;
            end
            
            % Update plot appearance
            update_plot(obj);
        end
        
        function reset_objects(obj)
            % Delete old objects
            delete(obj.DataLines);
            delete(obj.ScatterPoints);
            delete(obj.NanPoints);
            delete(obj.ThetaAxesLines);
            delete(obj.RhoAxesLines);
            delete(obj.RhoMinorLines);
            delete(obj.FillPatches);
            delete(obj.AxesPatches);
            delete(obj.AxesTextLabels);
            delete(obj.AxesTickText);
            delete(obj.AxesDataLabels);
            
            % Reset object with empty objects
            obj.DataLines = gobjects(0);
            obj.ScatterPoints = gobjects(0);
            obj.NanPoints = gobjects(0);
            obj.ThetaAxesLines = gobjects(0);
            obj.RhoAxesLines = gobjects(0);
            obj.RhoMinorLines = gobjects(0);
            obj.FillPatches = gobjects(0);
            obj.AxesPatches = gobjects(0);
            obj.AxesValues = [];
            obj.AxesTextLabels = gobjects(0);
            obj.AxesTickText = gobjects(0);
            obj.AxesDataLabels = gobjects(0);
        end
        
        function initialize(obj)
            % Figure properties
            fig = gcf;
            fig.Color = obj.BackgroundColor;

            % Axis properties
            scaling_factor = 1 + (1 - obj.AxesZoom);
            ax = getAxes(obj);
            ax.Color = obj.BackgroundColor;
            hold(ax, 'on');
            axis(ax, 'square');
            axis(ax, 'off');
            axis(ax, [-1, 1, -1, 1] * scaling_factor);
            
            % Legend properties
            obj.LegendHandle = getLegend(obj);
            obj.LegendHandle.Color = obj.BackgroundColor;
            
            % Selected data
            P_selected = obj.P;
            
            % Check axes scaling option
            log_index = strcmp(obj.AxesScaling, 'log');
            
            % If any log scaling is specified
            if any(log_index)
                % Initialize copy
                P_log = P_selected(:, log_index);
                
                % Logarithm of base 10, account for numbers less than 1
                P_log = sign(P_log) .* log10(abs(P_log));
                
                % Minimum and maximun log limits
                min_limit = min(min(fix(P_log)));
                max_limit = max(max(ceil(P_log)));
                recommended_axes_interval = max_limit - min_limit;
                
                % Warning message
                warning('For the log scale values, recommended axes limit is [%i, %i] with an axes interval of %i.',...
                    10^min_limit, 10^max_limit, recommended_axes_interval);
                
                % Replace original
                P_selected(:, log_index) = P_log;
            end
            
            % Axes handles
            ax = getAxes(obj);
            
            % Polar increments
            theta_increment = 2*pi/obj.NumDataPoints;
            full_interval = obj.AxesInterval+1;
            rho_offset = obj.AxesOffset/full_interval;
            
            %%% Scale Data %%%
            % Number of shaded rows
            num_shaded = length(obj.AxesShadedLimits);
            shaded_rows = num_shaded * 2;

            % Check if axes shaded is on
            if strcmp(obj.AxesShaded, 'on')
                all_shaded_limits = vertcat(obj.AxesShadedLimits{:});
                P_selected = [P_selected; all_shaded_limits];
            end

            % Pre-allocation
            P_scaled = zeros(size(P_selected));
            axes_range = zeros(3, obj.NumDataPoints);
            
            % Check axes scaling option
            axes_direction_index = strcmp(obj.AxesDirection, 'reverse');
            
            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Check for one data group and no axes limits
                if obj.NumDataGroups == 1 && isempty(obj.AxesLimits)
                    % Group of points
                    group_points = P_selected(:, :);
                else
                    % Group of points
                    group_points = P_selected(:, ii);
                end
                
                % Check for log axes scaling option
                if log_index(ii)
                    % Minimum and maximun log limits
                    min_value = min(fix(group_points));
                    max_value = max(ceil(group_points));
                else
                    % Automatically the range of each group
                    min_value = min(group_points);
                    max_value = max(group_points);
                end
                
                % Range of min and max values
                range = max_value - min_value;
                
                % Check if axes_limits is not empty
                if ~isempty(obj.AxesLimits)
                    % Check for log axes scaling option
                    if log_index(ii)
                        % Logarithm of base 10, account for numbers less than 1
                        obj.AxesLimits(:, ii) = sign(obj.AxesLimits(:, ii)) .* log10(abs(obj.AxesLimits(:, ii)));
                    end
                    
                    % Manually set the range of each group
                    min_value = obj.AxesLimits(1, ii);
                    max_value = obj.AxesLimits(2, ii);
                    range = max_value - min_value;
                    
                    % Check if the axes limits are within range of points
                    if min_value > min(group_points) || max_value < max(group_points)
                        error('Error: Please make sure the manually specified axes limits are within range of the data points.');
                    end
                end
                
                % Check if range is valid
                if range == 0
                    error('Error: Range of data values is not valid. Please specify the axes limits.');
                end
                
                % Scale points to range from [0, 1]
                P_scaled(:, ii) = ((P_selected(:, ii) - min_value) / range);
                
                % If reverse axes direction is specified
                if axes_direction_index(ii)
                    % Store to array
                    axes_range(:, ii) = [max_value; min_value; range];
                    P_scaled(:, ii) = -(P_scaled(:, ii) - 1);
                else
                    % Store to array
                    axes_range(:, ii) = [min_value; max_value; range];
                end
                
                % Add offset of [rho_offset] and scaling factor of [1 - rho_offset]
                P_scaled(:, ii) = P_scaled(:, ii) * (1 - rho_offset) + rho_offset;
            end

            % Check if axes shaded is on
            if strcmp(obj.AxesShaded, 'on')
                P_shaded = P_scaled(end-shaded_rows+1:end, :);
                P_scaled = P_scaled(1:end-shaded_rows, :);
            end

            %%% Polar Axes %%%
            % Polar coordinates
            rho_increment = 1/full_interval;
            rho = 0:rho_increment:1;
            
            % Check specified direction of rotation
            switch obj.Direction
                case 'counterclockwise'
                    % Shift by pi/2 to set starting axis the vertical line
                    theta = (0:theta_increment:2*pi) + (pi/2);
                case 'clockwise'
                    % Shift by pi/2 to set starting axis the vertical line
                    theta = (0:-theta_increment:-2*pi) + (pi/2);
            end
            
            % Remainder after using a modulus of 2*pi
            theta = mod(theta, 2*pi);
            
            % Check if axes radial is toggled on
            if strcmp(obj.AxesRadial, 'on')
                % Iterate through each theta
                for ii = 1:length(theta)-1
                    % Convert polar to cartesian coordinates
                    [x_axes, y_axes] = pol2cart(theta(ii), rho);

                    % Plot
                    obj.ThetaAxesLines(ii) = line(ax, x_axes, y_axes,...
                        'LineWidth', 1.5, ...
                        'Color', obj.AxesColor,...
                        'HandleVisibility', 'off');
                end
            end

            % Check if axes angular is toggled on
            if strcmp(obj.AxesAngular, 'on')
                % Iterate through each rho
                for ii = 2:length(rho)
                    % Convert polar to cartesian coordinates
                    [x_axes, y_axes] = pol2cart(theta, rho(ii));

                    % Plot
                    obj.RhoAxesLines(ii-1) = line(ax, x_axes, y_axes,...
                        'Color', obj.AxesColor,...
                        'HandleVisibility', 'off');
                end
            end

            % Check if minor grid is toggled on
            if strcmp(obj.MinorGrid, 'on')
                % Polar coordinates
                rho_minor_increment = 1/(full_interval*obj.MinorGridInterval);
                rho_minor = rho(2):rho_minor_increment:1;
                rho_minor = setdiff(rho_minor, rho(2:end));

                % Iterate through each rho minor
                for ii = 1:length(rho_minor)
                    % Convert polar to cartesian coordinates
                    [x_axes, y_axes] = pol2cart(theta, rho_minor(ii));

                    % Plot
                    obj.RhoMinorLines(ii) = line(ax, x_axes, y_axes,...
                        'LineStyle', '--',...
                        'Color', obj.AxesColor,...
                        'LineWidth', 0.5,...
                        'HandleVisibility', 'off');
                end
            end

            % Check if axes zero is toggled on
            if strcmp(obj.AxesZero, 'on') && strcmp(obj.AxesDisplay, 'one')
                % Scale points to range from [0, 1]
                zero_scaled = (0 - min_value) / range;

                % If reverse axes direction is specified
                if strcmp(obj.AxesDirection, 'reverse')
                    zero_scaled = -zero_scaled - 1;
                end

                % Add offset of [rho_offset] and scaling factor of [1 - rho_offset]
                zero_scaled = zero_scaled * (1 - rho_offset) + rho_offset;

                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta, zero_scaled);

                % Plot webs
                h = plot(x_axes, y_axes,...
                    'LineWidth', obj.AxesZeroWidth,...
                    'Color', obj.AxesZeroColor);

                % Turn off legend annotation
                h.Annotation.LegendInformation.IconDisplayStyle = 'off';
            end

            % Set end index depending on axes display argument
            switch obj.AxesDisplay
                case 'all'
                    theta_end_index = length(theta)-1;
                case 'one'
                    theta_end_index = 1;
                case 'none'
                    theta_end_index = 0;
                case 'data'
                    theta_end_index = 0;
            end
            
            % Rho start index and offset interval
            rho_start_index = obj.AxesOffset+1;
            offset_interval = full_interval - obj.AxesOffset;

            %%% Plot %%%
            % Initialize data children
            for ii = 1:obj.NumDataGroups
                obj.FillPatches(ii) = patch(nan, nan, nan,...
                    'Parent', ax,...
                    'EdgeColor', 'none',...
                    'HandleVisibility', 'off');
                obj.DataLines(ii) = line(nan, nan,...
                    'Parent', ax);
                obj.ScatterPoints(ii) = scatter(nan, nan,...
                    'Parent', ax);
                obj.NanPoints(ii) = plot(nan, nan,...
                    'Parent', ax);
                
                % Turn off legend annotation
                obj.DataLines(ii).Annotation.LegendInformation.IconDisplayStyle = 'off';
                obj.ScatterPoints(ii).Annotation.LegendInformation.IconDisplayStyle = 'off';
                obj.FillPatches(ii).Annotation.LegendInformation.IconDisplayStyle = 'off';
            end
                
            % Check if any NaNs detected
            if any(isnan(P_scaled), 'all')
                % Set value to zero
                nan_index = isnan(P_scaled);
                P_scaled(nan_index) = 0;
            end

            % Iterate through number of data groups
            for ii = 1:obj.NumDataGroups
                % Convert polar to cartesian coordinates
                [x_points, y_points] = pol2cart(theta(1:end-1), P_scaled(ii, :));
                
                % Make points circular
                x_circular = [x_points, x_points(1)];
                y_circular = [y_points, y_points(1)];
                
                % Plot data points
                obj.DataLines(ii).XData = x_circular;
                obj.DataLines(ii).YData = y_circular;
                
                % Plot data points
                obj.ScatterPoints(ii).XData = x_circular;
                obj.ScatterPoints(ii).YData = y_circular;
                
                % Check if fill option is toggled on
                obj.FillPatches(ii).XData = x_circular;
                obj.FillPatches(ii).YData = y_circular;
                
                % Check axes display setting
                if strcmp(obj.AxesDisplay, 'data')
                    % Iterate through number of data points
                    for jj = 1:obj.NumDataPoints
                        % Convert polar to cartesian coordinates
                        [current_theta, current_rho] = cart2pol(x_points(jj), y_points(jj));
                        [x_pos, y_pos] = pol2cart(current_theta, current_rho+obj.AxesDataOffset);

                        % Display axes text
                        obj.AxesDataLabels(ii, jj) = text(ax, x_pos, y_pos, '',...
                            'Units', 'Data',...
                            'Color', obj.AxesFontColor(ii, :),...
                            'FontName', obj.AxesFont,...
                            'FontSize', obj.AxesFontSize,...
                            'HorizontalAlignment', 'center',...
                            'VerticalAlignment', 'middle',...
                            'Visible', 'off');
                    end
                end
            end

            % Check if axes shaded is on
            if strcmp(obj.AxesShaded, 'on')
                % Iterate through number of shaded groups
                for ii = 1:num_shaded
                    % Initialize
                    P_shaded_lower = P_shaded(2*ii-1, :);
                    P_shaded_upper = P_shaded(2*ii, :);
                    P_temp = [P_shaded_lower; P_shaded_upper];

                    % Polar verticies of patch
                    P_temp = [P_temp, P_temp(:, 1)];
                    P_temp = [P_temp(1, :), P_temp(2, :)];
                    patch_rho = reshape(P_temp, 1, []);
                    patch_theta = [theta, theta];

                    % Convert polar to cartesian coordinates
                    [x_points, y_points] = pol2cart(patch_theta, patch_rho);

                    % Interweave lower and upper limits
                    x_points = reshape(x_points, [], 2)';
                    y_points = reshape(y_points, [], 2)';

                    x_points = x_points(:);
                    y_points = y_points(:);

                    % Increment through groups of four vertices at a time
                    for jj = 1:2:length(x_points)-2
                        % Verticies and face points
                        v = [x_points(jj:jj+3), y_points(jj:jj+3)];
                        f = [1 2 4 3];

                        % Patch polygon
                        obj.AxesPatches(ii) = patch('Parent', ax,...
                            'Faces', f, 'Vertices', v,...
                            'FaceColor', obj.AxesShadedColor{ii},...
                            'EdgeColor', 'none',...
                            'FaceAlpha', obj.AxesShadedTransparency(ii));
                        obj.AxesPatches(ii).Annotation.LegendInformation.IconDisplayStyle = 'off';
                    end
                end
            end

            %%% Labels %%%
            % Check if axes labels rotate is on
            if strcmp(obj.AxesLabelsRotate, 'on')
                % Find number of degrees to rotate text by
                rotate_deg = rad2deg(obj.text_rotation(theta));

                % Find the horizontal alignments to align closer to axes
                horz_aligns = obj.text_alignment(theta);
            else
                % No rotation
                rotate_deg = zeros(1, length(theta));
            end

            % Iterate through number of data points
            for ii = 1:obj.NumDataPoints
                % Horizontal text alignment by quadrant
                [horz_align, ~] = obj.quadrant_position(theta(ii));

                % Check if axes labels rotate is on
                if strcmp(obj.AxesLabelsRotate, 'on')
                    % Adjust horizontal text alignment
                    horz_align = horz_aligns{ii};
                end

                % Convert polar to cartesian coordinates
                [x_pos, y_pos] = pol2cart(theta(ii), rho(end)+obj.AxesLabelsOffset);

                % Display text label
                obj.AxesTextLabels(ii) = text(ax, x_pos, y_pos, '',...
                    'Units', 'Data',...
                    'HorizontalAlignment', horz_align,...
                    'VerticalAlignment', 'middle',...
                    'EdgeColor', obj.AxesLabelsEdge,...
                    'BackgroundColor', obj.BackgroundColor,...
                    'FontName', obj.LabelFont,...
                    'FontSize', obj.LabelFontSize,...
                    'Rotation', rotate_deg(ii),...
                    'Visible', 'off');
            end
            
            % Alignment for axes labels
            horz_align = obj.AxesHorzAlign;
            vert_align = obj.AxesVertAlign;
            
            % Iterate through each theta
            for ii = 1:theta_end_index
                % Convert polar to cartesian coordinates
                [x_axes, y_axes] = pol2cart(theta(ii), rho);
                
                % Check if horizontal alignment is quadrant based
                if strcmp(obj.AxesHorzAlign, 'quadrant')
                    % Alignment based on quadrant
                    [horz_align, ~] = obj.quadrant_position(theta(ii));
                end
                
                % Check if vertical alignment is quadrant based
                if strcmp(obj.AxesVertAlign, 'quadrant')
                    % Alignment based on quadrant
                    [~, vert_align] = obj.quadrant_position(theta(ii));
                end
                
                % Iterate through points on isocurve
                for jj = rho_start_index:length(rho)
                    % Axes increment value
                    min_value = axes_range(1, ii);
                    range = axes_range(3, ii);
                    
                    % If reverse axes direction is specified
                    if axes_direction_index(ii)
                        % Axes increment value
                        axes_value = min_value - (range/offset_interval) * (jj-rho_start_index);
                    else
                        % Axes increment value
                        axes_value = min_value + (range/offset_interval) * (jj-rho_start_index);
                    end
                    
                    % Check for log axes scaling option
                    if log_index(ii)
                        % Exponent to the tenth power
                        axes_value = 10^axes_value;
                    end
                    
                    % Display axes text
                    obj.AxesValues(ii, jj) = axes_value;
                    obj.AxesTickText(ii, jj) = text(ax, x_axes(jj), y_axes(jj), '',...
                        'Units', 'Data',...
                        'Color', obj.AxesFontColor,...
                        'FontName', obj.AxesFont,...
                        'FontSize', obj.AxesFontSize,...
                        'HorizontalAlignment', horz_align,...
                        'VerticalAlignment', vert_align,...
                        'Visible', 'off');
                end
            end
             
            % Keep only valid entries
            obj.AxesValues = obj.AxesValues(:, rho_start_index:end);
            obj.AxesTickText = obj.AxesTickText(:, rho_start_index:end);
        end
        
        function update_plot(obj)
            % Fill option index
            fill_option_index = strcmp(obj.FillOption, 'on');

            % Iterate through patch objects
            for ii = 1:numel(obj.FillPatches)
                % Check fill option argument
                if fill_option_index(ii)
                    % Fill in patch with specified color and transparency
                    obj.FillPatches(ii).FaceColor = obj.Color(ii, :);
                    obj.FillPatches(ii).FaceAlpha = obj.FillTransparency(ii);
                else
                    % Set no patch color
                    obj.FillPatches(ii).FaceColor = 'none';
                end
            end
            
            % Iterate through data line objects
            for ii = 1:numel(obj.DataLines)
                % Set line settings
                obj.DataLines(ii).LineStyle = obj.LineStyle{ii};
                obj.DataLines(ii).Color = obj.Color(ii, :);
                obj.DataLines(ii).LineWidth = obj.LineWidth(ii);
                obj.DataLines(ii).DisplayName = obj.LegendLabels{ii};
                obj.DataLines(ii).Color(4) = obj.LineTransparency(ii);
                obj.DataLines(ii).Visible = obj.PlotVisible;
                
                % Set scatter settings
                obj.ScatterPoints(ii).Marker = obj.Marker{ii};
                obj.ScatterPoints(ii).SizeData = obj.MarkerSize(ii);
                obj.ScatterPoints(ii).MarkerFaceColor = obj.Color(ii, :);
                obj.ScatterPoints(ii).MarkerEdgeColor = obj.Color(ii, :);
                obj.ScatterPoints(ii).MarkerFaceAlpha = obj.MarkerTransparency(ii);
                obj.ScatterPoints(ii).MarkerEdgeAlpha = obj.MarkerTransparency(ii);
                obj.ScatterPoints(ii).Visible = obj.PlotVisible;

                % Set legend settings
                obj.NanPoints(ii).Marker = obj.Marker{ii};
                obj.NanPoints(ii).MarkerSize = obj.MarkerSize(ii)/6;
                obj.NanPoints(ii).MarkerFaceColor = obj.Color(ii, :);
                obj.NanPoints(ii).MarkerEdgeColor = obj.Color(ii, :);
                obj.NanPoints(ii).LineStyle = obj.LineStyle{ii};
                obj.NanPoints(ii).Color = obj.Color(ii, :);
                obj.NanPoints(ii).LineWidth = obj.LineWidth(ii);
                obj.NanPoints(ii).DisplayName = obj.LegendLabels{ii};
                obj.NanPoints(ii).Visible = obj.PlotVisible;
            end
            
            % Check axes labels argument
            if strcmp(obj.AxesLabels, 'none')
                % Set axes text labels to invisible
                set(obj.AxesTextLabels, 'Visible', 'off')
            else
                % Set axes text labels to visible
                set(obj.AxesTextLabels, 'Visible', 'on')
                
                % Iterate through number of data points
                for ii = 1:obj.NumDataPoints
                    % Display text label
                    obj.AxesTextLabels(ii).String = obj.AxesLabels{ii};
                    obj.AxesTextLabels(ii).FontName = obj.LabelFont;
                    obj.AxesTextLabels(ii).FontSize = obj.LabelFontSize;
                    obj.AxesTextLabels(ii).EdgeColor = obj.AxesLabelsEdge;
                    obj.AxesTextLabels(ii).Interpreter = obj.AxesInterpreter{ii};
                end
            end
            
            % Check axes axes display argument
            if strcmp(obj.AxesDisplay, 'none') || strcmp(obj.AxesDisplay, 'data')
                % Set axes tick label invisible
                set(obj.AxesTickText, 'Visible', 'off')
            else
                % Set axes tick label visible
                set(obj.AxesTickText, 'Visible', 'on')
                
                % Iterate through axes values rows
                for ii = 1:size(obj.AxesValues, 1)
                    % Iterate through axes values columns
                    for jj = 1:size(obj.AxesValues, 2)
                        % Display axes text
                        if strcmp(obj.AxesTickLabels, 'data')
                            text_str = sprintf(sprintf('%%.%if', obj.AxesPrecision(ii)), obj.AxesValues(ii, jj));
                        else
                            text_str = obj.AxesTickLabels{jj};
                        end

                        % Display and set axes tick label settings
                        obj.AxesTickText(ii, jj).String = text_str;
                        obj.AxesTickText(ii, jj).FontName = obj.AxesFont;
                        obj.AxesTickText(ii, jj).FontSize = obj.AxesFontSize;
                        obj.AxesTickText(ii, jj).Color = obj.AxesFontColor;

                        % Apply to axes tick labels only when not data
                        if iscellstr(obj.AxesTickLabels)
                            obj.AxesTickText(ii, jj).Interpreter = obj.AxesInterpreter{1};
                        end
                    end
                end
            end
            
            % Check axes display
            if strcmp(obj.AxesDisplay, 'data')
                % Set axes data label visible
                set(obj.AxesDataLabels, 'Visible', 'on')
                
                % Iterate through axes values rows
                for ii = 1:size(obj.AxesDataLabels, 1)
                    % Iterate through axes values columns
                    for jj = 1:size(obj.AxesDataLabels, 2)
                        % Display axes text
                        text_str = sprintf(sprintf('%%.%if', obj.AxesPrecision(ii)), obj.P(ii, jj));
                        obj.AxesDataLabels(ii, jj).String = text_str;
                        obj.AxesDataLabels(ii, jj).FontName = obj.AxesFont;
                        obj.AxesDataLabels(ii, jj).FontSize = obj.AxesFontSize;
                        obj.AxesDataLabels(ii, jj).Color = obj.AxesFontColor(ii, :);
                    end
                end
            else
                % Set axes data label invisible
                set(obj.AxesDataLabels, 'Visible', 'off')
            end
        end

        function horz_aligns = text_alignment(~, theta)
            % Pre-allocate cell
            horz_aligns = cell(length(theta), 1);
            horz_aligns(:) = {'center'};

            % Iterate through each theta
            for kk = 1:length(theta)
                % Adjust horizontal alignment accordingly
                if theta(kk) <= pi/2
                    horz_aligns{kk} = 'left';
                elseif theta(kk) < 3*pi/2
                    horz_aligns{kk} = 'right';
                elseif theta(kk) <= 2*pi
                    horz_aligns{kk} = 'left';
                end
            end
        end

        function rotate_deg = text_rotation(~, theta)
            % Find how much to rotate text
            rotate_deg = theta;

            % Iterate through each theta
            for kk = 1:length(theta)
                % Adjust sign and rotation accordingly
                if theta(kk) == 0
                    rotate_deg(kk) = 0;
                elseif theta(kk) > 0 && theta(kk) <= pi/2
                    rotate_deg(kk) = theta(kk);
                elseif theta(kk) > pi/2 && theta(kk) < pi
                    rotate_deg(kk) = -(pi - theta(kk));
                elseif theta(kk) == pi
                    rotate_deg(kk) = 0;
                elseif theta(kk) > pi && theta(kk) < 3*pi/2
                    rotate_deg(kk) = -(pi - theta(kk));
                elseif theta(kk) >= 3*pi/2
                    rotate_deg(kk) = -(2*pi - theta(kk));
                end
            end
        end

        function [horz_align, vert_align] = quadrant_position(~, theta_point)
            % Find out which quadrant the point is in
            if theta_point == 0
                quadrant = 0;
            elseif theta_point == pi/2
                quadrant = 1.5;
            elseif theta_point == pi
                quadrant = 2.5;
            elseif theta_point == 3*pi/2
                quadrant = 3.5;
            elseif theta_point == 2*pi
                quadrant = 0;
            elseif theta_point > 0 && theta_point < pi/2
                quadrant = 1;
            elseif theta_point > pi/2 && theta_point < pi
                quadrant = 2;
            elseif theta_point > pi && theta_point < 3*pi/2
                quadrant = 3;
            elseif theta_point > 3*pi/2 && theta_point < 2*pi
                quadrant = 4;
            end
            
            % Adjust label alignment depending on quadrant
            switch quadrant
                case 0
                    horz_align = 'left';
                    vert_align = 'middle';
                case 1
                    horz_align = 'left';
                    vert_align = 'bottom';
                case 1.5
                    horz_align = 'center';
                    vert_align = 'bottom';
                case 2
                    horz_align = 'right';
                    vert_align = 'bottom';
                case 2.5
                    horz_align = 'right';
                    vert_align = 'middle';
                case 3
                    horz_align = 'right';
                    vert_align = 'top';
                case 3.5
                    horz_align = 'center';
                    vert_align = 'top';
                case 4
                    horz_align = 'left';
                    vert_align = 'top';
            end
        end
        
    end
    
end

%%% Custom Validation Functions %%%
% Validate axes labels
function validateAxesLabels(axes_labels, P)
if ~strcmp(axes_labels, 'none')
    validateattributes(axes_labels, {'cell'}, {'size', [1, size(P, 2)]}, mfilename, 'axes_labels')
end
end

% Validate legend labels
function validateLegendLabels(legend_labels, P)
if ~strcmp(legend_labels, 'none')
    validateattributes(legend_labels, {'cell'}, {'size', [1, size(P, 1)]}, mfilename, 'legend_labels')
end
end

% Validate axes limits
function validateAxesLimits(axes_limits, P)
if ~isempty(axes_limits)
    validateattributes(axes_limits, {'double'}, {'size', [2, size(P, 2)]}, mfilename, 'axes_limits')
    
    % Lower and upper limits
    lower_limits = axes_limits(1, :);
    upper_limits = axes_limits(2, :);
    
    % Difference in upper and lower limits
    diff_limits = upper_limits - lower_limits;
    
    % Check to make sure upper limit is greater than lower limit
    if any(diff_limits < 0)
        error('Error: Please make sure max axes limits are greater than the min axes limits.');
    end
    
    % Check the range of axes limits
    if any(diff_limits == 0)
        error('Error: Please make sure the min and max axes limits are different.');
    end
end
end