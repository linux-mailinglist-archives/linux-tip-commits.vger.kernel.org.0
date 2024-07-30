Return-Path: <linux-tip-commits+bounces-1870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE49941C71
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7FD1C2365A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1A18C922;
	Tue, 30 Jul 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VONGelcf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZV1XYeHQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27618B465;
	Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359193; cv=none; b=E24tOhdEXZRe4XXCyYOedTwNJ+LuuLcmtDFxOq8eiUBgVHtrz/++kviyO0WzHidGoYKwsez9A9ZBaDdpgbylGr3k86cQ1yA3GhqqC4FDfKZPf0ZSCtnJXuii+LTv7bfUrkty68aK1OaE1+WGxzZTZX1HccXqaFWG5ulRJ3jE8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359193; c=relaxed/simple;
	bh=UNX0aqnK7dafOW8thFHIPb/PT4OKDmfCAQ9tEgoXJ+M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KX5S3BJff/exkOkdy0QLn7sg6In0TBf35pzjQsofMxQqW/x0hkWbHzt0Bb7Tv6MJeeQB5oAJZ51Q8US6wgtmrIbH0K5EMfKxBzwAp7mbKb5IolpG/XhYIprJ3fyAMHAe5lqip9c0+2S4DNpuFgEqlzhO6XhhE+/dSr4trEOecJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VONGelcf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZV1XYeHQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WRW3c6N6w738qfDV+HTihxBnVzJLnMxBe4erYxjPmro=;
	b=VONGelcfxQf67e/7sJyDTvox5mnR4HIifsJX2FBbiO8znJ3DBZlE4k590pqcbv+q+LNre+
	vVJ1jPHTW05+jgrfYMdzuyjOHB+cp3nTBvEvnlfLzyuv0HTU2dhwqc21mb2YGep+5z21fr
	hMpnxqFLctGFJWuZFr+Dxq7kvEAp1oyKrd2gHk8u1VPzDEVXlCzBpVT9Wciz+giVU078hk
	M0uVapO81srJKZumky38OPl2EdPyIvRmesqxRfAmpH2O0uRmVuy17FSCfK7nfSKDW+cdBi
	Oicxqf6fdCucv36HIhpPzP4MkzANlRyEjoAIW0prXYlZ3XrlDazEt9VW1vZprA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WRW3c6N6w738qfDV+HTihxBnVzJLnMxBe4erYxjPmro=;
	b=ZV1XYeHQiTn0t6FgGpmYvRdqIJ/oUh3YCROVLS+xCQ5CaXEmoCJYSOrewzhga9ey0kvO26
	AFF2fBQUgKLVK3DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clear overrun in common_timer_set()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918931.2215.3635195802816682801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aca1dc0ce128a9b12640c39c0e035266bf9c9fa5
Gitweb:        https://git.kernel.org/tip/aca1dc0ce128a9b12640c39c0e035266bf9c9fa5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:27 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

posix-timers: Clear overrun in common_timer_set()

Keeping the overrun count of the previous setup around is just wrong. The
new setting has nothing to do with the previous one and has to start from a
clean slate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 056966b..53a993e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -881,6 +881,7 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
+	timr->it_overrun = -1LL;
 
 	/* Switch off the timer when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)

