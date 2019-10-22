% Copyright (C) 2012  Nicola Fontana <ntd at entidi.it>
%
% This program can be redistributed and/or modified under
% the terms of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any later
% version. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all LaTeX distributions
% version 2005/12/01 or later.
%
% Based on the original idea by Alessandro Plasmati found at
% http://www.latextemplates.com/template/two-column-one-page-cv
%
% The most relevant changes from his work are:
%
% * this is a class, not a template document;
% * tccv is based on scrartcl (from Koma-script), not on article;
% * the fonts are selected from the PSNFSS collection, so no
%   custom font installation should be required;
% * heavily based the implementation on custom environments and
%   macros, so the document is much easier to read (and customize);
% * it is plain LaTeX/Koma-script, so the CV can be compiled
%   with the usual tools, latex and pdflatex included.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tccv}
              [2012/11/09 v1.0
 Two Column Curriculum Vitae]

\LoadClass[10pt]{scrartcl}

\setcounter{secnumdepth}{-1}
\RequirePackage[hmargin=1.25cm,vmargin=1cm,twocolumn,columnsep=1.25cm]{geometry}
\RequirePackage{bookman,etoolbox,hyperref,marvosym,needspace,tabularx,xcolor}

% Capitalize words of at least a minimum length (default to 3 chars).
% The text is capitalized before being expanded.
%
% This macro uses Lua to do the job but fails gracefully (that is,
% return the text as is) if \directlua is not available.
%
% |[
% \ucwords[optional: miminum length]{text}
% ]|
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}

\newcommand\ucwords[2][3]{%
    % Fails gracefully if not in LuaLaTeX
    \providecommand\directlua[1]{#2}%
    \directlua{%
	local minlen=tonumber("#1")
	local src="\luaescapestring{\unexpanded{#2}}"
	local dst={}
	for w in src:gmatch('[^\string\%s]+') do
	    if w:len() >= minlen then w = w:sub(1,1):upper()..w:sub(2) end
	    table.insert(dst, w)
	end
	tex.print(dst)}}

\pagestyle{empty}
\setlength\parindent{0pt}
\color[HTML]{303030} % Default foreground color
\definecolor{link}{HTML}{20418E} % Hyperlinks
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}
\setkomafont{disposition}{\color[HTML]{801010}}
\setkomafont{section}{\scshape\Large\mdseries}

% In tccv \part must contain the subject of the curriculum vitae.
% The command will start a new page and output in onecolumn the
% subject (first and last name) with the hardcoded text
% "Curriculum vitae" under it.
% \renewcommand\part[5][]{%
%   \twocolumn[%
%   % \needspace{0.5\textheight}%
  

%   \begin{center}
%     \newdimen\boxwidth%
%     \boxwidth=\dimexpr\columnwidth%-2\fboxsep\relax%
%     % \colorbox[HTML]{FFFFFF}{%
%     \raggedleft{\begin{tabularx}{\boxwidth}{c|X}
%       \Gentsroom & {#4}\smallskip\\
%       % \Writinghand & {#2}\smallskip\\
%       \Telefon     & {#2}\smallskip\\
%       \Letter      & \href{mailto:#3}{#3}
%       \ifstrempty{#1}{}{\smallskip\\
%       \Lightning & \href{http://#1}{#1}}
%     \end{tabularx}}
%     %     \vskip-\lastskip%
%          {\usekomafont{part} Filip Mari\'c}% \medskip\\
%     %     %{\fontfamily{cm}\selectfont\Large Curriculum vitae}
%     %     \bigskip
%     \end{center}
%       ]
%     }

\renewcommand\part[5][]{
 \twocolumn[
  \begin{minipage}{0.45\textwidth} %0.65
    {\usekomafont{part}Filip Mari\'c}
    \begin{flushright}
    {\small  \textit{``Understanding is but the sum of misunderstandings.''}\\
      \textit{-Haruki Murakami}}
    \end{flushright}
  \end{minipage}\bigskip
  \hspace{0.2\textwidth}
  \begin{minipage}{0.35\textwidth}
    \raggedright{\begin{tabularx}{\linewidth}{c|X} 
      \Gentsroom & {#4}\smallskip\\
      \Telefon & {#2}\smallskip\\
      \Letter & \href{mailto:#3}{#3}\smallskip\\
      \Lightning & \href{http://#1}{#1}
    \end{tabularx}}
  \end{minipage}

  ]
}

% Overrides the \section command to capitalize every
% word for cosmetic purposes and draws a rule under it.
\makeatletter
\let\old@section\section
\renewcommand\section[2][]{%
    \old@section[#1]{\ucwords{#2}}%
    \newdimen\raising%
    \raising=\dimexpr-0.7\baselineskip\relax%
    \vskip\raising\hrule height 0.4pt\vskip-\raising}
\makeatother

% Allow conditionals based on the job name. This can usually be set
% from a command-line argument: check fausto.en.tex for an example.
%
% |[
% \ifjob{jobname}{content if matches}{content if does not match}
% ]|
\newcommand\ifjob[3]{%
    \edef\JOBNAME{\jobname}%
    \edef\PIVOT{\detokenize{#1}}%
    \ifdefstrequal{\JOBNAME}{\PIVOT}{#2}{#3}%
}

% Renders a personal data box:
%
% |[
% \personal[optional: web site without scheme (no http:// prefix)]
%          {address}{phone number}{email}
% ]|

% Every \item can be followed by one or more paragraphs
% of description:
%
% |[
% \item{date range}{company}{role}
%
% Description of what achieved during this application.
% ]|
\newenvironment{eventlist}{%
    \newcommand*\inskip{}
    \renewcommand\item[3]{%
	\inskip%
	{\raggedleft\sc ##1\\[1pt]}
	{ ##2}\\[2pt]
	%{\it ##3}
	%\smallskip
	\renewcommand\inskip{\bigskip}}}

% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item[optional: what has been achieved]{years}{subject}{notes}
% ]|
\newenvironment{yearlist}{%
    \renewcommand\item[4][]{%
	{\small \sc ##2} & {\bfseries ##3} \\
	\ifstrempty{##1}{}{& {\sc ##1} \\}
	\ifstrempty{##4}{}{& {\it ##4}\medskip\\}}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}

\newenvironment{yearlist2}{%
    \renewcommand\item[4][]{%
	{\small \sc ##2} & {\bfseries ##3} \\
	\ifstrempty{##1}{}{& {\sc ##1} \\}
	& {##4}\medskip\\}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}

% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item{fact}{description}
% ]|
\newenvironment{factlist}{%
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    \renewcommand\item[2]{%
	\textsc{\small ##1} & {\raggedright \small ##2\smallskip\\}\\[\unbaseline]} 
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
%%
%% End of file `tccv.cls'.
