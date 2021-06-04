Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29FF39B9F7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFDNkc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNkc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 09:40:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B440C061766;
        Fri,  4 Jun 2021 06:38:45 -0700 (PDT)
Date:   Fri, 04 Jun 2021 13:38:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622813922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zlZ3pzpVm5b9khr9J+B4kVxV4oeFJqoK77aZam4DhU=;
        b=U7diDigWQZGCvPVKJVRcavjAucRwJdbgVMEsO6TftzYYIIUfF52n08VF+GCs/B2iop1Btc
        +BVflGwM3VZSS4cwU+UhNWvKmBhMGBHyfmsVOcGKlBYjjFzyPlSJH2J3nHwTiZj9yNK31n
        qTpeqe6UzEXk/UmGv/VX/bN+V4AxmmExhefzn57EIeLL8uM4NRZ0iWinga6CbVTAjuKhON
        /FJJTpHTDSUKQA2IQ+NsNxajpu30kt8XGuF02HpZsfrPDjkkhGjsr06x688I37ls8dUOdP
        wcZRtFOqxvKT40wVpgFFQ11vsXo/T4ZGKCf0L0uQ4J3V9IiFCUkgYJCsgZ8NzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622813922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zlZ3pzpVm5b9khr9J+B4kVxV4oeFJqoK77aZam4DhU=;
        b=+Zjo+nkWstu2Bip7TaSoGzac+8Zp4N2N2/28xMv3gLQt0TFSYVfCQhtQkczI8wxgQQYru/
        nrsc0EOq1cuxTgDQ==
From:   "tip-bot2 for Naveen N. Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Do not increment probe miss count in the
 fault handler
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <162281392181.29796.17357169645855038512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2e38eb04c95e5546b71bb86ee699a891c7d212b5
Gitweb:        https://git.kernel.org/tip/2e38eb04c95e5546b71bb86ee699a891c7d212b5
Author:        Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
AuthorDate:    Tue, 01 Jun 2021 17:31:50 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Jun 2021 15:47:26 +02:00

kprobes: Do not increment probe miss count in the fault handler

Kprobes has a counter 'nmissed', that is used to count the number of
times a probe handler was not called. This generally happens when we hit
a kprobe while handling another kprobe.

However, if one of the probe handlers causes a fault, we are currently
incrementing 'nmissed'. The comment in fault handler indicates that this
can be used to account faults taken by the probe handlers. But, this has
never been the intention as is evident from the comment above 'nmissed'
in 'struct kprobe':

	/*count the number of times this probe was temporarily disarmed */
	unsigned long nmissed;

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com
---
 arch/arc/kernel/kprobes.c          |  6 ------
 arch/arm/probes/kprobes/core.c     | 14 --------------
 arch/arm64/kernel/probes/kprobes.c |  7 -------
 arch/csky/kernel/probes/kprobes.c  |  7 -------
 arch/ia64/kernel/kprobes.c         |  7 -------
 arch/powerpc/kernel/kprobes.c      |  7 -------
 arch/riscv/kernel/probes/kprobes.c |  7 -------
 arch/s390/kernel/kprobes.c         |  7 -------
 arch/sh/kernel/kprobes.c           |  7 -------
 arch/sparc/kernel/kprobes.c        |  7 -------
 arch/x86/kernel/kprobes/core.c     |  8 --------
 11 files changed, 84 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 9f5b39f..5f0415f 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -317,12 +317,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned long trapnr)
 		 * caused the fault.
 		 */
 
-		/* We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned zero,
 		 * try to fix up.
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 7b9b9a5..27e0af7 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -348,20 +348,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 			reset_current_kprobe();
 		}
 		break;
-
-	case KPROBE_HIT_ACTIVE:
-	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		break;
-
-	default:
-		break;
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index f6b088e..004b86e 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -277,13 +277,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index e0e973e..68b22b4 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -295,13 +295,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 6efed4e..441ed04 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -844,13 +844,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 75b4e87..3f70083 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -502,13 +502,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 923b5ea..9b71a63 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -277,13 +277,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index ad631e3..74b0bd2 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -446,13 +446,6 @@ static int kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(p);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 5826342..1c7f358 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -383,13 +383,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index db4e341..4c05a4e 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -346,13 +346,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
 		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index cfcdf4b..1b3fe0e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1102,14 +1102,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 			restore_previous_kprobe(kcb);
 		else
 			reset_current_kprobe();
-	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
-		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
 	}
 
 	return 0;
