Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7A3D8B3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhG1J6N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhG1J6M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825DC061757;
        Wed, 28 Jul 2021 02:58:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOAl2EFe+mUWmxJ0hhtL93+AhdVGBTtUt30nmIAsPC0=;
        b=Llc9H8JUMJ60QHMDwoE8YdWISt7dyrGp7WqVRixNUYV7CJXt4ihTkxxtPshDcOGZfMXOdG
        Rnhk1pP+xg8gV9w5wmjoMdsJ/EppbapUFH8FLFrT9G1eCfU0sI+6KkF2DDjI0hbOVeNVje
        RVfOPqUTQR4Cndllh40C2yNb/7mn50/OHZmj/75NvKmjHnoOysve+GCYhsjOtjWAoCrxAX
        bFdvFxOaLblrkg6HxPpB3/KF81IShgZrHamSMG1GEw4VPzoIuRDWmuEfER5n3sF+HgH6o5
        DmxeypK6LN00jbvw4xRSF9B5yg2cuVk7ob+sqzyLilgLQ+3TN406cvg6vhg6Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOAl2EFe+mUWmxJ0hhtL93+AhdVGBTtUt30nmIAsPC0=;
        b=RLfqgyll8CUJH6Solr6fFRmd1SbXbU+lrF94iMaACZQzDTZTqMs4y13uUOqewb2K95ZjBB
        IL6GNeyRc+FRm5Ag==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86, prctl: Hook L1D flushing in via prctl
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-5-sblbir@amazon.com>
References: <20210108121056.21940-5-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628683.395.6666665580026120284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e893bb1bb4d2eb635eba61e5d9c5135d96855773
Gitweb:        https://git.kernel.org/tip/e893bb1bb4d2eb635eba61e5d9c5135d96855773
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Fri, 08 Jan 2021 23:10:55 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:25 +02:00

x86, prctl: Hook L1D flushing in via prctl

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D flush
capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

Enabling L1D flush does not check if the task is running on an SMT enabled
core, rather a check is done at runtime (at the time of flush), if the task
runs on a SMT sibling then the task is sent a SIGBUS which is executed
before the task returns to user space or to a guest.

This is better than the other alternatives of:

  a. Ensuring strict affinity of the task (hard to enforce without further
     changes in the scheduler)

  b. Silently skipping flush for tasks that move to SMT enabled cores.

Hook up the core prctl and implement the x86 specific parts which in turn
makes it functional.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-5-sblbir@amazon.com
---
 arch/x86/kernel/cpu/bugs.c | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1a5a1b0..ecfca3b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1252,6 +1252,24 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (!static_branch_unlikely(&switch_mm_cond_l1d_flush))
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		set_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+		return 0;
+	case PR_SPEC_DISABLE:
+		clear_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+		return 0;
+	default:
+		return -ERANGE;
+	}
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1361,6 +1379,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1377,6 +1397,17 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_prctl_get(struct task_struct *task)
+{
+	if (!static_branch_unlikely(&switch_mm_cond_l1d_flush))
+		return PR_SPEC_FORCE_DISABLE;
+
+	if (test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH))
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1427,6 +1458,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH:
+		return l1d_flush_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c5..964c41e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
