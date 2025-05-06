Return-Path: <linux-tip-commits+bounces-5306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E109AAC609
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693324A1EB6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DA288C3A;
	Tue,  6 May 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYit7/ik";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="whpx+w8Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0473288527;
	Tue,  6 May 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537643; cv=none; b=iFRiuYIyHdNrMkU6IrU1lGmhkwfcAdY/Frxjr7sohvtpnLOvy1xVYdASPs68RoVxEd95CajLtH7zDs74p3pJTEArFwzYxzhZBk940ZXkFmQ+ovGEMKxzEDL6nmM1p3jgcY7NeO3xMGmF5X9jcTcLeTlwTrgiB/+H6L2slDLrGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537643; c=relaxed/simple;
	bh=PdJOZNgqk4iDD30IpojstTB23pWkjEutR4g0cEP9sxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KUdwupfXLgV0zkUOJmkCybjwjnhGWL8G1O9538bHrsy6pL5S+R4Vis30dj1d19eDVCeb/+cZYuemaM/6q7c329SzcEkulPDdu1x4LB8d6N8344Bo7/UT5KwGTvc7OnP2kSWHjFXPI9sVKy2Nh/Tt1Mih8qjcz8HlCk2yMQD1qzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYit7/ik; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=whpx+w8Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6n6R3QS6vlzOxNVUjGGmJcGXVGL5fEjZpyuv0gckgo=;
	b=yYit7/ik++QrqnXVfJYL6FWnfMZaqQjqkXZ8COdJpwTLkMJ2gFpovNWq63b4ZAMA0xBmm+
	wdD8N9PqiRYMdGWH2d9QC7uXDVk97h3GtDwlxBhyco3ZJDApRc7Do4FmOX4vSegctmXU/A
	MfqA/JmuP1t89vd7Fu81zq+uOxVsuIbBASN+C6a8DHe+k8GY+xCht4hsxWCBKLnPME7tVj
	JQhoCQ+BHRoj9yC6KWd58MYBoO0n85FfLbG44CQaBit2TVXvDBuN3+uYZwvW+nXHTvpDht
	Xs+8/5awSyVmCEjsjoATjaeKY3V1mOFlpB1GTqz/Fk2w5AEw6LqVJkPA6atKhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6n6R3QS6vlzOxNVUjGGmJcGXVGL5fEjZpyuv0gckgo=;
	b=whpx+w8ZVOUdHekqY4NeJIvLCP4E5woYP+P/L6/v3zoJVK5/CEk76lyCCPYtAK8Vc2clDR
	PCT6KqhffFwImeBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] ARC: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-14-jirislaby@kernel.org>
References: <20250319092951.37667-14-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763924.406.8268726967266899964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     12fc10f71905ebdc3ca6620f173c517d5f059d8e
Gitweb:        https://git.kernel.org/tip/12fc10f71905ebdc3ca6620f173c517d5f059d8e
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:04 +02:00

ARC: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-14-jirislaby@kernel.org

---
 arch/arc/kernel/intc-arcv2.c   | 2 +-
 arch/arc/kernel/intc-compact.c | 5 +++--
 arch/arc/kernel/mcip.c         | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index fea29d9..809edc5 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -170,7 +170,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, nr_cpu_irqs, &arcv2_irq_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_cpu_irqs, &arcv2_irq_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
index 1d2ff1c..1b159e9 100644
--- a/arch/arc/kernel/intc-compact.c
+++ b/arch/arc/kernel/intc-compact.c
@@ -112,8 +112,9 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, NR_CPU_IRQS,
-					    &arc_intc_domain_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc),
+					       NR_CPU_IRQS,
+					       &arc_intc_domain_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index cdd370e..02b28a9 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -391,7 +391,8 @@ idu_of_init(struct device_node *intc, struct device_node *parent)
 
 	pr_info("MCIP: IDU supports %u common irqs\n", nr_irqs);
 
-	domain = irq_domain_add_linear(intc, nr_irqs, &idu_irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_irqs,
+					  &idu_irq_ops, NULL);
 
 	/* Parent interrupts (core-intc) are already mapped */
 

