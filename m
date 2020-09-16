Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A937326CDFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIPVH3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9AC02C283;
        Wed, 16 Sep 2020 08:17:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lomKa/3VCt+1oXOHm3axXG3ZewcLHQhqdBYAUE26kfs=;
        b=pVE36DSzdz2I4532hMgF75UoXEcpwqWtQ5G6KWbZcO2+N+jiz8gdJPp3BFzqHR2SNnk4kY
        PrpX/nwVRXkH5r+ikPq86VqIruOXyDVldlNFUEpOHFPT+T59xHjyeQFqelETn8tcYElfaR
        qGKxZ5wBT9XIARxZlf3x+iqAPFksy+Vsbgqxu7ftcpfA/JS6u95YSNVMCZnIOi/vTO6MtV
        kglc/x6fM8bGunFUZTPVrR33QNmDjmr0lSkJLQ5DvkObASYMmXjFAVMcRfPbu+2+rXcRHv
        W0tim6ed2AviC5Q/dxa4ZeHJcjIyBZue6ClNAZs8quoG+7ryGEywBPTQ3u2OQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lomKa/3VCt+1oXOHm3axXG3ZewcLHQhqdBYAUE26kfs=;
        b=9Bv1msLxVfwhIHR4wZGnZJDahWebmqGBMoMrwk/UAut4IH96C/je9PHNbSBUoagAX4o23C
        Qg9if+24taeJktDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.954409970@linutronix.de>
References: <20200826112332.954409970@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913348.15536.1116317786269080023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     c6c9e2838c5f0b94773511586123bcb125757f2a
Gitweb:        https://git.kernel.org/tip/c6c9e2838c5f0b94773511586123bcb125757f2a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI

PCI devices behind a VMD bus are not subject to interrupt remapping, but
the irq domain for VMD MSI cannot be distinguished from a regular PCI/MSI
irq domain.

Add a new domain bus token and allow it in the bus token check in
msi_check_reservation_mode() to keep the functionality the same once VMD
uses this token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Link: https://lore.kernel.org/r/20200826112332.954409970@linutronix.de

---
 include/linux/irqdomain.h | 1 +
 kernel/irq/msi.c          | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b37350c..44445d9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 640668e..616b958 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -364,8 +364,13 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 {
 	struct msi_desc *desc;
 
-	if (domain->bus_token != DOMAIN_BUS_PCI_MSI)
+	switch(domain->bus_token) {
+	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_VMD_MSI:
+		break;
+	default:
 		return false;
+	}
 
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
