Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2833F53D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhCQQQF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhCQQPj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 12:15:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4332C06175F;
        Wed, 17 Mar 2021 09:15:38 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:19:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615994386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgV51ibPcfISQ+sGgS3nDU4tWskT7lkLqjb/sl1ES4A=;
        b=G4wI4MlO+npTQQtQ8Y7Q1ggXBrLXqhcqMDIn4qsIWKQmmkDpsGY2M5FdUcizGKgAhBsn+x
        3CeKL6Y5f/7Y+Kj4xfM2AKBB32fHAVrhs9hTIPAS/w3RADU0nLVyL6nEIAwfyBH7kBwUZJ
        HNaF4XMf2cZkMiLJcBfjivORNiDvXrW5uySvHuPAmrAszu8I65SJRvropAcxVJLxxnevN0
        jrBd5xPLludk86UsK1/V0JV7mscIpVDYECvfW4JYvxCnQ1x/EsNGwJbn8ipZhJ/168XCtx
        3BHjWzWxki96txOVAs4SEqULje+ot7HHd5wEusLxp53oVmfOPGHYln36d2Fucg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615994386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgV51ibPcfISQ+sGgS3nDU4tWskT7lkLqjb/sl1ES4A=;
        b=F6bVIt9n8RRhLoTuA1xSzXQibL4p/HFgmxVnR4BeLWzMU/Tw5gIw3kfVl7ec44WuitNU7O
        ogk4Pr5aIniY7QAw==
From:   "tip-bot2 for Piotr Figiel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq, ptrace: Add PTRACE_GET_RSEQ_CONFIGURATION request
Cc:     Piotr Figiel <figiel@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Miroslaw <emmir@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226135156.1081606-1-figiel@google.com>
References: <20210226135156.1081606-1-figiel@google.com>
MIME-Version: 1.0
Message-ID: <161599438512.398.10240803553618340072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     90f093fa8ea48e5d991332cee160b761423d55c1
Gitweb:        https://git.kernel.org/tip/90f093fa8ea48e5d991332cee160b761423d55c1
Author:        Piotr Figiel <figiel@google.com>
AuthorDate:    Fri, 26 Feb 2021 14:51:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:15:39 +01:00

rseq, ptrace: Add PTRACE_GET_RSEQ_CONFIGURATION request

For userspace checkpoint and restore (C/R) a way of getting process state
containing RSEQ configuration is needed.

There are two ways this information is going to be used:
 - to re-enable RSEQ for threads which had it enabled before C/R
 - to detect if a thread was in a critical section during C/R

Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
using the address registered before C/R.

Detection whether the thread is in a critical section during C/R is needed
to enforce behavior of RSEQ abort during C/R. Attaching with ptrace()
before registers are dumped itself doesn't cause RSEQ abort.
Restoring the instruction pointer within the critical section is
problematic because rseq_cs may get cleared before the control is passed
to the migrated application code leading to RSEQ invariants not being
preserved. C/R code will use RSEQ ABI address to find the abort handler
to which the instruction pointer needs to be set.

To achieve above goals expose the RSEQ ABI address and the signature value
with the new ptrace request PTRACE_GET_RSEQ_CONFIGURATION.

This new ptrace request can also be used by debuggers so they are aware
of stops within restartable sequences in progress.

Signed-off-by: Piotr Figiel <figiel@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michal Miroslaw <emmir@google.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20210226135156.1081606-1-figiel@google.com
---
 include/uapi/linux/ptrace.h | 10 ++++++++++
 kernel/ptrace.c             | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 83ee45f..3747bf8 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -102,6 +102,16 @@ struct ptrace_syscall_info {
 	};
 };
 
+#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
+
+struct ptrace_rseq_configuration {
+	__u64 rseq_abi_pointer;
+	__u32 rseq_abi_size;
+	__u32 signature;
+	__u32 flags;
+	__u32 pad;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 821cf17..c71270a 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
+#include <linux/minmax.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -779,6 +780,24 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	return ret;
 }
 
+#ifdef CONFIG_RSEQ
+static long ptrace_get_rseq_configuration(struct task_struct *task,
+					  unsigned long size, void __user *data)
+{
+	struct ptrace_rseq_configuration conf = {
+		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
+		.rseq_abi_size = sizeof(*task->rseq),
+		.signature = task->rseq_sig,
+		.flags = 0,
+	};
+
+	size = min_t(unsigned long, size, sizeof(conf));
+	if (copy_to_user(data, &conf, size))
+		return -EFAULT;
+	return sizeof(conf);
+}
+#endif
+
 #ifdef PTRACE_SINGLESTEP
 #define is_singlestep(request)		((request) == PTRACE_SINGLESTEP)
 #else
@@ -1222,6 +1241,12 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+#ifdef CONFIG_RSEQ
+	case PTRACE_GET_RSEQ_CONFIGURATION:
+		ret = ptrace_get_rseq_configuration(child, addr, datavp);
+		break;
+#endif
+
 	default:
 		break;
 	}
