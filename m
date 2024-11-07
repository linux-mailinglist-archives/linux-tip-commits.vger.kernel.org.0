Return-Path: <linux-tip-commits+bounces-2818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA29BFC2A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DD22830F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E26195B33;
	Thu,  7 Nov 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+PoBRFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6mwbhBBK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C21946BB;
	Thu,  7 Nov 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944789; cv=none; b=FzO9CAy+HqIbUBdpgfT+a6RXU4hXw7fI19o96k8UNoh3y/5axhHmFnfSWbwYCwBJIXBgWzu580Q30gYFa3c8J8vx4EgpkbvzEcEn+PG3Kt9Ilpa+NK8lQWLkk/vnM6L+4bgHLRau+wjBrvyzrYOZY2rh1WCPzL8NLt+A0+RmnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944789; c=relaxed/simple;
	bh=+NWyGmIBRLf60BxChGae4OoLSKfA/GdEKswgJssbH6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mg0norkyu7JcduuH8YkDcKRWIx6FpE9Alz1uk5djVfjXxt4rZ4OpJoXOk9H8EaXWLGgwq9PyRWOMoOS8pgZscYDpoHFF/aezVtTDjEQuu3mM2u/Cf5mM/HlYinF2UlFqg6LmaKjDzLB5yyDnZ9zlteQ8+DbUbbcbnSSF/BTh9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+PoBRFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6mwbhBBK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UHyao/p45JcQ9GLYHJq3mhQQ2YU5BUXNNCBYzX2Xh8=;
	b=1+PoBRFEUtz1EPabX1xBpmndWgkBt2rhqjjQx6NvwDi9GExh034elQZXT0qEbscbgrYSdu
	FZB3rGxFCxBrhptVos+QVOx9nk4z5TgLffiQRO0NmybBs/THrXdtH3qDdbY0soQydi7jHD
	YoR7EpesXtmAYl7bb47oFqopgAMXODXqMhzkRVbgvev/WuiuEuOraW6w/Od9eF2Uoxl7bq
	qXjfJMjutDeUMsjeQtKd4NRqKzeUyOnirmoVZH0q9y/+vm3kRSOVlIAMaPsonp8qNpnVrD
	OzSg2adwtZUIna+YwuhlP7GIKCbkFHs3tfvSVNBPDS4ehCLZZWM7lMeWI9gN9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UHyao/p45JcQ9GLYHJq3mhQQ2YU5BUXNNCBYzX2Xh8=;
	b=6mwbhBBKd8ez1tvPuqeDKzI4y+B196w6WKWKM516j7Xf9HxVe0YNnmNVhBk/UX4UsNq+on
	DCl8CRxwNaFEW5BA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core]
 _RESEND_PATCH_v2_04_19_wifi_rt2x00_Remove_redundant_hrtimer_init_
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Kalle Valo <kvalo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C66116057f788e18a6603d50a554417eee459e02c=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C66116057f788e18a6603d50a554417eee459e02c=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478554.32228.2627084733345548575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     48baf9fa4884e5ccf6ef8fa7099693696ebc6975
Gitweb:        https://git.kernel.org/tip/48baf9fa4884e5ccf6ef8fa7099693696ebc6975
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

_RESEND_PATCH_v2_04_19_wifi_rt2x00_Remove_redundant_hrtimer_init_

rt2x00usb_probe() executes a hrtimer_init() for txstatus_timer. Afterwards,
rt2x00lib_probe_dev() is called which also initializes this txstatus_timer
with the same settings.

Remove the redundant hrtimer_init() call in rt2x00usb_probe().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/all/66116057f788e18a6603d50a554417eee459e02c.1730386209.git.namcao@linutronix.de
---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index 8fd22c6..a6d5014 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -823,8 +823,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 
 	INIT_WORK(&rt2x00dev->rxdone_work, rt2x00usb_work_rxdone);
 	INIT_WORK(&rt2x00dev->txdone_work, rt2x00usb_work_txdone);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
 
 	retval = rt2x00usb_alloc_reg(rt2x00dev);
 	if (retval)

