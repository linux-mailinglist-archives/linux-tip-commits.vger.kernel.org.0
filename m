Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1612D86C8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436726AbgLLNLB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438897AbgLLM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9EC06179C;
        Sat, 12 Dec 2020 04:58:41 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE64vdFNvpjx3DSB/F3NdQAj8Ny1d5vxUlKKhg9abWs=;
        b=pDr8JsMePYh7/S0RHYHu/mnlFLZyGbIblHN8Kk9IU4aIouNpsNxFnlxBdesOWpcd2nv4zN
        oyrI5ct6O1McHSy2nyL8ma4QUwvpnmL7hNItF0zmZSSgcJw8u4t8inbAKcUh+9P2HjsANQ
        dGQlqZ6KWz3yCaWJlOGV4bOTDK2cB+LsJDTSGkNsS1Cm6T2R8PzbMm5Bua4B6s6awbTERc
        ZO0R818EPAZlnR2K7qULPUUQGm5gsuQvqiArnIEh9IXan7qSy6ALTyCZd0st1YBSplJk7v
        zsgVkZjzkAfHvsK5EwWiS8+W9iW/cZeoi4HxiXuNxBlcMFOTf3sw/GVDf+OewQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE64vdFNvpjx3DSB/F3NdQAj8Ny1d5vxUlKKhg9abWs=;
        b=cSGir/ScK4LtiRJqIZwmx6KwjMl3gcirR5yuYXKG20TJd/JsDUnMUKc4zSPLSI1ZB6J35Q
        GjtkwYnGhGxJ6YCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net/mlx4: Use effective interrupt affinity
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tariq Toukan <tariqt@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.672935978@linutronix.de>
References: <20201210194044.672935978@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791672.3364.17648709739154869994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f23130b1af7bccb23dff1e9223d826869c2ad45d
Gitweb:        https://git.kernel.org/tip/f23130b1af7bccb23dff1e9223d826869c2ad45d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

net/mlx4: Use effective interrupt affinity

Using the interrupt affinity mask for checking locality is not really
working well on architectures which support effective affinity masks.

The affinity mask is either the system wide default or set by user space,
but the architecture can or even must reduce the mask to the effective set,
which means that checking the affinity mask itself does not really tell
about the actual target CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.672935978@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 2a250f3..d5fc72b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -117,7 +117,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 			assigned_eq = true;
 		}
 		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
-		cq->aff_mask = irq_get_affinity_mask(irq);
+		cq->aff_mask = irq_get_effective_affinity_mask(irq);
 	} else {
 		/* For TX we use the same irq per
 		ring we assigned for the RX    */
