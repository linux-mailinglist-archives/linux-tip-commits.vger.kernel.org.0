Return-Path: <linux-tip-commits+bounces-3457-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA2A39850
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDAF188E1C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70E24339C;
	Tue, 18 Feb 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0KUmgRM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TfIkf/B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD64241CA4;
	Tue, 18 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873217; cv=none; b=EHnVYWJvKCKO2AqSbvzL9/GDAmqS2EAcCxub/pHCo4ndH6FUOJ6TIYw9ZBhUQLeAphuOBxcLsAh8B6FwzNM3UcG3AUVFyTrXXccxNerlYQXmX64dn4dO14QWrd7LCqkcDsWogYkdkwM9WPwp4ZG4SOOKW/IC8CyvmiD5HIB7F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873217; c=relaxed/simple;
	bh=ShdnROxA976Ce2oMIOQ+alxqEceLqASvFhe0pZlqZ5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sWFpH164FA09FrS6BlfOTBHZ10y7F38142dDphOxCE4PgQdiNDxY3nztqsGy2wlZt//icLHbeVWcaW1x+8YMM8XN8Ali8YcYpUl0ShHtG7WV/wRKvtcehx4s1I0uWz9uJWBU7YYCk/JkcIf7XArQ/Uo6gva1viD9A1Q/TA++ssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0KUmgRM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TfIkf/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiGYK632w47jOCM7EfchVcaZhxt86A0R32pClSc1/c0=;
	b=a0KUmgRMSRwUg/PgGmqiY83TuB7WtZS5EHFmN3PHDwKapWZRc/ikWgupuLAW7374gSWM0g
	zW5CQ5aAv3OW/vvrc4Wvzs8ku6ibW+vMJn2UftigM4wLAauT60N0CwC23wfpzeLVm0XEcw
	bD4gZ8JkxbQ89az4f0VmsKlreoWDDX3yP7NiG09EX45ELO4AaoA03Ft6Avpb9xmkO4aJzA
	UIE1kW3x9f3rCsiDwENWHYfhTEy9ADNMbEapmu1VDrKNeI7GnPjj7ecYpXPKZbJdHpLTZ+
	/32gYEG8GUONiY5koeAv7QM2nq/oa/NIdy0JOBIDt+uNGTpjXAoHOm6ZbmDLgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiGYK632w47jOCM7EfchVcaZhxt86A0R32pClSc1/c0=;
	b=8TfIkf/BFTze1/Etnj6a12Zmc3wbSo7owx//AhdOsP5W2Y+sjAcJZnLhlvvwXOKc+eay7n
	ws+qiYDYtzjoUFCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] mac802154: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5a89d86092d11a1d0cdfdfaa33990aaf7f1eec87=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C5a89d86092d11a1d0cdfdfaa33990aaf7f1eec87=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321377.10177.14742511095675473336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     96b2fb3e6d146ab0b286101ddea6ad0cca8335c8
Gitweb:        https://git.kernel.org/tip/96b2fb3e6d146ab0b286101ddea6ad0cca8335c8
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:44 +01:00

mac802154: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/5a89d86092d11a1d0cdfdfaa33990aaf7f1eec87.1738746872.git.namcao@linutronix.de

---
 net/mac802154/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b..ea1efef 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -213,8 +213,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		goto out_wq;
 	}
 
-	hrtimer_init(&local->ifs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	local->ifs_timer.function = ieee802154_xmit_ifs_timer;
+	hrtimer_setup(&local->ifs_timer, ieee802154_xmit_ifs_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	wpan_phy_set_dev(local->phy, local->hw.parent);
 

