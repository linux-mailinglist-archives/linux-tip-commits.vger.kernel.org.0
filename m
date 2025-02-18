Return-Path: <linux-tip-commits+bounces-3444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5791A3983A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CFF1883698
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E723C8B3;
	Tue, 18 Feb 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RfCYeVXX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOILYxSt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8422343C0;
	Tue, 18 Feb 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873209; cv=none; b=hCm7ZHAiM9f9RjODMnjwpC6vizifEbffKiKZy6VUMnx+rSWHt+zZ33jOMsupDIQ6VUS5JcElHLWW61WW2P9MOpG2hHuuosTB7Bj5liT8miKwu89ktzFSULUHWMcxPS52iHmFBb6TLFSZrWSfcNUxwoE/jz18YBADOHiQPo5r2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873209; c=relaxed/simple;
	bh=8T0TuxoQfXBH7nMD0WR/ur+FH8tUmDWfw3hFKbnl4SU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u/S5PtqLTw1J49ly4DZJ2NdseD5NM2dL0MN6PZTDjor977Dn7qwkzXbpFwjBsT8ajGcBf3ZNVOteph6VzkAXYLZLW6eTJ7bRIydd2VrcLd4g1SIlBVrreHLD40GNs6AzLXZvloRx2XubEGT6SlyfxN0XW6OzwCuerT13a97KEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RfCYeVXX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOILYxSt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/feIrx5HH6mjFbpCb70xs5YTtofSnRH49Yve25aZHM=;
	b=RfCYeVXXYNYdASqOV0/ntYQbTGZOGEwjximRUN3nzwdMqNC/2d013kzsICvQqCT08gLTLH
	NyjB3KkPH9P5Es1Ic2V5HW+/EpKzaDhKztq5G6WRfkkP7bB1h4uZt6SMt1kti5Z0rgoucH
	FZ4nfCKVe/NVT7yfA8F/DzbDvBF4lZ8u/m3+j5ejBg/+3IrDmdWS3376hxn5cgAgoQmA9l
	e/6WlveRGampaAU83KXpWh8LbC+7QwOOselSNVKnZfVk1fGYeKbsE1qfTe3hs8lq+DvxIK
	R2bbzTIwEMK0YmETGyQMyyhm/CNZkDvlalWfLVeKO+RllQhv/wMGiurAVBysXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/feIrx5HH6mjFbpCb70xs5YTtofSnRH49Yve25aZHM=;
	b=FOILYxStNVIiGSfzRkuMAklx7uNkIWsVYlQSC9g4Z0JNBSeQ8ZTX7nQ8G2fb6niefh/qVm
	6mBzjn5/4eVXqdCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: stmmac: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C73598e0c22ca99ce7a0e863298a0e0902f4d6e1d=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C73598e0c22ca99ce7a0e863298a0e0902f4d6e1d=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320491.10177.6952042959184558919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     78afb7fa96ed9742c09a033782f50908c3d8e3cf
Gitweb:        https://git.kernel.org/tip/78afb7fa96ed9742c09a033782f50908c3d8e3cf
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:46 +01:00

net: stmmac: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/73598e0c22ca99ce7a0e863298a0e0902f4d6e1d.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c0ae7db..554d2c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3199,8 +3199,7 @@ static void stmmac_init_coalesce(struct stmmac_priv *priv)
 		priv->tx_coal_frames[chan] = STMMAC_TX_FRAMES;
 		priv->tx_coal_timer[chan] = STMMAC_COAL_TX_TIMER;
 
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function = stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
 	for (chan = 0; chan < rx_channel_count; chan++)
@@ -6970,8 +6969,7 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
 				       tx_q->tx_tail_addr, chan);
 
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function = stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
 	/* Enable the MAC Rx/Tx */

