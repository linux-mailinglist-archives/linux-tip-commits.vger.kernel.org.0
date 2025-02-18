Return-Path: <linux-tip-commits+bounces-3412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7711A3977F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463D33A80B7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACD22FAFD;
	Tue, 18 Feb 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L29lIKjk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F80oRI5i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A2343D4;
	Tue, 18 Feb 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871994; cv=none; b=dPXNRQC0LdwkKRF89G/hie869WAZ9uv07p2fE35OjDsxFjti6UzAc31zgqXha4FYXHBMtuqBnTTsRjLM1i6ouFqZaNxK8JWpdCavmlx9MfLNsyx4aySvPM5z7fXinIDM8C99WC6ZXeT5UvLL/zBiT1HtWtTVMyeSn/A2R2HXNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871994; c=relaxed/simple;
	bh=ZRK9DkGAdWHaLVW2FmS2uFw8+3RShiT5gWi20wgEjP4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IYbDbuNh69BzKVi9Vg0897R+fPCO7Q2JzRA60rpxjEvaVHMueypmLAtxpdmlHDMAsmyTimBty4zh+5FuOtoteTwSJxztTtlZ2wi0QSYJvgEuCv6OPsYilGh7y+9eLxxHDXJq7iZgfjuXK2hVwlicwPLUb26VHrpQGR4TOx9lAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L29lIKjk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F80oRI5i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3/vNErZjl0gewE84wnG96tfUOdnxBJenFzfpO6G/Ec=;
	b=L29lIKjkIZxuN8QxhDyh4nmY+m4k5Z87aKdUPhIsESf3fApDHZJT0+Jnz7ZfaOnSvyzhAY
	0IWPUDL9mmI2yjLXnBIJAw00qdxmQ2DIzejqnEQve9PW1hms2bf7yx2CIRyBfIEiiXiGJA
	dXXhfj5EAO19f/AAiZJFcdrJLc5fV4PMLZTMkdALm+AlG27OgTqaMEvdHthGyjbYvBN4j5
	T2YTPWQ50LPKotAIHIR1famAfx0nkYsQvZSIFKPhm4k2NAqmnO16NfhgKUR32g6mh/+6Em
	i7qKxb0zDL+VkozFqS+QruEVRptZUFuur2RSArIx4fSAhrr92djUN34BlNh7bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871991;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3/vNErZjl0gewE84wnG96tfUOdnxBJenFzfpO6G/Ec=;
	b=F80oRI5iZHbXHWuOiGiSVR4oL4g0O64dm4Ii5ckhwKudTErWfEBqlNZqqs+YPJcpjdMmuq
	sQ3sHv4pnnmRTHAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] tracing/osnoise: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cff8e6e11df5f928b2b97619ac847b4fa045376a1=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cff8e6e11df5f928b2b97619ac847b4fa045376a1=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199076.10177.13770385401042617924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     19fec9c4434f86bce6b7227ee70b8d9a2b3c9035
Gitweb:        https://git.kernel.org/tip/19fec9c4434f86bce6b7227ee70b8d9a2b3c9035
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

tracing/osnoise: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/ff8e6e11df5f928b2b97619ac847b4fa045376a1.1738746821.git.namcao@linutronix.de

---
 kernel/trace/trace_osnoise.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f3a2722..1599953 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1901,8 +1901,7 @@ static int timerlat_main(void *data)
 	tlat->count = 0;
 	tlat->tracing_thread = false;
 
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function = timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	tlat->kthread = current;
 	osn_var->pid = current->pid;
 	/*
@@ -2456,8 +2455,7 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	tlat = this_cpu_tmr_var();
 	tlat->count = 0;
 
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function = timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 
 	migrate_enable();
 	return 0;

