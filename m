Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB52B3A7C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKOW4g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKOW4f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:56:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948AC0613CF;
        Sun, 15 Nov 2020 14:56:35 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:56:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=km7Slix76rspfzQsOmys81UPfOB5HZftlvk8l3W+8LI=;
        b=ZLfkQARV/oRw8mi6Djaer5FHke9OWlE0pzIaHyw08nYQaJoc1mtkncycpvvcm6QTE1VL2R
        GL3UiAn2mS1XAdYZJiE6pxCVz1Y5dpSxGPZaje2sadFeur69DjAWZPxnMnrqaiQAEMxEtD
        5STK1qtiHisARhKQXnXabKJfS3vyPTBI/ji8upITfsCboz2g8nnuuLuxykvHbFux6+CuVi
        BJpcPqXGfOotiDavlsGD+z3IplOTBqkzzElh0LauYYx1pW7OEccpHe4p3SUQ1SbX1cpEIx
        UFf9niMJzwyXUb/uoGDXucgLHFjyNrFv1UPWFm6gNeoXIt5D2yUZMlebPp/6gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=km7Slix76rspfzQsOmys81UPfOB5HZftlvk8l3W+8LI=;
        b=t9xuabEIHCtyRfUn7qtdCdJ6/dlulNldOrk6R97W1cjuh8HFqpmBvcJExe+vad59iCE7H9
        actPHPeFw4IebKAw==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Fix spelling/typo errors in irq entry code
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201104230157.3378023-1-ira.weiny@intel.com>
References: <20201104230157.3378023-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <160548099204.11244.6842720288075136334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     78a56e0494ad29feccd4c54c2b5682721f8cb988
Gitweb:        https://git.kernel.org/tip/78a56e0494ad29feccd4c54c2b5682721f8cb988
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Wed, 04 Nov 2020 15:01:57 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:54:00 +01:00

entry: Fix spelling/typo errors in irq entry code

s/reguired/required/
s/Interupts/Interrupts/
s/quiescient/quiescent/
s/assemenbly/assembly/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201104230157.3378023-1-ira.weiny@intel.com
---
 include/linux/entry-common.h | 4 ++--
 kernel/entry/common.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1a128ba..aab5490 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -415,7 +415,7 @@ void irqentry_exit_cond_resched(void);
  * @state:	Return value from matching call to irqentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and reguired and returns to
+ * preemption and work checks if possible and required and returns to
  * the caller with interrupts disabled and no further work pending.
  *
  * This is the last action before returning to the low level ASM code which
@@ -438,7 +438,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
  * @regs:	Pointer to pt_regs (NMI entry regs)
  * @irq_state:	Return value from matching call to irqentry_nmi_enter()
  *
- * Last action before returning to the low level assmenbly code.
+ * Last action before returning to the low level assembly code.
  *
  * Counterpart to irqentry_nmi_enter().
  */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bc75c11..fa17baa 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -304,7 +304,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * If this entry hit the idle task invoke rcu_irq_enter() whether
 	 * RCU is watching or not.
 	 *
-	 * Interupts can nest when the first interrupt invokes softirq
+	 * Interrupts can nest when the first interrupt invokes softirq
 	 * processing on return which enables interrupts.
 	 *
 	 * Scheduler ticks in the idle task can mark quiescent state and
@@ -315,7 +315,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interupt and eventually claim
-	 * quiescient state and end grace periods prematurely.
+	 * quiescent state and end grace periods prematurely.
 	 *
 	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
 	 * consistent.
