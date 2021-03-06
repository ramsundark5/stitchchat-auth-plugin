%%%-------------------------------------------------------------------
%% @doc stitchchat-auth-plugin public API
%% @end
%%%-------------------------------------------------------------------

-module('auth_plugin_app').

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    'auth_plugin_sup':start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
