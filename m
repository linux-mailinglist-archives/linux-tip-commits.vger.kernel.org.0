Return-Path: <linux-tip-commits+bounces-3482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47480A39922
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FA43BB8D1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAF22451D2;
	Tue, 18 Feb 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+JUP8lD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkxENYNP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3123F276;
	Tue, 18 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874399; cv=none; b=HiU4NLzxV8yiDETQxo9Caqjlivwg4JRfKvn+2spw93hX2xsZ6O/10hDDxq0zMckFpa6L+XuOGViHB2aEEX+vGzWzNNffjr5FoPHBUEyNkbq+WQj0uA80AHKhOuJvDfPRrzoub5tiLLCgDuVwXQDyyki4yegUzFKg1cSPFKSOWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874399; c=relaxed/simple;
	bh=qqEemsh+pu1ms+0AovnBoRPjhZ4Z12NAoBG3Sh2Dbzc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Diq8FOnUSiGYHqLOoV7tJTRDCa7KtvoXYVDXyy9GTiiAz4/ts2NUgTbweO3SlrKjhZ1edcpZIMQf5UvOh6LeOjJ5q88tA/rzcpJrDlsnjr+8BEGsbulFLBj79HyIkSXF9bJiTauYC0u1HNCYfa/6nJjefcZJfQahwh4HRBMmLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+JUP8lD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkxENYNP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0uURZFvAb4yLJqmUBDqa+ybRsywxPU1vU+2v0+N9B8=;
	b=V+JUP8lDNmZ+d/WMME3+V8MV6M5IO0Y7hcMm7+NOBIzDWgVBc5pWr90y8IuOUdwJmbmyA3
	F5CLIZxYMXdSqBoawuAkCNIk2sYQul27gtz1rhTxk54CqrN0nha+7ojM9ewcXGRQeqseJa
	Mv7txKyQPN14BiEH2kNmewA6jyfcDRl/yJi8Z052rcP3mx5pCRq5h57qV0H1Xq9US+xboy
	e9FUPvfCDn4sCcpki7XCu1RNgqJ6E6CxtnKZaReOyruEteSFaroF3gYUHh6fMxBrYrPjee
	EqzFeZ1tvZiWAJOy3s2CZxDwUIh5fudWzUPeZiDPTyV7uSWVhBkBth/Md3u6Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0uURZFvAb4yLJqmUBDqa+ybRsywxPU1vU+2v0+N9B8=;
	b=UkxENYNPXAdkPdVtVcQ++kWGG7Gl7bc7tiMEfDwJas5wx71WK2D8+1rDsg0nBLj/H0oGNt
	2mOe+1XyLOtHeKDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] ntb: ntb_pingpong: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2b179e16ab830611fdcb09a33a5a531c9800679b=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2b179e16ab830611fdcb09a33a5a531c9800679b=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439577.10177.6649229711889784438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     abeebe8889b732b2de3c5c098350f51bc5204069
Gitweb:        https://git.kernel.org/tip/abeebe8889b732b2de3c5c098350f51bc5204069
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

ntb: ntb_pingpong: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/2b179e16ab830611fdcb09a33a5a531c9800679b.1738746904.git.namcao@linutronix.de

---
 drivers/ntb/test/ntb_pingpong.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 8aeca79..1c1c74f 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -284,8 +284,7 @@ static struct pp_ctx *pp_create_data(struct ntb_dev *ntb)
 	pp->ntb = ntb;
 	atomic_set(&pp->count, 0);
 	spin_lock_init(&pp->lock);
-	hrtimer_init(&pp->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pp->timer.function = pp_timer_func;
+	hrtimer_setup(&pp->timer, pp_timer_func, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	return pp;
 }

