Return-Path: <linux-tip-commits+bounces-2164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BB96C6AF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6091C21975
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F41E410C;
	Wed,  4 Sep 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xchRNXjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otzWg+Ax"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2C1E2039;
	Wed,  4 Sep 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475698; cv=none; b=W/ndooWhZfAvAUHstWl9fdsW0MmJ6wv3lSKXxWAyLrtChod1QpNNngLfNewDbNpzQbRo2aPGR/j8p8SxJgIJtpMgmoYKRMe6UAsbSzsR2rzSkP2DwSTyIBc2Pdi88ev9eC6FNZgp6M5BCirF7OkPFARcCRJOPuS3prQ0nJLaWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475698; c=relaxed/simple;
	bh=7wfKcuTn7NMipmc83QEZLVK/TZ0cbb7vGV73qsYwx6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=anVNwiVjXRgJxbirj0JWidIocV792ONuvmNducUASjuCqnxSSD0JbrcoJaPfGQWT1P+LrIM0+JksUYZT01xC7DPahwCMrv8EwZy/o9/3EEV1sW/GL6zoWN8F2ZjNt6sV00RVePtF2P2Q1GlIGaJD7yEuvp7x7Hj51+tGtqCi36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xchRNXjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=otzWg+Ax; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 18:48:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725475694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmqbj5CYBKv3wtEvTWMKJRBVceO87ZyNCCcV4RD6/l4=;
	b=xchRNXjX7++vBkSlvxxhFQNJQjUtxg7LVvU6sfbSckm0o9CRcGV8BqB+KeAeMqgEwVo/lB
	IHJruhXCy8n1v2hD0+2vcO4Bv3peOK7tEFEP1L4pOJZKoMyLPdWdgvDSSzCaVo3iKg66Dz
	Py8g2Jda992XNldNqQo3egJxw/s1YPGQ0qZAS+h8tNn4ykCcP9m6jiwBfJnEKaoAacn74x
	UjXTiXzdnqFTU2PiVSWLomFyVT52MPxr+oakyjGwlTi6W0X+dr5NHp0zA+lGywZdZRywNq
	EqiA1ijNRistbC+IQtMn7cncYjrU8dLx33FoNgwHcqQf3NBmscAfaa+Q12ELiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725475694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmqbj5CYBKv3wtEvTWMKJRBVceO87ZyNCCcV4RD6/l4=;
	b=otzWg+AxYV/iXNS/2YuwbOJITaA3AytETGuoah1sncH4g4ufnGM6YhkloiBFECgh+nhaP1
	+jW4HqUoRpHj4AAg==
From: "tip-bot2 for Nick Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/apple-aic: Add a new "Global fast IPIs only"
 feature level
Cc: Nick Chan <towinchenmi@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sven Peter <sven@svenpeter.dev>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240901034143.12731-4-towinchenmi@gmail.com>
References: <20240901034143.12731-4-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172547569410.2215.2054723833730489550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a845342e6e5fb4937564f93cc88e00c732286fe3
Gitweb:        https://git.kernel.org/tip/a845342e6e5fb4937564f93cc88e00c732286fe3
Author:        Nick Chan <towinchenmi@gmail.com>
AuthorDate:    Sun, 01 Sep 2024 11:40:06 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 20:43:30 +02:00

irqchip/apple-aic: Add a new "Global fast IPIs only" feature level

Starting with the A11 (T8015) SoC, Apple began using arm64 sysregs for
fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.

Add a new feature level, used by the compatible "apple,t8015-aic",
controlled by a static branch key named use_local_fast_ipi. When
use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
"global" IPIs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Link: https://lore.kernel.org/all/20240901034143.12731-4-towinchenmi@gmail.com

---
 drivers/irqchip/irq-apple-aic.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 8d81d5f..9012690 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -235,6 +235,8 @@ enum fiq_hwirq {
 };
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
+static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
 
 struct aic_info {
 	int version;
@@ -252,6 +254,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool local_fast_ipi;
 };
 
 static const struct aic_info aic1_info __initconst = {
@@ -270,17 +273,32 @@ static const struct aic_info aic1_fipi_info __initconst = {
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic1_local_fipi_info __initconst = {
+	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+
+	.fast_ipi	= true,
+	.local_fast_ipi = true,
+};
+
 static const struct aic_info aic2_info __initconst = {
 	.version	= 2,
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
 	.fast_ipi	= true,
+	.local_fast_ipi = true,
 };
 
 static const struct of_device_id aic_info_match[] = {
 	{
 		.compatible = "apple,t8103-aic",
+		.data = &aic1_local_fipi_info,
+	},
+	{
+		.compatible = "apple,t8015-aic",
 		.data = &aic1_fipi_info,
 	},
 	{
@@ -750,12 +768,12 @@ static void aic_ipi_send_fast(int cpu)
 	u64 cluster = MPIDR_CLUSTER(mpidr);
 	u64 idx = MPIDR_CPU(mpidr);
 
-	if (MPIDR_CLUSTER(my_mpidr) == cluster)
-		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
-			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
-	else
+	if (static_branch_likely(&use_local_fast_ipi) && MPIDR_CLUSTER(my_mpidr) == cluster) {
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx), SYS_IMP_APL_IPI_RR_LOCAL_EL1);
+	} else {
 		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cluster),
 			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
+	}
 	isb();
 }
 
@@ -990,6 +1008,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
+	if (!irqc->info.local_fast_ipi)
+		static_branch_disable(&use_local_fast_ipi);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),

