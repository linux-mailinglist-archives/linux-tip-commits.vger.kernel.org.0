Return-Path: <linux-tip-commits+bounces-5139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BC9AA43C9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D424C5D7D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08F20C463;
	Wed, 30 Apr 2025 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ggGsuy8W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0YNflh6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968420ADF8;
	Wed, 30 Apr 2025 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997745; cv=none; b=Ef/Zt9lVQoUueDdsbBTtmDnKpS1s0XboKOymBzrIlNmo//DLub6sUMhqzuQz7tF+VJysHxMl5UAxrarU/7s5iZgWdgBgeDXZFwlQkEL8EQPYzbnJ93uBdlcWvRCzPnaJLUPj4EW6BKgJtIO7amkuKvTKR+OWFIJdIOzwewqEd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997745; c=relaxed/simple;
	bh=kYL1LAtu0LPPgF7k+hreUP6qjoZqTx/w+2BYFEDdtXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GdfMPn1ndZp160BnqqHvO790XzCYHkKBLdLOWtCYrg4I05ccvCfF8Vc0ntg1OELQY44jD9uHS4QywLAorWUyP3sDbnpF7N8EAd2MESV/+sPMjFlNBwBZuaRfQ+OXy738NlcvJyWCKARZCIgmkKo4YoYGvnT99Ti7f9xMvhrkjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ggGsuy8W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0YNflh6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 07:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745997741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODE0MUC2rnYlolyY2Mrwi3zOX9lOBFsoJ9nuk4Fnw3s=;
	b=ggGsuy8W0Sq4lmgtfTegqe4kIxSC0Ixuc2NZCoA23l0c6Ma7fWRWTTKYLOVtDOnaL9Py9g
	rEsi6errK9fw31KhrD01+lFrl/oBqFs2V2oodhZmgOCujf6CYn2g11LlzveTLYa/0WHTk/
	zkTKlQKB2NY1Vr89D/n9c999nEz4uv6m/aaszDzSC1eva/8A0hSLR8+M5g0YzfRVc3v1ZK
	w6cOKNBSnfVv2QGyVtSerolYhXzZwr3q8l+JJ7tWN0TFUaAB4QVl1hCrARpK8aoDaczT88
	K+df2tBFIE+G0argMWzgVYCUVr0aELJLil2zjM51PWGbbwIWz0TitJTvKfiOGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745997741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODE0MUC2rnYlolyY2Mrwi3zOX9lOBFsoJ9nuk4Fnw3s=;
	b=0YNflh6Nc4m5EJA3QrivfWl+AMN0xQ3xZtkpYTynyAR2qlG7zzjGGfKeK1oBgcACTXq3mx
	xLs5s8+gYXZbc6Cw==
From: "tip-bot2 for Su Hui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] alarmtimer: Remove dead return value in clock2alarm()
Cc: Su Hui <suhui@nfschina.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430032734.2079290-3-suhui@nfschina.com>
References: <20250430032734.2079290-3-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174599774083.22196.5201101258841287355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d8ca84d48a2a2d4f6780980743c34b70c49f5844
Gitweb:        https://git.kernel.org/tip/d8ca84d48a2a2d4f6780980743c34b70c49f5844
Author:        Su Hui <suhui@nfschina.com>
AuthorDate:    Wed, 30 Apr 2025 11:27:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Apr 2025 09:06:23 +02:00

alarmtimer: Remove dead return value in clock2alarm()

'clockid' can only be ALARM_REALTIME and ALARM_BOOTTIME. It's impossible to
return -1 and callers never check the return value.

Only alarm_clock_get_timespec(), alarm_clock_get_ktime(),
alarm_timer_create() and alarm_timer_nsleep() call clock2alarm(). These
callers use clockid_to_kclock() to get 'struct k_clock', which ensures
that clock2alarm() never returns -1.

Remove the impossible -1 return value, and add a warning to notify about any
future misuse of this function.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250430032734.2079290-3-suhui@nfschina.com

---
 kernel/time/alarmtimer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0ddccdf..621d396 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -515,9 +515,9 @@ static enum alarmtimer_type clock2alarm(clockid_t clockid)
 {
 	if (clockid == CLOCK_REALTIME_ALARM)
 		return ALARM_REALTIME;
-	if (clockid == CLOCK_BOOTTIME_ALARM)
-		return ALARM_BOOTTIME;
-	return -1;
+
+	WARN_ON_ONCE(clockid != CLOCK_BOOTTIME_ALARM);
+	return ALARM_BOOTTIME;
 }
 
 /**

