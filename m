Return-Path: <linux-tip-commits+bounces-3451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B03A39840
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33BE172FF3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD902417DE;
	Tue, 18 Feb 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9iGEhCJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0wbV5Ug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF3241106;
	Tue, 18 Feb 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873214; cv=none; b=nlTsfhft7QwUg5St34M/adkkmQ/GU4WFSeitIaoxBa5SGCVKCp8rG1TwVlLMO2QOACEmpWX5ohPjyZ5Z9LF6SqEvdD/EkrOiSANQFhbZOHZuHWJ9p5nzb8PyXv9A6podigCf6we1q4k51NugfLp6FmRN7q7Maxl08qIM6KNLA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873214; c=relaxed/simple;
	bh=UblsUv6MvrVWk82OjDancK7y/gE8zTyUYuZ4AgU05yY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NgJPRAD8uK7WVqIrx6xdbVxQrv3+1MhJEgdXqzZzFqQeKt0ERugnZWqqbG85G3C3uQRil6eh9wnF1+nrHP9A1pLZZ+4HuM/A5/ThTQiFUO332R5gTm1FTSUbKAJ62sJr3nGI2vF36l2gplBHPO/vXCzDULXFKBqI4pysNPWgKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9iGEhCJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0wbV5Ug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upmMCKeP+wNfdKvJVKWKRBAlwW5h12A+glsQNOGg5JA=;
	b=n9iGEhCJIcBsRIlCJhkpA6nSuld4uvWasRI/ZbGF6DM+lY5gXTGUjvgZ1JuhMt6O+JqnIh
	KH3RklaCGDOwHzKKdTpskL+Z/Oh/UxY4rOQl48PtAylaKrLNvLHHSw50CtiaihCZjbWAO+
	6I7QiGVujqa+XkCCh+2Ty793bH+zlOt/G1GzohI0Aa70akTuwRDnfJNy8561yL++wweKIL
	2OTjqAkrcQiuuvP1oVlOPkkmysbjHyyZhBrsYpYoV4+I3ahOWbptsUtNT+B4byPoKXfHqw
	iN6Vf5YT19MmUkOXT0LpuKRc6bnd4LuNL1bSF7132O9dHHsDV07CRLrQjgmIyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upmMCKeP+wNfdKvJVKWKRBAlwW5h12A+glsQNOGg5JA=;
	b=X0wbV5Uga7GGfgb5mEvX0/IrzK26tVbgZ07bvCbAdA+AlrX1XV7iSJzxtDx/tjlOgsRt9M
	tEpCiyaP3WD1ABBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] net: ethernet: ti: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbd34d3d0dba9a47b6ec5d14776941e9aa118c7d2=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cbd34d3d0dba9a47b6ec5d14776941e9aa118c7d2=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321061.10177.16417111946330529031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e9cc3a8936ee7740b59547b369d60febbbbd1be0
Gitweb:        https://git.kernel.org/tip/e9cc3a8936ee7740b59547b369d60febbbbd1be0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

net: ethernet: ti: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/bd34d3d0dba9a47b6ec5d14776941e9aa118c7d2.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     |  9 ++++-----
 drivers/net/ethernet/ti/icssg/icssg_common.c |  5 ++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2806238..361169d 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2311,8 +2311,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &am65_cpsw_nuss_tx_timer_callback,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 
 		ret = devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
@@ -2565,9 +2565,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		snprintf(flow->name,
 			 sizeof(flow->name), "%s-rx%d",
 			 dev_name(dev), i);
-		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
+		hrtimer_setup(&flow->rx_hrtimer, &am65_cpsw_nuss_rx_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 
 		ret = devm_request_irq(dev, flow->irq,
 				       am65_cpsw_nuss_rx_irq,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 74f0f20..6c1b8ff 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -249,9 +249,8 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 		struct prueth_tx_chn *tx_chn = &emac->tx_chns[i];
 
 		netif_napi_add_tx(emac->ndev, &tx_chn->napi_tx, emac_napi_tx_poll);
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		tx_chn->tx_hrtimer.function = &emac_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &emac_tx_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 		ret = request_irq(tx_chn->irq, prueth_tx_irq,
 				  IRQF_TRIGGER_HIGH, tx_chn->name,
 				  tx_chn);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 00ed978..d3bdde6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1169,9 +1169,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED);
-	emac->rx_hrtimer.function = &emac_rx_timer_callback;
+	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	prueth->emac[mac] = emac;
 
 	return 0;

