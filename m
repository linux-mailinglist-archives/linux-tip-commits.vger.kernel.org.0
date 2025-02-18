Return-Path: <linux-tip-commits+bounces-3449-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D28A39842
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44611883A5C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E786240610;
	Tue, 18 Feb 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lo4doG1L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwNPOnfK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3523F295;
	Tue, 18 Feb 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873212; cv=none; b=ZKKUKGsIP3dUBYbA3X7trarJYGOoMyXe3vBzySahi440IlEQpiRxulP4x4ReiEX7ZT25cXOL4xJGMO7VRRgNEH5p2iLc1suElYcJew0RAwlEFU0/tD+zU29M1p8zBFtnRVQ2vfEoWZAhnfnrb7OBs/iiLGjP+AC0FrmE2YPHPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873212; c=relaxed/simple;
	bh=+OrIUx5Uh9T3en+0RSEGZDHZqlxq63dbBMKn+lXFQ1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OfK7EOurii/XO/nvj4cN055UURL/qnOf/ACd2f1FTtuVWSeltQ0J+G3LW9jMuFGyM30fv6YMG7oWBWyt2ufJ2JhfFPTur/J8SP9qwIjGieP0tO3fVpGJzvGnEllifnC26FuGNQURZIhdZmgyJxy2zVEJqRS5fb07uyC6Ud9mxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lo4doG1L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwNPOnfK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyTu2t2j1Mj3X+hWR1cxQgcBkwzGO2cfJ8FND5QUUo0=;
	b=lo4doG1LOa8FB3bOxiMP9+wrzAby7X8XW8DTKhFweHi0MxzRBeOYgkr/xlX3y0dFZTOySY
	subjhIlENa+I82xQ0WMSpUhxEKjjxjvyrAr8ubcrj3ZcWsE+ERzxlcK71X13sd6w8exJs8
	J+tri54RlbJcq9cbbU94HEp0WnGRoM8agJXWW+MIhZDnXI2W8EHSGesCGfWtbmKo2iIMY3
	0jSg0DH+IMuIuJexySUgpluWWZ1I28cL2153YaA4SUXCe9Qs9xMZxNEa+wuY9nNs0hrp0x
	6hfCno5q4cN6TTt7kL3NC7j0PF2FhgWv5R8nu/zp9P4wd5t7/3YKMjTgrqZorw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyTu2t2j1Mj3X+hWR1cxQgcBkwzGO2cfJ8FND5QUUo0=;
	b=dwNPOnfKqSLydoIVPTFGbSTv/nElmNW34e8NyEeRANioB7gcbMKA5YDwWtzL56PNJwgOGi
	LheyfW8jAzdjBLDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: ethernet: hisilicon: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C11f5140e157cc0cd02a715f531217b021743aa71=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C11f5140e157cc0cd02a715f531217b021743aa71=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320872.10177.3290724221860151012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     964177da435cc466c4ff4774f18e37aa03fafe4a
Gitweb:        https://git.kernel.org/tip/964177da435cc466c4ff4774f18e37aa03fafe4a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

net: ethernet: hisilicon: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/11f5140e157cc0cd02a715f531217b021743aa71.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index a376d4b..18376bc 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -934,8 +934,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->chan = arg.args[1] * RX_DESC_NUM;
 	priv->group = arg.args[2];
 
-	hrtimer_init(&priv->tx_coalesce_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
 	/* BQL will try to keep the TX queue as short as possible, but it can't
 	 * be faster than tx_coalesce_usecs, so we need a fast timeout here,
 	 * but also long enough to gather up enough frames to ensure we don't
@@ -944,7 +942,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	 */
 	priv->tx_coalesce_frames = TX_DESC_NUM * 3 / 4;
 	priv->tx_coalesce_usecs = 200;
-	priv->tx_coalesce_timer.function = tx_done;
+	hrtimer_setup(&priv->tx_coalesce_timer, tx_done, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	priv->map = syscon_node_to_regmap(arg.np);
 	of_node_put(arg.np);

