---
title: "README"
author: "Mateo Córdoba Toro"
date: "17/6/2020"
output: html_document
---

## Getting and cleaning data - Course Project

Data is first loaded using the read.table () function. Since "activity_label" and "features"
contain the information in the second column, only the second column is selected.

The related databases were then joined.

The names of the X database were replaced with the names that were in features.
Only the mean and sd data were extracted and all were pooled into a single database.

Columns 1 and 2 representing the subject and the activiy_label have been renamed to subject_id and activity_id.

Since the variable activity_id displays the level number but the name is not replaced by the respective name.

the database is reorganized and the data is selected to present the tidy database.

