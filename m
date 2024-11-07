Return-Path: <linux-tip-commits+bounces-2801-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D29BFBF2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB241B20BFA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AA944E;
	Thu,  7 Nov 2024 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4MMn63R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TJzLyeLr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773071119A;
	Thu,  7 Nov 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944137; cv=none; b=i4dsfaAv6eI9ZFJ3EViQJ7oQqxcLuq0nRjprxuGxLKG/PKlcX4BuEIZt9C1KNkSWmat0CEu23LdoIBE3/ElLu4PiwqGrvu3YxsAh7JbnmUoTEuzW8YzLJ+vKM5MzYREoB5Hg7RDwZ/aftpQnpUayh32Uf6ogO0V9+52lFtDECJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944137; c=relaxed/simple;
	bh=qoyPgZ8SM46TpPCBJerkUj14kCsYvt9cp3opkNggvyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KBShKQtszlaKNCCNdBeo+KWKPN+db5sXGZnKlddefSaymSLYx1Ccy3zUutWKR7xlJWQlTeSVkcm6/kt8cuei8kKIhBv2f7qwwgwmu5hNoRpZFHlsX8m0sOrmtu8pdDEV/ahJYOVPcQkDnxxCOxwfBy3/Rh60AZAddY+9+tDo8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4MMn63R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TJzLyeLr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP9j1gZwpxjTvIyIA4SIV3T882a42q8uB/HUA1hjiWI=;
	b=r4MMn63RRn7PNL8p4iEa7Vuao0bK/E9tlavTQ6QMigNxhXTH5xCuRnRTvae4sweyoeBH/q
	P1ZHo5iyJIX1eKSRv7/Pp02ThmZ71mIpVwq2swGTjKvhYRHBIWlHRzR/CFam0IJtBxwmM8
	ayde7zppjPaHJFmbSNLKOr+wJML7qFtX/kCkjcr8jj2wY79Wth6zc+o0Q7H91Rj8p/uc9l
	OMtlY59Kn202O3Vh8HeqO71iqsfxesWK2GRDq3eSmevqql1Ewvc4AD4UbLJVMX6KfT1Ssm
	Xy8PbmZtfKIjEufA4PWF/uzn4ErJehkbBF/6nrAMRqCCn/lIFhZD1yAEqeEkhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP9j1gZwpxjTvIyIA4SIV3T882a42q8uB/HUA1hjiWI=;
	b=TJzLyeLrvMpuXmLCTBE7pwnFLT7oi0ydRgX97sDOc0+gd1iczvouiGeT3c6ywUbNCeaiGt
	rTeH3fKfVBZLdIBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] timers: Use __raise_softirq_irqoff() to raise the softirq.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241106150419.2593080-3-bigeasy@linutronix.de>
References: <20241106150419.2593080-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094413383.32228.15495402388906189523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a02976cfce4fe8336c6be08cd4dc35ca1aa794e9
Gitweb:        https://git.kernel.org/tip/a02976cfce4fe8336c6be08cd4dc35ca1aa794e9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Nov 2024 15:51:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:44:38 +01:00

timers: Use __raise_softirq_irqoff() to raise the softirq.

Raising the timer soft interrupt is always done from hard interrupt
context, so it can be reduced to just setting the TIMER soft interrupt
flag. The soft interrupt will be invoked on return from interrupt.

Use therefore __raise_softirq_irqoff() to raise the TIMER soft interrupt,
which is a trivial optimization.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241106150419.2593080-3-bigeasy@linutronix.de

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0fc9d06..1759de9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
-			raise_softirq(TIMER_SOFTIRQ);
+			__raise_softirq_irqoff(TIMER_SOFTIRQ);
 			return;
 		}
 	}

