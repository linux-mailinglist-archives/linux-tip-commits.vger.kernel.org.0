Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61F529EB6B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgJ2MPi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgJ2MPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0782AC0613CF;
        Thu, 29 Oct 2020 05:15:37 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EeXLfeaYJiOuRnab9AdTS8oAINSs0VFxMHS+r/WrzE=;
        b=Mc1+k1y1HAWt4KcaAFCaf9Hnab6zWV7lizGWT8rl0ZPlKmV/ERHHeB+Q+WL2MVRTdS44pc
        QYwneF8rW/x2EPHYpI0FBvJPKa5tXBk8YqWTbN4F6xRmQ8N2DWlLXSrk87zZd823HD2vLJ
        Ln9QF39ygr8g9vNtlv80iXTWglCK91oXt5bko/GKkPskk3IFq7Ypol26zR5svNaZcE/k5K
        51y/17IjbVKlEYebeYpCF+ovY8oXBKUGYUV6gH25zooWNzUDjcNZAv4TdQLIwndWkwGZc+
        K21U6eIArnNXrDRwfcsOW6kTc6DcrEYTSQMC6c2XisaguF/YxgInoC2Awryh/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EeXLfeaYJiOuRnab9AdTS8oAINSs0VFxMHS+r/WrzE=;
        b=pcUudlE1cgHZhtiwcstOCfA9rc7RafKZ4uQyHMw1+BYLTTbZCtrYheOZMduJy45n3F3GG+
        W7wD+V9bu0IoJQDg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/hyper-v: Implement select() method on remapping
 irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-27-dwmw2@infradead.org>
References: <20201024213535.443185-27-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373378.397.9950426517318034330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a491bb19f728cdb8cc1f4734ecc57c0afa099fac
Gitweb:        https://git.kernel.org/tip/a491bb19f728cdb8cc1f4734ecc57c0afa099fac
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

iommu/hyper-v: Implement select() method on remapping irqdomain

Preparatory for removing irq_remapping_get_irq_domain()

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-27-dwmw2@infradead.org

---
 drivers/iommu/hyperv-iommu.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 37dd485..78a264a 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -101,7 +101,16 @@ static void hyperv_irq_remapping_free(struct irq_domain *domain,
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
 
+static int hyperv_irq_remapping_select(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	/* Claim only the first (and only) I/OAPIC */
+	return x86_fwspec_is_ioapic(fwspec) && fwspec->param[0] == 0;
+}
+
 static const struct irq_domain_ops hyperv_ir_domain_ops = {
+	.select = hyperv_irq_remapping_select,
 	.alloc = hyperv_irq_remapping_alloc,
 	.free = hyperv_irq_remapping_free,
 };
