Return-Path: <linux-tip-commits+bounces-1868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB027941C66
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6C51C23210
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CF318B463;
	Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blpxtufz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TeTrG9dk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08E189502;
	Tue, 30 Jul 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359191; cv=none; b=Gy/Maishe6jJewfMVGkv7fzgVo+kNuFofwFI1vZ26+oBkEZ6tyeTsw19FOZlmad+YeVTXhUrQL/XGTxhgDttd+CXesrXwi24vlhdtv5YAsT2DWJAspXMyDTKi48cd+cAGLSfU2qNSev5tTbO5rHcbpBAKDoX3AjpHQetu3MFt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359191; c=relaxed/simple;
	bh=DA31S1NdmPJZ/mqTi9o/cYjlvt8qB6FVPIHrr5nQr3w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MULzfose+T/3t5isKYMwrzINUGDgBcD3ala+PkHtO8RNuVs9yrjx+La9OkWlgLRdygXg+ydewOoBIEK69nz8mc8UBeKCXk2i8UZPRl4/gZMlolyylI4cYXtjCAPi2DquSjxyPytvO2JdFb2WL67/fuYYFki9KYozb8fb5mQdoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blpxtufz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TeTrG9dk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7DfXW0lpoeysxbiDz5TDDzHkIMftfnt2SICzBKMEaK0=;
	b=blpxtufzfa16C439NNoZNxpOS9nAoJnvqCHjpWSXz8/SWQ38gz7roWouPzFdhT1bdZREYV
	Eb6rvXUTmJe6SZUXCEk61VYEAqZcVdOdgOjxWl0nCA9XiNpwIGtntQ4MYBCwsSh6blHYtn
	0wrmxcuMs2Z6kB9FRlNnv930MSxfKFoWPLmqdlpzBjSR0mdEMwX9nYGcAL3ADlWPdAzAr5
	9bxkv2TK7vDSPFIhvoP3Ym+0wIS6thoXMXBMuXvfFCwBE5Aj1huiL6tH1YFfbd6OukRAfU
	rDUUtVrSb5Uw+aBSS6roXZlWJOCOqx4bo797AaqwF9M0Eurm7o8c+fMNYxjCvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7DfXW0lpoeysxbiDz5TDDzHkIMftfnt2SICzBKMEaK0=;
	b=TeTrG9dkTSn9dTjloMxY5ncRnZrTcS/PDeEWt0WV42dzfLTOHfhYgxZ4wiKB7JRwExvIrg
	lYAmkZfKLZ1ZpsDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-cpu-timers: Make k_itimer::it_active consistent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918800.2215.17419829558172715073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     24aea4cc483240ead3fdf581045a636dc7ea1352
Gitweb:        https://git.kernel.org/tip/24aea4cc483240ead3fdf581045a636dc7ea1352
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:31 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-cpu-timers: Make k_itimer::it_active consistent

Posix CPU timers are not updating k_itimer::it_active which makes it
impossible to base decisions in the common posix timer code on it.

Update it when queueing or dequeueing posix CPU timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 43cf3f6..bcc2b83 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
+	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
+	timer->it_active = 1;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -584,6 +586,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
+	timer->it_active = 0;
 	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
@@ -668,6 +671,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
+		timer->it_active = 0;
 	}
 
 	/*

