Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6833F46C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhCQPta (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhCQPs7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:59 -0400
Date:   Wed, 17 Mar 2021 15:48:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+SRGDy1zMe8Vd5oH5fIqc4SuM5qLPSksLVh673yNB4=;
        b=xrBzoYLoyICIoWIoyLYozozYZTtb2lz/O0iHcvizzzw94tK8v6WVtDVlNXXsgQQogJDGRq
        wT/0Zzm4K7usFoQp0/r4NNCPfzrvuaQN+au3Lk31pUUzNCmgJfp85zA2rLaOh8fZpNPJDC
        SrgrYGvVnDSki4EZwka59MSNiiV5ougAwrY1R2i2SRV8dgwlNXWMm+ZESYk+imgDwCmedK
        YG8UH4Yjgf0P8W8Voqt6Ifko3dEAhzsFbPVnUh0589RDGSrh2lmc5m1BgRnkHIP5a/BmrY
        bwKccLnzkLrCWK36V1X/f2jZtGWECyNPv17vinRp6RNBZLBxuydwGM7+eEXr1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+SRGDy1zMe8Vd5oH5fIqc4SuM5qLPSksLVh673yNB4=;
        b=ezezpdVky2Mp28LYSRrt+Jg+PahR7eDQ8xoNtOgSPrffYWsB7utQE8dgUqxycnJrF+jt3c
        VreOsPEokgh1l7Cw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net: sundance: Use tasklet_disable_in_atomic().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.209110861@linutronix.de>
References: <20210309084242.209110861@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613716.398.6112842639162687576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     25cf87df1a3a85959bf1bf27df0eb2e6e04b2161
Gitweb:        https://git.kernel.org/tip/25cf87df1a3a85959bf1bf27df0eb2e6e04b2161
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:00 +01:00

net: sundance: Use tasklet_disable_in_atomic().

tasklet_disable() is used in the timer callback. This might be distangled,
but without access to the hardware that's a bit risky.

Replace it with tasklet_disable_in_atomic() so tasklet_disable() can be
changed to a sleep wait once all remaining atomic users are converted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.209110861@linutronix.de

---
 drivers/net/ethernet/dlink/sundance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index e3a8858..df0eab4 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -963,7 +963,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 	unsigned long flag;
 
 	netif_stop_queue(dev);
-	tasklet_disable(&np->tx_tasklet);
+	tasklet_disable_in_atomic(&np->tx_tasklet);
 	iowrite16(0, ioaddr + IntrEnable);
 	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
 		   "TxFrameId %2.2x,"
