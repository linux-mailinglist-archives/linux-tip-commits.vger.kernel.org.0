Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B340737A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Sep 2021 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhIJWq1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 18:46:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhIJWq0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 18:46:26 -0400
Date:   Fri, 10 Sep 2021 22:45:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631313912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmEeGE452jy4O2twHwGu3+JhNlxDDQWqGQMQ7i+xUNQ=;
        b=Au4xnyWI+1AjFHgLMaKGsInM/GmJhs/QeDsJhilxlXyOhvUJa32suTxfztRAWdCspe8FuW
        ooCSZYmFND/9vCbpewy9phWNZAaxMEfMzvtTSXMWEC30EfRhyQweL6TWzRHMV14DTXQdbi
        lSBDhkkhNOmu0xm1QsEV4eq+dW/RMZ3FZ0RIyvj/7ihkgUfxBt/fB5TnmwtGg+ITHa3vtL
        vbNnHFSwv0Q/i2EN1+LgHJReyaCaeFm98BaKNCJ2KNBjIUNEeq1LwAZk82QlGbZbZzpUw2
        FKv0/XnUdDga6ZRLQqFBkLDMq3/G6WQyK0k8iTe8yNev67dE4zXGT/q7E1dViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631313912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmEeGE452jy4O2twHwGu3+JhNlxDDQWqGQMQ7i+xUNQ=;
        b=6OFw9uersIYfHoOIbdY7vk7P3E2vE5+xNh+JWssf7WUCLr2f6hQy33JCVrR/5Nag7ls1EO
        LdUGcYy96SCPy6Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] Documentation: core-api/cpuhotplug: Rewrite the API section
Cc:     Dave Chinner <david@fromorbit.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210909123212.489059409@linutronix.de>
References: <20210909123212.489059409@linutronix.de>
MIME-Version: 1.0
Message-ID: <163131391108.25758.6317046565531817076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     c9871c800f65fffed40f3df3e1eb38984f95cfcf
Gitweb:        https://git.kernel.org/tip/c9871c800f65fffed40f3df3e1eb38984f9=
5cfcf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 09 Sep 2021 14:34:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Sep 2021 00:41:21 +02:00

Documentation: core-api/cpuhotplug: Rewrite the API section

Dave stumbled over the incomplete and confusing documentation of the CPU
hotplug API.

Rewrite it, add the missing function documentations and correct the
existing ones.

Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210909123212.489059409@linutronix.de

---
 Documentation/core-api/cpu_hotplug.rst | 579 +++++++++++++++++++-----
 include/linux/cpuhotplug.h             | 132 ++++-
 2 files changed, 590 insertions(+), 121 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/=
cpu_hotplug.rst
index b66e3ca..c6f4ba2 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -2,12 +2,13 @@
 CPU hotplug in the Kernel
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-:Date: December, 2016
+:Date: September, 2021
 :Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
-          Rusty Russell <rusty@rustcorp.com.au>,
-          Srivatsa Vaddagiri <vatsa@in.ibm.com>,
-          Ashok Raj <ashok.raj@intel.com>,
-          Joel Schopp <jschopp@austin.ibm.com>
+         Rusty Russell <rusty@rustcorp.com.au>,
+         Srivatsa Vaddagiri <vatsa@in.ibm.com>,
+         Ashok Raj <ashok.raj@intel.com>,
+         Joel Schopp <jschopp@austin.ibm.com>,
+	 Thomas Gleixner <tglx@linutronix.de>
=20
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -158,100 +159,480 @@ at state ``CPUHP_OFFLINE``. This includes:
 * Once all services are migrated, kernel calls an arch specific routine
   ``__cpu_disable()`` to perform arch specific cleanup.
=20
-Using the hotplug API
----------------------
-
-It is possible to receive notifications once a CPU is offline or onlined. Th=
is
-might be important to certain drivers which need to perform some kind of set=
up
-or clean up functions based on the number of available CPUs::
-
-  #include <linux/cpuhotplug.h>
-
-  ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "X/Y:online",
-                          Y_online, Y_prepare_down);
-
-*X* is the subsystem and *Y* the particular driver. The *Y_online* callback
-will be invoked during registration on all online CPUs. If an error
-occurs during the online callback the *Y_prepare_down* callback will be
-invoked on all CPUs on which the online callback was previously invoked.
-After registration completed, the *Y_online* callback will be invoked
-once a CPU is brought online and *Y_prepare_down* will be invoked when a
-CPU is shutdown. All resources which were previously allocated in
-*Y_online* should be released in *Y_prepare_down*.
-The return value *ret* is negative if an error occurred during the
-registration process. Otherwise a positive value is returned which
-contains the allocated hotplug for dynamically allocated states
-(*CPUHP_AP_ONLINE_DYN*). It will return zero for predefined states.
-
-The callback can be remove by invoking ``cpuhp_remove_state()``. In case of a
-dynamically allocated state (*CPUHP_AP_ONLINE_DYN*) use the returned state.
-During the removal of a hotplug state the teardown callback will be invoked.
-
-Multiple instances
-~~~~~~~~~~~~~~~~~~
-
-If a driver has multiple instances and each instance needs to perform the
-callback independently then it is likely that a ''multi-state'' should be us=
ed.
-First a multi-state state needs to be registered::
-
-  ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "X/Y:online,
-                                Y_online, Y_prepare_down);
-  Y_hp_online =3D ret;
-
-The ``cpuhp_setup_state_multi()`` behaves similar to ``cpuhp_setup_state()``
-except it prepares the callbacks for a multi state and does not invoke
-the callbacks. This is a one time setup.
-Once a new instance is allocated, you need to register this new instance::
-
-  ret =3D cpuhp_state_add_instance(Y_hp_online, &d->node);
-
-This function will add this instance to your previously allocated
-*Y_hp_online* state and invoke the previously registered callback
-(*Y_online*) on all online CPUs. The *node* element is a ``struct
-hlist_node`` member of your per-instance data structure.
-
-On removal of the instance::
-
-  cpuhp_state_remove_instance(Y_hp_online, &d->node)
-
-should be invoked which will invoke the teardown callback on all online
-CPUs.
-
-Manual setup
-~~~~~~~~~~~~
-
-Usually it is handy to invoke setup and teardown callbacks on registration or
-removal of a state because usually the operation needs to performed once a C=
PU
-goes online (offline) and during initial setup (shutdown) of the driver. How=
ever
-each registration and removal function is also available with a ``_nocalls``
-suffix which does not invoke the provided callbacks if the invocation of the
-callbacks is not desired. During the manual setup (or teardown) the functions
-``cpus_read_lock()`` and ``cpus_read_unlock()`` should be used to inhibit CPU
-hotplug operations.
-
-
-The ordering of the events
---------------------------
-
-The hotplug states are defined in ``include/linux/cpuhotplug.h``:
-
-* The states *CPUHP_OFFLINE* =E2=80=A6 *CPUHP_AP_OFFLINE* are invoked before=
 the
-  CPU is up.
-* The states *CPUHP_AP_OFFLINE* =E2=80=A6 *CPUHP_AP_ONLINE* are invoked
-  just the after the CPU has been brought up. The interrupts are off and
-  the scheduler is not yet active on this CPU. Starting with *CPUHP_AP_OFFLI=
NE*
-  the callbacks are invoked on the target CPU.
-* The states between *CPUHP_AP_ONLINE_DYN* and *CPUHP_AP_ONLINE_DYN_END* are
-  reserved for the dynamic allocation.
-* The states are invoked in the reverse order on CPU shutdown starting with
-  *CPUHP_ONLINE* and stopping at *CPUHP_OFFLINE*. Here the callbacks are
-  invoked on the CPU that will be shutdown until *CPUHP_AP_OFFLINE*.
-
-A dynamically allocated state via *CPUHP_AP_ONLINE_DYN* is often enough.
-However if an earlier invocation during the bring up or shutdown is required
-then an explicit state should be acquired. An explicit state might also be
-required if the hotplug event requires specific ordering in respect to
-another hotplug event.
+
+The CPU hotplug API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+CPU hotplug state machine
+-------------------------
+
+CPU hotplug uses a trivial state machine with a linear state space from
+CPUHP_OFFLINE to CPUHP_ONLINE. Each state has a startup and a teardown
+callback.
+
+When a CPU is onlined, the startup callbacks are invoked sequentially until
+the state CPUHP_ONLINE is reached. They can also be invoked when the
+callbacks of a state are set up or an instance is added to a multi-instance
+state.
+
+When a CPU is offlined the teardown callbacks are invoked in the reverse
+order sequentially until the state CPUHP_OFFLINE is reached. They can also
+be invoked when the callbacks of a state are removed or an instance is
+removed from a multi-instance state.
+
+If a usage site requires only a callback in one direction of the hotplug
+operations (CPU online or CPU offline) then the other not-required callback
+can be set to NULL when the state is set up.
+
+The state space is divided into three sections:
+
+* The PREPARE section
+
+  The PREPARE section covers the state space from CPUHP_OFFLINE to
+  CPUHP_BRINGUP_CPU.
+
+  The startup callbacks in this section are invoked before the CPU is
+  started during a CPU online operation. The teardown callbacks are invoked
+  after the CPU has become dysfunctional during a CPU offline operation.
+
+  The callbacks are invoked on a control CPU as they can't obviously run on
+  the hotplugged CPU which is either not yet started or has become
+  dysfunctional already.
+
+  The startup callbacks are used to setup resources which are required to
+  bring a CPU successfully online. The teardown callbacks are used to free
+  resources or to move pending work to an online CPU after the hotplugged
+  CPU became dysfunctional.
+
+  The startup callbacks are allowed to fail. If a callback fails, the CPU
+  online operation is aborted and the CPU is brought down to the previous
+  state (usually CPUHP_OFFLINE) again.
+
+  The teardown callbacks in this section are not allowed to fail.
+
+* The STARTING section
+
+  The STARTING section covers the state space between CPUHP_BRINGUP_CPU + 1
+  and CPUHP_AP_ONLINE.
+
+  The startup callbacks in this section are invoked on the hotplugged CPU
+  with interrupts disabled during a CPU online operation in the early CPU
+  setup code. The teardown callbacks are invoked with interrupts disabled
+  on the hotplugged CPU during a CPU offline operation shortly before the
+  CPU is completely shut down.
+
+  The callbacks in this section are not allowed to fail.
+
+  The callbacks are used for low level hardware initialization/shutdown and
+  for core subsystems.
+
+* The ONLINE section
+
+  The ONLINE section covers the state space between CPUHP_AP_ONLINE + 1 and
+  CPUHP_ONLINE.
+
+  The startup callbacks in this section are invoked on the hotplugged CPU
+  during a CPU online operation. The teardown callbacks are invoked on the
+  hotplugged CPU during a CPU offline operation.
+
+  The callbacks are invoked in the context of the per CPU hotplug thread,
+  which is pinned on the hotplugged CPU. The callbacks are invoked with
+  interrupts and preemption enabled.
+
+  The callbacks are allowed to fail. When a callback fails the hotplug
+  operation is aborted and the CPU is brought back to the previous state.
+
+CPU online/offline operations
+-----------------------------
+
+A successful online operation looks like this::
+
+  [CPUHP_OFFLINE]
+  [CPUHP_OFFLINE + 1]->startup()       -> success
+  [CPUHP_OFFLINE + 2]->startup()       -> success
+  [CPUHP_OFFLINE + 3]                  -> skipped because startup =3D=3D NULL
+  ...
+  [CPUHP_BRINGUP_CPU]->startup()       -> success
+  =3D=3D=3D End of PREPARE section
+  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
+  ...
+  [CPUHP_AP_ONLINE]->startup()         -> success
+  =3D=3D=3D End of STARTUP section
+  [CPUHP_AP_ONLINE + 1]->startup()     -> success
+  ...
+  [CPUHP_ONLINE - 1]->startup()        -> success
+  [CPUHP_ONLINE]
+
+A successful offline operation looks like this::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_AP_ONLINE + 1]->teardown()    -> success
+  =3D=3D=3D Start of STARTUP section
+  [CPUHP_AP_ONLINE]->teardown()        -> success
+  ...
+  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
+  ...
+  =3D=3D=3D Start of PREPARE section
+  [CPUHP_BRINGUP_CPU]->teardown()
+  [CPUHP_OFFLINE + 3]->teardown()
+  [CPUHP_OFFLINE + 2]                  -> skipped because teardown =3D=3D NU=
LL
+  [CPUHP_OFFLINE + 1]->teardown()
+  [CPUHP_OFFLINE]
+
+A failed online operation looks like this::
+
+  [CPUHP_OFFLINE]
+  [CPUHP_OFFLINE + 1]->startup()       -> success
+  [CPUHP_OFFLINE + 2]->startup()       -> success
+  [CPUHP_OFFLINE + 3]                  -> skipped because startup =3D=3D NULL
+  ...
+  [CPUHP_BRINGUP_CPU]->startup()       -> success
+  =3D=3D=3D End of PREPARE section
+  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
+  ...
+  [CPUHP_AP_ONLINE]->startup()         -> success
+  =3D=3D=3D End of STARTUP section
+  [CPUHP_AP_ONLINE + 1]->startup()     -> success
+  ---
+  [CPUHP_AP_ONLINE + N]->startup()     -> fail
+  [CPUHP_AP_ONLINE + (N - 1)]->teardown()
+  ...
+  [CPUHP_AP_ONLINE + 1]->teardown()
+  =3D=3D=3D Start of STARTUP section
+  [CPUHP_AP_ONLINE]->teardown()
+  ...
+  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
+  ...
+  =3D=3D=3D Start of PREPARE section
+  [CPUHP_BRINGUP_CPU]->teardown()
+  [CPUHP_OFFLINE + 3]->teardown()
+  [CPUHP_OFFLINE + 2]                  -> skipped because teardown =3D=3D NU=
LL
+  [CPUHP_OFFLINE + 1]->teardown()
+  [CPUHP_OFFLINE]
+
+A failed offline operation looks like this::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()
+  ...
+  [CPUHP_ONLINE - 1]->startup()
+  [CPUHP_ONLINE]
+
+Recursive failures cannot be handled sensibly. Look at the following
+example of a recursive fail due to a failed offline operation: ::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
+  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
+
+The CPU hotplug state machine stops right here and does not try to go back
+down again because that would likely result in an endless loop::
+
+  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
+  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
+  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+
+Lather, rinse and repeat. In this case the CPU left in state::
+
+  [CPUHP_ONLINE - (N - 1)]
+
+which at least lets the system make progress and gives the user a chance to
+debug or even resolve the situation.
+
+Allocating a state
+------------------
+
+There are two ways to allocate a CPU hotplug state:
+
+* Static allocation
+
+  Static allocation has to be used when the subsystem or driver has
+  ordering requirements versus other CPU hotplug states. E.g. the PERF core
+  startup callback has to be invoked before the PERF driver startup
+  callbacks during a CPU online operation. During a CPU offline operation
+  the driver teardown callbacks have to be invoked before the core teardown
+  callback. The statically allocated states are described by constants in
+  the cpuhp_state enum which can be found in include/linux/cpuhotplug.h.
+
+  Insert the state into the enum at the proper place so the ordering
+  requirements are fulfilled. The state constant has to be used for state
+  setup and removal.
+
+  Static allocation is also required when the state callbacks are not set
+  up at runtime and are part of the initializer of the CPU hotplug state
+  array in kernel/cpu.c.
+
+* Dynamic allocation
+
+  When there are no ordering requirements for the state callbacks then
+  dynamic allocation is the preferred method. The state number is allocated
+  by the setup function and returned to the caller on success.
+
+  Only the PREPARE and ONLINE sections provide a dynamic allocation
+  range. The STARTING section does not as most of the callbacks in that
+  section have explicit ordering requirements.
+
+Setup of a CPU hotplug state
+----------------------------
+
+The core code provides the following functions to setup a state:
+
+* cpuhp_setup_state(state, name, startup, teardown)
+* cpuhp_setup_state_nocalls(state, name, startup, teardown)
+* cpuhp_setup_state_cpuslocked(state, name, startup, teardown)
+* cpuhp_setup_state_nocalls_cpuslocked(state, name, startup, teardown)
+
+For cases where a driver or a subsystem has multiple instances and the same
+CPU hotplug state callbacks need to be invoked for each instance, the CPU
+hotplug core provides multi-instance support. The advantage over driver
+specific instance lists is that the instance related functions are fully
+serialized against CPU hotplug operations and provide the automatic
+invocations of the state callbacks on add and removal. To set up such a
+multi-instance state the following function is available:
+
+* cpuhp_setup_state_multi(state, name, startup, teardown)
+
+The @state argument is either a statically allocated state or one of the
+constants for dynamically allocated states - CPUHP_PREPARE_DYN,
+CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
+which a dynamic state should be allocated.
+
+The @name argument is used for sysfs output and for instrumentation. The
+naming convention is "subsys:mode" or "subsys/driver:mode",
+e.g. "perf:mode" or "perf/x86:mode". The common mode names are:
+
+=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+prepare  For states in the PREPARE section
+
+dead     For states in the PREPARE section which do not provide
+         a startup callback
+
+starting For states in the STARTING section
+
+dying    For states in the STARTING section which do not provide
+         a startup callback
+
+online   For states in the ONLINE section
+
+offline  For states in the ONLINE section which do not provide
+         a startup callback
+=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+As the @name argument is only used for sysfs and instrumentation other mode
+descriptors can be used as well if they describe the nature of the state
+better than the common ones.
+
+Examples for @name arguments: "perf/online", "perf/x86:prepare",
+"RCU/tree:dying", "sched/waitempty"
+
+The @startup argument is a function pointer to the callback which should be
+invoked during a CPU online operation. If the usage site does not require a
+startup callback set the pointer to NULL.
+
+The @teardown argument is a function pointer to the callback which should
+be invoked during a CPU offline operation. If the usage site does not
+require a teardown callback set the pointer to NULL.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_setup_state_nocalls(), cpuhp_setup_state_nocalls_cpuslocked()
+    and cpuhp_setup_state_multi() only install the callbacks
+
+  * cpuhp_setup_state() and cpuhp_setup_state_cpuslocked() install the
+    callbacks and invoke the @startup callback (if not NULL) for all online
+    CPUs which have currently a state greater than the newly installed
+    state. Depending on the state section the callback is either invoked on
+    the current CPU (PREPARE section) or on each online CPU (ONLINE
+    section) in the context of the CPU's hotplug thread.
+
+    If a callback fails for CPU N then the teardown callback for CPU
+    0 .. N-1 is invoked to rollback the operation. The state setup fails,
+    the callbacks for the state are not installed and in case of dynamic
+    allocation the allocated state is freed.
+
+The state setup and the callback invocations are serialized against CPU
+hotplug operations. If the setup function has to be called from a CPU
+hotplug read locked region, then the _cpuslocked() variants have to be
+used. These functions cannot be used from within CPU hotplug callbacks.
+
+The function return values:
+  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  0        Statically allocated state was successfully set up
+
+  >0       Dynamically allocated state was successfully set up.
+
+           The returned number is the state number which was allocated. If
+           the state callbacks have to be removed later, e.g. module
+           removal, then this number has to be saved by the caller and used
+           as @state argument for the state remove function. For
+           multi-instance states the dynamically allocated state number is
+           also required as @state argument for the instance add/remove
+           operations.
+
+  <0	   Operation failed
+  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Removal of a CPU hotplug state
+------------------------------
+
+To remove a previously set up state, the following functions are provided:
+
+* cpuhp_remove_state(state)
+* cpuhp_remove_state_nocalls(state)
+* cpuhp_remove_state_nocalls_cpuslocked(state)
+* cpuhp_remove_multi_state(state)
+
+The @state argument is either a statically allocated state or the state
+number which was allocated in the dynamic range by cpuhp_setup_state*(). If
+the state is in the dynamic range, then the state number is freed and
+available for dynamic allocation again.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_remove_state_nocalls(), cpuhp_remove_state_nocalls_cpuslocked()
+    and cpuhp_remove_multi_state() only remove the callbacks.
+
+  * cpuhp_remove_state() removes the callbacks and invokes the teardown
+    callback (if not NULL) for all online CPUs which have currently a state
+    greater than the removed state. Depending on the state section the
+    callback is either invoked on the current CPU (PREPARE section) or on
+    each online CPU (ONLINE section) in the context of the CPU's hotplug
+    thread.
+
+    In order to complete the removal, the teardown callback should not fail.
+
+The state removal and the callback invocations are serialized against CPU
+hotplug operations. If the remove function has to be called from a CPU
+hotplug read locked region, then the _cpuslocked() variants have to be
+used. These functions cannot be used from within CPU hotplug callbacks.
+
+If a multi-instance state is removed then the caller has to remove all
+instances first.
+
+Multi-Instance state instance management
+----------------------------------------
+
+Once the multi-instance state is set up, instances can be added to the
+state:
+
+  * cpuhp_state_add_instance(state, node)
+  * cpuhp_state_add_instance_nocalls(state, node)
+
+The @state argument is either a statically allocated state or the state
+number which was allocated in the dynamic range by cpuhp_setup_state_multi().
+
+The @node argument is a pointer to an hlist_node which is embedded in the
+instance's data structure. The pointer is handed to the multi-instance
+state callbacks and can be used by the callback to retrieve the instance
+via container_of().
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_state_add_instance_nocalls() and only adds the instance to the
+    multi-instance state's node list.
+
+  * cpuhp_state_add_instance() adds the instance and invokes the startup
+    callback (if not NULL) associated with @state for all online CPUs which
+    have currently a state greater than @state. The callback is only
+    invoked for the to be added instance. Depending on the state section
+    the callback is either invoked on the current CPU (PREPARE section) or
+    on each online CPU (ONLINE section) in the context of the CPU's hotplug
+    thread.
+
+    If a callback fails for CPU N then the teardown callback for CPU
+    0 .. N-1 is invoked to rollback the operation, the function fails and
+    the instance is not added to the node list of the multi-instance state.
+
+To remove an instance from the state's node list these functions are
+available:
+
+  * cpuhp_state_remove_instance(state, node)
+  * cpuhp_state_remove_instance_nocalls(state, node)
+
+The arguments are the same as for the the cpuhp_state_add_instance*()
+variants above.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_state_remove_instance_nocalls() only removes the instance from the
+    state's node list.
+
+  * cpuhp_state_remove_instance() removes the instance and invokes the
+    teardown callback (if not NULL) associated with @state for all online
+    CPUs which have currently a state greater than @state.  The callback is
+    only invoked for the to be removed instance.  Depending on the state
+    section the callback is either invoked on the current CPU (PREPARE
+    section) or on each online CPU (ONLINE section) in the context of the
+    CPU's hotplug thread.
+
+    In order to complete the removal, the teardown callback should not fail.
+
+The node list add/remove operations and the callback invocations are
+serialized against CPU hotplug operations. These functions cannot be used
+from within CPU hotplug callbacks and CPU hotplug read locked regions.
+
+Examples
+--------
+
+Setup and teardown a statically allocated state in the STARTING section for
+notifications on online and offline operations::
+
+   ret =3D cpuhp_setup_state(CPUHP_SUBSYS_STARTING, "subsys:starting", subsy=
s_cpu_starting, subsys_cpu_dying);
+   if (ret < 0)
+        return ret;
+   ....
+   cpuhp_remove_state(CPUHP_SUBSYS_STARTING);
+
+Setup and teardown a dynamically allocated state in the ONLINE section
+for notifications on offline operations::
+
+   state =3D cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, sub=
sys_cpu_offline);
+   if (state < 0)
+       return state;
+   ....
+   cpuhp_remove_state(state);
+
+Setup and teardown a dynamically allocated state in the ONLINE section
+for notifications on online operations without invoking the callbacks::
+
+   state =3D cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", su=
bsys_cpu_online, NULL);
+   if (state < 0)
+       return state;
+   ....
+   cpuhp_remove_state_nocalls(state);
+
+Setup, use and teardown a dynamically allocated multi-instance state in the
+ONLINE section for notifications on online and offline operation::
+
+   state =3D cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", subs=
ys_cpu_online, subsys_cpu_offline);
+   if (state < 0)
+       return state;
+   ....
+   ret =3D cpuhp_state_add_instance(state, &inst1->node);
+   if (ret)
+        return ret;
+   ....
+   ret =3D cpuhp_state_add_instance(state, &inst2->node);
+   if (ret)
+        return ret;
+   ....
+   cpuhp_remove_instance(state, &inst1->node);
+   ....
+   cpuhp_remove_instance(state, &inst2->node);
+   ....
+   remove_multi_state(state);
+
=20
 Testing of hotplug states
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 39cf84a..832d8a7 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -22,8 +22,42 @@
  *              AP_ACTIVE			AP_ACTIVE
  */
=20
+/*
+ * CPU hotplug states. The state machine invokes the installed state
+ * startup callbacks sequentially from CPUHP_OFFLINE + 1 to CPUHP_ONLINE
+ * during a CPU online operation. During a CPU offline operation the
+ * installed teardown callbacks are invoked in the reverse order from
+ * CPU_ONLINE - 1 down to CPUHP_OFFLINE.
+ *
+ * The state space has three sections: PREPARE, STARTING and ONLINE.
+ *
+ * PREPARE: The callbacks are invoked on a control CPU before the
+ * hotplugged CPU is started up or after the hotplugged CPU has died.
+ *
+ * STARTING: The callbacks are invoked on the hotplugged CPU from the low le=
vel
+ * hotplug startup/teardown code with interrupts disabled.
+ *
+ * ONLINE: The callbacks are invoked on the hotplugged CPU from the per CPU
+ * hotplug thread with interrupts and preemption enabled.
+ *
+ * Adding explicit states to this enum is only necessary when:
+ *
+ * 1) The state is within the STARTING section
+ *
+ * 2) The state has ordering constraints vs. other states in the
+ *    same section.
+ *
+ * If neither #1 nor #2 apply, please use the dynamic state space when
+ * setting up a state by using CPUHP_PREPARE_DYN or CPUHP_PREPARE_ONLINE
+ * for the @state argument of the setup function.
+ *
+ * See Documentation/core-api/cpu_hotplug.rst for further information and
+ * examples.
+ */
 enum cpuhp_state {
 	CPUHP_INVALID =3D -1,
+
+	/* PREPARE section invoked on a control CPU */
 	CPUHP_OFFLINE =3D 0,
 	CPUHP_CREATE_THREADS,
 	CPUHP_PERF_PREPARE,
@@ -95,6 +129,11 @@ enum cpuhp_state {
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
 	CPUHP_BRINGUP_CPU,
+
+	/*
+	 * STARTING section invoked on the hotplugged CPU in low level
+	 * bringup and teardown code.
+	 */
 	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_SCHED_STARTING,
@@ -155,6 +194,8 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
+
+	/* Online section invoked on the hotplugged CPU from the hotplug thread */
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
@@ -216,14 +257,15 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state sta=
te, const char *name,
 				   int (*teardown)(unsigned int cpu),
 				   bool multi_instance);
 /**
- * cpuhp_setup_state - Setup hotplug state callbacks with calling the callba=
cks
+ * cpuhp_setup_state - Setup hotplug state callbacks with calling the @start=
up
+ *                     callback
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback (will be used in debug output)
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
- * Installs the callback functions and invokes the startup callback on
- * the present cpus which have already reached the @state.
+ * Installs the callback functions and invokes the @startup callback on
+ * the online cpus which have already reached the @state.
  */
 static inline int cpuhp_setup_state(enum cpuhp_state state,
 				    const char *name,
@@ -233,6 +275,18 @@ static inline int cpuhp_setup_state(enum cpuhp_state sta=
te,
 	return __cpuhp_setup_state(state, name, true, startup, teardown, false);
 }
=20
+/**
+ * cpuhp_setup_state_cpuslocked - Setup hotplug state callbacks with calling
+ *				  @startup callback from a cpus_read_lock()
+ *				  held region
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback (will be used in debug output)
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
+ *
+ * Same as cpuhp_setup_state() except that it must be invoked from within a
+ * cpus_read_lock() held region.
+ */
 static inline int cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 					       const char *name,
 					       int (*startup)(unsigned int cpu),
@@ -244,14 +298,14 @@ static inline int cpuhp_setup_state_cpuslocked(enum cpu=
hp_state state,
=20
 /**
  * cpuhp_setup_state_nocalls - Setup hotplug state callbacks without calling=
 the
- *			       callbacks
+ *			       @startup callback
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback.
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
- * Same as @cpuhp_setup_state except that no calls are executed are invoked
- * during installation of this callback. NOP if SMP=3Dn or HOTPLUG_CPU=3Dn.
+ * Same as cpuhp_setup_state() except that the @startup callback is not
+ * invoked during installation. NOP if SMP=3Dn or HOTPLUG_CPU=3Dn.
  */
 static inline int cpuhp_setup_state_nocalls(enum cpuhp_state state,
 					    const char *name,
@@ -262,6 +316,19 @@ static inline int cpuhp_setup_state_nocalls(enum cpuhp_s=
tate state,
 				   false);
 }
=20
+/**
+ * cpuhp_setup_state_nocalls_cpuslocked - Setup hotplug state callbacks with=
out
+ *					  invoking the @startup callback from
+ *					  a cpus_read_lock() held region
+ *			       callbacks
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback.
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
+ *
+ * Same as cpuhp_setup_state_nocalls() except that it must be invoked from
+ * within a cpus_read_lock() held region.
+ */
 static inline int cpuhp_setup_state_nocalls_cpuslocked(enum cpuhp_state stat=
e,
 						     const char *name,
 						     int (*startup)(unsigned int cpu),
@@ -275,13 +342,13 @@ static inline int cpuhp_setup_state_nocalls_cpuslocked(=
enum cpuhp_state state,
  * cpuhp_setup_state_multi - Add callbacks for multi state
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback.
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
  * Sets the internal multi_instance flag and prepares a state to work as a m=
ulti
  * instance callback. No callbacks are invoked at this point. The callbacks =
are
  * invoked once an instance for this state are registered via
- * @cpuhp_state_add_instance or @cpuhp_state_add_instance_nocalls.
+ * cpuhp_state_add_instance() or cpuhp_state_add_instance_nocalls()
  */
 static inline int cpuhp_setup_state_multi(enum cpuhp_state state,
 					  const char *name,
@@ -306,9 +373,10 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_sta=
te state,
  * @state:	The state for which the instance is installed
  * @node:	The node for this individual state.
  *
- * Installs the instance for the @state and invokes the startup callback on
- * the present cpus which have already reached the @state. The @state must h=
ave
- * been earlier marked as multi-instance by @cpuhp_setup_state_multi.
+ * Installs the instance for the @state and invokes the registered startup
+ * callback on the online cpus which have already reached the @state. The
+ * @state must have been earlier marked as multi-instance by
+ * cpuhp_setup_state_multi().
  */
 static inline int cpuhp_state_add_instance(enum cpuhp_state state,
 					   struct hlist_node *node)
@@ -322,8 +390,9 @@ static inline int cpuhp_state_add_instance(enum cpuhp_sta=
te state,
  * @state:	The state for which the instance is installed
  * @node:	The node for this individual state.
  *
- * Installs the instance for the @state The @state must have been earlier
- * marked as multi-instance by @cpuhp_setup_state_multi.
+ * Installs the instance for the @state. The @state must have been earlier
+ * marked as multi-instance by cpuhp_setup_state_multi. NOP if SMP=3Dn or
+ * HOTPLUG_CPU=3Dn.
  */
 static inline int cpuhp_state_add_instance_nocalls(enum cpuhp_state state,
 						   struct hlist_node *node)
@@ -331,6 +400,17 @@ static inline int cpuhp_state_add_instance_nocalls(enum =
cpuhp_state state,
 	return __cpuhp_state_add_instance(state, node, false);
 }
=20
+/**
+ * cpuhp_state_add_instance_nocalls_cpuslocked - Add an instance for a state
+ *						 without invoking the startup
+ *						 callback from a cpus_read_lock()
+ *						 held region.
+ * @state:	The state for which the instance is installed
+ * @node:	The node for this individual state.
+ *
+ * Same as cpuhp_state_add_instance_nocalls() except that it must be
+ * invoked from within a cpus_read_lock() held region.
+ */
 static inline int
 cpuhp_state_add_instance_nocalls_cpuslocked(enum cpuhp_state state,
 					    struct hlist_node *node)
@@ -346,7 +426,7 @@ void __cpuhp_remove_state_cpuslocked(enum cpuhp_state sta=
te, bool invoke);
  * @state:	The state for which the calls are removed
  *
  * Removes the callback functions and invokes the teardown callback on
- * the present cpus which have already reached the @state.
+ * the online cpus which have already reached the @state.
  */
 static inline void cpuhp_remove_state(enum cpuhp_state state)
 {
@@ -355,7 +435,7 @@ static inline void cpuhp_remove_state(enum cpuhp_state st=
ate)
=20
 /**
  * cpuhp_remove_state_nocalls - Remove hotplug state callbacks without invok=
ing
- *				teardown
+ *				the teardown callback
  * @state:	The state for which the calls are removed
  */
 static inline void cpuhp_remove_state_nocalls(enum cpuhp_state state)
@@ -363,6 +443,14 @@ static inline void cpuhp_remove_state_nocalls(enum cpuhp=
_state state)
 	__cpuhp_remove_state(state, false);
 }
=20
+/**
+ * cpuhp_remove_state_nocalls_cpuslocked - Remove hotplug state callbacks wi=
thout invoking
+ *					   teardown from a cpus_read_lock() held region.
+ * @state:	The state for which the calls are removed
+ *
+ * Same as cpuhp_remove_state nocalls() except that it must be invoked
+ * from within a cpus_read_lock() held region.
+ */
 static inline void cpuhp_remove_state_nocalls_cpuslocked(enum cpuhp_state st=
ate)
 {
 	__cpuhp_remove_state_cpuslocked(state, false);
@@ -390,8 +478,8 @@ int __cpuhp_state_remove_instance(enum cpuhp_state state,
  * @state:	The state from which the instance is removed
  * @node:	The node for this individual state.
  *
- * Removes the instance and invokes the teardown callback on the present cpus
- * which have already reached the @state.
+ * Removes the instance and invokes the teardown callback on the online cpus
+ * which have already reached @state.
  */
 static inline int cpuhp_state_remove_instance(enum cpuhp_state state,
 					      struct hlist_node *node)
