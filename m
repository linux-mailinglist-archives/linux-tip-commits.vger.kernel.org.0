Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496AB26CC65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgIPUnq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgIPRD1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BCC02C29A;
        Wed, 16 Sep 2020 08:20:26 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhkJ/Uf5Pn+VCZtvUSlByH4G4HSOWZCCYqHkZ2mbY0M=;
        b=Lb2Q8yrJtmEKoaM9vCzYowCSd+DNqVxnZc/Y76/U0to7oizbMj0aBQUndfeX8iHizK+jAe
        xWO4tY01/jTD5aCXGbov0LHjYpV1JPQdIivzqZ8DVS3ER/iHMcVXfMq9IazNrrhWvAyi7o
        NlB1hIP3NypgSPCUz+ZH0YHGrzkqQrJ0A4gALuee5KYCTw+vLDsmQEoeROUbuxI3nLnkz5
        0rTIPgyu1S9+m3nAFeUQbBxcIsUfFCcroYBWMG0cUBvW8S8/z7X/V5ySTwtjr0yzZ+CbOA
        7PbQNB0w9ZiPGPqlxJATl96HKqFR0SrhnbSu3S5t/dJ7+ErtXyBRW1+L1liSSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhkJ/Uf5Pn+VCZtvUSlByH4G4HSOWZCCYqHkZ2mbY0M=;
        b=le48P3HXzgts3VGvHPvbLL7fzm4moj3/RiTguRsdbbXawFZQqMI0GZnbA/Rxm+xpUH/vfd
        WEYECXTNnxBzl6DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Prepare consolidation of irq_alloc_info
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112331.849577844@linutronix.de>
References: <20200826112331.849577844@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026914170.15536.5962432390197354179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     874d9b3a958897e914982962fa25b3bb9dc07988
Gitweb:        https://git.kernel.org/tip/874d9b3a958897e914982962fa25b3bb9dc07988
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:30 +02:00

x86/irq: Prepare consolidation of irq_alloc_info

struct irq_alloc_info is a horrible zoo of unnamed structs in a union. Many
of the struct fields can be generic and don't have to be type specific like
hpet_id, ioapic_id...

Provide a generic set of members to prepare for the consolidation. The goal
is to make irq_alloc_info have the same basic member as the generic
msi_alloc_info so generic MSI domain ops can be reused and yet more mess
can be avoided when (non-PCI) device MSI support comes along.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112331.849577844@linutronix.de
---
 arch/x86/include/asm/hw_irq.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 91b064d..b0e15f6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -44,10 +44,25 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
+/**
+ * irq_alloc_info - X86 specific interrupt allocation info
+ * @type:	X86 specific allocation type
+ * @flags:	Flags for allocation tweaks
+ * @devid:	Device ID for allocations
+ * @hwirq:	Associated hw interrupt number in the domain
+ * @mask:	CPU mask for vector allocation
+ * @desc:	Pointer to msi descriptor
+ * @data:	Allocation specific data
+ */
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
 	u32			flags;
-	const struct cpumask	*mask;	/* CPU mask for vector allocation */
+	u32			devid;
+	irq_hw_number_t		hwirq;
+	const struct cpumask	*mask;
+	struct msi_desc		*desc;
+	void			*data;
+
 	union {
 		int		unused;
 #ifdef	CONFIG_HPET_TIMER
@@ -88,11 +103,6 @@ struct irq_alloc_info {
 			char		*uv_name;
 		};
 #endif
-#if IS_ENABLED(CONFIG_VMD)
-		struct {
-			struct msi_desc *desc;
-		};
-#endif
 	};
 };
 
