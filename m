Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460102D86CE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438893AbgLLNMb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438894AbgLLM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D1C061793;
        Sat, 12 Dec 2020 04:58:40 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Syk/5Pm78WmjbYRYKALZAHgm5RituhwmJV4c+Upm+kI=;
        b=fQIB96yKil3OloY4C+o933v14C2WIBCleFEofP+vXOp2mtTDP2XOpRR+5ndsFK2Gqf5jM8
        ivQdbijp+wxkIcjTr80sRvUUHDE9uT+77jHBmYWbjhyxOB5CNtJPKC6oKYiVjaXehp3OZ7
        rOnEbHfT5W32VCahDeiotgFWYjg29ebHGZJKrGE4Rq0/EcKynjEzIEhX4Fw1E0VUxUnCov
        +MQEH3buvJjMlVVdE8g+Rp2llh8iK9ttSXS1iAcooo0Q1VFEbNm2pvr5QD3BzurdXzm/PD
        xIRS6Ns6SWIUR5kJmIq566nHSAAarO6I0jw6/owcvkDsp/m5PsrDgJHAg0ReVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Syk/5Pm78WmjbYRYKALZAHgm5RituhwmJV4c+Upm+kI=;
        b=GpAJy6ZKhV42JGBXgxCN0QQjDV0SGSq8Mk9A13sNxBD0A6fRexCKeAwc+dM/RG78dvh5t3
        kIaJ4NRElljtlNAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net/mlx5: Replace irq_to_desc() abuse
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Saeed Mahameed <saeedm@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.769458162@linutronix.de>
References: <20201210194044.769458162@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791646.3364.2505749639821754000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3d18847680102182fed60b90ae65cbbb3d929a3c
Gitweb:        https://git.kernel.org/tip/3d18847680102182fed60b90ae65cbbb3d929a3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

net/mlx5: Replace irq_to_desc() abuse

No driver has any business with the internals of an interrupt
descriptor. Storing a pointer to it just to use yet another helper at the
actual usage site to retrieve the affinity mask is creative at best. Just
because C does not allow encapsulation does not mean that the kernel has no
limits.

Retrieve a pointer to the affinity mask itself and use that. It's still
using an interface which is usually not for random drivers, but definitely
less hideous than the previous hack.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.769458162@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2f05b0f..45fd585 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -669,7 +669,7 @@ struct mlx5e_channel {
 	spinlock_t                 async_icosq_lock;
 
 	/* data path - accessed per napi poll */
-	struct irq_desc *irq_desc;
+	const struct cpumask	  *aff_mask;
 	struct mlx5e_ch_stats     *stats;
 
 	/* control */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b3f02aa..0e19b3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1998,7 +1998,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->num_tc   = params->num_tc;
 	c->xdp      = !!params->xdp_prog;
 	c->stats    = &priv->channel_stats[ix].ch;
-	c->irq_desc = irq_to_desc(irq);
+	c->aff_mask = irq_get_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll, 64);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index d586867..793e313 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -40,12 +40,8 @@
 static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
 {
 	int current_cpu = smp_processor_id();
-	const struct cpumask *aff;
-	struct irq_data *idata;
 
-	idata = irq_desc_get_irq_data(c->irq_desc);
-	aff = irq_data_get_affinity_mask(idata);
-	return cpumask_test_cpu(current_cpu, aff);
+	return cpumask_test_cpu(current_cpu, c->aff_mask);
 }
 
 static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
