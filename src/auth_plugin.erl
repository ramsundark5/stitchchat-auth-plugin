-module(auth_plugin).

-behaviour(auth_on_register_hook).

-export([auth_on_register/5]).

auth_on_register({_IpAddr, _Port} = Peer, {MountPoint, ClientId} = SubscriberId, UserName, Password, CleanSession) ->
    %inets:start(),
    %ssl:start(),
    %application:start(inets),
    Method = get,
    URL = bitstring_to_list(UserName),
    OauthHeader = bitstring_to_list(Password),
    Header = [{"Authorization", OauthHeader}, {"Content-Type", "application/json"}],
    HttpOptions = [],
    Options = [],
    %error_logger:info_msg("auth header from user is : ~p ", [OauthHeader]),
    
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

