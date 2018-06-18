#!/usr/bin/python
load adna12step1.pdb, adna
load bdna12step1.pdb, bdna
load zdna12step1.pdb, zdna

translate [-24,0,0], adna
translate [22,0,0], zdna
translate [0,0,1.5], zdna

zoom all, 1

color black, elem c

bg white

set orthoscopic, 1

set antialias, 10
set ray_trace_mode, 0
#png conformations1a.png, width=1200, height=1200, dpi=300, ray=1
set ray_trace_mode, 3
#png conformations1b.png, width=1200, height=1200, dpi=300, ray=1

turn x, -90
zoom all, 1
set ray_trace_mode, 0
#png conformations2a.png, width=1200, height=1200, dpi=300, ray=1
set ray_trace_mode, 3
#png conformations2b.png, width=1200, height=1200, dpi=300, ray=1
