# Lightstreamer SDK for macOS Clients Changelog

## 4.3.2 build 84

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 May 2021_

Built with the APPLICATION_EXTENSION_API_ONLY setting enabled.

## 4.3.1 build 83

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 25 Feb 2021_

Fixed a bug that could have caused the client to not reissue the active
subscriptions on the next connection attempts when the device switched
several times between online and offline mode.

## 4.3.0 build 82

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 Jan 2021_

Discontinued a notification to the Server of the termination of a HTTP
streaming session. The notification could help the Server to detect
closed connections in some cases, but in other cases it could give rise
to bursts of new connections.

The library is now built and distributed as an XCFramework.

Introduced support for Apple Silicon Macs.

Dropped distribution via CocoaPods, replaced with Swift Package Manager.

## 4.2.1 build 74

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 Dec 2019_

Revised the policy of reconnection attempts to reduce the attempt
frequency in case of repeated failure of the first bind request, which
could be due to issues in accessing the "control link" (when
configured).

## 4.2.0 build 73

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 22 Nov 2019_

Updated documentation of `LSMPNDevice` and event `mpnDeviceDidResume:`
of `LSMPNDeviceDelegate` to reflect changes on Server version 7.1. In
particular, a suspended MPN device now is resumed at the first
subsequent registration (a token change is no more required). <span
class="compatibility">COMPATIBILITY NOTE: If upgrading the SDK and
keeping Server version 7.0, some parts of the documentation will become
slightly incorrect, but the application will work exactly as
before.</span> Note: this documentation change was already included by
mistake since version 4.1.0 of this SDK.

Reduced reconnection time in case the browser detects the online status.

Fixed a bug causing `sessionId` of `LSConnectionDetails` to return nil
notwithstanding the connection status was CONNECTED:STREAM-SENSING.

Fixed a bug affecting the various callbacks that report custom error
codes and error messages received from Lightstreamer Server (originated
by the Metadata Adapter). The message reported could have been in a
percent-encoded form.

By-passed the `retryDelay` setting when recovering from a closed
session. This may speedup the recovery process.

Clarified in the docs the role of `delayTimeout` in
`sendMessage:withSequence:timeout:delegate:enqueueWhileDisconnected`.  
Fixed typos in the docs of MPN-related methods.

Fixed a bug which caused an exception when the Server sent an invalid
item name in two-level subscriptions instead of triggering the listener
`subscription:didFailWithErrorCode:message:forCommandSecondLevelItemWithKey:`
of `LSSubscriptionDelegate` with the error code 14 (Invalid second-level
item name).

Fixed a bug affecting polling sessions, which, upon a connection issue,
could have caused the session to be interrupted by issuing
`client:didReceiveServerError:withMessage:`, instead of being
automatically recovered.

Incremented the minor version number. <span
class="compatibility">COMPATIBILITY NOTE: If running Lightstreamer
Server with a license of "file" type which enables macOS Client SDK up
to version 4.1 or earlier, clients based on this new version will not be
accepted by the Server: a license upgrade will be needed.</span>

## 4.1.2 build 69

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 9 Jul 2019_

Fixed race condition that under rare circumstances could have caused a
crash when closing a connection that was actively receiving data.

## 4.1.1 build 67

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 4 Apr 2019_

Fixed a bug in the recently revised policy of reconnection attempts upon
failed or unresponsive requests. In case of multiple failed attempts on
unresponsive connections the retry delay was increased dynamically, but
was not restored to the configured value after a successful connection.
As a consequence, after a server or network unavailability lasting for a
couple of minutes, further cases of server or network unavailability
would be recovered in about one minute, even if much shorter.

## 4.1.0 build 66

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 14 Mar 2019_

Wholly revised the policy of reconnection attempts upon failed or
unresponsive requests. Now the only property related with this policy is
`retryDelay`, which now affects both (1) the minimum time to wait before
trying a new connection to the Server in case the previous one failed
for any reason and (2) the maximum time to wait for a response to a
request before dropping the connection and trying with a different
approach.  
Previously, point (2) was related with the `connectTimeout` and
`currentConnectTimeout` properties. Now, in case of multiple failed
attempts on unresponsive connections (i.e. while in CONNECTING state),
the timeout used may still be increased dynamically and can be inspected
through `currentConnectTimeout`, but this behavior is no longer
configurable. <span class="compatibility">COMPATIBILITY NOTE: Existing
code that tries to take control of the connection timeouts will no
longer be obeyed, but we assume that the new policy will bring an
overall improvement. Note that, when in CONNECTING state, the current
timeout can be restored by issuing `disconnect`\> and then
`connect`.</span> As a result of the change, properties `connectTimeout`
and `currentConnectTimeout` of `LSConnectionOptions` have been
deprecated, as the setters have no effect and the getter is now
equivalent to `retryDelay`.  
Also changed the default value of the `retryDelay` property from 2
seconds to 4 seconds.

Modified the implementation of `connect` when issued while the state is
either DISCONNECTED:WILL-RETRY or DISCONNECTED:TRYING-RECOVERY. The call
will no longer interrupt the pending reconnection attempt, but it will
be ignored, to lean on the current attempt. Note that a pending
reconnection attempt can still be interrupted by issuing disconnect
first.  
Modified in a similar way the implementation of `forcedTransport`
property when issued while the state is either DISCONNECTED:WILL-RETRY
or DISCONNECTED:TRYING-RECOVERY, the call will no longer interrupt the
pending reconnection attempt, but it will apply to the outcome of that
connection attempt.

Fixed a bug triggered by a call to `connect` or a change to
`forcedTransport` issued while the Client was attempting the recovery of
the current session. This caused the recovery to fail, but, then, the
library might not reissue the current subscriptions on the newly created
session.

Fixed a bug that could have caused session recovery to fail if preceded
by a previous successful session recovery on the same session by more
than a few seconds.

Changed the default value of the `earlyWSOpenEnabled` property from
`YES` to `NO`. This removes a potential incompatibility with
cookie-based Load Balancers, at the expense of a possible slight delay
in session startup.

Changed the default value of the `slowingEnabled` property from `YES` to
`NO`.

Incremented the minor version number. <span
class="compatibility">COMPATIBILITY NOTE: If running Lightstreamer
Server with a license of "file" type which enables macOS Client SDK up
to version 4.0 or earlier, clients based on this new version will not be
accepted by the Server: a license upgrade will be needed.</span>

## 4.0.5 build 65

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 20 Nov 2018_

Fixed a race condition that could lead the Client to stop trying to
reconnect to the Server after a network disconnection or a server
restart. This bug has been reported only when running on the Simulator,
but could happen also on the device.

## 4.0.4 build 64

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 30 Oct 2018_

Fixed a bug causing a fatal error when the Client recreated a session
because of a network error and there were active MPN subscriptions.

Fixed a bug causing the Client to ignore the `sessionRecoveryTimeout`
when in state STALLED.

Fixed a bug causing the closing of the session when the user made a copy
of a triggered `LSMPNSubscription` (with the copy constructor
`initWithMPNSubscription:`) and then subscribed the copy.

## 4.0.3 build 62

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 10 Jul 2018_

Fixed reference cycles that could lead to memory leaks while trying to
connect for extended periods of time or, once connected, when
subscribing and unsubscribing multiple times.

## 4.0.2 build 60

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 31 May 2018_

Raised minimum macOS version requirement to 10.10, from 10.9.

Introduced a maximum time on attempts to recover the current session,
after which a new session will be opened. The default is 15 seconds, but
it can be customized with the newly added `sessionRecoveryTimeout`
property in `LSConnectionOptions`. This fixes a potential case of
permanently unsuccessful recovery, if the \<control_link_address>
setting were leveraged in a Server cluster and a Server instance
happened to leave a cluster and were not automatically restarted.

Fixed a bug in the recently introduced session recovery mechanism
triggered by the use of the \<control_link_address> setting on
Lightstreamer Server, which could have caused feasible recovery attempts
to fail.

Fixed a bug in the Stream-Sense mechanism, which was unable to recover
to HTTP streaming in some specific cases of unavailability of a
websocket connection.

Fixed a bug affecting the interruption of a session on a WebSocket. In
case of connectivity issues (or cluster affinity issues) the session
might have remained open in the background, causing a resource waste.

Fixed a bug in the recently introduced session recovery mechanism, by
which, a "sendMessage" request issued while a recovery operation was in
place, could have never been notified to the listener until the end of
the session (at which point an "abort" notification would have been
issued to the listener), even in case the recovery was successful.

Fixed a bug which, upon particular kinds of network issues and when the
"early websocket open" feature was enabled, could have caused the Client
to abort session establishment or recovery attempts with no notification
to the application.

Minor performance improvement in native HTTP connection mechanism by
replacing threads with GCD queues

## 4.0.1 build 58

_Compatible with Lightstreamer Server since 7.0 b2._<br>

_May not be compatible with code developed with the previous version; see
compatibility notes below._<br>

_Released on 26 Feb 2018_

Added the error code 21 in `client:didReceiveServerError:withMessage:`,
that can be received upon some failed requests, to inform that not only
the current session was not found but it is also likely that the request
was routed to the wrong Server instance. Previously, in the same cases,
the SDK library would not invoke
`client:didReceiveServerError:withMessage:` and would open a new session
instead. <span class="compatibility">COMPATIBILITY NOTE: If using an
existing application, you should check how it would handle the new (and
unexpected) error code. A reconnection attempt would ensure the previous
behavior, although this is no longer the suggested action.</span>

Modified the default value of the `retryDelay` property from 5 to 2
seconds. This should help recovering from network outages of a few
seconds, typical, for instance, of wifi/mobile network switches.

Extended the recovery mechanism to stalled sessions. Now, when the
`reconnectTimeout` expires, an attempt to recover the current session
will be performed first.

Fixed a bug, introduced in version 3.0.0, which could have caused the
property `snapshot` of `LSItemUpdate` to behave wrongly on subscriptions
in which the snapshot was not requested.

Fixed a bug introduced with version 3.0.0 preventing the connection when
the Server configuration specifies a control-link address.

Fixed a rare race condition which could have caused the delay of
subscription requests issued on a websocket session startup due to a
wrong request to the Server.

Fixed a bug which, in a slow client scenario, could have caused the
interruption of a polling session due to a wrong request to the Server.

Fixed a race condition, mostly possible in an overloaded client
scenario, which could have caused subscription or sendMessage requests
to be delayed.

Fixed a harmless bug in the reverse heartbeat mechanism which, upon
session startup, could have caused an exception to be logged on the
console.

Fixed the instructions provided in the documentation of
`notificationFormat` property of the `LSMPNSubscription` class.

Extended the scope of error code 41 on the various MPN requests to all
issues related with resource unavailability in the Server preventing the
operation. Previously, such issues could have caused the whole session
to be interrupted.

Added clarifications on licensing matters in the docs.

## 4.0.0 build 55

_Compatible with Lightstreamer Server since 7.0 b2._<br>

_May not be compatible with code developed with the previous version; see
compatibility notes below._<br>

_Released on 20 Dec 2017_

Introduced the support for Mobile Push Notifications. It consists in new
methods in the `LSLightstreamerClient` class together with new dedicated
classes. See the API documentation for details.  
An MPN subscription is backed by a real-time subscription, from which it
may take any field value. Unlike the usual real-time subscriptions, MPN
subscriptions are persistent: they survive the session and are
identified by a permanent, global, unique key provided by the Server at
time of activation.  
The notifications are managed by third-party services supported by the
Server, which determine the notification characteristics and the
supported devices.

Added automatic recovery of sessions upon unexpected socket interruption
during streaming or long polling. Now the library will perform an
attempt to resume the session from the interruption point. The attempt
may or may not succeed, also depending on the Server configuration of
the recovery capability.  
As a consequence, introduced a new status, namely
DISCONNECTED:TRYING-RECOVERY, to inform the application when a recovery
attempt is being performed; hence, `client:didChangeStatus:` event and
the status property can provide the new status. <span
class="compatibility">COMPATIBILITY NOTE: Existing code that uses the
status names received via `client:didChangeStatus:` or status may have
to be aligned.</span>

Extended the reverse heartbeat mechanism, governed by the
`reverseHeartbeatInterval` property. Now, it will also allow the Server
to detect when a client has abandoned a session although the socket
remains open.  
Fixed the reverse heartbeat mechanism, which didn't work at all. Since
version 3.0.0, setting a value for the `reverseHeartbeatInterval`
property could have even caused the connection interruption.

Added the new Server error code 71 to
`client:didReceiveServerError:withMessage:` and clarified the difference
with error code 60.

Fixed a bug that, when under certain circumstances the Server is
unreachable, caused the Client to enter in a tight reconnection loop
ignoring the parameter `retryDelay` property of `LSConnectionOptions`.

Fixed a bug, introduced in version 3, affecting the case of session
establishment refusal by the Metadata Adapter (through a
CreditsException) and the case of forced destroy (via external
requests), when a negative custom error code was supplied. The
subsequent invocation to `client:didReceiveServerError:withMessage:`
would carry code 61 (internal error) instead of the specified custom
code.

Fixed a bug which caused polling on WebSocket to fail. Note that this
feature is available, but very rarely used.

Fixed the documentation of `serverSocketName` property, whose behavior
has slightly changed since version 3.0.0.

Fixed the documentation of the `contentLength`, `keepaliveInterval`, and
`reverseHeartbeatInterval` properties of `LSConnectionOptions`, to
clarify that a zero value is not allowed in the first and it is allowed
in the others.

Aligned the documentation to comply with current licensing policies.

## 3.0.1 build 46.11

_Compatible with Lightstreamer Server since 6.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 26 Oct 2017_

Fixed bug that could have caused a streaming connection to stall if the
Client was under heavy activity.

Fixed minor memory leak in WebSocket connection opening.

## 3.0.0 build 46.9

_Compatible with Lightstreamer Server since 6.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 6 Sep 2017_

Confirmed and published with no changes since beta prerelease.

## 3.0.0 beta build 46.8

_Compatible with Lightstreamer Server since 6.1_<br>

_May not be compatible with code developed with the previous version; see
compatibility notes below._<br>

_Made available as a prerelease on 19 Jul 2017_

Introduced the use of WebSockets both for streaming and for subscription
and client message requests, which brings an overall performance
improvement.  
As a consequence, `forcedTransport` now also supports the "WS",
"WS-STREAMING", and "WS-POLLING" values and the predisposed
`earlyWSOpenEnabled` property is now effective.  
WebSocket support is provided by SocketRocket. Its license file is
included in the distribution.

Added static methods `addCookies:forURL:` and `getCookiesForURL:` in
LSLightstreamerClient, to allow for cookie sharing with the rest of the
application when a local cookie store is being used.

Replaced the `maxBandwidth` property of LSConnectionOptions with two
distinct properties: `requestedMaxBandwidth` and the read-only
`realMaxBandwidth`, so that the setting is made with the former, while
the value applied by the Server is only reported by the latter, now
including changes during session life. The extension affects the
property names and also the invocations of `client:didChangeProperty:`
on the LSClientDelegate (see the docs for details). <span
class="compatibility">COMPATIBILITY NOTE: Custom code using
`maxBandwidth` in any of the mentioned forms has to be ported and
recompiled. If the property is not used in any form, existing compiled
code can still run against the new library.</span>

Introduced a new callback, `subscription:didReceiveRealFrequency:`, to
the LSSubscriptionDelegate, to report the frequency constraint on the
subscription as determined by the Server and their changes during
subscription life. See the docs for details and special cases. <span
class="compatibility">COMPATIBILITY NOTE: Custom code has to be ported,
by implementing the new method, and recompiled. Existing compiled code
should still run against the new library: invocations to
`subscription:didReceiveRealFrequency:` to the custom delegate would
simply be ignored.</span>

Introduced a new property, `clientIp`, in LSConnectionDetails; it is a
read-only property with the keyword for `client:didChangeProperty:` (see
the docs for details).

Completed the implementation of methods whose implementation was only
partial. This regards:

-   `fieldSchema` in LSSubscription now also working for COMMAND mode
    subscriptions;
-   `slowingEnabled` in LSConnectionOptions now working if YES is
    supplied;
-   `subscription:didClearSnapshotForItemName:itemPos:` in the
    LSSubscriptionDelegate now invoked as expected.

Fixed the nullability annotations for the following methods and
properties:

-   LSClientDelegate:
    -   `client:didReceiveServerError:withMessage:`
-   LSClientMessageDelegate:
    -   `client:didDenyMessage:withCode:error:`
-   LSLightstreamerClient:
    -   `setLoggerProvider:`
-   LSSubscription:
    -   `commandSecondLevelFields`
    -   `commandSecondLevelFieldSchema`
    -   `fields`
    -   `fieldSchema`
    -   `itemGroup`
    -   `items`

<span class="compatibility">COMPATIBILITY NOTE: Existing code written in
Swift may no longer compile and should be aligned with the new
signatures. No issues are expected for existing Objective-C code.</span>

Revised the `sendMessage` implementation in the HTTP case, to limit
recovery actions when messages are not to be ordered and a delegate is
not provided.  
Revised `sendMessage` to accept 0 as a legal value for the
`delayTimeout` argument; negative values will now be accepted to mean
that the Server default timeout is to be used. <span
class="compatibility">COMPATIBILITY NOTE: Existing code using the
5-argument version of `sendMessage` and supplying 0 as `delayTimeout`
must be modified to use -1 instead. Invocations to the 1-argument
version don't have to be modified.</span>

Fixed a bug which affected any unsubscription request issued so early
that the corresponding subscription request had not been completed yet.
Such unsubscription could have caused
`subscription:didFailWithErrorCode:message:` with code 19 and the item
would have been left subscribed to by the session on the Server, yet
considered not subscribed to by the library.

Improved the efficiency by avoiding unnecessary encoding of characters
in the requests (for instance, in group/schema names and in client
messages). In particular, non-ascii characters are no longer encoded.

Improved the management of retries upon unsuccessful control requests.

Slightly delayed the availability of the `serverSocketName` property of
LSConnectionDetails, which was already valued upon session start. <span
class="compatibility">COMPATIBILITY NOTE: Custom code using
`serverSocketName` right after a session start, should ensure that
`client:didChangeProperty:` for `serverSocketName` gets invoked
first.</span>

Added the support for non standard unicode names, if supplied as
hostnames in Lightstreamer Server's \<control_link_address>
configuration element.

Removed useless requests to the Server for bandwidth change when the
Server is not configured for bandwidth management.

Improved the management of `HTTPExtraHeadersOnSessionCreationOnly`, when
YES. Previously, the extra headers (supplied with `HTTPExtraHeaders`)
were still sent, redundantly, on control requests.

Fully revised the documentation to be more readable from Xcode
preview.  
Also switched to Appledoc for the generation of API docsets, for
improved readability and conformance with other SDKs documentation.

Added new error codes 66 and 68 to
`client:didReceiveServerError:withMessage:`,
`subscription:didFailWithErrorCode:message:`, and
`subscription:didFailWithErrorCode:message:forCommandSecondLevelItemWithKey:`,
to report server-side issues; previously, upon such problems, the
connection was just interrupted.  
Added missing error code 60 to
`client:didReceiveServerError:withMessage:` documentation; this error
reports server-side licensing limitations.  
Removed error code 20 from `subscription:didFailWithErrorCode:message:`
and
`subscription:didFailWithErrorCode:message:forCommandSecondLevelItemWithKey:`
documentation; when a subscription request cannot find the session, the
session is just closed and recovered immediately.  
Revised the documentation of the possible error codes.

Clarified in the documentation the meaning of nil in
`requestedMaxFrequency` and `requestedBufferSize`. Extended
`requestedMaxFrequency` to allow the setting also when the subscription
is "active" and the current value is nil.

Aligned the `LIB_NAME` property to "macos"; it was still valued as
"osx".

## 2.1.2 build 43

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 17 Jan 2017_

Added the new setting `limitExceptionsUse` in LSLightstreamerClient to
avoid throwing an exception when certain methods are called with an
invalid parameter. E.g. `valueWithFieldName:` in LSItemUpdate and
`valueWithItemName:fieldName:` in LSSubscription both obey to this new
setting. See API docs for more information.

Removed a restriction on field names that can be supplied to a
LSSubscription object within a "field list"; names made by numbers are
now allowed. Obviously, the final validation on field names is made by
the Metadata Adapter.

Moved the `LIB_NAME` and `LIB_VERSION` methods of LSLightstreamerClient
to class properties. They can now be accessed with the dot notation.
Previous class methods remain available.

## 2.1.1 build 41

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 6 Jan 2017_

Fixed a bug on the implementation of `disconnect`, whereby an ongoing
loop of connection attempt was not interrupted in case of Server down or
wrong address.

Fixed a bug, regarding only subscriptions in COMMAND mode, which caused
unchanged fields to be redundantly indicated as changed. The bug didn't
affect the returned data values.

Revised the default setting for the `contentLength` property of
LSConnectionOptions, to allow the library to set it to the best value.

## 2.1.0 build 40

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 25 Nov 2016_

Added new properties to LSConnectionOptions and new behavior to
LSLightstreamerClient to limit the number of sessions that can be
concurrently open to the same Server. New properties are:
`maxConcurrentSessionsPerServer` (a class property) and
`maxConcurrentSessionsPerServerExceededPolicy`. See docs for more
information.

Added new event to LSClientDelegate to respond to an authentication
challenge raised during network connection. New event is
`client:willSendRequestForAuthenticationChallenge:`. See docs for more
information.

Fixed bug that caused a crash if an LSSubscription object was created
before initializing an LSLightstreamerClient instance.

Removed any remaining use of NSURLConnection. Now all networking is done
through NSURLSession.

Fixed a bug that could have caused wrong error codes (that is, codes
different from the documented ones) to be reported by subscription error
events of LSSubscriptionDelegate.

Fixed the documentation of
`subscription:didClearSnapshotForItemName:itemPos:` on
LSSubscriptionDelegate, which is only predisposed.

The client library is now distributed as a framework.

Raised the minimum macOS version requirements to 10.9.

References to "OS X" or "Mac OS X" now changed to "macOS".

## 2.0.1 build 33

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 26 Aug 2016_

Fixed a memory leak that could become significant with intense update
activity.

Fixed bug in network reachability thread that caused a 100% CPU usage if
the Client was initialized but left unconnected.

Clarified the documentation in regard to a few API methods that still
have a partial implementation or are just predisposed and not
implemented yet.

## 2.0.0 build 28

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Compatible with code developed with the previous version._<br>

_Released on 8 Apr 2016_

Added bitcode support.

Fixed casing of property "sessionID" of LSConnectionDetails as
"sessionId", for coherence with other Unified API Client SDKs.

Event `client:didChangeProperty:` now reports correct client property
names, e.g. "pollingTimeout" instead of "pollingMillis".

Fixed potential exception which could be thrown when setting or updating
fields and/or items list if logging is enabled at DEBUG level.

Prevented reconnection attempts upon wrong answers from the Server.

Fixed an error in the log of the keepalive interval setting.

Fixed the documentation of `client:didReceiveServerError:withMessage:`
and `client:didChangeStatus:`, to specify that the former is always
preceded, not followed, by the latter with DISCONNECTED.

## 2.0 a5 build 22

_Compatible with Lightstreamer Server since 6.0.1_<br>

_May not be compatible with code developed with the previous version; see
compatibility notes below._<br>

_Made available as a prerelease on 17 Nov 2015_

Changed the type and behavior of connectTimeout. This setting is now
represented as a String in order to accept the "auto" value. If "auto"
is specified the value used internally will be chosen (and possibly
changed over time) by the library itself. Note that "auto" is also the
new default value. To check and or modify the current value a property
is exposed: currentConnectTimeout. <span
class="compatibility">COMPATIBILITY NOTE: if the connectTimeout property
is changed by the client code, the given parameter must be modified to
be a String. If the connectTimeout property is accesses by the client
code its receiving variable must be converted to an NSString; moreover
it is likely that connectTimeout accesses should be replaced by
currentConnectTimeout ones.</span> See the docs for further details.

## 2.0 a4 build 16

_Compatible with Lightstreamer Server since 6.0.1_<br>

_Made available as a prerelease on 7 Oct 2015_

Introduced as an improved alternative to the SDK for macOS clients. The
interface offered is completely different, and it is very similar to the
one currently exposed by the SDK for JavaScript Clients.
