Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB433F0E9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCQNOE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:14:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhCQNNf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:13:35 -0400
Date:   Wed, 17 Mar 2021 13:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615986813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YApcwjDihhlakWewylW9wFlszybKBfhMe+HG10/Bbs=;
        b=J4qRMBDPpcIL0nGjtO/zSF1shHNpCGKc8Z9ly2vRGVjElc5r/YNbrcFvPajzLF8GvhEIsB
        XXVdja54QhTo0cUKQwTitWTi4Gw4VHJSaOUzv1MIkra7LAbyfx1Q1B2dKUONg1fuv8yymX
        a6lpGx5RjrK+reOznvznEX0EI7bSSZEsJ7KsVoV3wxEeAgP4GaEW69kj3TKG4mpPsbh3d8
        VfdfNhLB2DBHxOP7yu6/io3T3spXqm3ZjwF8g5pmNDqct2aFgHYZ5yiOl8ShYvt9gAbPuI
        yuLKebx7ALdc+CoNXEwzIkO1HYO71jyC2UEcpHbHah0qRAtfoJ95BiXWOfK1QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615986813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YApcwjDihhlakWewylW9wFlszybKBfhMe+HG10/Bbs=;
        b=bCJdHS+IAqCowhPNJ3hvo3sfKFRKosIWl+l/ZKdoGlpQOWnfJJqsIWgQPJcrNvn23mXbXb
        F/Pv7V0z/gREESAQ==
From:   "tip-bot2 for Piotr Figiel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq, ptrace: Add PTRACE_GET_RSEQ_CONFIGURATION request
Cc:     Piotr Figiel <figiel@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Miroslaw <emmir@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226135156.1081606-1-figiel@google.com>
References: <20210226135156.1081606-1-figiel@google.com>
MIME-Version: 1.0
Message-ID: <161598681294.398.14135404653803937904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2c406d3f436db1deea55ec44cc4c3c0861c3c185
Gitweb:        https://git.kernel.org/tip/2c406d3f436db1deea55ec44cc4c3c0861c3c185
Author:        Piotr Figiel <figiel@google.com>
AuthorDate:    Fri, 26 Feb 2021 14:51:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Mar 2021 14:05:40 +01:00

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
