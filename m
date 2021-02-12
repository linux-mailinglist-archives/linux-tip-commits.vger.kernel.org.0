Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D00319EDF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBLMnC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhBLMkh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:37 -0500
Date:   Fri, 12 Feb 2021 12:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ozv3NwoPzkn0OJJbLb0miU7RFy9mVdOOI1FZFXfQXwQ=;
        b=df9JPgxjcUb7k2E1vZKgRpLgUiaBinBBvfr8FZHi9d3hbQ1e4ZGwkx9rrskIqVrs994hcN
        cj9QVyookY6hdm20ra1O822Gdk2PAJJmDM5utnCOlanog5zI399YEjoGMm2y0Xj3QCnEeU
        okLpgkDfyXD//r8xJ6KNyPM/DbuiGiwUia2nv+wl3o/tgFz2ipbEDhlguGT/eNLCQtOrDB
        HzFzyi/IydvnXInskJRRyNY82qSpmCglmOwkPG+tzjfu8O2RNaQe5aJv/4JnEYGCSXNXlM
        R6qfiYblQMHG/n5O8yEodfUtL77fA+g7IaYeA7LJ1T0x3HSoS7aDxe7gdMM94g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ozv3NwoPzkn0OJJbLb0miU7RFy9mVdOOI1FZFXfQXwQ=;
        b=CupfuHAimt+1mC3Nrl7P3EufO+0emo8PnY9OJWBmJMquOnzzYFNg9/04K5Pb5oATyHanAF
        5BB9w8wxtHdWRpDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Use CONFIG_PREEMPTION
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344248.23325.3227545792428716538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     81ad58be2f83f9bd675f67ca5b8f420358ddf13c
Gitweb:        https://git.kernel.org/tip/81ad58be2f83f9bd675f67ca5b8f420358d=
df13c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 15:16:49 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:10:44 -08:00

doc: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the documents and mention CONFIG_PREEMPTION. Spell out
CONFIG_PREEMPT_RT (instead PREEMPT_RT) since it is an option now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst=
 |  4 ++--
 Documentation/RCU/Design/Requirements/Requirements.rst                      =
 | 22 +++++++++++-----------
 Documentation/RCU/checklist.rst                                             =
 |  2 +-
 Documentation/RCU/rcubarrier.rst                                            =
 |  6 +++---
 Documentation/RCU/stallwarn.rst                                             =
 |  4 ++--
 Documentation/RCU/whatisRCU.rst                                             =
 | 10 +++++-----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace=
-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Gra=
ce-Periods.rst
index 72f0f6f..6f89cf1 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Period=
s.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Period=
s.rst
@@ -38,7 +38,7 @@ sections.
 RCU-preempt Expedited Grace Periods
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-``CONFIG_PREEMPT=3Dy`` kernels implement RCU-preempt.
+``CONFIG_PREEMPTION=3Dy`` kernels implement RCU-preempt.
 The overall flow of the handling of a given CPU by an RCU-preempt
 expedited grace period is shown in the following diagram:
=20
@@ -112,7 +112,7 @@ things.
 RCU-sched Expedited Grace Periods
 ---------------------------------
=20
-``CONFIG_PREEMPT=3Dn`` kernels implement RCU-sched. The overall flow of
+``CONFIG_PREEMPTION=3Dn`` kernels implement RCU-sched. The overall flow of
 the handling of a given CPU by an RCU-sched expedited grace period is
 shown in the following diagram:
=20
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index bac1cdd..42a81e3 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -78,7 +78,7 @@ RCU treats a nested set as one big RCU read-side critical s=
ection.
 Production-quality implementations of rcu_read_lock() and
 rcu_read_unlock() are extremely lightweight, and in fact have
 exactly zero overhead in Linux kernels built for production use with
-``CONFIG_PREEMPT=3Dn``.
+``CONFIG_PREEMPTION=3Dn``.
=20
 This guarantee allows ordering to be enforced with extremely low
 overhead to readers, for example:
@@ -1181,7 +1181,7 @@ and has become decreasingly so as memory sizes have exp=
anded and memory
 costs have plummeted. However, as I learned from Matt Mackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
-non-preemptible (``CONFIG_PREEMPT=3Dn``) kernels, and thus `tiny
+non-preemptible (``CONFIG_PREEMPTION=3Dn``) kernels, and thus `tiny
 RCU <https://lore.kernel.org/r/20090113221724.GA15307@linux.vnet.ibm.com>`__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
@@ -1497,7 +1497,7 @@ limitations.
=20
 Implementations of RCU for which rcu_read_lock() and
 rcu_read_unlock() generate no code, such as Linux-kernel RCU when
-``CONFIG_PREEMPT=3Dn``, can be nested arbitrarily deeply. After all, there
+``CONFIG_PREEMPTION=3Dn``, can be nested arbitrarily deeply. After all, there
 is no overhead. Except that if all these instances of
 rcu_read_lock() and rcu_read_unlock() are visible to the
 compiler, compilation will eventually fail due to exhausting memory,
@@ -1769,7 +1769,7 @@ implementation can be a no-op.
=20
 However, once the scheduler has spawned its first kthread, this early
 boot trick fails for synchronize_rcu() (as well as for
-synchronize_rcu_expedited()) in ``CONFIG_PREEMPT=3Dy`` kernels. The
+synchronize_rcu_expedited()) in ``CONFIG_PREEMPTION=3Dy`` kernels. The
 reason is that an RCU read-side critical section might be preempted,
 which means that a subsequent synchronize_rcu() really does have to
 wait for something, as opposed to simply returning immediately.
@@ -2038,7 +2038,7 @@ the following:
        5 rcu_read_unlock();
        6 do_something_with(v, user_v);
=20
-If the compiler did make this transformation in a ``CONFIG_PREEMPT=3Dn`` ker=
nel
+If the compiler did make this transformation in a ``CONFIG_PREEMPTION=3Dn`` =
kernel
 build, and if get_user() did page fault, the result would be a quiescent
 state in the middle of an RCU read-side critical section.  This misplaced
 quiescent state could result in line 4 being a use-after-free access,
@@ -2320,7 +2320,7 @@ conjunction with the `-rt
 patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
-is inappropriate. Kernels built with ``CONFIG_PREEMPT=3Dy`` therefore use
+is inappropriate. Kernels built with ``CONFIG_PREEMPTION=3Dy`` therefore use
 an RCU implementation that allows RCU read-side critical sections to be
 preempted. This requirement made its presence known after users made it
 clear that an earlier `real-time
@@ -2460,11 +2460,11 @@ not have this property, given that any point in the c=
ode outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows =E2=80=9Cclassic=E2=80=9D RCU in that=
 an
 RCU-sched grace period waits for pre-existing interrupt and NMI
-handlers. In kernels built with ``CONFIG_PREEMPT=3Dn``, the RCU and
+handlers. In kernels built with ``CONFIG_PREEMPTION=3Dn``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
-``CONFIG_PREEMPT=3Dy`` provide a separate implementation for each.
+``CONFIG_PREEMPTION=3Dy`` provide a separate implementation for each.
=20
-Note well that in ``CONFIG_PREEMPT=3Dy`` kernels,
+Note well that in ``CONFIG_PREEMPTION=3Dy`` kernels,
 rcu_read_lock_sched() and rcu_read_unlock_sched() disable and
 re-enable preemption, respectively. This means that if there was a
 preemption attempt during the RCU-sched read-side critical section,
@@ -2627,10 +2627,10 @@ userspace execution also delimit tasks-RCU read-side =
critical sections.
=20
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
-rcu_barrier_tasks(). In ``CONFIG_PREEMPT=3Dn`` kernels, trampolines
+rcu_barrier_tasks(). In ``CONFIG_PREEMPTION=3Dn`` kernels, trampolines
 cannot be preempted, so these APIs map to call_rcu(),
 synchronize_rcu(), and rcu_barrier(), respectively. In
-``CONFIG_PREEMPT=3Dy`` kernels, trampolines can be preempted, and these
+``CONFIG_PREEMPTION=3Dy`` kernels, trampolines can be preempted, and these
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
=20
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2d1dc1d..1030119 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -212,7 +212,7 @@ over a rather long period of time, but improvements are a=
lways welcome!
 	the rest of the system.
=20
 7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPT=3Dn and RCU-preempt for PREEMPT=3Dy.
+	which is RCU-sched for PREEMPTION=3Dn and RCU-preempt for PREEMPTION=3Dy.
 	If the updater uses call_rcu() or synchronize_rcu(),
 	then the corresponding readers may use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.=
rst
index f64f441..3b4a248 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -9,7 +9,7 @@ RCU (read-copy update) is a synchronization mechanism that ca=
n be thought
 of as a replacement for read-writer locking (among other things), but with
 very low-overhead readers that are immune to deadlock, priority inversion,
 and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPT
+by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPTION
 kernels, generate no code whatsoever.
=20
 This means that RCU writers are unaware of the presence of concurrent
@@ -329,10 +329,10 @@ Answer: This cannot happen. The reason is that on_each_=
cpu() has its last
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of
 	rcu_barrier_func() has completed. This by itself would prevent
-	a grace period from completing on non-CONFIG_PREEMPT kernels,
+	a grace period from completing on non-CONFIG_PREEMPTION kernels,
 	since each CPU must undergo a context switch (or other quiescent
 	state) before the grace period can complete. However, this is
-	of no use in CONFIG_PREEMPT kernels.
+	of no use in CONFIG_PREEMPTION kernels.
=20
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index c9ab6af..e97d1b4 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -25,7 +25,7 @@ warnings:
=20
 -	A CPU looping with bottom halves disabled.
=20
--	For !CONFIG_PREEMPT kernels, a CPU looping anywhere in the kernel
+-	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
 	without invoking schedule().  If the looping in the kernel is
 	really expected and desirable behavior, you might need to add
 	some calls to cond_resched().
@@ -44,7 +44,7 @@ warnings:
 	result in the ``rcu_.*kthread starved for`` console-log message,
 	which will include additional debugging information.
=20
--	A CPU-bound real-time task in a CONFIG_PREEMPT kernel, which might
+-	A CPU-bound real-time task in a CONFIG_PREEMPTION kernel, which might
 	happen to preempt a low-priority task in the middle of an RCU
 	read-side critical section.   This is especially damaging if
 	that low-priority task is not permitted to run on any other CPU,
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 1a4723f..17e95ab 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -683,7 +683,7 @@ Quick Quiz #1:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
-on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
+on features such as hotplug CPU and the ability to run in CONFIG_PREEMPTION
 kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
 are the same as those shown in the preceding section, so they are omitted.
 ::
@@ -739,7 +739,7 @@ Quick Quiz #2:
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 :ref:`Answers to Quick Quiz <8_whatisRCU>`
=20
@@ -1093,7 +1093,7 @@ Quick Quiz #2:
 		overhead is **negative**.
=20
 Answer:
-		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+		Imagine a single-CPU system with a non-CONFIG_PREEMPTION
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1120,10 +1120,10 @@ Answer:
 Quick Quiz #3:
 		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
-		PREEMPT_RT, where normal spinlocks can block???
+		CONFIG_PREEMPT_RT, where normal spinlocks can block???
=20
 Answer:
-		Just as PREEMPT_RT permits preemption of spinlock
+		Just as CONFIG_PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
