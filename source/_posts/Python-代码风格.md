---
title: Python 代码风格
date: 2018-06-30 11:24:13
categories: "风格"
tags: ["python","PEP","Coding Style"]
---
# 关于PEP #
## 什么是PEP ##

PEP 是 Python Enhancement Proposals 的缩写，即“Python增强建议书”。
> A PEP is a design document providing information to the Python community, or describing a new feature for Python or its processes or environment. The PEP should provide a concise technical specification of the feature and a rationale for the feature.

## PEP的类型 ##
PEP有三种类型：
1. 跟踪Python中的新特性
2. 说明Python中的某一个设计问题
3. 关于Python的提案，但不针对Python语言本身

> There are three kinds of PEP:
1. A Standards Track PEP describes a new feature or implementation for Python. It may also describe an interoperability standard that will be supported outside the standard library for current Python versions before a subsequent PEP adds standard library support in a future version.
2. An Informational PEP describes a Python design issue, or provides general guidelines or information to the Python community, but does not propose a new feature. Informational PEPs do not necessarily represent a Python community consensus or recommendation, so users and implementers are free to ignore Informational PEPs or follow their advice.
3. A Process PEP describes a process surrounding Python, or proposes a change to (or an event in) a process. Process PEPs are like Standards Track PEPs but apply to areas other than the Python language itself. They may propose an implementation, but not to Python's codebase; they often require community consensus; unlike Informational PEPs, they are more than recommendations, and users are typically not free to ignore them. Examples include procedures, guidelines, changes to the decision-making process, and changes to the tools or environment used in Python development. Any meta-PEP is also considered a Process PEP.

即