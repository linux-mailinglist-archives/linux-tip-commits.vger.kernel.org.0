Return-Path: <linux-tip-commits+bounces-2812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775C9BFC1C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFB41F2187B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B418FDBC;
	Thu,  7 Nov 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cn5ArHaS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RtaXvJhZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FB186E58;
	Thu,  7 Nov 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944784; cv=none; b=Mrq3v0uHS+p6/x3wSdIFUHtg3TTXYxnNHs0te1i35TPZYDJCrG/VJSzlAEiVCOrVN/NdSVQnD+EAWOiLVMx9bMSqIx2xy1Eh/8+8/X7wP7boKEALO/gd6uUDNIfUoVvfbpB8rUVgrsfs4+bddgS3UjGVf+1VhyCgX93f9/dTRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944784; c=relaxed/simple;
	bh=qcLKCYoaBLNaNvLqbqYfMZaRFfxtgLAv2sggI5XlpuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ToyXPyoTIq+MMTyP8TNvRuU3zl6QlKu/P8v3Qsfh3vv7cLWR1BjfBjJtUwW78AD6NR9wbFig40/pAR5ZcJ/5tjMwmR84FJN5XFUiqSScTDflj1h+AVKavmxnmc04zIPN8Ek2/iKg1SyGXLfZBh9fcZ9RA97WeH/vhKvj0TS8gUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cn5ArHaS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RtaXvJhZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR94sC9NHLPQpReMCiZ0IbVV0ulni5tQaXU/7IVJO78=;
	b=cn5ArHaS4yOfxGnhZDRPXkzEHY5MoWRQJbwLdiOy4SGjXkZ1cdTyIIlqgHQpMVG5VOZzKJ
	cf/+nORfJUOGtJb9j6T2kskT+yYBVzZgYMQJeCoDOD2nVVg8G/NVsWu2UndFG7fnzNzwZZ
	DlB9fIo34V/bN9B4YWmxAwYVeTkCEh793OL5rTlSMzQr1F+wZGkKKpa2Qtz7vD78Ng6m+f
	9ZAYB+DSPuLzHL4/3d7ZA6Pl4joqgeywWG+MWQs/5V03gbrTOHb78MzK2RImju2EI1g1Kp
	VVAUTbxwN4e6anoz7kkLfJ7kZKUZ/9lX+OJbx2vu4CqB0zQzCXuOycR1/qgraw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR94sC9NHLPQpReMCiZ0IbVV0ulni5tQaXU/7IVJO78=;
	b=RtaXvJhZo3tcjYiEUVAuxV8t6+5TMrK2QBkENe4lARSF/fgOVIjW84f4a849BkfZy6caA5
	Vq8W0/vs66un+5CQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5f10c259fa43ba2fe774de5b2cedc22f5e9cfd2d=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C5f10c259fa43ba2fe774de5b2cedc22f5e9cfd2d=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478128.32228.9020713843656870379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     28e70352b8069fcebf18466a780e2469f968ea98
Gitweb:        https://git.kernel.org/tip/28e70352b8069fcebf18466a780e2469f968ea98
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it. The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/5f10c259fa43ba2fe774de5b2cedc22f5e9cfd2d.1730386209.git.namcao@linutronix.de

---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index e892017..a5d331f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1335,7 +1335,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	if (until == 0 || ret < 0 || ret >= min_nr)
 		return ret;
 
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	if (until != KTIME_MAX) {
 		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
 		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);

