# Qchan Web
HTML-based client application of Qchan.

Qchan is a project of a Job-Queue Worker System.
It consists of a cluster of many processes and Qchan Web provides User Interface to web browsers.
Qchan Web is one of client applicaitons of Qchan's REST API, implemented with client-side JavaScript.

![](https://raw.github.com/r7kamura/qchan-web/master/doc/png/overview.png)

## Usage
Run server by `rake`, then open http://localhost:4000 in your web browser.

```sh
rake
```

## Architecture
* View Tree
* View Partitioning
* View Communication
* Model

### View Tree
Our application consists of some view objects, having tree-structured relationship.
An upper view object has lower view objects.
This is similar to the HTML element tree.
While a child has a reference to its parent (to know the element where it should be rendered),
the parent has no reference to its children.

### View Partitioning
Views are partitioned by the following unit:

* layout unit (header, footer, main, sidebar)
* dynamically changed unit (sign-in link)
* event manager unit (tab menu)
* top-level unit (as a root node)

### View Communication
All communication between view objects are done via Event.
A global event manager called Mediator manages their events.
Each view object subscribes to and triggers events on Medaitor to talk with other view objects.

### Model
Some view objects may have model object(s).
Model can also be observable like Mediator to notify events to its owner.
We can notify any model events to other view objects by sending the event from its owner to Mediator.
