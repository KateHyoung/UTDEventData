---
title: 'UTDEventData: An R package to access political event data'
tags:
  - R
  - political event data
  - real-time political events
  - data-intensive social research
  - big data
authors:
  - name: HyoungAh Kim
    orcid: 0000-0002-0744-5884
    affiliation: 1
  - name: Vito D’Orazio
    orcid: 0000-0003-4249-0768
    affiliation: 1
  - name: Patrick T. Brandt
    orcid: 0000-0002-7261-7056
    affiliation: 1
  - name: Jared Looper
    orcid: 0000-0002-4819-2780
    affiliation: 1
  - name: Sayeed Salam
    orcid: 0000-0002-7254-749X
    affiliation: 2
  - name: Latifur Khan
    orcid: 0000-0002-9300-1576
    affiliation: 2
  - name: Michael Shoemate
    orcid: 0000-0003-1190-3363
    affiliation: 3
affiliations:
 - name: School of Economic, Political and Policy Sciences, University of Texas at Dallas
   index: 1
 - name: Department of Computer Science, University of Texas at Dallas
   index: 2
 - name: School of Natural Sciences and Mathematics, University of Texas at Dallas
   index: 3
date: "March 13,  2019"
bibliography: paper.bib
---

# Introduction

Political event data record interactions among social and political actors. Researchers use these data to understand relations among actors, predict outcomes of interest, and forecast trends [@schrodt2012]. As automated technologies have become better able to extract events from text, event data projects and repositories have increased in number. For example, the Cline Center at the University of Illinois contains events from 1945 to 2015 coded from three different news sources [@cline]. The Integrated Crisis Early Warning System (ICEWS) program regularly delivers updates to their repository on Harvard’s Dataverse [@icews]. The Temporally Extended, Regular, Reproducible International Event Records (TERRIER) database at the University of Oklahoma contains 73 million political event records from 1979 to 2016 [@halterman2017].  At the University of Texas at Dallas (UTD), we have built an automated political event data system called "Spark-based Political Event Coding (SPEC)",  that extracts and processes political event data from over 380 different English written news media on a daily basis, and has been doing so since October 2017 [@sayeed16]. Technologies for accessing event data resources exist [@vito2018], but not directly through R. The UTDEventData R library provides access to these event data and is flexible to access new sources as they become available.

# The UTD political event data API server
The server is hosted in XSEDE’s JetStream cloud and provides access to six datasets: three from the Cline Center, the ICEWS data, TERRIER data, and the real-time data coded by SPEC at UTD. We use a Flask API to handle web requests, data is accessed from MongoDB, and served in JSON format [@brandt2018]. Users are required to obtain an API key for access [http://eventdata.utdallas.edu/signup](http://eventdata.utdallas.edu/signup).  More details about this repository, including how to obtain an API key, may be found at [http://eventdata.utdallas.edu/](http://eventdata.utdallas.edu/). 

# The ``UTDEventData`` R package

``UTDEventData`` enables direct access to the UTD event data repository through R. It includes functions to explore, to query, and to download event data from any table in the repository. Exploratory functions include ``DataTables()``, which provides a list of all available datasets,  ``tableVar()``, which lists the variables in a particular data table, and ``previewData()``, which downloads a sample of the data for browsing. This centralization of event data resources, and a single interface for access, facilitates workflows for researchers working with these datasets. It also provides a convenient way to handle large datasets when only a subset is of interest.

Users can subset and download the data using one of two functions: ``pullData()`` or ``sendQuery()``.  The ``pullData()`` function is simpler, and provides a fixed way to retrieve data using only date and location information. ``sendQuery()`` is more flexible, and allows users to build up a query element-by-element. For example, helper functions such as  ``returnDyad()`` returns the query element to ask for a pair of actors as source and target, and ``returnRegExp()`` allows for virtually any single query element using MongoDB regular expressions. These single elements are then combined using either their intersection (``andList()``) or their union  (``orList()``), which forms the query to submit with the ``sendQuery()`` method.  

A user is required to enter his or her API key as an argument for each of the aforementioned functions. For convenience, we have a reference class called ``Table`` that includes a field for storing the user’s API key, and has methods that mirror the above functions ``pullData()``, ``tableVar()``, and ``DataTables()``. With ``Table``, users are only required to submit their API key once.

This R library has additional functions to cite the data table (``citeData()``), gauge the size of a query (``getQuerySize()``), and to download an entire data table directly to disk (``entireData()``). More information about the ``UTDEventData`` package, along with the package vignette, can be found at the project’s Github page, [https://github.com/KateHyoung/UTDEventData](https://github.com/KateHyoung/UTDEventData).
 
``UTDEventData`` provides an accessible and user-friendly environment to access political event data. As automated methods develop, and event datasets proliferate in number and expand in magnitude, we expect new and larger tables to be added to the repository and accessed through our interface.  

# Acknowledgements

This R library has been developed upon the work funded by the National Science Foundation under Grant No. SBE-SMA-1539302. 

# References


