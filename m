Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38CC2D86C7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439021AbgLLNLC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438893AbgLLM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3BC0613D3;
        Sat, 12 Dec 2020 04:58:38 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhbAJPyaRLkGT04nHlT7ePL+X9AYtQ+xwTqx7CN7ojM=;
        b=pU56q1M9KoN3H72qTZw/CioEjJM65G4yTO9ohzit7BOMFJJ5o0l1nQCkqZZE/0MNz9SVVz
        2RU77GGpXQZA0pnqwOOT4vOfc0XyQoJuk/tYQNmV0TUWtp7hwzX2gyFu3s/FeGWEL2pdLJ
        oNqHQVcSKaSyN3mhmiv8LiVWUhb/YJ7HdB6sh6iDA8gRdYoUsaStnWINsW9bDCjX55ca13
        b881yf7vazRWJfag+ih9LP3Abe2OMuB9+ppsTTcvqytNlZCFD4Gs3VHHDic40fOsL/xQam
        SUJLkBZjNi+bnsMLW//NGfQd3m876u+l5oUSVtDWKJu/cGBUKZGi54NnPOkd1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhbAJPyaRLkGT04nHlT7ePL+X9AYtQ+xwTqx7CN7ojM=;
        b=5SC+DNlwCPLpGJ6C65fb2GcbOaMxDy2IWPJZ5ivFx4a293zwo+WPMa8IEXIibxMCgKOjfI
        ZWWwiyqaNHB6TSDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] xen/events: Remove disfunct affinity spreading
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194045.065115500@linutronix.de>
References: <20201210194045.065115500@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791566.3364.11691003667802645875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     26599cd34323b73894ebcb5197693cdd668b4aa8
Gitweb:        https://git.kernel.org/tip/26599cd34323b73894ebcb5197693cdd668b4aa8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

xen/events: Remove disfunct affinity spreading

This function can only ever work when the event channels:

  - are already established
  - interrupts assigned to them
  - the affinity has been set by user space already

because any newly set up event channel is forced to be bound to CPU0 and
the affinity mask of the interrupt is forced to contain cpumask_of(0).

As the CPU0 enforcement was in place _before_ this was implemented it's
entirely unclear how that can ever have worked at all.

Remove it as preparation for doing it proper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194045.065115500@linutronix.de

---
 drivers/xen/events/events_base.c |  9 +--------
 drivers/xen/evtchn.c             | 34 +-------------------------------
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index d6458e4..9cade19 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1696,15 +1696,6 @@ static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 	return ret;
 }
 
-/* To be called with desc->lock held. */
-int xen_set_affinity_evtchn(struct irq_desc *desc, unsigned int tcpu)
-{
-	struct irq_data *d = irq_desc_get_irq_data(desc);
-
-	return set_affinity_irq(d, cpumask_of(tcpu), false);
-}
-EXPORT_SYMBOL_GPL(xen_set_affinity_evtchn);
-
 static void enable_dynirq(struct irq_data *data)
 {
 	evtchn_port_t evtchn = evtchn_from_irq(data->irq);
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 5dc016d..a7a8571 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -421,36 +421,6 @@ static void evtchn_unbind_from_user(struct per_user_data *u,
 	del_evtchn(u, evtchn);
 }
 
-static DEFINE_PER_CPU(int, bind_last_selected_cpu);
-
-static void evtchn_bind_interdom_next_vcpu(evtchn_port_t evtchn)
-{
-	unsigned int selected_cpu, irq;
-	struct irq_desc *desc;
-	unsigned long flags;
-
-	irq = irq_from_evtchn(evtchn);
-	desc = irq_to_desc(irq);
-
-	if (!desc)
-		return;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	selected_cpu = this_cpu_read(bind_last_selected_cpu);
-	selected_cpu = cpumask_next_and(selected_cpu,
-			desc->irq_common_data.affinity, cpu_online_mask);
-
-	if (unlikely(selected_cpu >= nr_cpu_ids))
-		selected_cpu = cpumask_first_and(desc->irq_common_data.affinity,
-				cpu_online_mask);
-
-	this_cpu_write(bind_last_selected_cpu, selected_cpu);
-
-	/* unmask expects irqs to be disabled */
-	xen_set_affinity_evtchn(desc, selected_cpu);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-}
-
 static long evtchn_ioctl(struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
@@ -508,10 +478,8 @@ static long evtchn_ioctl(struct file *file,
 			break;
 
 		rc = evtchn_bind_to_user(u, bind_interdomain.local_port);
-		if (rc == 0) {
+		if (rc == 0)
 			rc = bind_interdomain.local_port;
-			evtchn_bind_interdom_next_vcpu(rc);
-		}
 		break;
 	}
 
