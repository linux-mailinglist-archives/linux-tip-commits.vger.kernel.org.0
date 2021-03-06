Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8D32FA4D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhCFLzR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhCFLyh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:37 -0500
Date:   Sat, 06 Mar 2021 11:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21PtMgo5esx0f9qYfMiOPAKEeGiNP5JdjJ7pHFapubQ=;
        b=I8LCW2fM+YuCQoo4IckPAyyzIQaKhaNq8X0ghHfPmB2Q4giDpI9k1FZxNrIp+xMxntZ1gq
        eTlkRBeEj05Sa/9cQkVzcdYgCFCCgTmawS9/DwxtmgGVWjotRtUMUwPwagy6Wp6fxheFtT
        dz/iMqAUTKYDl37Fifa0OoIgFGIkNcgKjckFiZtjFWQYEwikIV+6SxA9pBcDf3e9txCeX9
        q7D8XKyXkhkkTjF1uq05nxWwAHR2AL19GLUkvjAR9FdXNvKYVR4c5i1snEFTWlbmiUwImW
        sxLdrnJ4OWMM7CvFKL+ULdxMyb+6qKSEVQndeepgpjfV+Blc3y+anUyMAPkHpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21PtMgo5esx0f9qYfMiOPAKEeGiNP5JdjJ7pHFapubQ=;
        b=/zWuMeU7np1PV2mjvMeOTJC3GU1r6yoFeef36AG64ZeAQvM+V3u7o0W4w+8u4ia7Zv8TNl
        4w1HJyyLYTGRZ0Dg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/csd_lock: Add boot parameter for
 controlling CSD lock debugging
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210301101336.7797-2-jgross@suse.com>
References: <20210301101336.7797-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161503167578.398.264181158722622384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8d0968cc6b8ffd8496c2ebffdfdc801f949a85e5
Gitweb:        https://git.kernel.org/tip/8d0968cc6b8ffd8496c2ebffdfdc801f949a85e5
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 01 Mar 2021 11:13:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:49:48 +01:00

locking/csd_lock: Add boot parameter for controlling CSD lock debugging

Currently CSD lock debugging can be switched on and off via a kernel
config option only. Unfortunately there is at least one problem with
CSD lock handling pending for about 2 years now, which has been seen
in different environments (mostly when running virtualized under KVM
or Xen, at least once on bare metal). Multiple attempts to catch this
issue have finally led to introduction of CSD lock debug code, but
this code is not in use in most distros as it has some impact on
performance.

In order to be able to ship kernels with CONFIG_CSD_LOCK_WAIT_DEBUG
enabled even for production use, add a boot parameter for switching
the debug functionality on. This will reduce any performance impact
of the debug coding to a bare minimum when not being used.

Signed-off-by: Juergen Gross <jgross@suse.com>
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210301101336.7797-2-jgross@suse.com
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++-
 kernel/smp.c                                    | 38 ++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..98dbffa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -784,6 +784,12 @@
 	cs89x0_media=	[HW,NET]
 			Format: { rj45 | aui | bnc }
 
+	csdlock_debug=	[KNL] Enable debug add-ons of cross-CPU function call
+			handling. When switched on, additional debug data is
+			printed to the console in case a hanging CPU is
+			detected, and that CPU is pinged again in order to try
+			to resolve the hang situation.
+
 	dasd=		[HW,NET]
 			See header of drivers/s390/block/dasd_devmap.c.
 
diff --git a/kernel/smp.c b/kernel/smp.c
index aeb0adf..d5f0b21 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
+#include <linux/jump_label.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -102,6 +103,20 @@ void __init call_function_init(void)
 
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
+static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
+
+static int __init csdlock_debug(char *str)
+{
+	unsigned int val = 0;
+
+	get_option(&str, &val);
+	if (val)
+		static_branch_enable(&csdlock_debug_enabled);
+
+	return 0;
+}
+early_param("csdlock_debug", csdlock_debug);
+
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
@@ -110,7 +125,7 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void csd_lock_record(call_single_data_t *csd)
+static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -125,7 +140,13 @@ static void csd_lock_record(call_single_data_t *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+static __always_inline void csd_lock_record(call_single_data_t *csd)
+{
+	if (static_branch_unlikely(&csdlock_debug_enabled))
+		__csd_lock_record(csd);
+}
+
+static int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
 	unsigned int csd_type;
 
@@ -140,7 +161,7 @@ static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -204,7 +225,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static void __csd_lock_wait(call_single_data_t *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -218,6 +239,15 @@ static __always_inline void csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
+	if (static_branch_unlikely(&csdlock_debug_enabled)) {
+		__csd_lock_wait(csd);
+		return;
+	}
+
+	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
+}
 #else
 static void csd_lock_record(call_single_data_t *csd)
 {
