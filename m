Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45F034DC03
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Mar 2021 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhC2Wo5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 18:44:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhC2Wox (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 18:44:53 -0400
Date:   Mon, 29 Mar 2021 22:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617057881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xmTU8qdCMGobX0Aubpcpv6tYqUIZ1MyetwU8YF1Nco=;
        b=CJGCD0jv0L7lx+5B14ELL7VgixvdYC1V1yycbwHAQdq3EvXwoE1kILxfv4LLgIVjeCwO8j
        t9TI8a34a9jB7mdHHhjCpMEExq66eRoMzs1LnhCBKsp0cucJ/ik775xb7LakWhmdIMhOMK
        EkAXhpZwTBEyP1/9uryMgUmgT2Btunogbg2nB/bdHEdVHQXR4il5j3NxGtrg984toGYn3X
        bKHzOrs//ctUI6LWVpRStFkLsm9h7FaZdkQoUfO/9SDSys75xw1vB6u1PkYHSm1zB6S/Jk
        pAQzVN9ti05gnwvSrU8B+N5TfcyCkz5KWw58LDD/HuetfbDniSWHqL/s9FCi4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617057881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xmTU8qdCMGobX0Aubpcpv6tYqUIZ1MyetwU8YF1Nco=;
        b=+zWC9bqsuYm3eX9B9ADmwEuR8yVOiGDhON9P67nesYvdpeQEbfWvCJey4AHNI54wwWMkma
        oFAL25yBVU3+3sCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/vector: Add a sanity check to prevent IRQ2 allocations
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318192819.795280387@linutronix.de>
References: <20210318192819.795280387@linutronix.de>
MIME-Version: 1.0
Message-ID: <161705788092.29796.9852234771468172792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     9a98bc2cf08a095367449b3548c3d9ad4ad2cd20
Gitweb:        https://git.kernel.org/tip/9a98bc2cf08a095367449b3548c3d9ad4ad2cd20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 18 Mar 2021 20:26:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Mar 2021 00:39:12 +02:00

x86/vector: Add a sanity check to prevent IRQ2 allocations

To prevent another incidental removal of the IRQ2 ignore logic in the
IO/APIC code going unnoticed add a sanity check. Add some commentry at the
other place which ignores IRQ2 while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210318192819.795280387@linutronix.de

---
 arch/x86/kernel/apic/vector.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c749..9b75a70 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -543,6 +543,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
 		return -ENOSYS;
 
+	/*
+	 * Catch any attempt to touch the cascade interrupt on a PIC
+	 * equipped system.
+	 */
+	if (WARN_ON_ONCE(info->flags & X86_IRQ_ALLOC_LEGACY &&
+			 virq == PIC_CASCADE_IR))
+		return -EINVAL;
+
 	for (i = 0; i < nr_irqs; i++) {
 		irqd = irq_domain_get_irq_data(domain, virq + i);
 		BUG_ON(!irqd);
@@ -745,6 +753,11 @@ void __init lapic_assign_system_vectors(void)
 
 	/* Mark the preallocated legacy interrupts */
 	for (i = 0; i < nr_legacy_irqs(); i++) {
+		/*
+		 * Don't touch the cascade interrupt. It's unusable
+		 * on PIC equipped machines. See the large comment
+		 * in the IO/APIC code.
+		 */
 		if (i != PIC_CASCADE_IR)
 			irq_matrix_assign(vector_matrix, ISA_IRQ_VECTOR(i));
 	}
