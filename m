Return-Path: <linux-tip-commits+bounces-4687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7DA7C2E8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D87178FD2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517721D3D4;
	Fri,  4 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJnBg9KB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NznagAFZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9221A945;
	Fri,  4 Apr 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789278; cv=none; b=o8ETAr1gOJw53WIO+Ans1lujx3PD571/m4Vk+e4GDgDA9Af6ejRa+vpiWQR7ZHxeOOVQE3WRQuBzWf5Lmogm7Qd3Ql1Rjh8Dy3NX5CijwHa4iiC9kxhL6Vhg1WPE6/LnLpZOM655qsSwypBOZLnzZn/zIaQ/MuHLd7Po9Sf2oHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789278; c=relaxed/simple;
	bh=8/8I4THINBj8wylMaQhE7ax5MiobwnA3VYFnwWA8WA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lZBTUumr1MK4Q1uAdi55vXDlct0KxlHTjJzrx3ZvT9p7e6BMC0Qx1kyyFmvFCZ7tTZHcvE7EyUptOKFO8P/xYMegO8NkW2jNYP5neW3gksHkyb7JogF30gGzPUDnH7JicwKVcK0L+j+QxHI79P6V5Q+/zaJYljFScfIawcf0icE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJnBg9KB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NznagAFZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8nDRsplf9SBpnOE/eLrpfwyIDtAE38MgiKPpaWKCko=;
	b=IJnBg9KBBI3dvsY2BBqqv7PJ763MfoBuZBxPOMPoY98VvPuBVYAy1s1im0pQCodxJUG5+k
	LOug6ehAfrLGq5NBkQh47HRlCrdcuPt7MPJ/1gi4BPb0LwAX/j5DSkVN8FqPyj4XB4zGoD
	IqRPOU8CfqQiWu4dE9qCLL83panPguXEqYDSCryuIGFwWco6am5Z3nXGITje9c0W2trytv
	mF2MsJonlW5r7fs86yg2gA57CsH8tRmvoMCNKXTp6TOJ/6fOIm50PbusOiIucby9PuTSeX
	QPePX1xw66x+qrEB2d2MIjc4HSGkVG2b6zWMl8dFUgZW2VayiSbZdRcWxC6f+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8nDRsplf9SBpnOE/eLrpfwyIDtAE38MgiKPpaWKCko=;
	b=NznagAFZYrpJovsS/pguvhMsOtV5wEfZARaaNPaAXKfnAgVen5r7nUbcCKYHv5aund7umN
	CxUpy6oeoQRa20AA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Remove unnecessary NULL check in
 hrtimer_start_range_ns()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927457.31282.16588742079706725251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     a86ced94eb6743e4fb30e568ff557f3bc31a3b69
Gitweb:        https://git.kernel.org/tip/a86ced94eb6743e4fb30e568ff557f3bc31a3b69
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()

The 'function' field of struct hrtimer can only be changed using
hrtimer_setup*() or hrtimer_update_function(), and both already null-check
'function'. Therefore, null-checking 'function' in hrtimer_start_range_ns()
is not necessary.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4661c571ee87980c340ccc318fc1a473c0c8f6bc.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88ea4bb..e883f65 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1316,8 +1316,6 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
-		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

