# Object Management System

Objects managment and their relationships assesment.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Usage](#usage)
- [Implementation](#implementation)
- [Contact](#contact)

## Introduction

Please imagine that you are working for an international team and you are asked to develop an object management app whose requirements are explained below.
The goal is to create a system for managing objects. For example, an object can be a desk, computer, keyboard, server or human being.
Describe all the choices you made for the implementation.

## Features

- Objects have the following attributes: name, description and type.
- Create/edit/delete objects
- Create/edit/delete relations between objects (for example a desk can contain a calculator and Max uses the desk as a workplace)
- Search for objects
- All data must be serializable/storable. For this use a persistent storage.
- Native components and styles are preferred.
- The implementation should be done in Swift 5, SwiftUI and Clean Swift architecture. 
- Any pods or design patterns are allowed.

## Usage

- The main view is the list of all the objects we have in our persistent store
- Can create a new object selecting the plus icon.
- Can delete an object swiping the object row to the left.
- Can modify an object selecting the object row.
- Can search an object by its name, description or type. Just pull the view to the bottom.
- Can add/delete relationships in the add/edit view when you create or modify an object.
- Can add a new relationship selecting the plus icon. A modal view with all possible present and you can select an object.
- Can delete a relationship swiping left.

## Implementation

- Swift 5
- SwiftUI
- SwiftData
- No unit tests: All views (tested with previews) plus one model (no unit tests needed). There are several third party libraries, like VieWInspector to unit test views.
- No view models needed, or service layers.
- No pods or SPM

## Contact

momachilles@gmail.com
