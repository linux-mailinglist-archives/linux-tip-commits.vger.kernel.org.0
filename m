Return-Path: <linux-tip-commits+bounces-2648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D815B9B667A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821921F214C3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155611F472D;
	Wed, 30 Oct 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0t2VnIA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7LOuktl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997E1F131C;
	Wed, 30 Oct 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299797; cv=none; b=s6kO9mk/hDn4Je3bh3bo0PQoMC41VQKuDGaofrGtL3MBNOJHTiu6M/MXZd1V6CoJ7QhDB8UJUnNqbJHutJtTC1wQIlDrTX0gCIatjj4jATpmOaV9PFTiJhIfF4dPkfTbmGbMvgDkz7gfg7HulkyeEzW098tC6WXQ0rnm2Cff+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299797; c=relaxed/simple;
	bh=n6YhXFC3o0gxDpEEkteBbpQRaWQIj2mWAMsh6yeZx6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=joGKqrsK/GlNEv3pUye0rRjoH/2giVV/IglSI+z9p38nTmhwcexosOd3zqyRMlATpRqlaxjgPxeVPRBF3DoPZ1eUTHaeKrLVWq3A9BXOe51r6inau281+tXKnuFD0eE4cou1xXSDCrdgSVr4BLsQFU8/SMyhwDZnpqY+A1ysEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0t2VnIA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7LOuktl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 14:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730299793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXr+7W0i7y/UNtmd3bOUDzCe4RhHn91qAZ2T6qx48+s=;
	b=h0t2VnIAbwjNQ99KfwxKon3QudrFeD13H1Y3SF1mtJgQfw2BaXQ2vq1LP92bf2cn+/PzPE
	kCK7DPvjZfIDvF10ALxQQYgWju3Z1jB6i6tKU8qRvHbB1oJGMY5cgFjElyAui2Uw9I29I+
	AmWXKYmwvUrEfuYcVmXaN2ekverH2bQsp8uh4yXYBe9nJdlWYjSu6ZqbZpeKfZTc+02gru
	yHYFW6/g8YhnnNTMV090jcjBBY6Ve6YgO9+wwdNb9URsyuZhMm3eM/DnU7UAMKclsSNcjv
	XOlP6yhoU2B39QIwK6489rHgCWoxsDNHenMedpx9UTE7GMV6FAj6QLZSN1HPCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730299793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXr+7W0i7y/UNtmd3bOUDzCe4RhHn91qAZ2T6qx48+s=;
	b=O7LOuktlrhUXeOGCvm1fkbl5xlhbDnUFVE9Kw2ubXFtJ26L1+cTUBrb1JUvibo41jMwRjK
	aDWxA9dCU8oZ9bBg==
From: "tip-bot2 for Chao-ying Fu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mips-gic: Setup defaults in each cluster
Cc: "Chao-ying Fu" <cfu@wavecomp.com>,
 Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Serge Semin <fancer.lancer@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241028175935.51250-4-arikalo@gmail.com>
References: <20241028175935.51250-4-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173029979246.3137.4752160860801797555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c7c0d13d1d308b6e2a3d69274b38fca0167081df
Gitweb:        https://git.kernel.org/tip/c7c0d13d1d308b6e2a3d69274b38fca0167081df
Author:        Chao-ying Fu <cfu@wavecomp.com>
AuthorDate:    Mon, 28 Oct 2024 18:59:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 15:41:18 +01:00

irqchip/mips-gic: Setup defaults in each cluster

In multi-cluster MIPS I6500 systems, there is a GIC per cluster.

The default shared interrupt setup configured in gic_of_init() applies only
to the GIC in the cluster containing the boot CPU, leaving the GICs of
other clusters unconfigured.

Configure the other clusters as well.

Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/all/20241028175935.51250-4-arikalo@gmail.com

---
 drivers/irqchip/irq-mips-gic.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 29bdfdc..d93a076 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -764,7 +764,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig;
+	unsigned int cpu_vec, i, gicconfig, cl, nclusters;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -845,11 +845,29 @@ static int __init gic_of_init(struct device_node *node,
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
-	/* Setup defaults */
-	for (i = 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(i);
+	/*
+	 * Initialise each cluster's GIC shared registers to sane default
+	 * values.
+	 * Otherwise, the IPI set up will be erased if we move code
+	 * to gic_cpu_startup for each cpu.
+	 */
+	nclusters = mips_cps_numclusters();
+	for (cl = 0; cl < nclusters; cl++) {
+		if (cl == cpu_cluster(&current_cpu_data)) {
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_trig(i, GIC_TRIG_LEVEL);
+				write_gic_rmask(i);
+			}
+		} else {
+			mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+			for (i = 0; i < gic_shared_intrs; i++) {
+				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_redir_trig(i, GIC_TRIG_LEVEL);
+				write_gic_redir_rmask(i);
+			}
+			mips_cm_unlock_other();
+		}
 	}
 
 	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,

