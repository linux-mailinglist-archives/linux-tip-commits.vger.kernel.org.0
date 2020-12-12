Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6C2D86CC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395257AbgLLNLB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgLLM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CEC0613D6;
        Sat, 12 Dec 2020 04:58:40 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nk1ANxlzzip/J4mjShQ0Pve9n07Xf0iz5t5d5/vJfQY=;
        b=iq9VUxck3I8zV1Dmy4dvmvhdAxGBWtJSDMaISKDry9leK+k2j025/tbvtTmWfzWbhhyg97
        zj0/y8etPja45AXsk6dUPdV9KCM1pNLcBGxGU+QFsuSgpD5HXul+nmqDliRprYkxpV0mKt
        Ox2GxFDsEVBJqvq9Xg00cbTWjFR8yvDesHiA6FwGViTGX3chpcPjiFLCbOOvszxLsTAPMm
        Y3dK15JG6QK5uPeLWCmOH1oXXfevwrzeYYhjIEgilS8fKb7nLwLH2O+Yu4aNxvbfGGGeSD
        5HxVgPNSvu6j3fgogYFZoYfM4PlI4Bife8E7xcAnW0lBTVfzog0884Q4d2dCYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nk1ANxlzzip/J4mjShQ0Pve9n07Xf0iz5t5d5/vJfQY=;
        b=UFoDapTaeoeRjH9CekvXf+2xB7o+JTFTfYpfuwjXpgO1C2/1AzD1UB9UUwkV1MG+r4VrJ0
        WmOjehpn81WcjvBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net/mlx5: Use effective interrupt affinity
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Saeed Mahameed <saeedm@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.876342330@linutronix.de>
References: <20201210194044.876342330@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791620.3364.1699410105095052355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ca00c76aa8acf5a7563dd9f5020f9c6dc9a0577d
Gitweb:        https://git.kernel.org/tip/ca00c76aa8acf5a7563dd9f5020f9c6dc9a0577d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

net/mlx5: Use effective interrupt affinity

Using the interrupt affinity mask for checking locality is not really
working well on architectures which support effective affinity masks.

The affinity mask is either the system wide default or set by user space,
but the architecture can or even must reduce the mask to the effective set,
which means that checking the affinity mask itself does not really tell
about the actual target CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.876342330@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0e19b3c..dad9bd8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1998,7 +1998,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->num_tc   = params->num_tc;
 	c->xdp      = !!params->xdp_prog;
 	c->stats    = &priv->channel_stats[ix].ch;
-	c->aff_mask = irq_get_affinity_mask(irq);
+	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll, 64);
