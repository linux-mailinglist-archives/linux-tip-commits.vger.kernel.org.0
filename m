Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745821CB0E0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEHNrP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728282AbgEHNqk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:46:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7FC05BD43;
        Fri,  8 May 2020 06:46:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kn-0001nu-RY; Fri, 08 May 2020 15:46:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A36681C0493;
        Fri,  8 May 2020 15:46:36 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:36 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Update Documentation/dev-tools/kcsan.rst
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559654.8414.11668659442200987775.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     e7325b774cc72edc2cffc4a1ce40f4dbf1bc0930
Gitweb:        https://git.kernel.org/tip/e7325b774cc72edc2cffc4a1ce40f4dbf1bc0930
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 05 Mar 2020 15:21:08 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 25 Mar 2020 09:56:00 -07:00

kcsan: Update Documentation/dev-tools/kcsan.rst

Extend and improve based on recent changes, and summarize important
bits that have been missing. Tested with "make htmldocs".

Signed-off-by: Marco Elver <elver@google.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 227 ++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 83 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 65a0be5..52a5d6f 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,27 +1,22 @@
 The Kernel Concurrency Sanitizer (KCSAN)
 ========================================
 
-Overview
---------
-
-*Kernel Concurrency Sanitizer (KCSAN)* is a dynamic data race detector for
-kernel space. KCSAN is a sampling watchpoint-based data race detector. Key
-priorities in KCSAN's design are lack of false positives, scalability, and
-simplicity. More details can be found in `Implementation Details`_.
-
-KCSAN uses compile-time instrumentation to instrument memory accesses. KCSAN is
-supported in both GCC and Clang. With GCC it requires version 7.3.0 or later.
-With Clang it requires version 7.0.0 or later.
+The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector, which
+relies on compile-time instrumentation, and uses a watchpoint-based sampling
+approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 
 Usage
 -----
 
-To enable KCSAN configure kernel with::
+KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0 or
+later. With Clang it requires version 7.0.0 or later.
+
+To enable KCSAN configure the kernel with::
 
     CONFIG_KCSAN = y
 
 KCSAN provides several other configuration options to customize behaviour (see
-their respective help text for more info).
+the respective help text in ``lib/Kconfig.kcsan`` for more info).
 
 Error reports
 ~~~~~~~~~~~~~
@@ -96,7 +91,8 @@ The other less common type of data race report looks like this::
 This report is generated where it was not possible to determine the other
 racing thread, but a race was inferred due to the data value of the watched
 memory location having changed. These can occur either due to missing
-instrumentation or e.g. DMA accesses.
+instrumentation or e.g. DMA accesses. These reports will only be generated if
+``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` (selected by default).
 
 Selective analysis
 ~~~~~~~~~~~~~~~~~~
@@ -110,9 +106,26 @@ the below options are available:
   behaviour when encountering a data race is deemed safe.
 
 * Disabling data race detection for entire functions can be accomplished by
-  using the function attribute ``__no_kcsan`` (or ``__no_kcsan_or_inline`` for
-  ``__always_inline`` functions). To dynamically control for which functions
-  data races are reported, see the `debugfs`_ blacklist/whitelist feature.
+  using the function attribute ``__no_kcsan``::
+
+    __no_kcsan
+    void foo(void) {
+        ...
+
+  To dynamically limit for which functions to generate reports, see the
+  `DebugFS interface`_ blacklist/whitelist feature.
+
+  For ``__always_inline`` functions, replace ``__always_inline`` with
+  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
+
+    static __no_kcsan_or_inline void foo(void) {
+        ...
+
+  Note: Older compiler versions (GCC < 9) also do not always honor the
+  ``__no_kcsan`` attribute on regular ``inline`` functions. If false positives
+  with these compilers cannot be tolerated, for small functions where
+  ``__always_inline`` would be appropriate, ``__no_kcsan_or_inline`` should be
+  preferred instead.
 
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
@@ -124,13 +137,29 @@ the below options are available:
 
     KCSAN_SANITIZE := n
 
-debugfs
-~~~~~~~
+Furthermore, it is possible to tell KCSAN to show or hide entire classes of
+data races, depending on preferences. These can be changed via the following
+Kconfig options:
+
+* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: If enabled and a conflicting write
+  is observed via a watchpoint, but the data value of the memory location was
+  observed to remain unchanged, do not report the data race.
+
+* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: Assume that plain aligned writes
+  up to word size are atomic by default. Assumes that such writes are not
+  subject to unsafe compiler optimizations resulting in data races. The option
+  causes KCSAN to not report data races due to conflicts where the only plain
+  accesses are aligned writes up to word size.
+
+DebugFS interface
+~~~~~~~~~~~~~~~~~
+
+The file ``/sys/kernel/debug/kcsan`` provides the following interface:
 
-* The file ``/sys/kernel/debug/kcsan`` can be read to get stats.
+* Reading ``/sys/kernel/debug/kcsan`` returns various runtime statistics.
 
-* KCSAN can be turned on or off by writing ``on`` or ``off`` to
-  ``/sys/kernel/debug/kcsan``.
+* Writing ``on`` or ``off`` to ``/sys/kernel/debug/kcsan`` allows turning KCSAN
+  on or off, respectively.
 
 * Writing ``!some_func_name`` to ``/sys/kernel/debug/kcsan`` adds
   ``some_func_name`` to the report filter list, which (by default) blacklists
@@ -142,91 +171,120 @@ debugfs
   can be used to silence frequently occurring data races; the whitelist feature
   can help with reproduction and testing of fixes.
 
+Tuning performance
+~~~~~~~~~~~~~~~~~~
+
+Core parameters that affect KCSAN's overall performance and bug detection
+ability are exposed as kernel command-line arguments whose defaults can also be
+changed via the corresponding Kconfig options.
+
+* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): Number of per-CPU memory
+  operations to skip, before another watchpoint is set up. Setting up
+  watchpoints more frequently will result in the likelihood of races to be
+  observed to increase. This parameter has the most significant impact on
+  overall system performance and race detection ability.
+
+* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): For tasks, the
+  microsecond delay to stall execution after a watchpoint has been set up.
+  Larger values result in the window in which we may observe a race to
+  increase.
+
+* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): For
+  interrupts, the microsecond delay to stall execution after a watchpoint has
+  been set up. Interrupts have tighter latency requirements, and their delay
+  should generally be smaller than the one chosen for tasks.
+
+They may be tweaked at runtime via ``/sys/module/kcsan/parameters/``.
+
 Data Races
 ----------
 
-Informally, two operations *conflict* if they access the same memory location,
-and at least one of them is a write operation. In an execution, two memory
-operations from different threads form a **data race** if they *conflict*, at
-least one of them is a *plain access* (non-atomic), and they are *unordered* in
-the "happens-before" order according to the `LKMM
-<../../tools/memory-model/Documentation/explanation.txt>`_.
+In an execution, two memory accesses form a *data race* if they *conflict*,
+they happen concurrently in different threads, and at least one of them is a
+*plain access*; they *conflict* if both access the same memory location, and at
+least one is a write. For a more thorough discussion and definition, see `"Plain
+Accesses and Data Races" in the LKMM`_.
+
+.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1922
 
-Relationship with the Linux Kernel Memory Model (LKMM)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Relationship with the Linux-Kernel Memory Consistency Model (LKMM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The LKMM defines the propagation and ordering rules of various memory
 operations, which gives developers the ability to reason about concurrent code.
 Ultimately this allows to determine the possible executions of concurrent code,
 and if that code is free from data races.
 
-KCSAN is aware of *atomic* accesses (``READ_ONCE``, ``WRITE_ONCE``,
-``atomic_*``, etc.), but is oblivious of any ordering guarantees. In other
-words, KCSAN assumes that as long as a plain access is not observed to race
-with another conflicting access, memory operations are correctly ordered.
+KCSAN is aware of *marked atomic operations* (``READ_ONCE``, ``WRITE_ONCE``,
+``atomic_*``, etc.), but is oblivious of any ordering guarantees and simply
+assumes that memory barriers are placed correctly. In other words, KCSAN
+assumes that as long as a plain access is not observed to race with another
+conflicting access, memory operations are correctly ordered.
 
 This means that KCSAN will not report *potential* data races due to missing
-memory ordering. If, however, missing memory ordering (that is observable with
-a particular compiler and architecture) leads to an observable data race (e.g.
-entering a critical section erroneously), KCSAN would report the resulting
-data race.
-
-Race conditions vs. data races
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Race conditions are logic bugs, where unexpected interleaving of racing
-concurrent operations result in an erroneous state.
-
-Data races on the other hand are defined at the *memory model/language level*.
-Many data races are also harmful race conditions, which a tool like KCSAN
-reports!  However, not all data races are race conditions and vice-versa.
-KCSAN's intent is to report data races according to the LKMM. A data race
-detector can only work at the memory model/language level.
-
-Deeper analysis, to find high-level race conditions only, requires conveying
-the intended kernel logic to a tool. This requires (1) the developer writing a
-specification or model of their code, and then (2) the tool verifying that the
-implementation matches. This has been done for small bits of code using model
-checkers and other formal methods, but does not scale to the level of what can
-be covered with a dynamic analysis based data race detector such as KCSAN.
-
-For reasons outlined in this `article <https://lwn.net/Articles/793253/>`_,
-data races can be much more subtle, but can cause no less harm than high-level
-race conditions.
+memory ordering. Developers should therefore carefully consider the required
+memory ordering requirements that remain unchecked. If, however, missing
+memory ordering (that is observable with a particular compiler and
+architecture) leads to an observable data race (e.g. entering a critical
+section erroneously), KCSAN would report the resulting data race.
+
+Race Detection Beyond Data Races
+--------------------------------
+
+For code with complex concurrency design, race-condition bugs may not always
+manifest as data races. Race conditions occur if concurrently executing
+operations result in unexpected system behaviour. On the other hand, data races
+are defined at the C-language level. The following macros can be used to check
+properties of concurrent code where bugs would not manifest as data races.
+
+.. kernel-doc:: include/linux/kcsan-checks.h
+    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_ACCESS
+                ASSERT_EXCLUSIVE_BITS
 
 Implementation Details
 ----------------------
 
-The general approach is inspired by `DataCollider
+KCSAN relies on observing that two accesses happen concurrently. Crucially, we
+want to (a) increase the chances of observing races (especially for races that
+manifest rarely), and (b) be able to actually observe them. We can accomplish
+(a) by injecting various delays, and (b) by using address watchpoints (or
+breakpoints).
+
+If we deliberately stall a memory access, while we have a watchpoint for its
+address set up, and then observe the watchpoint to fire, two accesses to the
+same address just raced. Using hardware watchpoints, this is the approach taken
+in `DataCollider
 <http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>`_.
 Unlike DataCollider, KCSAN does not use hardware watchpoints, but instead
-relies on compiler instrumentation. Watchpoints are implemented using an
-efficient encoding that stores access type, size, and address in a long; the
-benefits of using "soft watchpoints" are portability and greater flexibility in
-limiting which accesses trigger a watchpoint.
+relies on compiler instrumentation and "soft watchpoints".
 
-More specifically, KCSAN requires instrumenting plain (unmarked, non-atomic)
-memory operations; for each instrumented plain access:
+In KCSAN, watchpoints are implemented using an efficient encoding that stores
+access type, size, and address in a long; the benefits of using "soft
+watchpoints" are portability and greater flexibility. KCSAN then relies on the
+compiler instrumenting plain accesses. For each instrumented plain access:
 
 1. Check if a matching watchpoint exists; if yes, and at least one access is a
    write, then we encountered a racing access.
 
 2. Periodically, if no matching watchpoint exists, set up a watchpoint and
-   stall for a small delay.
+   stall for a small randomized delay.
 
 3. Also check the data value before the delay, and re-check the data value
    after delay; if the values mismatch, we infer a race of unknown origin.
 
-To detect data races between plain and atomic memory operations, KCSAN also
-annotates atomic accesses, but only to check if a watchpoint exists
-(``kcsan_check_atomic_*``); i.e.  KCSAN never sets up a watchpoint on atomic
-accesses.
+To detect data races between plain and marked accesses, KCSAN also annotates
+marked accesses, but only to check if a watchpoint exists; i.e. KCSAN never
+sets up a watchpoint on marked accesses. By never setting up watchpoints for
+marked operations, if all accesses to a variable that is accessed concurrently
+are properly marked, KCSAN will never trigger a watchpoint and therefore never
+report the accesses.
 
 Key Properties
 ~~~~~~~~~~~~~~
 
-1. **Memory Overhead:**  The current implementation uses a small array of longs
-   to encode watchpoint information, which is negligible.
+1. **Memory Overhead:**  The overall memory overhead is only a few MiB
+   depending on configuration. The current implementation uses a small array of
+   longs to encode watchpoint information, which is negligible.
 
 2. **Performance Overhead:** KCSAN's runtime aims to be minimal, using an
    efficient watchpoint encoding that does not require acquiring any shared
@@ -253,14 +311,17 @@ Key Properties
 Alternatives Considered
 -----------------------
 
-An alternative data race detection approach for the kernel can be found in
+An alternative data race detection approach for the kernel can be found in the
 `Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
 KTSAN is a happens-before data race detector, which explicitly establishes the
 happens-before order between memory operations, which can then be used to
-determine data races as defined in `Data Races`_. To build a correct
-happens-before relation, KTSAN must be aware of all ordering rules of the LKMM
-and synchronization primitives. Unfortunately, any omission leads to false
-positives, which is especially important in the context of the kernel which
-includes numerous custom synchronization mechanisms. Furthermore, KTSAN's
-implementation requires metadata for each memory location (shadow memory);
-currently, for each page, KTSAN requires 4 pages of shadow memory.
+determine data races as defined in `Data Races`_.
+
+To build a correct happens-before relation, KTSAN must be aware of all ordering
+rules of the LKMM and synchronization primitives. Unfortunately, any omission
+leads to large numbers of false positives, which is especially detrimental in
+the context of the kernel which includes numerous custom synchronization
+mechanisms. To track the happens-before relation, KTSAN's implementation
+requires metadata for each memory location (shadow memory), which for each page
+corresponds to 4 pages of shadow memory, and can translate into overhead of
+tens of GiB on a large system.
