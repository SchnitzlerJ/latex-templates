% Definition of class version and last release date
\def\fileversion{1.0.0-dev}
\def\filedate{2016/12/25}

% Definition of the actual class interface
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{student}[\filedate\space Version \fileversion\space by Philipp Tempel <philipp.tempel@isw.uni-stuttgart.de>]

% Typeout a notice
\typeout{}
\typeout{ISW - Institute for Control Engineering of Machine Tools}
\typeout{      and Manufacturing Units, University Stuttgart}
\typeout{      Document class for student theses}
\typeout{      Version \fileversion\space(\filedate) }
\typeout{}

\input{common/packages-head}
\input{doctorate/packages-head}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CRUCIAL COMMANDS                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deprecate commands
\DeclareRobustCommand{\deprecate}[2]{%
  % #1 is the deprecated command
  % #2 is the new command to use
  % Issue a message at first usage
  \PackageWarning{student-thesis}{%
    Deprecated command \@backslashchar#1;\MessageBreak%
    \protect#2\space should be used instead\MessageBreak%
  }%
  % globally redefine "\#1" to "\deprecate@#1"
  \global\expandafter\let\csname#1\expandafter\endcsname%
                         \csname deprecated@#1\endcsname%
  % issue the old command
  \csname#1\endcsname%
}

\newcommand{\@deprecate}[2]{%
  \expandafter\let\csname deprecated@#1\expandafter\endcsname\csname#1\endcsname%
  \@namedef{#1}{\deprecate{#1}{#2}}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Class Configuration                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Configure the kvoptions-package
\SetupKeyvalOptions{%
    family=ISW, %
    prefix=Document, %
}

% Declare debug options
\DeclareBoolOption{debug}

% Declare print and online style (complementary)
\DeclareBoolOption{print}
\DeclareComplementaryOption{online}{print}

% Declare the document type
\def\DocumentType{doctorate}

\DeclareBoolOption[true]{twoside}
\DeclareComplementaryOption{oneside}{twoside}

% Allow user to choose language
\def\DocumentLang{ngerman}
\DeclareOption{ngerman}{\def\DocumentLang{ngerman}}
\DeclareOption{german}{\def\DocumentLang{ngerman}}
\DeclareOption{english}{\def\DocumentLang{english}}

% Default options
\ExecuteOptions{ngerman, draft, a4paper, twoside, cleardoublepage=empty, open=right}

% Pass any other options not known to the scrbook package
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Process options passed to the class
\ProcessKeyvalOptions{thesis}

\ifDocumenttwoside%
  \PassOptionsToClass{twoside}{scrbook}%
\else%
  \PassOptionsToClass{oneside}{scrbook}%
\fi%

% Process options (finally)
\ProcessOptions\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Defaults for packages used                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/packages-options}
\input{doctorate/packages-options}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Necessary Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass{scrbook}

% The package is part of the Koma-Script bundle, that provides an end user interface above scrlayer, to define and manage page styles, controlling page headers and footers. The end user interface is as much compatible to that of the earlier scrpage2 package, that users should easily be able to switch from the older package to the new, more powerful, one.
\RequirePackage{scrlayer-scrpage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Debug Packages                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debug options
\ifDocumentdebug
    \usepackage{showframe}
% Non-debug options
\else
    
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load All Other Packages                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/packages-main}
\input{doctorate/packages-main}

% Some packages from other authors may have problems with KOMA-Script. In my opinion some packages could be im- proved. With some packages this makes only sense, if KOMA- Script was used. With some other packages the package author has another opinion. Sometimes proposals was never answered. Package scrhack contains all those improvement proposals for other packages. This means, scrhack redefines macros of pack- ages from other authors! The redefinitions are only activated, if those packages were loaded. Users may prevent scrhack from redefining macros of individual packages.
\RequirePackage{scrhack}

\input{common/tikz-packages}
\input{doctorate/tikz-packages}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURE PACKAGES                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define colors                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/colors}
\input{doctorate/colors}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define environments                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/environments}
\input{doctorate/environments}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define commands                                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{common/commands}
\input{doctorate/commands}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Localization                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doctorate/localization}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure layout                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doctorate/layout}

\input{doctorate/titlepage}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some cleanup tasks                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\originalmainmatter\mainmatter%
\renewcommand{\mainmatter}{%
    \originalmainmatter%
    \arrayrulecolor{ArrayRuleColor}%
}%

% Set the overfullrule to 5pt if we are in thesisdraft mode
\ifdraft{
    \overfullrule=5pt
}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Make @ Letter and at Begin Document                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter%
  \input{common/makeatletter}
  \input{doctorate/makeatletter}
\makeatother

\AtBeginDocument{%
  \input{common/atbegindocument}
  \input{doctorate/atbegindocument}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of file                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput