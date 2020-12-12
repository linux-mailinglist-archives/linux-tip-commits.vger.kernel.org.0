Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B062D86AB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394074AbgLLNHZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438929AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE5C061794;
        Sat, 12 Dec 2020 04:58:41 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh01GtSzoQZW3QrKDiex0U7KeNFUOw0ONlUWEr5sdzI=;
        b=Nq2pxiM3yH6i7HD3VTvM5bPS5EV8znrbRBl4MI3NcL60rgPi0P6f/uke1+fSUjTDb5DyD0
        /URRR9jA4YeQCHM5lK5QjiikJNTiLqoLE/cRRfwzAg91mRmLvwQ0JhvjfnqA7jzNMp5beh
        IWxsUaqIunupLsbb9hiGrlPqX0cEh7Q+1TV1jiq3eVHL8NAq3yrhVNA8reaUJLvdLNu7u8
        hcSqrKzgx0tDe3Ezg59KIwh+HXpBOweWhmS+TKvM8N0h24DcFYd+82Xa7eXGCXacmaRMQA
        AcyViIh9Q7DAez8z6eIEqN3Bdh84TtzYqhix9lD6EcsMYB2kGdhE8rDU1KKykQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh01GtSzoQZW3QrKDiex0U7KeNFUOw0ONlUWEr5sdzI=;
        b=1KgNtihPiJnunjBMJrNf60py4MSExtxoy4YtPdhTz0A8KodmU21LfPIeC7j6Cp5NezcoGr
        cL5dmcG4XXZlTZDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net/mlx4: Replace irq_to_desc() abuse
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tariq Toukan <tariqt@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.580936243@linutronix.de>
References: <20201210194044.580936243@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791699.3364.146087151070915411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ea444c8f27b50f14ccfece192a6199d3ada9253
Gitweb:        https://git.kernel.org/tip/5ea444c8f27b50f14ccfece192a6199d3ada9253
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

net/mlx4: Replace irq_to_desc() abuse

No driver has any business with the internals of an interrupt
descriptor. Storing a pointer to it just to use yet another helper at the
actual usage site to retrieve the affinity mask is creative at best. Just
because C does not allow encapsulation does not mean that the kernel has no
limits.

Retrieve a pointer to the affinity mask itself and use that. It's still
using an interface which is usually not for random drivers, but definitely
less hideous than the previous hack.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.580936243@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 8 +++-----
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 6 +-----
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 3 ++-
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 74d4667..2a250f3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -90,7 +90,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 			int cq_idx)
 {
 	struct mlx4_en_dev *mdev = priv->mdev;
-	int err = 0;
+	int irq, err = 0;
 	int timestamp_en = 0;
 	bool assigned_eq = false;
 
@@ -116,10 +116,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 
 			assigned_eq = true;
 		}
-
-		cq->irq_desc =
-			irq_to_desc(mlx4_eq_get_irq(mdev->dev,
-						    cq->vector));
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
+		cq->aff_mask = irq_get_affinity_mask(irq);
 	} else {
 		/* For TX we use the same irq per
 		ring we assigned for the RX    */
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 502d1b9..399459a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -959,8 +959,6 @@ int mlx4_en_poll_rx_cq(struct napi_struct *napi, int budget)
 
 	/* If we used up all the quota - we're probably not done yet... */
 	if (done == budget || !clean_complete) {
-		const struct cpumask *aff;
-		struct irq_data *idata;
 		int cpu_curr;
 
 		/* in case we got here because of !clean_complete */
@@ -969,10 +967,8 @@ int mlx4_en_poll_rx_cq(struct napi_struct *napi, int budget)
 		INC_PERF_COUNTER(priv->pstats.napi_quota);
 
 		cpu_curr = smp_processor_id();
-		idata = irq_desc_get_irq_data(cq->irq_desc);
-		aff = irq_data_get_affinity_mask(idata);
 
-		if (likely(cpumask_test_cpu(cpu_curr, aff)))
+		if (likely(cpumask_test_cpu(cpu_curr, cq->aff_mask)))
 			return budget;
 
 		/* Current cpu is not according to smp_irq_affinity -
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index a46efe3..48d71e0 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -46,6 +46,7 @@
 #endif
 #include <linux/cpu_rmap.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/irq.h>
 #include <net/xdp.h>
 
 #include <linux/mlx4/device.h>
@@ -380,7 +381,7 @@ struct mlx4_en_cq {
 	struct mlx4_cqe *buf;
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
-	struct irq_desc *irq_desc;
+	const struct cpumask *aff_mask;
 };
 
 struct mlx4_en_port_profile {
