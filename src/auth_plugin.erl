-module(auth_plugin).

-behaviour(auth_on_register_hook).

-export([auth_on_register/5]).

auth_on_register({_IpAddr, _Port} = Peer, {MountPoint, ClientId} = SubscriberId, UserName, Password, CleanSession) ->
    %inets:start(),
    %ssl:start(),
    %application:start(inets),
    Method = get,
    URL = "https://api.digits.com/1.1/sdk/account.json",
    %URL = UserName,
    Header = [{"Authorization", Password}, {"Content-Type", "application/json"}],
    HttpOptions = [],
    Options = [],
    error_logger:info_msg("auth register started for : ~p ", [ClientId]),
    
    %error_logger:info_msg("auth_on_register params are: ~p ~p ~p ~p ~p", [MountPoint, Peer, SubscriberId, ClientId, CleanSession]),
    Ret = httpc:request(Method, {URL, Header}, HttpOptions, Options),
     %Ret = {},
    case Ret of
        {ok, {{_, 200, _}, _, Body}} ->
            error_logger:info_msg("auth_on_register response: ~p", [Body]),
            ok;
        {error, Reason} ->
            error_logger:info_msg("auth_on_register error: ~p ~p" , [error, Reason]),
            next
        
    end.

