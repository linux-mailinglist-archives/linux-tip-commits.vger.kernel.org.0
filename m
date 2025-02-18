Return-Path: <linux-tip-commits+bounces-3452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD8A39843
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C92169ACD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4362417E9;
	Tue, 18 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBSNTByL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9S+4Oul"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5D24113E;
	Tue, 18 Feb 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873215; cv=none; b=PUlymMPJKAZ1UWhTc4WXP4VNkJ36qk/UYz1Xbxe47rQkHc5FCcbbZ2cRB/gPF90sPJNvNGrzWk64XmIKwFFYbxhTqYb4irwTyaEoA0eTtexBuFo/3pcD1BXNWGTF6iypgF2LOBenEbI3rc54b66U1Z/ltvMDqnbwMzLu6LgxSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873215; c=relaxed/simple;
	bh=bRt1T8nVG8am4CVlsxt7UeNmdq42qNUnLTVOWObylwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tMzuhpypZtQ9gGO803fLlaiseIKPUuV9+QLr3uV0Xn/f81jP6MxF3mdgU98lWrmXcGAnZy+A+0koaC8syv66Q4sgmS7HEz4d/Hh3ib8ZUuzBs8NEtgnyZ+hwnIy/ZAfB48EyKrH1Hg+CqQqsUGojkmbCnZzyx8EHyFb1kYFM8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBSNTByL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9S+4Oul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhFwL23Mr66MNI//Waoq+pQiQpR8vbYoc7IwfFztNBQ=;
	b=nBSNTByLftJ4ka43JiIA/227CPF5htZtVrw5GWfkil2ZvqG3thJRqmuT7qAP/A6Bicq8st
	BcO/KvEejggdLIJipPKRFaqODC3s7e3OXKs29qm1h53eR97tl5mcH2aA70UMPyNH6r05eO
	RdTpY9bePnfTnJl3Ge2Op1rPabR2mmYG2qXqCE8Bz0P930vx4bMhfCyG1ha6w6xsT7aLU8
	m50xVP99gP7ReLxVLVVQleEHl9z/V6OSqICDRJ0Losl0hUZyy+Ewl3lBErAeQBrHmlu9LN
	PmjWbNWLRLx04iQGxclIlyS+Po9fXnZJX1XaEOEZSby+KRMF5/cIfKf+IZ/6iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhFwL23Mr66MNI//Waoq+pQiQpR8vbYoc7IwfFztNBQ=;
	b=D9S+4Oul0IHP//ESVn/YpgqEbPfC0t+9Bx1ZmeVqp/UKs8hn7NinMK1ktI5FgeuKyzfOjX
	jZ5BybFfbC5H4kAg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] net: ethernet: cortina: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cddbeac1e5d81df33e9cccb099f520111cb8ce9c4=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cddbeac1e5d81df33e9cccb099f520111cb8ce9c4=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320998.10177.17457213977176779693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f12185af60cb4b81a22e600cbbf33fc91ba662f1
Gitweb:        https://git.kernel.org/tip/f12185af60cb4b81a22e600cbbf33fc91ba662f1
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

net: ethernet: cortina: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/ddbeac1e5d81df33e9cccb099f520111cb8ce9c4.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/cortina/gemini.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 991e383..2b4bb74 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1833,9 +1833,8 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
 
-	hrtimer_init(&port->rx_coalesce_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	port->rx_coalesce_timer.function = &gmac_coalesce_delay_expired;
+	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	netdev_dbg(netdev, "opened\n");
 

