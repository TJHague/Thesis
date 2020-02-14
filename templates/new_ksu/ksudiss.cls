%% File: ksudiss.cls
%% 
%% Author: Chuck Gartland
%% 
%% Usage: \documentclass[<options>]{ksudiss}
%% 
%% A LaTeX document class file for doctoral dissertations in the
%% College of Arts and Sciences at Kent State University.
%% 
%% Designed to satisfy the requirements of the "Style Guide and
%% Instructions for Preparing Dissertations and Theses for Electronic
%% Submission to OhioLINK", College of Arts and Sciences, Kent State
%% University, Revised, Summer 2019
%% 
%% Options:
%% 
%%    bound = set left margin to 1.5in (instead of default 1in)---useful
%%            if the dissertation is to be printed and bound
%% 
%%   signed = produce a version of the thesis with a Signature Page
%%            suitable for signing, in which case names (advisor,
%%            committee members, chair, dean) are printed below the
%%            signature lines; otherwise, names are printed above the
%%            signature lines
%% 
%% Built on top of the standard LaTeX `report' class, to which all
%% other options are passed.
%% 
%% Accepts all the standard options for `report.cls' and uses the
%% defaults for them (unless otherwise specified):
%% 
%%   letterpaper, 10pt, oneside, onecolumn, final, openany
%% 
%% Recommended options: 11pt
%% 
%% Note: Another option to consider is 'twoside' (for two-sided printing).
%%       For electronic copies, the only effect one should see is
%%       \flushbottom page breaking instead of \raggedbottom (the 'oneside'
%%       default).  When used together with the 'bound' option above,
%%       this would produce the correct 1.5in inner margins (on all pages
%%       except for the Signature Page, which always must have a 1.5in
%%       left margin, whether it is inner or not).
%% 
%% Source files: old ksudiss.cls    (AKA mathdiss.cls)
%%               latex.ltx          (LaTeX base file)
%%               report.cls         (standard LaTeX class file)
%%               size{10,11,12}.clo (class option files 10pt, 11pt, 12pt)
%%               setspace.sty       (package for setting double space, etc.)
%%               classes.pdf        (doc file for standard LaTeX classes)
%% 
%% History:
%% 
%%   1993/10/06: v2 adapted from ksudist.sty by Paul Farrell
%%   2001/07/05: v3 modified for LaTeX2e by Bryan Lewis and George Barrick
%%   2019/08/27: v4.0 re-written to provide several fixes and improvements
%%               by Chuck Gartland
%% 
%% Bugs: please communicate any bugs or suggestions to
%%       Chuck Gartland (gartland@math.kent.edu)

% ------------------------- identification ---------------------------

\ProvidesClass{ksudiss}
              [2019/08/27 v4.0
               LaTeX document class for doctoral dissertations
               in the College of Arts and Sciences
               at Kent State University]

\typeout{}
\typeout{ksudiss: Use option 'bound' to make left/inner margins
  1.5in (instead of 1in). Use option 'signed' to produce with a
  Signature Page suitable for signing. All options for the standard
  LaTeX class 'report' work as they should.}
\typeout{}

% --------------------------- initial code ---------------------------

%% Switches for options 'bound' and 'signed'.

\newif\if@bound
\@boundfalse

\newif\if@signed
\@signedfalse

% ---------------------- declaration of options ----------------------

%% The class ksudiss.cls has two options of its own:
%% 
%%    bound = set left margin to 1.5in (instead of default 1in)---useful
%%            if thesis is to be printed and bound
%% 
%%   signed = produce a version with the Signature Page suitable for signing,
%%            in which case, names are printed below the signature lines;
%%            otherwise, names are printed above the signature lines

\DeclareOption{bound}{\@boundtrue}

\DeclareOption{signed}{\@signedtrue}

%% All other options are passed to report.cls (which is loaded below).

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% ----------------------- execution of options -----------------------

\ProcessOptions

% ------------------------- package loading --------------------------

%% Built on top of standard LaTeX class report.cls

\LoadClass{report}

%% The package calc.sty redefines \setlength and \addtolength to
%% enable infix arithmetic expressions (for cleaner, simpler
%% manipulations of lengths and dimensions).

\RequirePackage{calc}

%% The package geometry.sty defines macros \geometry, \newgeometry,
%% and \restoregeometry, which allow me to set margins globally, as
%% well as to change margins on the Signature Page below---a 1.5in
%% left margin is required on the Signature Page vs 1in on all other
%% pages.  This package also enables a "one liner" to produce these
%% margins, with all other layout parameters adjusted automatically
%% (including \textwidth, \textheight, \oddsidemargin, \evensidemargin,
%% \topmargin, \marginparwidth, and \marginparsep).

\RequirePackage{geometry}

%% The package remreset.sty defines the macro \@removefromreset for
%% removing counters from reset lists controlled by another counter.
%% I use it below to remove the figure, footnote, and table counters
%% from resets at the start of new chapters (the report.cls default).

\RequirePackage{remreset}

% ------------------------- margins, lengths -------------------------

%% The LaTeX class option files size{10,11,12}.clo (associated with
%% options 10pt, 11pt, 12pt) all set \smallskip, \medskip, \bigskip to
%% the exact same lengths: 3pt, 6pt, 12pt (1in = 72.27pt).  These are
%% rubber lengths, however, and so they can be slightly compressed or
%% stretched.  When I want to use rubber lengths in what follows, I
%% use \smallskip or \medskip or \bigskip, or so; otherwise I use
%% unstretchable spaces 3pt or 6pt or 12pt, or so.

%% The A&S Style Guide requires 1in margins all around unless the
%% thesis is to be printed and bound, in which case the left margin
%% must be 1.5in

\if@bound
   \geometry{left=1.5in,right=1in,top=1in,bottom=1in}
\else
   \geometry{margin=1in}
\fi

%% Slightly different baseline stretches are needed for double space
%% depending on the font size (10pt vs 11pt vs 12pt).  The values below
%% are taken from the setspace.sty package.  The macro \@ptsize is set
%% in report.cls to 0 or 1 or 2 according to option 10pt or 11pt or 12pt.

\ifcase \@ptsize
   \linespread{1.667}\selectfont                                        % 10pt
\or
   \linespread{1.618}\selectfont                                        % 11pt
\or
   \linespread{1.655}\selectfont                                        % 12pt
\fi

%% Slightly different baseline stretches are needed for one-and-a-half
%% space as well.  These are used only in footnotes (below).  The values
%% are from the setspace.sty package. 

\ifcase \@ptsize
   \newcommand\footstretch{1.25}                                        % 10pt
\or
   \newcommand\footstretch{1.213}                                       % 11pt
\or
   \newcommand\footstretch{1.241}                                       % 12pt
\fi

%% I want major heads created with \chapter* and \@makeschapterhead
%% (Table of Contents, List of Figures, List of Tables, Preface,
%% Acknowledgments, Bibliography) to have 1.5in top margins.  Chapter
%% and Appendix heads (as created with \chapter and \@makechapterhead)
%% will have 2in top margins.  Most of the time, when I try to do
%% \vspace*{.5in} or so at the top of a page, I get an extra
%% \baselineskip from somewhere?  So I'm defining an adjusted skip
%% here to give me the top vskips that I want.

\newlength\halfinch
\setlength\halfinch{.5in-\baselineskip}

% =========================== FRONTMATTER ============================

%% The frontmatter comprises the Abstract, Title Page, Signature Page,
%% Table of Contents, List of Figures, List of Tables, List of
%% Figures, Preface, and Acknowledgments (to be presented in that
%% order).  Some of these are required; others are optional.  All that
%% appear are assigned page numbers, though some do not allow printing
%% of the page number on the page.  Printed page numbers of frontmatter
%% are required to be lowercase Roman numerals, centered in the footer.
%% 
%% The below is executed when \begin{document} in invoked.

\AtBeginDocument{
   \pagenumbering{roman}  % resets page counter to 1, lowercase Roman numerals
   \pagestyle{plain}}     % page number centered in footer (no header)

% -------------------------- abstract page ---------------------------

%% The Abstract is optional, though it is usually included in the copy
%% submitted to the OhioLINK Electronic Theses and Dissertaions (ETD).
%% Our abstract page must have a certain format, must contain certain
%% information, and must appear as the first page(s) of the document,
%% if included.
%% 
%% I follow standard practice and have LaTeX throw an error if any of the
%% needed major information is missing.

%%% from latex.ltx

% \def\title#1{\gdef\@title{#1}}
% \def\@title{\@latex@error{No \noexpand\title given}\@ehc}

\newcommand\namedegree[1]{\renewcommand\@namedegree{#1}}
\newcommand\@namedegree{\@latex@error{No \noexpand\namedegree given}\relax}

%% If the user doesn't set \graddate{month year}, then try to deduce
%% it here based upon what the current month is: May (if month = 1-5),
%% August (if month = 6-8), December (if month = 9-12)---and append
%% the current year, to produce "month year" (with no comma).

\newcommand\graddate[1]{\renewcommand\@graddate{#1}}
\newcommand\@graddate{\ifcase \the\month \or
  May\or May\or May\or May\or May\or August\or August\or
  August\or December\or December\or December\or December\fi
  \ \the\year}

\newcommand\program[1]{\renewcommand\@program{#1}}
\newcommand\@program{\@latex@error{No \noexpand\program given}\relax}

\newcommand\pages[1]{\renewcommand\@pages{#1}}
\newcommand\@pages{\@latex@error{No \noexpand\pages given}\relax}

\newcommand\advisor[1]{\renewcommand\@advisor{#1}}
\newcommand\@advisor{\@latex@error{No \noexpand\advisor given}\relax}

\newif\if@coadvisor
\@coadvisorfalse

\newcommand\coadvisor[1]{\@coadvisortrue\renewcommand\@coadvisor{#1}}
\newcommand\@coadvisor{}

\renewenvironment{abstract}{
   \pagestyle{empty}                     % no page numbers on abstract page(s)
   \noindent
   \@namedegree, \@graddate \hfill \MakeUppercase\@program \\
   \MakeUppercase\@title \ (\@pages\ pages) \\[4pt]
   \if@coadvisor
      Dissertation Advisors: \@advisor \ and \@coadvisor
   \else
      Dissertation Advisor: \@advisor
   \fi \\[8pt]}
   {\clearpage\pagestyle{plain}}

% ---------------------------- title page ----------------------------

%% The current A&S Style Guide requires copyright language, specified
%% as inserted below.

%%% from latex.ltx

% \def\author#1{\gdef\@author{#1}}
% \def\@author{\@latex@warning@no@line{No \noexpand\author given}}

\renewcommand\@author{\@latex@error{No \noexpand\author given}\relax}

%% Below I use \centering instead of \begin{center}/\end{center} to avoid
%% the extra above/below vskips created by \begin{center}/\end{center}.

\newcommand\mytitlepage{
   \thispagestyle{empty}
   \vspace*{\halfinch}
  {\centering
%     \MakeUppercase\@title \\                                % title not bold
      {\bfseries\MakeUppercase\@title} \\                     % title bold
      \vfill
      A dissertation submitted \\
      to Kent State University \\
      in partial fulfillment of the requirements \\
      for the degree of Doctor of Philosophy \\
      \vfill
      by \\
      \@author \\[\bigskipamount]
      \@graddate \\[\bigskipamount]
      \copyright\ Copyright \\
      All rights reserved \\
      Except for previously published materials \\
  }}

% -------------------------- signature page --------------------------

%% The Signature Page requires unfilled signature lines with printed
%% names below the signature lines for the printed page to be signed
%% by the advisor(s), committee members, department chair, and A&S
%% dean; it requires filled signature lines with printed names above
%% the lines for the electronic version submitted to the OhioLINK ETD.
%% I've enabled this with the 'signed' class option, which sets the
%% switch \if@signed to be true in the "declaration of options"
%% section above.
%% 
%% Some calculations and if-then-else are used below to make sure that
%% all the boxes on the signature lines are big enough to hold the
%% information that is put in them---note that "Members, Doctoral
%% Dissertation Committee" is a whisker wider than "Co-Chair, Doctoral
%% Dissertation Committee" (when typeset in Computer Modern Font).  I
%% arrange so that the signature lines themselves are never shorter
%% than .5\textwidth, and I tacitly assume that the contents of
%% \advisor, \coadvisor, \member{one,two,three,four}, \chair, and
%% \dean are each no wider than .5\textwidth
%% 
%% The A&S Style Guide requires that the Signature Page have a 1.5in
%% left margin and a 2in top margin (which differ from the margins on
%% all other pages).  I do this one-page change using the \newgeometry
%% and \restoregeometry commands from the geometry.sty package.

\newlength\@membersboxwd  % width of "Members, Doctoral Disseration Committee"
\newlength\@chairboxwd    %   "   "" "Chair, Department of \@dept"
\newlength\@maxwd         %   "   ""  the wider of these two boxes

\settowidth\@membersboxwd{Members, Doctoral Disseration Committee}

\newlength\@raise                      % length to raise/lower name boxes
\newlength\@skip                       % length to vskip below signature lines

\if@signed
   \setlength\@raise{-12pt}
   \setlength\@skip{20pt}
\else
   \setlength\@raise{4pt}
   \setlength\@skip{12pt}
\fi

\newlength\@tinyskip            % short hskip for comma-less member lines
\settowidth\@tinyskip{\,,}

\newlength\@doubleskip          % to separate "Accepted by" from "Approved by"
\setlength\@doubleskip{20pt}

\newcommand\degrees[1]{\renewcommand\@degrees{#1}}
\newcommand\@degrees{\@latex@error{No \noexpand\degrees given}\relax}

\newcommand\memberone[1]{\renewcommand\@memberone{#1}}
\newcommand\@memberone{\@latex@error{No \noexpand\memberone given}\relax}

\newcommand\membertwo[1]{\renewcommand\@membertwo{#1}}
\newcommand\@membertwo{\@latex@error{No \noexpand\membertwo given}\relax}

\newcommand\memberthree[1]{\renewcommand\@memberthree{#1}}
\newcommand\@memberthree{\@latex@error{No \noexpand\memberthree given}\relax}

% \newcommand\memberfour[1]{\renewcommand\@memberfour{#1}}
% \newcommand\@memberfour{}

\newcommand\chair[1]{\renewcommand\@chair{#1}}
\newcommand\@chair{\@latex@error{No \noexpand\chair given}\relax}

\newcommand\dept[1]{\renewcommand\@dept{#1}}
\newcommand\@dept{\@latex@error{No \noexpand\dept given}\relax}

%% Currently valid default for \dean set below.  It can be overridden
%% by the user via \dean{...}.

\newcommand\dean[1]{\renewcommand\@dean{#1}}
\newcommand\@dean{James L. Blank}

\newcommand\signaturepage{
   % increase left/top margins to 1.5in/2in for the Signature Page only
   \newgeometry{asymmetric,left=1.5in,right=1in,top=2in,bottom=1in}
   \thispagestyle{empty}
   \settowidth\@chairboxwd{Chair, Department of \@dept}
   \ifdim\@chairboxwd>\@membersboxwd
      \setlength\@maxwd{\@chairboxwd}
   \else
      \setlength\@maxwd{\@membersboxwd}
   \fi
   \ifdim\@maxwd<.5\textwidth
      \setlength\@maxwd{.5\textwidth}
   \fi
  {\centering
      Dissertation written by \\
      \@author \\
      \@degrees \\
      \vfill
      Approved by \\[\@skip]
      \if@coadvisor
         \_\makebox[0pt][l]{\raisebox{\@raise}{\@advisor}}\hrulefill\,,
           \makebox[\@maxwd][l]{Co-Chair, Doctoral Dissertation Committee}
           \\[\@skip]
         \_\makebox[0pt][l]{\raisebox{\@raise}{\@coadvisor}}\hrulefill\,,
           \makebox[\@maxwd][l]{Co-Chair, Doctoral Dissertation Committee}
           \\[\@skip]
      \else
         \_\makebox[0pt][l]{\raisebox{\@raise}{\@advisor}}\hrulefill\,,
           \makebox[\@maxwd][l]{Chair, Doctoral Dissertation Committee}
           \\[\@skip]
      \fi
      \_\makebox[0pt][l]{\raisebox{\@raise}{\@memberone}}\hrulefill\,,
        \makebox[\@maxwd][l]{Members, Doctoral Dissertation Committee}
        \\[\@skip]
      \_\makebox[0pt][l]{\raisebox{\@raise}{\@membertwo}}\hrulefill
        \makebox[\@tinyskip]{}\makebox[\@maxwd]{} \\[\@skip]
%     \_\makebox[0pt][l]{\raisebox{\@raise}{\@memberthree}}\hrulefill
%       \makebox[\@tinyskip]{}\makebox[\@maxwd]{} \\[\@skip]
      \_\makebox[0pt][l]{\raisebox{\@raise}{\@memberthree}}\hrulefill
        \makebox[\@tinyskip]{}\makebox[\@maxwd]{} \\[\@doubleskip]
%     \_\makebox[0pt][l]{\raisebox{\@raise}{\@memberfour}}\hrulefill
%       \makebox[\@tinyskip]{}\makebox[\@maxwd]{} \\[\@doubleskip]
      Accepted by \\[\@skip]
      \_\makebox[0pt][l]{\raisebox{\@raise}{\@chair}}\hrulefill\,,
        \makebox[\@maxwd][l]{Chair, Department of \@dept} \\[\@skip]
      \_\makebox[0pt][l]{\raisebox{\@raise}{\@dean}}\hrulefill\,,
        \makebox[\@maxwd][l]{Dean, College of Arts and Sciences}%
  }
   \restoregeometry}                       % restore margins to 1in all around

% ------------------------ table of contents -------------------------

%% The A&S Style Guide wants major headings all in caps in the Table of
%% Contents (toc).  I'm sticking to that throughout the entire document.

%%% from report.cls

% \newcommand\contentsname{Contents}
% \newcommand\listfigurename{List of Figures}
% \newcommand\listtablename{List of Tables}
% \newcommand\bibname{Bibliography}
% \newcommand\chaptername{Chapter}
% \newcommand\appendixname{Appendix}

\renewcommand\contentsname{TABLE OF CONTENTS}
\renewcommand\listfigurename{LIST OF FIGURES}
\renewcommand\listtablename{LIST OF TABLES}
\renewcommand\bibname{BIBLIOGRAPHY}
\renewcommand\chaptername{CHAPTER}
\renewcommand\appendixname{APPENDIX}

%% By default, report.cls doesn't put dotfills on the toc entries for
%% major headings (Chapter, Appendix, etc., as created by \chapter
%% and \chapter*).  The current A&S Style Guide requires dotfills on
%% all entries.  I dug the appropriate code to do this out of the
%% \@dottedtocline macro and added it to the \l@chapter command,
%% which generates the Table of Contents entries.

%%% from classes.pdf

%%   \@dottedtocline{level}{indent}{numwidth}{title}{page}
%%
%%    level: produce entry only if level .le. tocdepth counter
%%           chapter level 0, section level 1, etc.
%%   indent: indentation from left margin to start of contents line
%% numwidth: width of box for section number

%%% from latex.ltx

% \def\@dottedtocline#1#2#3#4#5{%
%   \ifnum #1>\c@tocdepth \else
%     \vskip \z@ \@plus.2\p@
%     {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
%      \parindent #2\relax\@afterindenttrue
%      \interlinepenalty\@M
%      \leavevmode
%      \@tempdima #3\relax
%      \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
%      {#4}\nobreak
%      \leaders\hbox{$\m@th
%         \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
%         mu$}\hfill
%      \nobreak
%      \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
%      \par}%
%   \fi}

%%% from report.cls

% \newcommand*\l@chapter[2]{%
%   \ifnum \c@tocdepth >\m@ne
%     \addpenalty{-\@highpenalty}%
%     \vskip 1.0em \@plus\p@
%     \setlength\@tempdima{1.5em}%
%     \begingroup
%       \parindent \z@ \rightskip \@pnumwidth
%       \parfillskip -\@pnumwidth
%       \leavevmode \bfseries
%       \advance\leftskip\@tempdima
%       \hskip -\leftskip
%       #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%       \penalty\@highpenalty
%     \endgroup
%   \fi}

\renewcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
%     \leavevmode \mdseries                                      % not bold
      \leavevmode \bfseries                                      % bold
      \advance\leftskip\@tempdima
      \hskip -\leftskip
%     #1\nobreak\hfil                                            % no dots
      #1\nobreak\leaders\hbox{$\m@th                             % dots
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill     % dots
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

%% The indent and numwidth on the entries in the toc for sections and
%% for subsections seemed to me to be a little too much.  I'm shaving
%% them down a little.

%%% from report.cls

% \newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
% \newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}

\renewcommand\l@section{\@dottedtocline{1}{1.5em}{2.1em}}
\renewcommand\l@subsection{\@dottedtocline{2}{3.6em}{2.9em}}

%% The Table of Contents will look fine, as long as none of the
%% counters for chapter, section, or subsection is greater than 9.
%% Otherwise, some re-adjustment of one or more of \l@chapter,
%% \l@section, and \l@subsection above will be required.

% -------------------- preface, acknowledgments  ---------------------

%% The Preface and Acknowledgments are both optional.  If included,
%% they must be listed in the Table of Contents.

\newenvironment{preface}
  {\chapter*{PREFACE}
   \addcontentsline{toc}{chapter}{PREFACE}}
  {\clearpage}

\newenvironment{acknowledgments}
  {\chapter*{ACKNOWLEDGMENTS}
   \addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}}
  {\clearpage}

% ----------------------- process frontmatter  -----------------------

%% By default, report.cls does not include entries in the Table of
%% Contents for Table of Contents, List of Figures, and List of Tables.
%% The current A&S Style Guide requires entries for all of these.
%% 
%% I insert the required toc entries below in the \makefrontmatter macro.
%% I did this to avoid having to edit the report.cls macros for
%% \tableofcontents, \listoffigures, and \listoftables
%% 
%% I'm setting as default to print a List of Figures/Tables.  These
%% are required if there are more than 3 figures/tables in the dissertation.
%% The user can disable printing of a List of Figures/Tables by issuing
%% \figurespagefalse or \tablespagefalse (before issuing \makefrontmatter).

\newif\iflistoffigures
\listoffigurestrue

\newif\iflistoftables
\listoftablestrue

\newcommand\makefrontmatter{
   \mytitlepage
   \signaturepage
   \addcontentsline{toc}{chapter}{\contentsname} 
   \tableofcontents
   \newpage
   \iflistoffigures
      \addcontentsline{toc}{chapter}{\listfigurename} 
      \listoffigures
      \newpage
   \fi
   \iflistoftables
      \addcontentsline{toc}{chapter}{\listtablename} 
      \listoftables
      \newpage
   \fi}

% ===================== MAIN DISSERTATION BODY =======================

%% This marks the break between the frontmatter and the main body of
%% the dissertation.  From this point on, page numbers must be Arabic
%% numerals (0,1,...,9), centered in the footer (with a blank header),
%% and with page numbers reset to 1 at the start of Chapter 1.

\newcommand\mainmatter{\pagenumbering{arabic}}           % resets page counter

% ----------------------- non-double spacings ------------------------

%% Make the verbatim environment single spaced.  I also needed to add
%% a little vskip above the verbatim text in order to make it match
%% that below the text---it was probably affected by my switching from
%% double to single spacing?

%%% from latex.ltx

% \def\verbatim{\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}
% \def\endverbatim{\if@newlist \leavevmode\fi\endtrivlist}

\renewenvironment{verbatim}
  {\@verbatim
   \linespread{1}\selectfont                               % single space
   \frenchspacing\@vobeyspaces
   \@xverbatim
   \vspace{\topsep}}                                       % extra vskip above
  {\if@newlist\leavevmode\fi\endtrivlist}

%% I want single spacing in captions for figures and tables.

%%% from report.cls

% \long\def\@makecaption#1#2{%
%   \vskip\abovecaptionskip
%   \sbox\@tempboxa{#1: #2}%
%   \ifdim \wd\@tempboxa >\hsize
%     #1: #2\par
%   \else
%     \global \@minipagefalse
%     \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
%   \fi
%   \vskip\belowcaptionskip}

\renewcommand\@makecaption[2]{%
   \vskip\abovecaptionskip
   \sbox\@tempboxa{#1: #2}%
   \ifdim \wd\@tempboxa >\hsize
      \linespread{1}\selectfont   % single space if caption longer than 1 line
      #1: #2\par
   \else
      \global \@minipagefalse
      \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
   \fi
   \vskip\belowcaptionskip}

%% I want one-and-a-half spacing in footnotes---single spacing looks a
%% little small to me with the already small \footnotesize?

%%% latex.ltx

% \long\def\@footnotetext#1{\insert\footins{%
%     \reset@font\footnotesize
%     \interlinepenalty\interfootnotelinepenalty
%     \splittopskip\footnotesep
%     \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
%     \hsize\columnwidth \@parboxrestore
%     \protected@edef\@currentlabel{%
%        \csname p@footnote\endcsname\@thefnmark
%     }%
%     \color@begingroup
%       \@makefntext{%
%         \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
%     \color@endgroup}}%

\renewcommand\@footnotetext[1]{\insert\footins{%
   \reset@font\footnotesize
%  \linespread{1}\selectfont                            % single space
   \linespread{\footstretch}\selectfont                 % one-and-a-half space
   \interlinepenalty\interfootnotelinepenalty
   \splittopskip\footnotesep
   \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
   \hsize\columnwidth \@parboxrestore
   \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}
   \color@begingroup
      \@makefntext{%
         \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}
   \color@endgroup}}%

% --------------------- chapter/section headings ---------------------

%% Chapter headings need to be centered.  I'm also making them all caps
%% (as they must be in the Table of Contents), normal size, and bold.
%% 
%% \@makechapterhead makes the heading for \chapter (Chapter, Appendix);
%% while \@makeschapterhead makes the heading for \chapter* (Table of
%% Contents, List of Figures, List of Tables, Preface, Acknowledgments,
%% Bibliography).

%%% from report.cls

% \def\@makechapterhead#1{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright \normalfont
%     \ifnum \c@secnumdepth >\m@ne
%         \huge\bfseries \@chapapp\space \thechapter
%         \par\nobreak
%         \vskip 20\p@
%     \fi
%     \interlinepenalty\@M
%     \Huge \bfseries #1\par\nobreak
%     \vskip 40\p@
%   }}

\renewcommand\@makechapterhead[1]{%
   \vspace*{\halfinch}%
   \normalfont \normalsize
   \ifnum \c@secnumdepth>\m@ne
      \vspace{.5in}
      \centerline{\bfseries\@chapapp\space\thechapter}
      \vspace{6pt}
   \fi
  {\centering\bfseries#1\par\nobreak}
   \vspace{12pt}}

%%% from report.cls

% \def\@makeschapterhead#1{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright
%     \normalfont
%     \interlinepenalty\@M
%     \Huge \bfseries  #1\par\nobreak
%     \vskip 40\p@
%   }}

\renewcommand\@makeschapterhead[1]{%
   \vspace*{\halfinch}
   \normalfont \normalsize
   \centerline{\bfseries#1}
   \vspace{12pt}}

%% I want section headings to be normalsize fonts, with smaller above/below
%% skips, etc.  These are all formatted via the \@startsection command.

%%% from classes.pdf

%%   \@startsection{name}{level}{indent}{beforeskip}{afterskip}{style}
%%
%%       name: chapter, section, etc.
%%      level: depth of the section (e.g., chapter 0, section 1, ...)
%%     indent: indentation of heading from left margin
%% beforeskip: |beforeskip| = space above heading
%%             if negative, then suppress par indent of following text
%%  afterskip: space below heading (if positive)
%%             space to the right of heading (if negative)
%%      style: formating style of heading

%%% from report.cls

% \newcommand\section{\@startsection{section}{1}{\z@}%
%                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
%                                   {2.3ex \@plus.2ex}%
%                                   {\normalfont\Large\bfseries}}
% \newcommand\subsection{\@startsection{subsection}{2}{\z@}%
%                                      {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                      {1.5ex \@plus .2ex}%
%                                      {\normalfont\large\bfseries}}
% \newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%                                         {-3.25ex\@plus -1ex \@minus -.2ex}%
%                                         {1.5ex \@plus .2ex}%
%                                         {\normalfont\normalsize\bfseries}}
% \newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
%                                     {3.25ex \@plus1ex \@minus.2ex}%
%                                     {-1em}%
%                                     {\normalfont\normalsize\bfseries}}
% \newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
%                                        {3.25ex \@plus1ex \@minus .2ex}%
%                                        {-1em}%
%                                        {\normalfont\normalsize\bfseries}}

\renewcommand\section{\@startsection{section}{1}{\z@}%
   {-2ex plus -.5ex minus -.1ex}{.5ex plus .1ex}%
   {\normalfont\normalsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
   {-1.5ex plus -.25ex minus -.1ex}{.25ex plus .1ex}%
   {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
   {-1ex plus -.125ex minus -.1ex}{.125ex plus .1ex}%
   {\normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
   {1ex plus .25ex minus .1ex}{-.5em}%
   {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
   {\parskip}{-.5em}%
   {\normalfont\normalsize\bfseries}}

%% The \@startsection command used above uses \@seccntformat to format
%% the section-number part.  To my taste, it puts too much space
%% between the section number and the section title (1em = \quad).
%% I'm reducing that by half.

%%% from latex.ltx

% \def\@seccntformat#1{\csname the#1\endcsname\quad}

\renewcommand\@seccntformat[1]{\csname the#1\endcsname\hspace{.5em}}

% ------------------ figure/table/footnote counters ------------------

%% By default, report.cls resets the counters for figures, tables, and
%% footnotes for each new chapter.  The A&S Style Guide explicitly says
%% that figures and tables should be numbered sequentially throughout
%% the whole document.  The Guide doesn't say how footnotes should be
%% numbered.  So I'm fixing it here so that all three (figures, tables,
%% and footnotes) are numbered sequentially throughout.

%%% from report.cls

% \newcounter{figure}[chapter]
% \newcounter{table}[chapter]
% ...
% \@addtoreset{footnote}{chapter}

%% Using a command from the package remreset.sty

\@removefromreset{figure}{chapter}
\@removefromreset{table}{chapter}
\@removefromreset{footnote}{chapter}

% ------------------- equation/figure/table numbers ------------------

%% By default, report.cls creates equation, figure, and table numbers
%% of the form chapter.equation, chapter.figure, and chapter.table.
%% I fix the figure/table numbers here, leaving the equation numbering
%% as is.

%%% from report.cls

% \renewcommand\theequation
%      {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
% \renewcommand\thefigure
%      {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
% \renewcommand\thetable
%      {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}

\renewcommand\thefigure{\@arabic\c@figure}
\renewcommand\thetable{\@arabic\c@table}

% --------------------------- bibliography ---------------------------

%% I need to add an entry for the Bibliography in the Table of Contents,
%% and I want to make bib items single spaced.  I also had to add an extra
%% vskip in order to be consistent with the behavior of other \chapter*'s
%% (which were producing a little more space between the baseline of
%% the heading and the baseline of the first line below it?).  Since the
%% thebibliography is a list-making environment, I guessed that \topsep
%% might do the trick, and it seems to work.

%%% from report.cls

% \newenvironment{thebibliography}[1]%
%      {\chapter*{\bibname}%
%       \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
%       \list{\@biblabel{\@arabic\c@enumiv}}%
%            {\settowidth\labelwidth{\@biblabel{#1}}%
%             \leftmargin\labelwidth
%             \advance\leftmargin\labelsep
%             \@openbib@code
%             \usecounter{enumiv}%
%             \let\p@enumiv\@empty
%             \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%       \sloppy
%       \clubpenalty4000
%       \@clubpenalty \clubpenalty
%       \widowpenalty4000%
%       \sfcode`\.\@m}
%      {\def\@noitemerr
%        {\@latex@warning{Empty `thebibliography' environment}}%
%       \endlist}

\renewenvironment{thebibliography}[1]%
     {\chapter*{\bibname}%
      \addcontentsline{toc}{chapter}{\bibname}%      % add an entry in the toc
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \linespread{1}\selectfont \vspace{\topsep}  % single space + extra vskip
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% ============================= THE END  =============================

\endinput
%% 
%% End of file `ksudiss.cls'
