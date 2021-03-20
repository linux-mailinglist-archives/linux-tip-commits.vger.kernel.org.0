Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4783A343048
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Mar 2021 00:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTXTx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 20 Mar 2021 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTXTZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 20 Mar 2021 19:19:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00BCC061574;
        Sat, 20 Mar 2021 16:19:24 -0700 (PDT)
Date:   Sat, 20 Mar 2021 23:19:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616282362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfwU/ul0+cTLgyrW6rhIfwnO+4QcYxylCaHls+xR/Xo=;
        b=Xab4p5vGZWmK06rVfim/7/+vxw2yMek/Bi0RdRZQl0Gl78kKwjJUfkVsS2TXnhw0xlY6RF
        2MG5988c9cAIBjAjtahBSeoaDPmPDJAR4mipNBtV82uFj0rkjGvT/9GiT3kjMMYOOEyPNH
        AyEvUYLc18DnGjOQqEiZeOmZ4fdCxzU14FO8UiGh1VaX+VNh6nEYUkxpTdSrbBo4bOCyxr
        Jqi8F9mYCRqx4A1k/HJQUgHTXluCRUASPo7zFLiCmZTz3NI5+hcFdDJqQtBqKKFaNM/3EH
        KFFnsbAPkHwQK/tcD5qV0OI47YO5OOma1w7gCtEwNkYQP0Mx1qXVi34Tgxj2xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616282362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfwU/ul0+cTLgyrW6rhIfwnO+4QcYxylCaHls+xR/Xo=;
        b=/xouHbAMqvg4ow9I3lJ8cE+9AizOiVNq0sXVKfaZ6Vv/p94c0r7yjBAmELiX7C4CczDSOM
        7x1yQF582UufZ8CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Disable interrupts for force threaded handlers
Cc:     Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210317143859.513307808@linutronix.de>
References: <20210317143859.513307808@linutronix.de>
MIME-Version: 1.0
Message-ID: <161628236069.398.8387834895225662982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     81e2073c175b887398e5bca6c004efa89983f58d
Gitweb:        https://git.kernel.org/tip/81e2073c175b887398e5bca6c004efa89983f58d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 17 Mar 2021 15:38:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 21 Mar 2021 00:17:52 +01:00

genirq: Disable interrupts for force threaded handlers

With interrupt force threading all device interrupt handlers are invoked
from kernel threads. Contrary to hard interrupt context the invocation only
disables bottom halfs, but not interrupts. This was an oversight back then
because any code like this will have an issue:

thread(irq_A)
  irq_handler(A)
    spin_lock(&foo->lock);

interrupt(irq_B)
  irq_handler(B)
    spin_lock(&foo->lock);

This has been triggered with networking (NAPI vs. hrtimers) and console
drivers where printk() happens from an interrupt which interrupted the
force threaded handler.

Now people noticed and started to change the spin_lock() in the handler to
spin_lock_irqsave() which affects performance or add IRQF_NOTHREAD to the
interrupt request which in turn breaks RT.

Fix the root cause and not the symptom and disable interrupts before
invoking the force threaded handler which preserves the regular semantics
and the usefulness of the interrupt force threading as a general debugging
tool.

For not RT this is not changing much, except that during the execution of
the threaded handler interrupts are delayed until the handler
returns. Vs. scheduling and softirq processing there is no difference.

For RT kernels there is no issue.

Fixes: 8d32a307e4fa ("genirq: Provide forced interrupt threading")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Johan Hovold <johan@kernel.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20210317143859.513307808@linutronix.de

---
 kernel/irq/manage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dec3f73..21ea370 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1142,11 +1142,15 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	irqreturn_t ret;
 
 	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 	local_bh_enable();
 	return ret;
 }
