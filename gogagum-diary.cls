\ProvidesClass{gogagum-diary-cls/gogagum-diary}[2026/05/03 Writing a diary in Russian.]
\LoadClass[12pt,a4paper,oneside]{book}

\RequirePackage[T2A]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,russian]{babel}
\RequirePackage{indentfirst}
\RequirePackage{array}
\RequirePackage{needspace}
\RequirePackage{multicol}
\RequirePackage{microtype}
\RequirePackage[normalem]{ulem}
\RequirePackage[useregional, calc, showdow]{datetime2}
\RequirePackage{titletoc,tocloft}
\RequirePackage{fancyhdr}
\RequirePackage{xparse}

\RequirePackage[
  a4paper,
  margin=2.5cm,
  headheight=25pt
]{geometry}

\renewcommand{\headrule}{\hrulefill}

\pagestyle{fancy}
\fancyhf{}
\cfoot{\thepage}

\setcounter{tocdepth}{4}

\setlength{\cftsubsecindent}{1cm}
\setlength{\cftsubsubsecindent}{1cm}

\makeatletter
\renewcommand\paragraph{%
  \@startsection{paragraph}{4}%
  {\parindent}%
  {-1ex \@plus -0.1ex \@minus -0.1ex}% beforeskip
  {-1em}% afterskip (positive = same line, negative = new line)
  {\normalfont\normalsize\bfseries}% style
}
\makeatother

\RequirePackage{etoolbox}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  filecolor=magenta,
  urlcolor=cyan,
}
\urlstyle{same}

\newcommand{\diarydowbyindex}[1]{%
  \ifcase#1
  Понедельник\or
  Вторник\or
  Среда\or
  Четверг\or
  Пятница\or
  Суббота\or
  Воскресенье
  \fi
}

\DTMlangsetup*{showyear=false}
\setcounter{secnumdepth}{0}

\NewDocumentCommand{\domonthlabel}{ m m }{month:#1-#2}
\NewDocumentCommand{\dodaylabel}{ m m m }{day:#1-#2-#3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{diarycurrentmonthindex}
\newcounter{diarycurrentyear}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryday}{ O{} m +m }{
  \needspace{3\baselineskip}
  \DTMcomputedayofweekindex{\arabic{diarycurrentyear}-\arabic{diarycurrentmonthindex}-#2}{\dowindex}

  \subsection*{\textit{\DTMdisplaydate{-1}{\arabic{diarycurrentmonthindex}}{#2}{-1}, \diarydowbyindex{\dowindex}\ifstrempty{#1}{}{ (#1)}}}
  \label{\dodaylabel{#2}{\arabic{diarycurrentmonthindex}}{\arabic{diarycurrentyear}}}
  {#3}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarydayreference}{ m m m m }{\hyperref[\dodaylabel{#1}{#2}{#3}]{#4}}

\newcommand{\monthnamebyindex}[1]{\ifcase #1 \or Январь\or Февраль\or Март\or %
  Апрель\or Май \or Июнь\or Июль\or Август\or Сентябрь\or Октябрь\or Ноябрь\or %
Декабрь\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarymonth}{ m }{
  \needspace{10\baselineskip}
  \setcounter{diarycurrentmonthindex}{#1}
  \section{\texorpdfstring{\centering \monthnamebyindex{#1}}{\monthnamebyindex{#1}}}
  \label{\domonthlabel{#1}{\arabic{diarycurrentyear}}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarymonthreference}{ m m m }{\hyperref[\domonthlabel{#1}{#2}]{#3}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryyear}{ m }{
  \setcounter{diarycurrentyear}{#1}
  \fancyhead[C]{#1 год}
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
  \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarynote}{ m }{
  {\noindent\footnotesize #1}
  \vspace{5pt}
}

\NewDocumentCommand{\diarypersonreference}{ m m }{\hyperref[person:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryperson}{ m m +m }{
  \section*{#2}
  \label{person:#1}

  #3
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarycountry}{ m m }{
  \section*{#2}
  \label{place:#1}
  \addcontentsline{toc}{section}{#2}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarylocality}{ m m +m }{
  \subsection*{#2}
  \label{place:#1}
  \addcontentsline{toc}{subsection}{#2}

  #3
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Улица / микрорайон / исторический район / садовое товарищество
\NewDocumentCommand{\diaryplacescluster}{ m m +m }{
  \subsubsection*{#2}
  \label{place:#1}

  #3
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryplace}{ O{} m m +m }{
  \paragraph*{#3 \ifstrempty{#1}{}{ (\href{geo:#1}{#1}) }}
  \label{place:#2}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryplacereference}{ m m }{\hyperref[place:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarytrack}{ m m m +m }{
  \needspace{5\baselineskip}
  \subsection*{#2 -- #3}
  \label{track:#1}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarytrackreference}{ m m }{\hyperref[track:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryfilm}{ m m m +m }{
  \subsection*{#2 (#3)}
  \label{film:#1}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryfilmreference}{ m m }{\hyperref[film:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarycartoon}{ m m m +m }{
  \subsection*{#2 (#3)}
  \label{cartoon:#1}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarycartoonreference}{ m m }{\hyperref[cartoon:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarycartoonseriesepisode}{ m m m +m }{
  \subsubsection*{#2 (#3)}
  \label{cartoon:#1}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryproject}{ m m +m }{
  \subsection*{#2}
  \label{project:#1}

  #3
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diaryprojectreference}{ m m }{\hyperref[project:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarybook}{ m m m +m }{
  \subsection*{#2. <<#3>>.}
  \label{book:#1}

  #4
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarybookreference}{ m m }{\hyperref[book:#1]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NewDocumentCommand{\diarytitle}{ m }{
  \thispagestyle{empty}

  \begin{center}
    \vfill
    \vspace*{0.4\textheight}

    \Huge
    \bf{#1}

    \normalsize
  \end{center}
  \newpage
}
