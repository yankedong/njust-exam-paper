% 南京理工大学试卷模板，修改自暨南大学吕荐瑞老师的模板
% 修改人：颜克冬 计算机学院
% 原作者信息如下
% -*- coding: utf-8 -*-
% ----------------------------------------------------------------------------
% Author:  Jianrui Lyu <tolvjr@163.com>
% Website: https://lvjr.bitbucket.io/jnuexam.html
% License: The LaTeX Project Public License 1.3
% ----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njustexam}[2021/02/28]

\newif\ifplain      \plainfalse      % 是否添加密封线和草稿纸
\newif\ifsidebyside \sidebysidefalse % 是否 A3 纸张
\newif\ifreverse    \reversefalse    % 是否逆序出题
\newif\ifanswer     \answertrue      % 是否显示答案
\newif\ifamsfonts   \amsfontsfalse   % 切换数学字体
\newif\ifsourcehan  \sourcehanfalse  % 切换思源字体
\newif\ifdisplay    \displayfalse    % 切换展示公式

\DeclareOption{plain}{\plaintrue}
\DeclareOption{a3paper}{\sidebysidetrue}
\DeclareOption{a3input}{\sidebysidetrue\plaintrue}
\DeclareOption{reverse}{\reversetrue}
\DeclareOption{noanswer}{\answerfalse}
\DeclareOption{amsfonts}{\amsfontstrue}
\DeclareOption{sourcehan}{\sourcehantrue}
\DeclareOption{display}{\displaytrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}} %其它选项

\ProcessOptions %不可省略

% 四号    小四号    五号      小五号
% 14bp    12bp      10.5bp    9bp
\LoadClass[cs4size,UTF8,noindent]{ctexart}

\ifamsfonts
  \RequirePackage{amssymb}
\else
  \RequirePackage[utopia]{mathdesign} % charter, utopia
  \renewcommand\bfdefault{bx}
  \let\oldoiint\oiint\renewcommand{\oiint}{\oldoiint\nolimits}
  \DeclareTextCommandDefault{\nobreakspace}{\leavevmode\nobreak\ }
\fi

%\ifsidebyside
\RequirePackage[a3paper,landscape,twocolumn,columnsep=22mm,left=30mm,right=30mm,top=30mm,bottom=30mm]{geometry}
%\else
%  \RequirePackage[a4paper,left=30mm,right=30mm,top=25mm,bottom=25mm]{geometry}
%\fi

\RequirePackage{tabularx}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{comment}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{iftex}
\RequirePackage{enumitem}
\RequirePackage{xeCJK}
\RequirePackage{xeCJKfntef}

\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcolumntype{n}[1]{>{\centering\arraybackslash}m{#1}}

\setlength{\parindent}{0em}
\setlength{\lineskiplimit}{4pt}
\setlength{\lineskip}{4pt}

%% ---------------------------------------------------------------------------
%% 密封线命令 \addsealingline
%% 草稿纸命令 \addscratchpaper
%% 这两个命令需要编译两次才能得到正确结果
%% ---------------------------------------------------------------------------

%\ifplain\else
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{everypage}
%\fi
%


\newcommand{\addborder}{\tikz[overlay, remember picture] {
    \draw [very thick] ($(current page.north west) + (18mm,-25mm)$) rectangle ($(current page.south east) + (-18mm, 23mm)$);
	\draw [very thick] ($(current page.north) + (0mm,-25mm)$) -- ($(current page.south) + (0mm, 23mm)$);
}}

\newcommand{\addline}{\tikz[overlay, remember picture] {
	\draw [very thick] ($(current page.north) + (-192mm, -95mm)$) -- ($(current page.north) + (0mm, -95mm)$);
}}

\AddThispageHook{\addline}
\AddEverypageHook{\addborder}

%\newcommand{\sealinglineleft}{
%  \path (current page.north west) +(25mm,-25mm) coordinate (a1);
%  \path (current page.south west) +(25mm,25mm)  coordinate (a2);
%  \draw[dashed] (a1) -- node[left=1mm,text width=1em,inner sep=0pt]{\1{线}\0\1{订}\0\1{装}} (a2);
%}
%
%\newcommand{\sealinglineright}{
%  \path (current page.north east) +(-25mm,-25mm) coordinate (b1);
%  \path (current page.south east) +(-25mm,25mm)  coordinate (b2);
%  \draw[dashed] (b1) -- node[right=1mm,text width=1em,inner sep=0pt]{\2{装}\0\2{订}\0\2{线}} (b2);
%}
%
%\newcommand{\sealinglineone}{%
%\def\0{\\[70mm]}\def\1{\rotatebox{90}}\def\2{\rotatebox{-90}}%
%\begin{tikzpicture}[remember picture,overlay,very thick]
%  \ifnumodd{\value{page}}{\sealinglineleft}{\sealinglineright}
%\end{tikzpicture}}
%
%\newcommand{\sealinglinetwo}{%
%\def\0{\\[70mm]}\def\1{\rotatebox{90}}\def\2{\rotatebox{-90}}%
%\begin{tikzpicture}[remember picture,overlay,very thick]
%  \sealinglineleft\sealinglineright
%\end{tikzpicture}}
%
%\ifsidebyside
%  \let\sealingline=\sealinglinetwo
%\else
%  \let\sealingline=\sealinglineone
%\fi
%
%\newcommand{\mifengxian}{3}
%
%\newcommand{\addsealingline}{%
%  \ifcase\mifengxian % 0
%  \or % 1
%    \ifbool{answer}{}{\sealingline}%
%  \or % 2
%    \sealingline
%  \fi
%}
%
%\ifplain\else
%  \AddEverypageHook{\addsealingline}
%\fi
%
%\newcommand{\scratchpaperone}{%
%\begin{tikzpicture}[remember picture,overlay,font=\sffamily\fontsize{120pt}{120pt}\selectfont]
%  \node[text=lightgray!40,text width=120pt] at (current page.center) {草\\ 稿\\ 纸};
%\end{tikzpicture}}
%
%\newcommand{\scratchpapertwo}{%
%\begin{tikzpicture}[remember picture,overlay,font=\sffamily\fontsize{180pt}{180pt}\selectfont]
%  \node[text=lightgray!40] at (current page.center) {草\quad 稿\quad 纸};
%\end{tikzpicture}}
%
%\newcommand{\caogaozhi}{1}

% 为了更准确的页码，这里用 \newpage 而非 \clearpage，故要求试卷中不能有浮动体
%\newcommand{\doscratchpaperone}{
%  \ifnumgreater{\caogaozhi}{0}{%
%    \ifnumodd{\value{page}}{%
%      \newpage\pagestyle{empty}\addtocounter{page}{-1}%
%      \let\sealinglineleft=\sealinglineright
%    }{}%
%  }{}%
%  \ifcase\caogaozhi % 0
%  \or % 1
%     \leavevmode\newpage\pagestyle{empty}\let\addsealingline=\relax\scratchpaper
%     \leavevmode\newpage\scratchpaper\addtocounter{page}{-2}%
%  \or % 2
%     \leavevmode\newpage\pagestyle{empty}\let\addsealingline=\relax\scratchpaper
%     \leavevmode\newpage\scratchpaper\leavevmode\newpage\scratchpaper
%     \leavevmode\newpage\scratchpaper\addtocounter{page}{-4}%
%  \fi
%}

% 在 twocolumn 文档中，\newpage 到下一栏，\clearpage 到下一页
% 由于无容易知道在左栏还是右栏，故这里用 \clearpage 而非 \newpage
%\newcommand{\doscratchpapertwo}{
%  \ifcase\caogaozhi % 0
%  \or % 1
%     \clearpage\pagestyle{empty}\let\addsealingline=\relax\scratchpaper
%     \scratchpaper\addtocounter{page}{-1}%
%  \or % 2
%     \clearpage\pagestyle{empty}\let\addsealingline=\relax\scratchpaper
%     \scratchpaper\clearpage\scratchpaper\addtocounter{page}{-2}%
%  \fi
%}
%
%\ifsidebyside
%  \let\scratchpaper=\scratchpapertwo
%  \let\doscratchpaper=\doscratchpapertwo
%\else
%  \let\scratchpaper=\scratchpaperone
%  \let\doscratchpaper=\doscratchpaperone
%\fi

% 在旧版本 ctex 宏包中不能用 \AtEndDocument 添加含中文的内容，即不能用 \appto 而要用 \preto
%\newcommand{\addscratchpaper}{%
%  \preto{\@enddocumenthook}{\doscratchpaper}%
%}

%\ifplain\else\ifanswer\else
%  \addscratchpaper
%\fi\fi
%
%\ifsidebyside
%  \RequirePackage{pdfpages}
%  % 新版本 pdfpages 将 \includepdf 放在文档开头时会有命令未定义的错误
%  % 见 https://tex.stackexchange.com/questions/352007/ieeetran-and-pdfpages
%  % 另外从 LaTeX release 2018 开始 \@ifundefined 不再将未定义命令定义为 \relax
%  % 见 https://www.latex-project.org/news/latex2e-news/ltnews28.pdf
%  \@ifundefined{@setmarks}{\let\@setmarks\relax}{}
%\fi

%% ---------------------------------------------------------------------------
%% 试卷表头命令 \makehead
%% ---------------------------------------------------------------------------

%\newcommand{\niandu}{2016-2017}
%\newcommand{\xueqi}{2}
\newcommand{\course}{}	%课程名
\newcommand{\credit}{}					%学分
\newcommand{\syllabus}{} 	%课程大纲编号
\newcommand{\fullmark}{}	%满分
\newcommand{\duration}{}   %考试时间
\newcommand{\composer}{}  %组卷教师
\newcommand{\validator}{}  %审定人
\newcommand{\composedate}{}  %组卷日期
\newcommand{\coursetype}{1}   % 1 为必修，0 为选修
\newcommand{\exammethod}{1}  % 1 为闭卷，0 为开卷
\newcommand{\testpaper}{A} % A 或 B 或 C 卷
%\newcommand{\neizhao}{1} % 1 打勾，0 不勾
%\newcommand{\waizhao}{1} % 1 打勾，0 不勾

\newcommand{\underspace}[1]{\kern0pt\underline{\hspace{#1}}\kern0pt\relax}
\newcommand{\underbox}[2]{\kern0pt\underline{\makebox[#1]{#2}}\kern0pt\relax}
\newcommand{\underparbox}[2]{\kern0pt\underline{\parbox[b]{#1}{#2}}\kern0pt\relax}

\newcommand{\ischeck}[1]{\ifnum#1>0\,$\checkmark$\,\else\quad\fi}
\newcommand{\isquad}[1]{\ifnum#1=0\,$\checkmark$\,\else\quad\fi}

\newcommand\my@temp@a{A}
\newcommand\my@temp@c{C}
\newcommand\my@empty{}

\newcommand{\head@table@a}{%
  \begin{tabular}{l}
%    \underbox{11\ccwd}{\niandu}学年度第\underbox{5.5\ccwd}{\xueqi}学期 \\
    {\bfseries 课程名称：\underbox{14\ccwd}{\centering\rule{0pt}{3ex}\course}}  \; 时长：\underparbox{4\ccwd}{\centering\rule{0pt}{3ex}\textbf{\duration}}分钟 \\
    学分：\underparbox{2\ccwd}{\centering\rule{0pt}{3ex}\credit} \; 教学大纲编号：\underparbox{7\ccwd}{\centering\rule{0pt}{3ex}\syllabus} \; 满分分值：\underparbox{3\ccwd}{\centering\rule{0pt}{3ex}\fullmark} \\
     组卷教师（签字）：\underparbox{20\ccwd}{\centering\rule{0pt}{3ex}\composer} \\
    组卷日期：\underparbox{9\ccwd}{\centering\rule{0pt}{3ex}\composedate} \; 审定人（签字）：\underparbox{6.4\ccwd}{\centering\rule{0pt}{3ex}\validator}  \\
  \end{tabular}
}

\newcommand{\head@table@b}{%
  \renewcommand{\arraystretch}{1}%
  \begin{tabular}{l}
    \textbf{课程类别} \\ 必修~[\ischeck{\coursetype}]\quad 选修~[\isquad{\coursetype}] \\
    \hline
    \textbf{考试方式} \\ 开卷~[\isquad{\exammethod}]\quad 闭卷~[\ischeck{\exammethod}] \\
    \hline
    \textbf{试卷编号}~(\,A, B\,)\\\relax [\,\textbf{\testpaper}\,]\hfill 共~\pageref{LastPage}~页
  \end{tabular}
}

\newcommand{\head@table@c}{%
  \begin{tabular}{l}
  \bfseries 班\kern0pt(\kern0pt{}级\kern0pt)：\underspace{10\ccwd} \; 姓名：\underspace{8\ccwd} \; 学号：\underspace{10\ccwd}\hfill
%    \underspace{10\ccwd}学院\underspace{8\ccwd}专业\underspace{7.5\ccwd}班\kern0pt(\kern0pt{}级\kern0pt) \\[1em]
%    姓名\underspace{8\ccwd}学号\underspace{10\ccwd}\hfill
%    \bfseries 内招~[\ischeck{\neizhao}]~~外招~[\ischeck{\waizhao}] %\\[0.8em]
  \end{tabular}
}

%\RequirePackage{tikz}
%\usetikzlibrary{calc}

\newcommand{\makehead}{
  \thispagestyle{plain}
  %\centerline{\LARGE\heiti 南\quad 京\quad 理\quad 工\quad 大\quad 学\quad 考\quad 试\quad 试\quad 卷}
  \vspace{2em}%
%  \ifreverse
%    \ifx\shijuan\my@temp@a\renewcommand{\shijuan}{B}\fi
%    \ifx\shijuan\my@temp@c\renewcommand{\shijuan}{D}\fi
%  \fi
  \noindent
  \begin{tabularx}{\linewidth}{|@{}X@{}|}
    \hline\renewcommand{\arraystretch}{1.5}%
    {\begin{tabularx}{\linewidth}{@{}X@{}|@{}l@{}}
      \head@table@a & \head@table@b
    \end{tabularx}}\\
    \hline\renewcommand{\arraystretch}{1.5}%
    \vspace{1em}
    {\begin{tabularx}{\linewidth}{@{}X@{}}
      \head@table@c
    \end{tabularx}}\\
    \hline
  \end{tabularx}
  \par\vspace{2em}

%  \noindent\begin{tabularx}{\linewidth}{|*{8}{Y|}}
%    \hline
%    \textbf{题\quad 号} & 一 & 二 & 三 & 四 & 五 & 六 & 总分\\
%    \hline
%    \textbf{得\quad 分} &  &  &  &  &  &  & \\
%    \hline
%    \textbf{评阅人} &  &  &  &  &  &  & \\
%    \hline
%  \end{tabularx}
}

%% ---------------------------------------------------------------------------
%% 页眉页脚设定
%% ---------------------------------------------------------------------------

%\newcommand{\my@columnbox}[1]{\makebox[\columnwidth]{#1}}
%\newcommand{\my@headleft}{\hspace{-0.3em}《\kecheng》\kern-0.3em 试卷\,\shijuan}
%\newcommand{\my@headright}{姓名\hspace{6em}学号\hspace{6em}}
%\newcommand{\my@headtext}{\my@headleft\hfill \my@headright}
\newcommand{\my@foottext}{\heiti 第~\thepage~页\quad 共~\pageref{LastPage}~页}

% fancy page style
\pagestyle{fancy}
\fancyhf{}


\renewcommand{\headrulewidth}{0pt}

\lhead{{\heiti 课程名称：}\underparbox{14\ccwd}{\centering\rule{0pt}{3ex}\heiti \course} \quad 学分：\underparbox{2\ccwd}{\centering\rule{0pt}{3ex}\credit}    \quad 试卷编号：\underparbox{2\ccwd}{\centering\rule{0pt}{3ex}\testpaper}}
%\cfoot{\my@foottext}      %mac
\cfoot{\vspace{1mm}\my@foottext}      %windows

\fancypagestyle{plain}{
  \lhead{{\LARGE\heiti 南\quad 京\quad 理\quad 工\quad 大\quad 学\quad 考\quad 试\quad 试\quad 卷}{\ifanswer {\heiti （存档用）} \,\else {\heiti （学生考试用）} \, \fi }}
%  \cfoot{\vspace{0mm}\my@foottext}  % mac
  \cfoot{\vspace{1mm}\my@foottext}  % windows
}



    
%\fancyhf{} % 清空页眉页脚

%\ifsidebyside
%  \renewcommand{\headrulewidth}{0pt}%
%  \lhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
%  \rhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
%  \lfoot{\small\my@columnbox{\my@foottext}}
%  \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
%\else
%  \lhead{\small\my@headleft}
%  \rhead{\small\my@headright}
%  \cfoot{\small\my@foottext}
%\fi
%
% plain page style
%\fancypagestyle{plain}{
%  \renewcommand{\headrulewidth}{0pt}%
%  \fancyhf{}
%  \ifsidebyside
%    \rhead{\small\underline{\my@columnbox{\my@headtext\strut}}}
%    \lfoot{\small\my@columnbox{\my@foottext}}
%    \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
%  \else
%    \cfoot{\small\my@foottext}
%  \fi
%}

%\ifplain
%  \pagestyle{plain}
%\else
%  \pagestyle{fancy}
%\fi

%% ---------------------------------------------------------------------------
%% 题型命令 \makepart
%% 附录命令 \makedata
%% 题目环境 problem
%% 解答环境 solution
%% 逆序选项 reverse
%% ---------------------------------------------------------------------------

\newif\ifonlyoneproblem \onlyoneproblemfalse % 此部分仅有一道题时不显示题目编号
\xdef\allproblems{}
\xdef\lastproblem{}
\newcounter{problem}
\newcommand{\solutionname}{解}
\newcounter{choice} % 后面选择题的 abcd 环境要用到
\newcounter{step}   % 后面解答题的 \step 命令要用到
\newcommand{\hangtext}{}
\newlength{\hanglength}

\newcommand{\printproblems}{\ifreverse\lastproblem\allproblems\fi\xdef\allproblems{}\xdef\lastproblem{}}

\newcommand{\makepart}[2]{%
  \printproblems
  \setcounter{problem}{0}%
  \stepcounter{section}%
  \vspace{1em}%
  \noindent\textbf{\Chinese{section}、#1}（#2）%
  \par\nopagebreak
  \if\relax\detokenize{#1}\relax % #1 is empty
    \onlyoneproblemtrue
  \else
    \onlyoneproblemfalse
    \vspace{1em}%
  \fi
  %其中设定了\@nobreaktrue，保证在列表前也不分页，详情见 source2e
  \@afterheading
}

\newcommand{\makedata}[1]{%
  \printproblems\my@stop@reverse
  \centerline{\textbf{附录}\quad #1}\smallskip
}

\preto{\@enddocumenthook}{\printproblems\my@stop@reverse}

\newcommand\ignorepars{\@ifnextchar\par{\expandafter\ignorepars\@gobble}{}}

\newenvironment{problemreal}{%
  \stepcounter{problem}\setcounter{choice}{0}\setcounter{step}{0}%
  \ifonlyoneproblem
    \renewcommand{\hangtext}{}%
    \setlength{\hanglength}{0pt}%
    %\onlyoneproblemfalse
  \else
    \renewcommand{\hangtext}{\textbf{\textsf{\textcolor{blue}{\arabic{problem}}.}}\;\,}%
    \settowidth{\hanglength}{\hangtext}%
  \fi
  \description[leftmargin=\hanglength,labelwidth=0pt,labelsep=0pt,topsep=0pt,parsep=0pt]
  \item[\hangtext]
}{\enddescription}
\newenvironment{solutionreal}{%
  \setcounter{step}{0}%
  \renewcommand{\hangtext}{\textbf{\textsf{\textcolor{blue}{\solutionname}.}}\;\,}%
  \settowidth{\hanglength}{\hangtext}%
  \description[leftmargin=\hanglength,labelwidth=0pt,labelsep=0pt,topsep=0pt,parsep=0pt]
  \item[\hangtext]
}{\enddescription}

\let \oldnewpage   = \newpage
\let \oldvfill     = \vfill
\let \oldsmallskip = \smallskip
\let \oldmedskip   = \medskip
\let \oldbigskip   = \bigskip

\ifreverse
  \NewEnviron{problem}{%
    \xdef\allproblems{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded\expandafter{\allproblems}%
    }%
    \xdef\lastproblem{%
      \unexpanded{\begin{problemreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{problemreal}}%
    }%
  }
  \NewEnviron{solution}{%
    \xdef\lastproblem{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded{\begin{solutionreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{solutionreal}}%
    }%
  }
  \renewcommand{\newpage}{\xdef\lastproblem{\noexpand\oldnewpage\unexpanded\expandafter{\lastproblem}}}
  \renewcommand{\vfill}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldvfill}}}
  \renewcommand{\smallskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldsmallskip}}}
  \renewcommand{\medskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldmedskip}}}
  \renewcommand{\bigskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldbigskip}}}
  \let \newpagea = \relax
  \let \newpageb = \newpage
\else
  \newenvironment{problem}{\problemreal}{\endproblemreal}
  %\newenvironment{solution}{\solutionreal}{\endsolutionreal}
  \NewEnviron{solution}{\begin{solutionreal}\BODY\end{solutionreal}}
  \let \newpagea = \newpage
  \let \newpageb = \relax
\fi

\newcommand{\my@stop@reverse}{%
  \ifreverse
    \renewenvironment{problem}{\problemreal}{\endproblemreal}%
    \renewenvironment{solution}{\solutionreal}{\endsolutionreal}%
    \let \newpage   = \oldnewpage
    \let \vfill     = \oldvfill
    \let \smallskip = \oldsmallskip
    \let \medskip   = \oldmedskip
    \let \bigskip   = \oldbigskip
  \fi
}

\def\CommentCutFile{\jobname.cut}

\AtBeginDocument{%
  \ifanswer\else
    \excludecomment{solution}
  \fi
}

%% ---------------------------------------------------------------------------
%% 答题栏命令 \answertable
%% ---------------------------------------------------------------------------

\gdef\answer@lines@temp{}%
\newcommand{\answer@lines@add}[1]{%
  \xdef\answer@lines@temp{\answer@lines@temp#1}%
}

\newrobustcmd{\answer@number@hided}[1]{小题} % 在 PDFLaTeX 中需要保护中文
\newrobustcmd{\answer@cell@strut}[1]{\parbox[c][#1][c]{2em}{\hbox{答案}}}

\newcounter{answer@col}
\newcounter{answer@row}
\newcounter{answer@total}

\newcommand{\answer@lines}[3]{%
  % #1 答题栏各栏指定高度
  % #2 答题栏总共答案个数
  % #3 答题栏每行答案个数
  \setcounter{answer@row}{(#2-1)/#3+1}% 除法向下取整，改为向上取整
  \begingroup
  \let\hline=\relax  \let\\=\relax % 禁止展开
  \gdef\answer@lines@temp{}%
  \setcounter{answer@total}{1}%
  \whileboolexpr{
      test{\ifnumgreater{\value{answer@row}}{0}}
  }{%
      \addtocounter{answer@row}{-1}%
      \answer@lines@add{\answer@number@hided}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{%
          test{\ifnumgreater{\value{answer@col}}{#3}}%
      }{%
          \answer@lines@add{&}%
          \ifnumgreater{\value{answer@total}}{#2}{}{%
            \answer@lines@add{\arabic{answer@total}}%
          }%
          \stepcounter{answer@col}%
          \stepcounter{answer@total}%
      }%
      \answer@lines@add{\\ \hline \answer@cell@strut{#1}}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{
          test{\ifnumgreater{\value{answer@col}}{#3}}
      }{%
          \answer@lines@add{&}%
          \stepcounter{answer@col}%
      }%
      \answer@lines@add{\\ \hline}%
  }%
  \endgroup
  \answer@lines@temp
}

\newcommand{\answertable}[3][1em]{%
  答题须知：本题答案必须写在如下表格中，否则不给分．\par
  \begin{tabularx}{\linewidth}{|c|*{#3}{Y|}}
    \hline
    \answer@lines{#1}{#2}{#3}
  \end{tabularx}%
  \par\vspace{0.8em}%
}

%% ---------------------------------------------------------------------------
%% 答案切换命令 \answer
%% 判断命令 \tickin 和 \tickout
%% 填空命令 \fillin 和 \fillout
%% 选择命令 \pickin 和 \pickout
%% ---------------------------------------------------------------------------

\newcommand{\answer}[1]{\ifanswer#1\else\phantom{#1}\fi}

\newcommand*{\cdotfill}{\leavevmode\xleaders\hbox to 0.5em{\hss$\cdot$\hss}\hfill\kern0pt\relax}

\newcommand*{\tick@box}[1]{[\makebox[1.5em]{\color{blue}\answer{#1}}]}
\newcommand*{\tick@text@t}{$\checkmark$}
\newcommand*{\tick@text@f}{{\large$\times$}}
\newcommand*{\tick@text@T}{\sffamily T}
\newcommand*{\tick@text@F}{\sffamily F}
\newcommand*{\tickin}[1]{\tick@box{\csname tick@text@#1\endcsname}}
\newcommand*{\tickout}[1]{\unskip\nobreak\cdotfill\tick@box{\csname tick@text@#1\endcsname}}
% 过时命令，不要再使用
\newcommand*{\true}{\tickout{t}}
\newcommand*{\false}{\tickout{f}}

\newcommand*{\ulinefill}[1]{\xleaders\hbox{\underline{\vphantom{#1}\kern1pt}}\hfill\kern0pt}
\newcommand*{\minwidthbox}[2]{\makebox[{\ifdim#1<\width\width\else#1\fi}]{#2}}

\newcommand*{\fillout}[1]{\allowbreak\hbox{}\nobreak\ulinefill{#1}\underline{\color{blue}\answer{#1}}\ulinefill{#1}}
\newcommand*{\fillin}[1]{\underline{\hspace{1em}\color{blue}\minwidthbox{2em}{\answer{#1}}\hspace{1em}}}

\newcommand*{\pickout}[1]{\unskip\nobreak\cdotfill(\makebox[1.5em]{\color{blue}\answer{#1}})}
\newcommand*{\pickin}[1]{\unskip\nobreak\hspace{0.3em}(\makebox[1.5em]{\color{blue}\answer{#1}})\hspace{0.3em}\ignorespaces}

%% ---------------------------------------------------------------------------
%% 选择题四个选项排版环境，根据四个选项的长度自动排成一行、两行或四行
%% 其中 abcd 环境各列平分整行宽度，而 abcd* 环境各列平分剩余空白
%% ---------------------------------------------------------------------------

\newlength{\my@item@len}

\newcommand\my@item@temp{%
  \unskip\cr\stepcounter{choice}(\Alph{choice})\ %
}
\newcommand\my@item@box{%
  \hfill\egroup\hfill\hbox to \my@item@len\bgroup
  \stepcounter{choice}(\Alph{choice})\ \ignorespaces
}
\newcommand\my@item@par{%
  \par\stepcounter{choice}(\Alph{choice})\ \ignorespaces
}

\NewEnviron{abcd}{
  \unskip
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt}%
  \setcounter{choice}{0}%
  \let\item=\my@item@temp
  \settowidth{\my@item@len}{\vbox{\halign{##\hfil\cr\BODY\crcr}}}%
  \setcounter{choice}{0}%
  \ifdim\my@item@len>0.486\linewidth
    \setlength{\my@item@len}{\linewidth}%
    \let\item=\my@item@par
    \BODY\par
  \else
    \ifdim\my@item@len>.243\linewidth
      \setlength{\my@item@len}{0.5\linewidth}%
    \else
      \setlength{\my@item@len}{0.25\linewidth}%
    \fi
    \let\item=\my@item@box
    \par\bgroup\BODY\hfill\egroup\par
  \fi
}

\newcommand\my@item@one@line{%
  \unskip
  \ifnumequal{\value{choice}}{0}{}{\hfill}
  \stepcounter{choice}(\Alph{choice})\ %
}
\newcommand\my@item@two@line{%
  \unskip
  \ifnumodd{\value{choice}}{&}{\unskip\cr}%
  \stepcounter{choice}(\Alph{choice})\ %
}

\NewEnviron{abcd*}{
  \unskip
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt}%
  \setcounter{choice}{0}%
  \let\item=\my@item@one@line
  \settowidth{\my@item@len}{\BODY}%
  \ifdim\my@item@len<0.95\linewidth
    \setcounter{choice}{0}%
    \par\bgroup\BODY\hfill\hfill\par\egroup\par
  \else
    \setcounter{choice}{0}%
    \let\item=\my@item@two@line
    \settowidth{\my@item@len}{\vbox{\halign{##&##\hfil\cr\BODY\crcr}}}%
    \ifdim\my@item@len<0.975\linewidth
      \setcounter{choice}{0}%
      \par\bgroup\nointerlineskip
      \vbox{\halign to\linewidth{##\hfil\tabskip=0pt plus 1fil&##\hfil\cr\BODY\crcr}}%
      \egroup\par
    \else
      \setcounter{choice}{0}%
      \let\item=\my@item@par
      \par\bgroup\BODY\hfill\egroup\par
    \fi
  \fi
}

%% ---------------------------------------------------------------------------
%% 解答题步骤命令 \step
%% ---------------------------------------------------------------------------

\newcommand{\step}{%
  \stepcounter{step}%
  \textsf{(\arabic{step})}\;\,%
}

%% ---------------------------------------------------------------------------
%% 自由对齐命令 \tabpoint, \tabto, \tableft
%% 命令 \tabpoint 记录当前的水平位置，也可以简写为 \?
%% 命令 \tabto 跳到之前记录的位置，也可以简写为 \+
%% 命令 \tableft 跳到之前记录的位置的左侧，也可以简写为 \<
%% 这些自由对齐命令需要编译两次才能生效
%% ---------------------------------------------------------------------------

\usepackage{zref-savepos}

\@ifundefined{zsaveposx}{\let\zsaveposx\zsavepos}{} % 旧版本无 \zsaveposx 命令

\newcounter{saveposcnt}
\newcounter{useposcnt}
\renewcommand*{\thesaveposcnt}{savepos\number\value{saveposcnt}}
\renewcommand*{\theuseposcnt}{usepos\number\value{useposcnt}}

\def\my@alignment@offset{}

\def\my@alignment@list{}
\forcsvlist{\listadd\my@alignment@list}{=,<,>,\le,\ge,\leq,\geq,\approx}

\newlength{\my@alignment@kern}

\newcommand*{\my@alignment@check}[1]{%
  \ifx\my@let@token #1%
    \def\my@alignment@offset{5}%
    \listbreak
  \fi
}

\newcommand{\my@alignment@next}{%
  \ifdefempty{\my@alignment@offset}{%
    \def\my@alignment@offset{0}%
    \forlistloop{\my@alignment@check}{\my@alignment@list}%
  }{}%
  \settowidth{\my@alignment@kern}{$\mkern\my@alignment@offset mu$}%
  \stepcounter{saveposcnt}%
  \rlap{\kern\my@alignment@kern\zsaveposx{\thesaveposcnt}}%
}

\newcommand*{\tabpoint}[1][]{%
  \leavevmode
  \def\my@alignment@offset{#1}%
  \futurelet\my@let@token\my@alignment@next
}
\let \? = \tabpoint

\newcommand*{\tabto}{%
  \stepcounter{useposcnt}%
  \zsaveposx{\theuseposcnt}%
  \noindent
  \hskip\zposx{\thesaveposcnt}sp\relax
  \hskip-\zposx{\theuseposcnt}sp\relax
  \ignorespaces
}
\let \+ = \tabto

\newcommand*{\tableft}{%
  \settowidth{\my@alignment@kern}{$=\mkern5mu$}%
  \stepcounter{useposcnt}%
  \zsaveposx{\theuseposcnt}%
  \noindent
  \hskip\zposx{\thesaveposcnt}sp\relax
  \hskip-\zposx{\theuseposcnt}sp\relax
  \hskip-\my@alignment@kern
  \ignorespaces
}
\let \< = \tableft

%% ---------------------------------------------------------------------------
%% 评分命令 \score
%% ---------------------------------------------------------------------------

\PassOptionsToPackage{tbtags}{amsmath}
\RequirePackage{amsmath}

\newcommand{\myscore}[1]{\textcolor{red}{#1\kern0.15em 分}}

\newcommand{\scoretext}[1]{\mbox{}\nobreak\hfill$\cdots\cdots$\myscore{#1}\par\noindent\ignorespaces}
\newcommand{\scoreeqno}[1]{\eqno{\cdots\cdots\text{\myscore{#1}}}}
\newcommand{\scoretag}[1]{\tag*{$\cdots\cdots$\myscore{#1}}}

\newrobustcmd{\score}[1]{%
  \ifbool{mmode}{%
    \ifdefstrequal{\tag}{\dft@tag}{\scoreeqno{#1}}{\scoretag{#1}}%
  }{%
    \scoretext{#1}%
  }%
}

%% ---------------------------------------------------------------------------
%% 文档选项 display 将全部公式都设为展示公式
%% 命令 \display 将当前环境的公式都设为展示公式
%% ---------------------------------------------------------------------------

\newcommand{\display}{\everymath\expandafter{\the\everymath\displaystyle}}
\ifbool{display}{
  \RequirePackage[math]{cellspace}
  \setlength\cellspacetoplimit{2pt}
  \setlength\cellspacebottomlimit{2pt}
  \addparagraphcolumntypes{X}
  % Fix cellspace bug before version 1.7
  % See https://tex.stackexchange.com/a/385581
  \@ifpackagelater{cellspace}{2017/08/12}{}{
    \patchcmd{\@endpbox}{\color@endgroup}{\expandafter\color@endgroup}{}{}
  }
  \display
}{}

%% ---------------------------------------------------------------------------
%% 载入个人定制文件 jnuexam.cfg
%% 中文字体切换选项 sourcehan
%% ---------------------------------------------------------------------------

\InputIfFileExists{jnuexam.cfg}{}{}

\newcommand{\my@set@sourcehan}{
  \setCJKmainfont[BoldFont=Source Han Sans SC]{Source Han Serif SC}
  \setCJKsansfont{Source Han Sans SC}
  % 用中文字体名时 LuaTeX 找不到该字体，XeTeX 正常
  %\setCJKmainfont[BoldFont=思源黑体]{思源宋体}
  %\setCJKsansfont{思源黑体}
}

\AtBeginDocument{%
  \ifbool{sourcehan}{%
    % https://sourceforge.net/p/xetex/code/ci/master/tree/source/texk/web2c/xetexdir/NEWS
    \ifbool{XeTeX}{% TeXLive 2015
      \ifdimless{\the\XeTeXversion\XeTeXrevision pt}{0.99992pt}{}{\my@set@sourcehan}%
    }{}%
    \ifbool{LuaTeX}{\my@set@sourcehan}{}%
  }{}%
}

%% ---------------------------------------------------------------------------
%% 载入常用宏包，定义常用命令
%% ---------------------------------------------------------------------------

\AtBeginDocument{
  \setlength{\abovedisplayskip}{4pt minus 2pt}
  \setlength{\belowdisplayskip}{4pt minus 2pt}
  \setlength{\abovedisplayshortskip}{2pt}
  \setlength{\belowdisplayshortskip}{2pt}
}

\setlength\arraycolsep{4pt}

\ifbool{XeTeX}{
  % https://en.wikipedia.org/wiki/Number_Forms
  % Ⅰ、Ⅱ、Ⅲ、Ⅳ、Ⅴ、Ⅵ、Ⅶ、Ⅷ、Ⅸ、Ⅹ、Ⅺ、Ⅻ
  \xeCJKsetcharclass{"2150}{"218F}{1} % 斜线分数，全角罗马数字等
  % https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
  \xeCJKsetcharclass{"2460}{"24FF}{1} % 带圈数字字母，括号数字字母，带点数字等
}{}

\RequirePackage{CJKfntef}
\RequirePackage{multirow}
\RequirePackage{diagbox}
\RequirePackage{tabu}

\RequirePackage{extarrows}

\RequirePackage{relsize}
\newcommand{\Int}{\mathop{\mathlarger{\int}}}

\newcommand{\e}{\mathrm{e}}
\newcommand{\limit}{\lim\limits}
\newcommand{\R}{\mathbb{R}}

\DeclareMathOperator{\Corr}{\rho}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\grad}{grad}
\DeclareMathOperator{\Prj}{Prj}
\DeclareMathOperator{\Var}{Var}

\newcommand{\diff}{\mathop{}\!\mathrm{d}}
\newcommand{\dx}{\diff x}
\newcommand{\dy}{\diff y}
\def\dz{\diff z} % 不确定命令是否已经定义
\newcommand{\du}{\diff u}
\newcommand{\dv}{\diff v}
\newcommand{\dr}{\diff r}
\newcommand{\ds}{\diff s}
\newcommand{\dt}{\diff t}
\newcommand{\dS}{\diff S}
% 有些宏包比如 hyperref 会修改 \d 的定义，所以放在 document 开始处
% 利用 etoolbox 将 \d 定义为健壮命令，以避免在 align 等环境中错误地展开
\AtBeginDocument{%
  \let\oldd=\d
  \renewrobustcmd{\d}{\ifbool{mmode}{\diff}{\oldd}}%
}

% from mathabx package
\DeclareFontFamily{U}{mathx}{\hyphenchar\font45}
\DeclareFontShape{U}{mathx}{m}{n}{<-> mathx10}{}
\DeclareSymbolFont{mathx}{U}{mathx}{m}{n}
\DeclareMathAccent{\widebar}{0}{mathx}{"73}

\newcommand{\va}{\vec{a}}
\newcommand{\vb}{\vec{b}}
\newcommand{\vc}{\vec{c}}
\newcommand{\vd}{\vec{d}}
\newcommand{\ve}{\vec{e}}
\newcommand{\vi}{\vec{i}}
\newcommand{\vj}{\vec{j}}
\newcommand{\vk}{\vec{k}}
\newcommand{\vn}{\vec{n}}
\newcommand{\vs}{\vec{s}}
\newcommand{\vv}{\vec{v}}

\let\ov=\overrightarrow

\let\le=\leqslant
\let\ge=\geqslant

\let\lb=\{
\let\rb=\}

\def\T{\mathrm{T}\kern-.5pt}

\newrobustcmd{\wfrac}[3][2pt]{%
  {\begingroup\hspace{#1}#2\hspace{#1}\endgroup\over\hspace{#1}#3\hspace{#1}}%
}

