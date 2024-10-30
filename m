Return-Path: <linux-tip-commits+bounces-2647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2C9B6678
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95969280256
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C71F4726;
	Wed, 30 Oct 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvLZ8HSs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kvmxu5JV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EC26AD4;
	Wed, 30 Oct 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299795; cv=none; b=fEGbbGdmDreSAOkZPhe+OEhU3y1zOiMggHf5URemEHsjuhhFPoepYBWOxD366mVoytk3wgiNe3zeidiRSqoYP+TddJwYVhUJHi4zVmUSZwfS7Ndr2sY+ZqjDqvrUtI5whatvjCp1D3KGVwUDOHqCnPcGUN7GdKbsx9LWYNE5SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299795; c=relaxed/simple;
	bh=NcxMU4S7X+EKySzWCB0SikmEKncE6APZpnVBX7sZ9F8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CInlWQFcEynFYz0lAoH2JzMqiApW+3vCP/oqylicyvpBjS6UPsXaXrZ/EySU00I5bPtw0EGgZUCQgTXvG08D+bpPZSFhbxYY7sQT3cOL91VaT3w15sI6MPLQ+tZvkEzasbjg8JEQ0ekoqYm2aUI+/lvNqFTJa2U/bNcjYy6tON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvLZ8HSs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kvmxu5JV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 14:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730299791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dv4J/KuaHF/yG3OPBdAKJ8i882g+dgZgJ8KwobcCXuI=;
	b=hvLZ8HSselp+du6ve9K/cMOmIcGyLjI8qQny5lHkS3RB5r/a3ltDHUUptJCc2XsF/1ece6
	pwd6a/tCIuHuxpYiZhxOZjAtAdWaIuWKG++Nqho2e5X8a40pGdU+tog2nM1I8e9K8zt6eJ
	PFFulqisqeYhvToBC6GiHg+yNhpfRNmfWC7LBMl06A7arLrxurCGqNzW/S+WxVAAukkCVi
	VCPMoncLS9AHvZy8tVX5aYToExfn3plZUOUnMYKszxYm3GNvHC8eZ8u3gXDOjpnC32wWZW
	mYm9bPr/83aO/HtYg50EMI7Oi9JQtczWo4aJF3ZOhIZLupHhCtj2g5XiUXNRwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730299791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dv4J/KuaHF/yG3OPBdAKJ8i882g+dgZgJ8KwobcCXuI=;
	b=Kvmxu5JVbEWmGJQ5Iq+TktoL0Sim1/1Ou9j7MDIQgZyUaG4ZUC8k04oLkAENQxufbCYY33
	femgxYaOvCTKoJCg==
From: "tip-bot2 for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mips-gic: Prevent indirect access to clusters
 without CPU cores
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241028175935.51250-14-arikalo@gmail.com>
References: <20241028175935.51250-14-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173029979090.3137.10502719543917785749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d1cb1437b785f312d63f447e2e79ff768e7ccc29
Gitweb:        https://git.kernel.org/tip/d1cb1437b785f312d63f447e2e79ff768e7ccc29
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Mon, 28 Oct 2024 18:59:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 15:41:32 +01:00

irqchip/mips-gic: Prevent indirect access to clusters without CPU cores

It is possible to have zero CPU cores in a cluster; in such cases, it is
not possible to access the GIC, and any indirect access leads to an
exception.

Prevent access to such clusters by checking the number of cores in the
cluster at all places which issue indirect cluster access.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241028175935.51250-14-arikalo@gmail.com
---
 drivers/irqchip/irq-mips-gic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index f42f69b..bca8053 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -141,7 +141,8 @@ static bool gic_irq_lock_cluster(struct irq_data *d)
 	cl = cpu_cluster(&cpu_data[cpu]);
 	if (cl == cpu_cluster(&current_cpu_data))
 		return false;
-
+	if (mips_cps_numcores(cl) == 0)
+		return false;
 	mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
 	return true;
 }
@@ -507,6 +508,9 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	struct gic_all_vpes_chip_data *cd;
 	int intr, cpu;
 
+	if (!mips_cps_multicluster_cpus())
+		return;
+
 	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
@@ -520,6 +524,9 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	struct gic_all_vpes_chip_data *cd;
 	int intr, cpu;
 
+	if (!mips_cps_multicluster_cpus())
+		return;
+
 	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
@@ -687,8 +694,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	for_each_online_cpu_gic(cpu, &gic_lock)
-		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
+	if (mips_cps_multicluster_cpus()) {
+		for_each_online_cpu_gic(cpu, &gic_lock)
+			write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
+	}
 
 	return 0;
 }
@@ -982,7 +991,7 @@ static int __init gic_of_init(struct device_node *node,
 				change_gic_trig(i, GIC_TRIG_LEVEL);
 				write_gic_rmask(i);
 			}
-		} else {
+		} else if (mips_cps_numcores(cl) != 0) {
 			mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
 			for (i = 0; i < gic_shared_intrs; i++) {
 				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
@@ -990,6 +999,9 @@ static int __init gic_of_init(struct device_node *node,
 				write_gic_redir_rmask(i);
 			}
 			mips_cm_unlock_other();
+
+		} else {
+			pr_warn("No CPU cores on the cluster %d skip it\n", cl);
 		}
 	}
 

