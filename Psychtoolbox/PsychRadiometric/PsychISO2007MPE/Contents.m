% Psychtoolbox:PsychISO2007MPE.
%
% Partial and in progress implementation of ISO 2007 standard for computing
% maximum permissable exposure to broadband lights.
%
% *****************************************************************
% IMPORTANT:
%   a) Individuals using these routines must accept full responsibility 
%   for light exposures they implement. We recommend that values computed
%   with these routines be carefully checked against independent calculations.
%   We have done our best to follow the standard, but it is very complex and
%   there may be errors.
%
%   b) As of June, 2013, these routines are still very much a work
%   in progress and should thus be treated with special caution.  See
%   ISO2007MPEBasicTest.
%
%   c) Only the Type 1 limits are computed.  My impression is that these are
%   more conservative, and that if you stay below them you good wrt the
%   standard content.  I believe that technically, a Type 1 instruement is
%   one that *cannot* produce more light than the Type 1 limits, but it seems
%   to me that for research purposes the main point is to stay below those limits
%   independent of what the instrument could in principle produce.  If someone
%   knows more or has a different view, please let me (DHB, brainard@psych.upenn.edu)
%   know.
%
%   d) There is a limit (Table 2, 5.4.1.5) for convergent beams, which I think is what
%   a Maxwellian view produces.  I wrote a placeholder routine for this limit, but since
%   I am not currently using such a rig I don't have any application for it and have
%   not tested it.
%
%   e) The standard uses cm^2 based units for radiance, irradiance, etc.  It switches
%   between uWatts, mWatts, and Watts depending on which limit is being considered.
%   For uniformity, these routines return all quantities and limits in uWatts, cm^2
%   based units.
%
%   For input, we typically measure radiance in Watts/[sr-m^22] and all the routines take
%   radiance as input and convert as necessary (with the help of passed ancilliary arguments).
%   To match the measurement instrumentation we use, the radiance units are kept in
%   units of Watts/[sr-m^22], and the routines do the appropriate converstions.  
%   these are the input units expected. The one exception on the input is the convergent beam limit,
%   where the input is irradiance and should be passed in uWatts/cm^2.   The help text is pretty
%   clear about what is desired for each routine.
%
% REFERENCES.
%   Ansi ISO 15004-2, Ophthalmic instruments - Fundamental requirements and test methods -
%   Part 2: Light hazard protection.  The standard document.  Tables listed below are in
%   this document.
%
%   ISO2007MPEBasicTest      - Test the suite of routines.  Generates many figures that should match those in the standard.
%   ISO2007MPECheckType1ContinuousRadiance - Wrapper function for comparing a measured radiance to MPE limits.
%   ISO2007MPEComputeType1ContinuousAntConvrgUnweightedValue - Placeholder (not tested) for convergent beam limit.  Table 2, 5.4.1.5.
%   ISO2007MPEComputeType1ContinuousCornealIRUnweightedValue - As the name indicates.  Table 2, 5.4.1.4.
%   ISO2007MPEComputeType1ContinuousCornealUVUnweightedValue - As the name indicates.  Table 2, 5.4.1.2.
%   ISO2007MPEComputeType1ContinuousCornealUVWeightedValue - As the name indicates.  Table 2, 5.4.1.1.
%   ISO2007MPEComputeType1ContinuousRadiancePCWeightedValue - As the name indicates.  Table 2, 5.4.1.3.b
%   ISO2007MPEComputeType1ContinuousRadianceTHWeightedValue - As the name indicates.  Table 2, 5.4.1.6.b
%   ISO2007MPEComputeType1ContinuousRetIrradiancePCWeightedValue - As the name indicates.  Table 2, 5.4.1.3.a
%   ISO2007MPEComputeType1ContinuousRetIrradianceTHWeightedValue - As the name indicates.  Table 2, 5.4.1.6.a
%   ISO2007MPEGetWeigthtings - Get the spectral weighting functions needed by the standard.
%   ISO2007MPEPrintAnalysis - Formatted print of output returned by ISO2007MPECheckType1ContinuousRadiance.
%
%   ISO2007MPETableA1.txt    - Table A1 of the standard as tab delimited text.
%   ISO2007MPETableA2.txt    - Table A2 of the standard as tab delimited text.


% Copyright (c) 2013 by David Brainard
