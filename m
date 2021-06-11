Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEACD3A3C41
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jun 2021 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhFKGw1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Jun 2021 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKGw1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Jun 2021 02:52:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26CC061574;
        Thu, 10 Jun 2021 23:50:29 -0700 (PDT)
Date:   Fri, 11 Jun 2021 06:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623394227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/3ijfI0m4vjm7GjxRYP7/U0ntdeDWf6I0SAXewBi8k=;
        b=uuO8Raocl7Xuzf+bi5rYvO9h39ohu2b//jpACI8rHK1ar/wQ/dU7DkP7hjJcey6ZZgLDwy
        7LWPkkP5r2Zd7ebP/lB+70KxVIOkB+1ptUToLjKbMN2cnD8qLEBBiNaejTbtpSA0dYczFO
        JTNJaKA2737ULMG8xiOAo0BS1P3eWbzUrd+tq444Bv0Iimai0kvpLLchIwN+pgMCf8xykU
        xnpcwhL/khSsnxJ5J/5DgougUOWp7xSNxaLiNqiuWYWqB6BK7okmTcF4DmbJ309GAqzGAu
        019TVgStfUD2mUTTuuiAtIArLjG4+b74jfJlrVXu7K7hAPRgFOLO3ev6Ca0DAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623394227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/3ijfI0m4vjm7GjxRYP7/U0ntdeDWf6I0SAXewBi8k=;
        b=4PIK+jCGCE6ORUjIhmKOZt9/WEsCz/TzEkwZMmhQz3Pk3SB6s++JeodBplpP5EFas+0B9c
        At1MZ7kU2wghnxDQ==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] Documentation: Add usecases, design and interface
 for core scheduling
Cc:     Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603013136.370918-1-joel@joelfernandes.org>
References: <20210603013136.370918-1-joel@joelfernandes.org>
MIME-Version: 1.0
Message-ID: <162339422621.19906.1506020937520475581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0159bb020ca9a43b17aa9149f1199643c1d49426
Gitweb:        https://git.kernel.org/tip/0159bb020ca9a43b17aa9149f1199643c1d49426
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Wed, 02 Jun 2021 21:31:36 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Jun 2021 09:57:09 +02:00

Documentation: Add usecases, design and interface for core scheduling

Now that core scheduling is merged, update the documentation.

Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210603013136.370918-1-joel@joelfernandes.org
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 223 +++++++++-
 Documentation/admin-guide/hw-vuln/index.rst           |   1 +-
 2 files changed, 224 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
new file mode 100644
index 0000000..7b410ae
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -0,0 +1,223 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Core Scheduling
+===============
+Core scheduling support allows userspace to define groups of tasks that can
+share a core. These groups can be specified either for security usecases (one
+group of tasks don't trust another), or for performance usecases (some
+workloads may benefit from running on the same core as they don't need the same
+hardware resources of the shared core, or may prefer different cores if they
+do share hardware resource needs). This document only describes the security
+usecase.
+
+Security usecase
+----------------
+A cross-HT attack involves the attacker and victim running on different Hyper
+Threads of the same core. MDS and L1TF are examples of such attacks.  The only
+full mitigation of cross-HT attacks is to disable Hyper Threading (HT). Core
+scheduling is a scheduler feature that can mitigate some (not all) cross-HT
+attacks. It allows HT to be turned on safely by ensuring that only tasks in a
+user-designated trusted group can share a core. This increase in core sharing
+can also improve performance, however it is not guaranteed that performance
+will always improve, though that is seen to be the case with a number of real
+world workloads. In theory, core scheduling aims to perform at least as good as
+when Hyper Threading is disabled. In practice, this is mostly the case though
+not always: as synchronizing scheduling decisions across 2 or more CPUs in a
+core involves additional overhead - especially when the system is lightly
+loaded. When ``total_threads <= N_CPUS/2``, the extra overhead may cause core
+scheduling to perform more poorly compared to SMT-disabled, where N_CPUS is the
+total number of CPUs. Please measure the performance of your workloads always.
+
+Usage
+-----
+Core scheduling support is enabled via the ``CONFIG_SCHED_CORE`` config option.
+Using this feature, userspace defines groups of tasks that can be co-scheduled
+on the same core. The core scheduler uses this information to make sure that
+tasks that are not in the same group never run simultaneously on a core, while
+doing its best to satisfy the system's scheduling requirements.
+
+Core scheduling can be enabled via the ``PR_SCHED_CORE`` prctl interface.
+This interface provides support for the creation of core scheduling groups, as
+well as admission and removal of tasks from created groups::
+
+    #include <sys/prctl.h>
+
+    int prctl(int option, unsigned long arg2, unsigned long arg3,
+            unsigned long arg4, unsigned long arg5);
+
+option:
+    ``PR_SCHED_CORE``
+
+arg2:
+    Command for operation, must be one off:
+
+    - ``PR_SCHED_CORE_GET`` -- get core_sched cookie of ``pid``.
+    - ``PR_SCHED_CORE_CREATE`` -- create a new unique cookie for ``pid``.
+    - ``PR_SCHED_CORE_SHARE_TO`` -- push core_sched cookie to ``pid``.
+    - ``PR_SCHED_CORE_SHARE_FROM`` -- pull core_sched cookie from ``pid``.
+
+arg3:
+    ``pid`` of the task for which the operation applies.
+
+arg4:
+    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
+    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
+    will be performed for all tasks in the task group of ``pid``.
+
+arg5:
+    userspace pointer to an unsigned long for storing the cookie returned by
+    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
+
+In order for a process to push a cookie to, or pull a cookie from a process, it
+is required to have the ptrace access mode: `PTRACE_MODE_READ_REALCREDS` to the
+process.
+
+Building hierarchies of tasks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The simplest way to build hierarchies of threads/processes which share a
+cookie and thus a core is to rely on the fact that the core-sched cookie is
+inherited across forks/clones and execs, thus setting a cookie for the
+'initial' script/executable/daemon will place every spawned child in the
+same core-sched group.
+
+Cookie Transferral
+~~~~~~~~~~~~~~~~~~
+Transferring a cookie between the current and other tasks is possible using
+PR_SCHED_CORE_SHARE_FROM and PR_SCHED_CORE_SHARE_TO to inherit a cookie from a
+specified task or a share a cookie with a task. In combination this allows a
+simple helper program to pull a cookie from a task in an existing core
+scheduling group and share it with already running tasks.
+
+Design/Implementation
+---------------------
+Each task that is tagged is assigned a cookie internally in the kernel. As
+mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
+each other and share a core.
+
+The basic idea is that, every schedule event tries to select tasks for all the
+siblings of a core such that all the selected tasks running on a core are
+trusted (same cookie) at any point in time. Kernel threads are assumed trusted.
+The idle task is considered special, as it trusts everything and everything
+trusts it.
+
+During a schedule() event on any sibling of a core, the highest priority task on
+the sibling's core is picked and assigned to the sibling calling schedule(), if
+the sibling has the task enqueued. For rest of the siblings in the core,
+highest priority task with the same cookie is selected if there is one runnable
+in their individual run queues. If a task with same cookie is not available,
+the idle task is selected.  Idle task is globally trusted.
+
+Once a task has been selected for all the siblings in the core, an IPI is sent to
+siblings for whom a new task was selected. Siblings on receiving the IPI will
+switch to the new task immediately. If an idle task is selected for a sibling,
+then the sibling is considered to be in a `forced idle` state. I.e., it may
+have tasks on its on runqueue to run, however it will still have to run idle.
+More on this in the next section.
+
+Forced-idling of hyperthreads
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The scheduler tries its best to find tasks that trust each other such that all
+tasks selected to be scheduled are of the highest priority in a core.  However,
+it is possible that some runqueues had tasks that were incompatible with the
+highest priority ones in the core. Favoring security over fairness, one or more
+siblings could be forced to select a lower priority task if the highest
+priority task is not trusted with respect to the core wide highest priority
+task.  If a sibling does not have a trusted task to run, it will be forced idle
+by the scheduler (idle thread is scheduled to run).
+
+When the highest priority task is selected to run, a reschedule-IPI is sent to
+the sibling to force it into idle. This results in 4 cases which need to be
+considered depending on whether a VM or a regular usermode process was running
+on either HT::
+
+          HT1 (attack)            HT2 (victim)
+   A      idle -> user space      user space -> idle
+   B      idle -> user space      guest -> idle
+   C      idle -> guest           user space -> idle
+   D      idle -> guest           guest -> idle
+
+Note that for better performance, we do not wait for the destination CPU
+(victim) to enter idle mode. This is because the sending of the IPI would bring
+the destination CPU immediately into kernel mode from user space, or VMEXIT
+in the case of guests. At best, this would only leak some scheduler metadata
+which may not be worth protecting. It is also possible that the IPI is received
+too late on some architectures, but this has not been observed in the case of
+x86.
+
+Trust model
+~~~~~~~~~~~
+Core scheduling maintains trust relationships amongst groups of tasks by
+assigning them a tag that is the same cookie value.
+When a system with core scheduling boots, all tasks are considered to trust
+each other. This is because the core scheduler does not have information about
+trust relationships until userspace uses the above mentioned interfaces, to
+communicate them. In other words, all tasks have a default cookie value of 0.
+and are considered system-wide trusted. The forced-idling of siblings running
+cookie-0 tasks is also avoided.
+
+Once userspace uses the above mentioned interfaces to group sets of tasks, tasks
+within such groups are considered to trust each other, but do not trust those
+outside. Tasks outside the group also don't trust tasks within.
+
+Limitations of core-scheduling
+------------------------------
+Core scheduling tries to guarantee that only trusted tasks run concurrently on a
+core. But there could be small window of time during which untrusted tasks run
+concurrently or kernel could be running concurrently with a task not trusted by
+kernel.
+
+IPI processing delays
+~~~~~~~~~~~~~~~~~~~~~
+Core scheduling selects only trusted tasks to run together. IPI is used to notify
+the siblings to switch to the new task. But there could be hardware delays in
+receiving of the IPI on some arch (on x86, this has not been observed). This may
+cause an attacker task to start running on a CPU before its siblings receive the
+IPI. Even though cache is flushed on entry to user mode, victim tasks on siblings
+may populate data in the cache and micro architectural buffers after the attacker
+starts to run and this is a possibility for data leak.
+
+Open cross-HT issues that core scheduling does not solve
+--------------------------------------------------------
+1. For MDS
+~~~~~~~~~~
+Core scheduling cannot protect against MDS attacks between an HT running in
+user mode and another running in kernel mode. Even though both HTs run tasks
+which trust each other, kernel memory is still considered untrusted. Such
+attacks are possible for any combination of sibling CPU modes (host or guest mode).
+
+2. For L1TF
+~~~~~~~~~~~
+Core scheduling cannot protect against an L1TF guest attacker exploiting a
+guest or host victim. This is because the guest attacker can craft invalid
+PTEs which are not inverted due to a vulnerable guest kernel. The only
+solution is to disable EPT (Extended Page Tables).
+
+For both MDS and L1TF, if the guest vCPU is configured to not trust each
+other (by tagging separately), then the guest to guest attacks would go away.
+Or it could be a system admin policy which considers guest to guest attacks as
+a guest problem.
+
+Another approach to resolve these would be to make every untrusted task on the
+system to not trust every other untrusted task. While this could reduce
+parallelism of the untrusted tasks, it would still solve the above issues while
+allowing system processes (trusted tasks) to share a core.
+
+3. Protecting the kernel (IRQ, syscall, VMEXIT)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unfortunately, core scheduling does not protect kernel contexts running on
+sibling hyperthreads from one another. Prototypes of mitigations have been posted
+to LKML to solve this, but it is debatable whether such windows are practically
+exploitable, and whether the performance overhead of the prototypes are worth
+it (not to mention, the added code complexity).
+
+Other Use cases
+---------------
+The main use case for Core scheduling is mitigating the cross-HT vulnerabilities
+with SMT enabled. There are other use cases where this feature could be used:
+
+- Isolating tasks that needs a whole core: Examples include realtime tasks, tasks
+  that uses SIMD instructions etc.
+- Gang scheduling: Requirements for a group of tasks that needs to be scheduled
+  together could also be realized using core scheduling. One example is vCPUs of
+  a VM.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd..f12cda5 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   core-scheduling.rst
