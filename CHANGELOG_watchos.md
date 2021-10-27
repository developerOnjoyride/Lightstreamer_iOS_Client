# Lightstreamer SDK for watchOS Clients Changelog

## 4.3.2 build 32

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 May 2021_

Built with the APPLICATION_EXTENSION_API_ONLY setting enabled.

## 4.3.1 build 31

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 25 Feb 2021_

Fixed a bug that could have caused the client to not reissue the active
subscriptions on the next connection attempts when the device switched
several times between online and offline mode.

## 4.3.0 build 30

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 Jan 2021_

Discontinued a notification to the Server of the termination of a HTTP
streaming session. The notification could help the Server to detect
closed connections in some cases, but in other cases it could give rise
to bursts of new connections.

The library is now built and distributed as an XCFramework.

Introduced support for running watchOS Simulator on Apple Silicon Macs.

Dropped distribution via CocoaPods, replaced with Swift Package Manager.

## 4.2.1 build 22

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 11 Dec 2019_

Revised the policy of reconnection attempts to reduce the attempt
frequency in case of repeated failure of the first bind request, which
could be due to issues in accessing the "control link" (when
configured).

## 4.2.0 build 21

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
Server with a license of "file" type which enables watchOS Client SDK up
to version 4.1 or earlier, clients based on this new version will not be
accepted by the Server: a license upgrade will be needed.</span>

## 4.1.2 build 17

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 9 Jul 2019_

Fixed race condition that under rare circumstances could have caused a
crash when closing a connection that was actively receiving data.

## 4.1.1 build 15

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

## 4.1.0 build 14

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
`YES` to `NO`.

Changed the default value of the `slowingEnabled` property from `YES` to
`NO`.

Incremented the minor version number. <span
class="compatibility">COMPATIBILITY NOTE: If running Lightstreamer
Server with a license of "file" type which enables watchOS Client SDK up
to version 4.0 or earlier, clients based on this new version will not be
accepted by the Server: a license upgrade will be needed.</span>

## 4.0.5 build 13

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 20 Nov 2018_

Fixed a race condition that could lead the Client to stop trying to
reconnect to the Server after a network disconnection or a server
restart. This bug has been reported only when running on the Simulator,
but could happen also on the device.

Added ARM64_32 code segments to the library binaries for compatibility
with the latest Apple Watch architecture.

## 4.0.4 build 12

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

## 4.0.3 build 10

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 10 Jul 2018_

Fixed reference cycles that could lead to memory leaks while trying to
connect for extended periods of time or, once connected, when
subscribing and unsubscribing multiple times.

## 4.0.2 build 8

_Compatible with Lightstreamer Server since 7.0._<br>

_Compatible with code developed with the previous version._<br>

_Released on 31 May 2018_

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

Fixed a bug in the recently introduced session recovery mechanism, by
which, a "sendMessage" request issued while a recovery operation was in
place, could have never been notified to the listener until the end of
the session (at which point an "abort" notification would have been
issued to the listener), even in case the recovery was successful.

Minor performance improvement in native HTTP connection mechanism by
replacing threads with GCD queues

## 4.0.1 build 7

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

Fixed a bug which could have caused the property `snapshot` of
`LSItemUpdate` to behave wrongly on subscriptions in which the snapshot
was not requested.

Fixed a bug preventing the connection when the Server configuration
specifies a control-link address.

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

## 4.0.0 build 4

_Compatible with Lightstreamer Server since 7.0 b2._<br>

_Made available as a prerelease on 7 Feb 2018_

Derived from iOS Client SDK 4.0.0 build 66.  
Some features are missing. See the introduction of the API documentation
for details.
