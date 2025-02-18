Return-Path: <linux-tip-commits+bounces-3448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA7A39841
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDB6188B8F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC212405FC;
	Tue, 18 Feb 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTJ1Kdgc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDR+zCTm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0123F28A;
	Tue, 18 Feb 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873212; cv=none; b=NQA/GOo/bC6p7cgPIFlk3AA/z6Th/KtsncPd9uMAdoDRyZAkPMHalYNX9+WvDn8GqjTzMiCCWLg3BX26Yow/DMSbQSkbFip2aGzacfrDuWQU5XZUPoYCND0ocgJIEhkdLgjk/jg8rCH77+lUvMmwbW64Ln2s3CFTD6OSaN+ALKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873212; c=relaxed/simple;
	bh=qv1ideuVaGSWmedRidvkQgqsg6wYjte4DZG9wMSiC38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=njXRuV1iJsI49vX32b6E3wuxHg7SkwPWI4SDbAlkRY4Fwn2keL+gUbW6jkw9soU0rXhCcSuuELYecKmjtPWKM5rF5EsBtsdr9X1bLjWhea2qhQMH3rAed0XRNKlGWfVnHSjM6oOTHE8wjJNjx53b5qee5ZMfsg/vqc0q3OC8cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTJ1Kdgc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDR+zCTm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5y08WYwDRig3E1g0XuKScO+j8aDNHucWRjRpv3f/fM=;
	b=zTJ1Kdgcn2rINrfHu1CVH8T9Fk2ZkUhDfBw3RtEYPI6kpNQqK0PzpC73wbRp+WH7XJTHAB
	dzEOgPOGvV6gI/mkBUFDrHn0sn3g2wWa0SFgFTxD4GeI4H6xC3ICCVylYo88QWxlaJ3ssu
	tDFOQxMRW6w5YA7T2QiAIMretdXnq6VeoHbXfef7T6wqnSWWEVKPMKxfZrOnBZzZJbWpDM
	q6XnaoH3vnkmx6Rz2RtDT8jMbkW7qe2u3NzkGEYFKKfH2uHbXKgfl++Ul48TheBXDonIo+
	Elfn4wAi3QXKN1C7f21Ptfphs30/o1A3AxNRnfWOrstHv91mJx4ji3rbNLLH4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5y08WYwDRig3E1g0XuKScO+j8aDNHucWRjRpv3f/fM=;
	b=aDR+zCTmpjRY7KAO4R1DAcOS3EE/K1kanKNH/9oYlPQ6KPfREXGBL3NQueoTz5NfAf+jvf
	nDyEba9X0GbOoyAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] net: sparx5: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd8f0e09bfa4bd4850e363645cc634afeb5779b88=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd8f0e09bfa4bd4850e363645cc634afeb5779b88=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320806.10177.3449486393959036186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7b63b1dc473e5ad3c4c0f404d198e0c18dcbfa64
Gitweb:        https://git.kernel.org/tip/7b63b1dc473e5ad3c4c0f404d198e0c18dcbfa64
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

net: sparx5: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d8f0e09bfa4bd4850e363645cc634afeb5779b88.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 138ac58..f713656 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -375,6 +375,6 @@ irqreturn_t sparx5_xtr_handler(int irq, void *_sparx5)
 
 void sparx5_port_inj_timer_setup(struct sparx5_port *port)
 {
-	hrtimer_init(&port->inj_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->inj_timer.function = sparx5_injection_timeout;
+	hrtimer_setup(&port->inj_timer, sparx5_injection_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }

