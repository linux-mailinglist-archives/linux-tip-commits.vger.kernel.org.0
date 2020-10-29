Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2329EB93
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgJ2MPi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJ2MPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:37 -0400
Date:   Thu, 29 Oct 2020 12:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjaxofdeyoBzmp8tu31qJLMa/tcENWmvARlCWqrMd2Q=;
        b=ukOKGdkU2/BDaj2WXc1bAwwsMfzVmW+Eo9HLqyzDQdYS8C6LN7MG5XLIQn1mGcPkgEpAI0
        IeZ5li9CeluJUxtEhOb3yqSYaZnX3+RK2tPaCGFKNEYGISoaoVB7KtHbvNgZWLtgOlHeR3
        0cyf65y9v5EP7hCv0ZKIPNXRG6QpLFfXXNrP5apxWoYSyHwrqDmqYPDW2SqacwG+tdj14z
        wuUSK0YzuXFWsGfn/0EKmV5lasshB5MqjXefIU4TxqG4Xuig02i7glbuSyc6WbX27RxIeH
        yY9NVtCcFSP9Pj/0/cCSNqged830lkkRzgIiLbwH3a5/WFVfL7Mn6/Gz6CqjRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjaxofdeyoBzmp8tu31qJLMa/tcENWmvARlCWqrMd2Q=;
        b=QHahSfjIdfZJhHBSulJWv7/WVibx5UPX1GIf5FpR0S8erbpgKCOQaU2LqwK14Xo6DvyoE/
        cUAr37egTbIdtCAg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/hpet: Use irq_find_matching_fwspec() to find
 remapping irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-28-dwmw2@infradead.org>
References: <20201024213535.443185-28-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373319.397.5962681410038991309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c2a5881c28e5bb4cb901029423a1c7068c0afa2d
Gitweb:        https://git.kernel.org/tip/c2a5881c28e5bb4cb901029423a1c7068c0afa2d
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

x86/hpet: Use irq_find_matching_fwspec() to find remapping irqdomain

All possible parent domains have a select method now. Make use of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-28-dwmw2@infradead.org

---
 arch/x86/kernel/hpet.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3b8b127..08651a4 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -543,8 +543,8 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 {
 	struct msi_domain_info *domain_info;
 	struct irq_domain *parent, *d;
-	struct irq_alloc_info info;
 	struct fwnode_handle *fn;
+	struct irq_fwspec fwspec;
 
 	if (x86_vector_domain == NULL)
 		return NULL;
@@ -556,15 +556,6 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	*domain_info = hpet_msi_domain_info;
 	domain_info->data = (void *)(long)hpet_id;
 
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.devid = hpet_id;
-	parent = irq_remapping_get_irq_domain(&info);
-	if (parent == NULL)
-		parent = x86_vector_domain;
-	else
-		hpet_msi_controller.name = "IR-HPET-MSI";
-
 	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
 					      hpet_id);
 	if (!fn) {
@@ -572,6 +563,19 @@ static struct irq_domain *hpet_create_irq_domain(int hpet_id)
 		return NULL;
 	}
 
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hpet_id;
+
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+		return NULL;
+	}
+	if (parent != x86_vector_domain)
+		hpet_msi_controller.name = "IR-HPET-MSI";
+
 	d = msi_create_irq_domain(fn, domain_info, parent);
 	if (!d) {
 		irq_domain_free_fwnode(fn);
