# ElixirExample

 The purpose of this code is to provide materials for training other 
engineers in the concepts of Erlang, OTP, and Elixir.


# Starting



To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


# Description

 
Visiting  "/" will pass whatever get params to the InputServer

IE: 
http://localhost:4000/?doc[id]=1&doc[name]=purchase_order


'ExampleApplication' is a dependency of ElixirExapmle it is
an instance of an Erlang VM application written in Elixir.


ExampleApplication has 2 GenServers and a GenEvent Handler
to use as training materials.


example_application/mix.exs configures erlang vm environment variables
for a server 'localhost' running on port 9292. This server is a mock
external dependency. It echo's any params or body posted to it and
returns json content-type response with a 200 status code.

The mock external dependency is started from ./example_application via
'rackup'.

eg:

cd ./example_application
rackup
With a http request :

GET http://u2u.local:4000/?invoice[id]=123&invoice[item]=414

The phoenix application 'ElixirSample' will call the
'ExampleApplication' InputServer with any passed get parameters
as a map (dictionary). (ASYNC)

The InputServer will in mark the map with 'processed' and generate
an event processed_input with the document. (ASYNC)

The Event Handler will generate another call to OutputServer to dispatch
the result to the external service. (ASYNC)

The GenServer InputServer and OutputServer are written async
(handle_cast) and could optionally be written syncronously
'handle_call'.






