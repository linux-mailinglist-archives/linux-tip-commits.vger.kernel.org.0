Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B412B3487
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 12:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKOLFq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 06:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgKOLFp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 06:05:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3807C0613D1;
        Sun, 15 Nov 2020 03:05:45 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:05:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605438343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bij7WmP9+y87wX1KmnpAU4g3B0H3sxtPXI7Q6zWWxQs=;
        b=cFN0Xi+xYEvuHoPWSxGjXqYvCpIIXDs5G2NN1Pg0ai7C8x5elEIbH3B2X2TIYdBKsZ5STX
        90FFlaLoj9Pyj7LxVMf02QdJknDAS1QSBXLzCNXKQvBLgb3wKExhDwhYef6uWYzjRUfuUw
        01XTQ09oJkydhWgrHghO6334MluuwikVi5ZsazgTMOwIdj0rpq7gMhpg0JL0EktGgQvMFI
        eG+1o+OtmlTDWJm+qPs0/183zJLoa+mLEqTt0T9akXNNTcQh5vLPbDOnraA2sPr6kbveiV
        3HivOAR0SjeIQ7bxZKbaS/u2Gnr0RA5P9TmD05stYxlcmRVYF8iEcDb50pmdDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605438343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bij7WmP9+y87wX1KmnpAU4g3B0H3sxtPXI7Q6zWWxQs=;
        b=9aHzsEu+3vkUgLobOam1UnDVGcyOjlX2Z8WySsysE24LlvIOAjNhLa9gnis2OYvkDodXxT
        HMq6ok/G231XAjAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Make irq_domain_disassociate() static
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87a6vja7mb.fsf@nanos.tec.linutronix.de>
References: <87a6vja7mb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160543834186.11244.15951474822549357496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e906a546bd8653ed2e7a14cb300fd17952d7f862
Gitweb:        https://git.kernel.org/tip/e906a546bd8653ed2e7a14cb300fd17952d7f862
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 14 Nov 2020 23:36:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 12:01:11 +01:00

genirq/irqdomain: Make irq_domain_disassociate() static

No users outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87a6vja7mb.fsf@nanos.tec.linutronix.de

---
 include/linux/irqdomain.h | 2 --
 kernel/irq/irqdomain.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 77bf7d8..5701a8b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -387,8 +387,6 @@ extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
 extern void irq_domain_associate_many(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
-extern void irq_domain_disassociate(struct irq_domain *domain,
-				    unsigned int irq);
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9c9cb88..3d7463f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -496,7 +496,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 	}
 }
 
-void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
+static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 {
 	struct irq_data *irq_data = irq_get_irq_data(irq);
 	irq_hw_number_t hwirq;
