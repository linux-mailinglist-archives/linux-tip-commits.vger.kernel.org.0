Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF12B45C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKPOYF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 09:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgKPOYF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 09:24:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EAFC0613CF;
        Mon, 16 Nov 2020 06:24:04 -0800 (PST)
Date:   Mon, 16 Nov 2020 14:24:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605536643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vScRVy7QM0+sLnAoznVf5bxH0XKWtr+smlPyTC25XQ=;
        b=3Ux3D+P+JrZAW+BzAz452omeDSiysjBNg7wnMEGfSq+I0OdBSFBiRscq8IARfonGy51UX5
        PbIEBQFYtwo1ocnxkQwGYmgoc7jNAo63pUCfqvRoHdRm8eZHf3yHepyEJAXYLPpHNgot96
        PE5qDtilofsgvw1we/jVDrYjfxM8YYb8gsDYu21PlCuP5wbA8p8KoGaIzbU8St74gT+kX4
        SI3gKehsfkMr6yIQEtV9Jj4L8Dso9hNwDDzE7uaaA9kf/M2QPJKiYvUvnHUYwAUiJp0brT
        8qgmhDxv2/wgwZboz56AfRNgDhTrNApHWfhTsBrOqfaQhs8ISEitukaHW5wCiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605536643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vScRVy7QM0+sLnAoznVf5bxH0XKWtr+smlPyTC25XQ=;
        b=VNq/abCVRw7uHFUen6mJov60NKMjIYlDzhuCoy9iAM2V+VtQo/ExO2vU4BsJZzvDNw1FQ/
        F0FBpsM5O+2h+oBA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix kernel-doc markups
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C13a44f4f0c3135e14b16ae8fcce4af1eab27cb5f=2E16055?=
 =?utf-8?q?21731=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C13a44f4f0c3135e14b16ae8fcce4af1eab27cb5f=2E160552?=
 =?utf-8?q?1731=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160553664203.11244.9491218497802141088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8c67d247dcad67fbdd07c8bab9818d0b8d9240bf
Gitweb:        https://git.kernel.org/tip/8c67d247dcad67fbdd07c8bab9818d0b8d9240bf
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 11:18:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 15:20:54 +01:00

genirq: Fix kernel-doc markups

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/13a44f4f0c3135e14b16ae8fcce4af1eab27cb5f.1605521731.git.mchehab+huawei@kernel.org

---
 kernel/irq/chip.c         | 2 +-
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b9b9618..df75c35 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -61,7 +61,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_type - set the irq trigger type for an irq
+ *	irq_set_irq_type - set the irq trigger type for an irq
  *	@irq:	irq number
  *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a0..a23ac2b 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -269,7 +269,7 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 }
 
 /**
- * __irq_alloc_domain_generic_chip - Allocate generic chips for an irq domain
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
  * @d:			irq domain for which to allocate chips
  * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
  * @num_ct:		Number of irq_chip_type instances associated with this
