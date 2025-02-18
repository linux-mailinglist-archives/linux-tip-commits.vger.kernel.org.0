Return-Path: <linux-tip-commits+bounces-3410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2AA39764
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07083170965
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBF234989;
	Tue, 18 Feb 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KltaVOnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erJCHMzP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A123237A;
	Tue, 18 Feb 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871993; cv=none; b=QA/kQN49PH6TQhX/4NUtXY2KZDRx/wxuGLVlkuQYgd//5IHiwQtWgUHPVehyqJb0YozgWrmgvcu+QkdGXsb25ToaEYY2HKIiI4ptADJBZkILiLmByzuOkRUbAL90JvRHf0+7YvXMtDOV6ABfkGtWENNWEx/e/A7qRgocd3bp65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871993; c=relaxed/simple;
	bh=HDiPLUyKgevKIXB+/ZeApkTAqJvXX2PRb25AT3SCDT0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QLWYFeFHYqQIxTTW5I36LvdpsKa5ptjG6il+2IZFd6tTUeUHq2BnPC5IrBnfp2yp0rPEUkHnF/7T8s3gOOo635MFJMDEwySpMY8EBb6fob6qDykb/Ln5Gr2qeEfBM9PRkUz9nEthf1B8ljM/f+adbaSBLcrzI3fhET6pHCbvR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KltaVOnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erJCHMzP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mncjL2LLoI/8ZDPrG6PW4GimpVqGsVcL3KHAIXk/9fw=;
	b=KltaVOnXNPjwJMWOGyV1ydoPOD/KXW0GNV3HVFUx7AuJmPaebgQyGLbiU9+QqJbgEnY05I
	R3IfP3X3cVZsDU8pW6rLJBxSeGfJSaG6atUl8ZJScAl8t/LoAvOzAojWe0bnlEKqGlKgTF
	AYpC8fOs2LSkKLixCeBo2eR/4DKjY5OtOi35W1XDgpxmeRCyo7swXrOnmLvVJaoobZgW0L
	uNqxpA43rBB789Zd8MOHvZJoOhYwhKldXUJPynD8YLEiXVR9aqNVfeiHY8qPs+0NsjYmjF
	gTCYhpQfhMRUGG81M9C3k7bz4+ne20umIIdGaLGX2s0ucrSFNZi/vE+sSdYzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mncjL2LLoI/8ZDPrG6PW4GimpVqGsVcL3KHAIXk/9fw=;
	b=erJCHMzPjCt5guifmaVU6WxO/xMy5YZOZCrU/oggSIUMN9ca4uY6iKgJF2bgdKLhyowzfe
	51Sk7sYLbcaUQZCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] ata: pata_octeon_cf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Damien Le Moal <dlemoal@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca36ae1e4be26f8359bf2777b1813bbf4d7a7983f=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca36ae1e4be26f8359bf2777b1813bbf4d7a7983f=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198942.10177.12997910500848121649.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     32539b780c4fc3641a37ad9cb6134d72b5c8cae9
Gitweb:        https://git.kernel.org/tip/32539b780c4fc3641a37ad9cb6134d72b5c8cae9
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

ata: pata_octeon_cf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/all/a36ae1e4be26f8359bf2777b1813bbf4d7a7983f.1738746821.git.namcao@linutronix.de

---
 drivers/ata/pata_octeon_cf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index dce2480..2d32125 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -935,9 +935,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
 		ap->mwdma_mask	= enable_dma ? ATA_MWDMA4 : 0;
 
 		/* True IDE mode needs a timer to poll for not-busy.  */
-		hrtimer_init(&cf_port->delayed_finish, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		cf_port->delayed_finish.function = octeon_cf_delayed_finish;
+		hrtimer_setup(&cf_port->delayed_finish, octeon_cf_delayed_finish, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	} else {
 		/* 16 bit but not True IDE */
 		base = cs0 + 0x800;

