Return-Path: <linux-tip-commits+bounces-3450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CDA3986E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFC3B79DE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B122417C3;
	Tue, 18 Feb 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaB/UxNN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/qaCqoQw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B2405E6;
	Tue, 18 Feb 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873213; cv=none; b=VChO3DORNCWEXxGijghF2Ahv82JuO6s4PKr1OzJJYZweeu9yBWqXn80uAdhmedc0MQhPkpG7ArkHjOoBjvaAp2uDY06qB5qpGZv2Y5WAoFU3RKp1honRsb+iDM66Ic1uK8XNOI6XgyroR/ECrP2OjTtzvnIamHXZoGPlOW4wFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873213; c=relaxed/simple;
	bh=3kkCNyvUPN4bu71L0p94DwWn7Hw0B/ZSnRxg3wP8qGE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JQstPtbrMOYjySvajymRNYkUb6hLFXLjYgHphLcSly8eQ1ObnZj1vkyfObx4OHtGfQYMbqUFfSaruACmMe5WwD4oLkXid/Jz6gzpZm5eVU1UWIvh04FEz6df5+7BpEqal/B274Qi8PBQTU1Yldfm0/7Xywgnq3Zs3RKFmbHlGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RaB/UxNN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/qaCqoQw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyoxwt4H/hftS3odm/cv5S+Oa5tRYP7UM3NV49mlfoY=;
	b=RaB/UxNNcVaFyiwfytaVy8ZnvqTnWloCgPwxwRzrIBo1LCoWrnX7c8AVI6yjV88ASwhQDL
	VLSrsIARGnLSh3IfKOS7Cm9/aQkH8rEtjlEaO7MNHbSsjIxIaXkDoowvNsPydx1MKuP0d/
	mTYBuowItu7chHEX+bwb4k8x1J6Y/9ordRg2+rQwirxib2/mB/ubroK6rkyAyEKqZ2gkEM
	XVWoEM108eLribk1wXe6aDpuO7dDzfDE+3ODLN1arpbLssYdPU72F4dcSwM4hT/dD7w/f0
	vKOiwnzM+B82DcC7dxB5uZFMe1znpUcow+6pH4m+TzalU8d/vf0Wt013arVdcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyoxwt4H/hftS3odm/cv5S+Oa5tRYP7UM3NV49mlfoY=;
	b=/qaCqoQwuqecQ4fPVhCX1iqm2fFC7+zfJpJlbToJ6Wl7tkYuQCKb2CpzV7jkpThDjE5pVt
	asnm4Jm8jGWdFfBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] net: ethernet: ec_bhf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2d8fcf9bf83af507f1ca25cb068af2ac32cdcb2c=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2d8fcf9bf83af507f1ca25cb068af2ac32cdcb2c=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320938.10177.5578448773777933370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     66a3898a203d7a62967812d97629ee402a6f2221
Gitweb:        https://git.kernel.org/tip/66a3898a203d7a62967812d97629ee402a6f2221
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

net: ethernet: ec_bhf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/2d8fcf9bf83af507f1ca25cb068af2ac32cdcb2c.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/ec_bhf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 44af1d1..67275aa 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -416,8 +416,7 @@ static int ec_bhf_open(struct net_device *net_dev)
 
 	netif_start_queue(net_dev);
 
-	hrtimer_init(&priv->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->hrtimer.function = ec_bhf_timer_fun;
+	hrtimer_setup(&priv->hrtimer, ec_bhf_timer_fun, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_start(&priv->hrtimer, polling_frequency, HRTIMER_MODE_REL);
 
 	return 0;

