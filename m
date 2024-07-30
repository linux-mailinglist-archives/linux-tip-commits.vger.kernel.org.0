Return-Path: <linux-tip-commits+bounces-1880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806D941C91
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FCE1F24100
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E51A4B52;
	Tue, 30 Jul 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOavXQ+B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0unBelZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA74188017;
	Tue, 30 Jul 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359197; cv=none; b=iDC3gyKg4rD+kQeiz+Xd/PFo6HhcpCb5H3PJEV9nVsHO0f4LPIDgYRQTy5KCYH/rLcl24dpjAZuIrdo4WddX/psqusZCalJvoroFAD1WAQagdhKfjbEKNse+EXhhPTyYVW/4kG5fLBqwaVcy02Q/FffbpyzLeReKc+Q9hghW7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359197; c=relaxed/simple;
	bh=HNXpMGAmtlih4OM3X8SZWFnVc+DULSUzmx9ujGeAATs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TD9bFZ+/zBKgUsxfJlb5Oujtl4edbuQigTnU1+7svjOFsP2+PsmsaLnIJ0wub0lMvaduxzj60gyx8FlD47Q4qHeHTwwsy0KDWw/aX23NmmfmqYN+lCcH9KdNg4flYguuWVybDld7NZaTUL6kETuK6a3gYHPrr5FcXbtkrr1KJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOavXQ+B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0unBelZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Bn+GifmrEsivroLZdM+SV6hvdiCVdDGJfFRKtW7/emo=;
	b=UOavXQ+B7xjagwREeSOjVXZt/Si8LVGWEl43YhJd6ZUVvGjeOaP78akcNb5Sr+kNnXgKuW
	JekxbfGTFwy3bVWiDE/l1ZVHrzMzQkN5MNdeINnCghGVXtUsASZ+H5ZtLtmoy0fe0/kUps
	+0qrXPDvyYAEN4uWAXriZ2LyuEa+QBl5YFxqOPUQs9nzddNmeZa0sRKHSGvdZAd0qmTAMh
	BhGdHIaucpTW2SCaoAHuerzrQwtoTCglkmazrwJZlJEqtA3o8viVQClobrQ7KjAs129ld/
	YA7Ohchn++q7mK2tS3ZlmXvwBcZPpdoux1krFS61t9RWbp/My96w2w66AQpUdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Bn+GifmrEsivroLZdM+SV6hvdiCVdDGJfFRKtW7/emo=;
	b=s0unBelZ5gsXg8IXo1voaYi1VUhaIJfhZzSFnDe2FY0+47/56pK8ryfHCc2V2TdBD0KVRI
	xYS+XB91MPgcPUCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-cpu-timers: Save interval only for armed timers
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
Message-ID: <172235919438.2215.5459224437664534869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b3e866b2dffbc36b31be7811ebded91ce82ecd10
Gitweb:        https://git.kernel.org/tip/b3e866b2dffbc36b31be7811ebded91ce82ecd10
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:15 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Save interval only for armed timers

There is no point to return the interval for timers which have been
disarmed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 558be8d..5aac088 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -809,17 +809,15 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 
 	rcu_read_lock();
 	p = cpu_timer_task_rcu(timer);
-	if (p) {
+	if (p && cpu_timer_getexpires(&timer->it.cpu)) {
 		itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
-		if (cpu_timer_getexpires(&timer->it.cpu)) {
-			if (CPUCLOCK_PERTHREAD(timer->it_clock))
-				now = cpu_clock_sample(clkid, p);
-			else
-				now = cpu_clock_sample_group(clkid, p, false);
+		if (CPUCLOCK_PERTHREAD(timer->it_clock))
+			now = cpu_clock_sample(clkid, p);
+		else
+			now = cpu_clock_sample_group(clkid, p, false);
 
-			__posix_cpu_timer_get(timer, itp, now);
-		}
+		__posix_cpu_timer_get(timer, itp, now);
 	}
 	rcu_read_unlock();
 }

