Return-Path: <linux-tip-commits+bounces-3497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA2A3990E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD291897686
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39C268C54;
	Tue, 18 Feb 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zbr8HeNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qamVwC2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC4266F01;
	Tue, 18 Feb 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874408; cv=none; b=Y24Q4b+bM+1HjDxvsU3R+pltPMz+ZkI61lkNWoOhxb6SB7B8cYoFLESuWjIgTGFIH5M08vjISBfS+XZ+fbnspJ24Y/meWWG4mdgKPwLTqcEqKN0XsGl/cS9Kl3ydF+C1fCv3P+6HFQLwufKhmUCZ+dmWTNAijQK4vPlRWiFha9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874408; c=relaxed/simple;
	bh=YWrD2yW4NudFttmFaZsICgFjG2kpcyTl48y+8PVA+AE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jL/xz9R+JC6ISbwsFn285Uh1DfzJtDXARrgheN31Up4Cg5xxxavqfxoDREt6AO18X9D19rw8H9FuZ0clpFNOn6J0Qt+MUXRFWFe+XTcFT/RE6EQsdJylWooA6WgZ2IyrcND8HzmrOoNs+iNRZBUhkke6sY2bHfWBoQLQhzV/fqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zbr8HeNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qamVwC2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0nXoCysE3gn28vavsBAgJDHpHzIM9f71ZWXMZfkw0Q=;
	b=Zbr8HeNgencx3gfhvoD1/V2LmNXohufDxHTuQROx9B5y7kOx7mv3StlG4WvtPfXqzzDee4
	Ir3YjQpnRfppyLMUKAuzfvR+hFqwi2ciHmRqqJ2ez46Fg2HM7lPSMAkLZc1MX4HFrowvPS
	90vYZUIejqZ7N5JOGpmeXfyZEMAU+fivcPj6dvorkwOkx3JNW41CE35Ddo2ebiLfBn2KVd
	TUOjPzBARdgkdq4OXK+lEakc/+as+s0DmbWIMgm7bg+1nBmBc5DzpzkeUrZLwUJYBKaoKp
	XYIZcZV8HBfhItlJyCixRwgzfEdLKVgwO3bZZazf/I2i8V7wUa5vUCMKCYhxlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0nXoCysE3gn28vavsBAgJDHpHzIM9f71ZWXMZfkw0Q=;
	b=qamVwC2/zO3EApikrHitH4DoAHugE8TRzWtdHLVhtWuUnmCUSw6HwN6bjh4Tot3sdfl2hL
	UPrQPaMdb0K/QoDg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] usb: ehci: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd703731ba61d1901c97758a60ccc3c209d21de0e=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd703731ba61d1901c97758a60ccc3c209d21de0e=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440533.10177.4149448053395346010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     da4f28741b905ad1aded9e699b5db6223245d3c4
Gitweb:        https://git.kernel.org/tip/da4f28741b905ad1aded9e699b5db6223245d3c4
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

usb: ehci: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/d703731ba61d1901c97758a60ccc3c209d21de0e.1738746904.git.namcao@linutronix.de

---
 drivers/usb/host/ehci-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6de79ac..6d1d190 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -466,8 +466,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 */
 	ehci->need_io_watchdog = 1;
 
-	hrtimer_init(&ehci->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ehci->hrtimer.function = ehci_hrtimer_func;
+	hrtimer_setup(&ehci->hrtimer, ehci_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	ehci->next_hrtimer_event = EHCI_HRTIMER_NO_EVENT;
 
 	hcc_params = ehci_readl(ehci, &ehci->caps->hcc_params);

