-module(auth_plugin).

-behaviour(auth_on_register_hook).

-export([auth_on_register/5]).

auth_on_register({_IpAddr, _Port} = Peer, {MountPoint, ClientId} = SubscriberId, UserName, Password, CleanSession) ->
    %inets:start(),
    %ssl:start(),
    %application:start(inets),
    Method = get,
    URL = "https://api.digits.com/1.1/sdk/account.json",
    Header = [{"Authorization", Password}],
    Type = "application/json",
    HttpOptions = [],
    Options = [],
    error_logger:info_msg("auth header is: ~p ", [Password]),
    
    error_logger:info_msg("auth_on_register started: ~p ~p ~p ~p ~p", [Peer, SubscriberId, UserName, Password, CleanSession]),
    Ret = httpc:request(Method, {URL, Header, Type}, HttpOptions, Options),
     %Ret = {},
    case Ret of
        {ok, {_, 200, _}, _, _} ->
            error_logger:info_msg("auth_on_register response: ~p ~p ~p ~p ~p", [Peer, SubscriberId, UserName, Password, CleanSession]),
            ok;
        _ ->
            next
    end.

%% Internal
empty_string_if_undefined(undefined) -> "";
empty_string_if_undefined(S) -> S.
