Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8182D86D0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439138AbgLLNMb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438891AbgLLM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333ABC0613CF;
        Sat, 12 Dec 2020 04:58:37 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BATRH1LeXO+eG/LfV81Ok3EQW+R/wP75GUmF+fML0v8=;
        b=zed35iTg2zhfWTfOZck1s3WSq5q09Xf5sig2zeLFrFzbmU1Z7kVsUho+xZdcl02hq9fAnF
        srGZJRXWxeYJD3KWiCHcVdSbW7xf03A/3lhqHy7dpexjNi6J4REL9SM7p5di1HZm9HtAKA
        Fv44tbGooG2ZKs0QEmU/qaQixjXn3gzW0rDAZPAZj1W7xShgmZnGuHUSbdatRHpaiC4CiX
        2c+Epy5M66LQTPZ1D9rVGmG0MrQpBIunX/huQzuwQ2xOOuKKviHS66jeIMyVFXw+YXkVSX
        xDdPL83KCqhWBeDJO2CwMaCN6iuyU7HKv91hxg8zvvtI/tzlpRa35DCszn4h8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BATRH1LeXO+eG/LfV81Ok3EQW+R/wP75GUmF+fML0v8=;
        b=0rxdRT/QonUbXupwiLil3O8ba98LMc7qcvpVoq9MMOMU0DSP+lQGVCHfsX7SOHJ0utWf41
        eU0f2YMLVYhHxNCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] xen/events: Use immediate affinity setting
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194045.157601122@linutronix.de>
References: <20201210194045.157601122@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791538.3364.15329504123021626204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9b23ffcbfa15f2d4959eaa42faae11e3e39d027a
Gitweb:        https://git.kernel.org/tip/9b23ffcbfa15f2d4959eaa42faae11e3e39d027a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

xen/events: Use immediate affinity setting

There is absolutely no reason to mimic the x86 deferred affinity
setting. This mechanism is required to handle the hardware induced issues
of IO/APIC and MSI and is not in use when the interrupts are remapped.

XEN does not need this and can simply change the affinity from the calling
context. The core code invokes this with the interrupt descriptor lock held
so it is fully serialized against any other operation.

Mark the interrupts with IRQ_MOVE_PCNTXT to disable the deferred affinity
setting. The conditional mask/unmask operation is already handled in
xen_rebind_evtchn_to_cpu().

This makes XEN on x86 use the same mechanics as on e.g. ARM64 where
deferred affinity setting is not required and not implemented and the code
path in the ack functions is compiled out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20201210194045.157601122@linutronix.de

---
 drivers/xen/events/events_base.c | 35 +++++++------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 9cade19..eaba42a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -628,6 +628,11 @@ static void xen_irq_init(unsigned irq)
 	info->refcnt = -1;
 
 	set_info_for_irq(irq, info);
+	/*
+	 * Interrupt affinity setting can be immediate. No point
+	 * in delaying it until an interrupt is handled.
+	 */
+	irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
 
 	INIT_LIST_HEAD(&info->eoi_list);
 	list_add_tail(&info->list, &xen_irq_list_head);
@@ -739,18 +744,7 @@ static void eoi_pirq(struct irq_data *data)
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
-	if (unlikely(irqd_is_setaffinity_pending(data)) &&
-	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
-
-		clear_evtchn(evtchn);
-
-		irq_move_masked_irq(data);
-
-		if (!masked)
-			unmask_evtchn(evtchn);
-	} else
-		clear_evtchn(evtchn);
+	clear_evtchn(evtchn);
 
 	if (pirq_needs_eoi(data->irq)) {
 		rc = HYPERVISOR_physdev_op(PHYSDEVOP_eoi, &eoi);
@@ -1641,7 +1635,6 @@ void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
 	mutex_unlock(&irq_mapping_update_lock);
 
         bind_evtchn_to_cpu(evtchn, info->cpu);
-	/* This will be deferred until interrupt is processed */
 	irq_set_affinity(irq, cpumask_of(info->cpu));
 
 	/* Unmask the event channel. */
@@ -1688,8 +1681,9 @@ static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 			    bool force)
 {
 	unsigned tcpu = cpumask_first_and(dest, cpu_online_mask);
-	int ret = xen_rebind_evtchn_to_cpu(evtchn_from_irq(data->irq), tcpu);
+	int ret;
 
+	ret = xen_rebind_evtchn_to_cpu(evtchn_from_irq(data->irq), tcpu);
 	if (!ret)
 		irq_data_update_effective_affinity(data, cpumask_of(tcpu));
 
@@ -1719,18 +1713,7 @@ static void ack_dynirq(struct irq_data *data)
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
-	if (unlikely(irqd_is_setaffinity_pending(data)) &&
-	    likely(!irqd_irq_disabled(data))) {
-		int masked = test_and_set_mask(evtchn);
-
-		clear_evtchn(evtchn);
-
-		irq_move_masked_irq(data);
-
-		if (!masked)
-			unmask_evtchn(evtchn);
-	} else
-		clear_evtchn(evtchn);
+	clear_evtchn(evtchn);
 }
 
 static void mask_ack_dynirq(struct irq_data *data)
