Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519B41DE319
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 May 2020 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEVJdA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 May 2020 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJc7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 May 2020 05:32:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F548C061A0E;
        Fri, 22 May 2020 02:32:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc42x-0001OP-Bb; Fri, 22 May 2020 11:32:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0780D1C0475;
        Fri, 22 May 2020 11:32:55 +0200 (CEST)
Date:   Fri, 22 May 2020 09:32:54 -0000
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] prctl: Hook L1D flushing in via prctl
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200516103430.26527-3-sblbir@amazon.com>
References: <20200516103430.26527-3-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <159013997492.17951.8240809605276627934.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     edf7ce0b231cb6cdc170125588cf71c70358fc74
Gitweb:        https://git.kernel.org/tip/edf7ce0b231cb6cdc170125588cf71c70358fc74
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Sat, 16 May 2020 20:34:29 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 22 May 2020 10:36:48 +02:00

prctl: Hook L1D flushing in via prctl

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

There is also no seccomp integration for the feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200516103430.26527-3-sblbir@amazon.com

---
 arch/x86/kernel/cpu/bugs.c | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b..3eb9139 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1121,6 +1121,19 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		return enable_l1d_flush_for_task(task);
+	case PR_SPEC_DISABLE:
+		return disable_l1d_flush_for_task(task);
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1206,6 +1219,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1221,6 +1236,17 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_out_prctl_get(struct task_struct *task)
+{
+	int ret;
+
+	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+	if (ret)
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1272,6 +1298,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f81..1e86486 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH_OUT		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
