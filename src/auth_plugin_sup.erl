%%%-------------------------------------------------------------------
%% @doc stitchchat-auth-plugin top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module('auth_plugin_sup').

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    %application:start(ssl),
    %application:start(inets),
    {ok, { {one_for_one, 10, 10}, []} }.

%%====================================================================
%% Internal functions
%%====================================================================