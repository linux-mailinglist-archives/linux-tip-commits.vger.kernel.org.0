Return-Path: <linux-tip-commits+bounces-5901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D34AE896C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E9B16166A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162C2D2391;
	Wed, 25 Jun 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZWUAfyTn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uo9gJtbc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69142BDC10;
	Wed, 25 Jun 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868161; cv=none; b=hDW0kZNMiPw0cxjsQM5DpZb8jVSf29K3BTM9JkdNAXQbvpTJIu8Mrc/Olo3OzvcjaqGTuLlvkN03QhB/9jkcBcHwB/2APwq7Xrcn48QPvok9qgMjJ1F/bNTMZxwn+qgxkNST6QeJVZdOsqGxVaNA9sXWRFV+OIcQAQ9aIjiAhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868161; c=relaxed/simple;
	bh=nEUs8gaxJt9BadjNXqQwicfWKnSYjVPTTO90aNxdeS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SjfD7qTuTdweq2CvGCcwVAD2RvtlpbKmC5OT9c37vXw6padKKxG9DhKoCpzIk/jqC2CBfWlSgy/TUyxUewNDx3Exb0acppPTCd7rDOgQ64p5euGBcd6y+OAiOb5IzZQ1bD7w+X+SOScxNzRi2N11PVffIjspkE1vrFt1wTR6CR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZWUAfyTn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uo9gJtbc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:15:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWbZfy8bZ8b+u+kw6Bd4+Ne9qSI2T+KW8nPvsYmZLIQ=;
	b=ZWUAfyTnsbOLQLY2ClDkFuFdTDQcPmJL54w5BhXfkIE4qeVijiKmeerThp91aCz41KctX9
	OtS1tmGfZzwXtUiLYNQ8ZBVGrNC3bt1sI6wjKiKRJ6X/KRtDi4TnekDvlXUfZrYJks1/TJ
	NSSHZH770WAjlQePXzvODKCZ8/C4qvILwVccjwHqF1tiTUJwTZ/JriGLaec3jEm2OgSY9C
	tsC4cey/hpkCHDZw95S4XhdGrOVGtPgJAvLOU92B6zB+qoPz90U/SP8bx459/uRgqA2C6/
	q3uxOHUZrKPBVYQIBcFAUUF2RpDuWk+oKchjarxJ8SvfC//l9H1/2WSOATjA+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWbZfy8bZ8b+u+kw6Bd4+Ne9qSI2T+KW8nPvsYmZLIQ=;
	b=uo9gJtbcBq0DEzSRZo4edvJEXjSL42hKpqYY6iWCF+bOVyQ81e7BtLOPCadoj0IFGmNyHk
	jvZzVPl3GIksUTBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Provide ktime_get_ntp_seconds()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.411809421@linutronix.de>
References: <20250519083026.411809421@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086815720.406.17334189517995884555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     ffa0519baaed48ca953bd201e1b17f15dae21b2d
Gitweb:        https://git.kernel.org/tip/ffa0519baaed48ca953bd201e1b17f15dae21b2d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

timekeeping: Provide ktime_get_ntp_seconds()

ntp_adjtimex() requires access to the actual time keeper per timekeeper
ID. Provide an interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250519083026.411809421@linutronix.de


---
 kernel/time/timekeeping.c          |  9 +++++++++
 kernel/time/timekeeping_internal.h |  3 +++
 2 files changed, 12 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 19f4af1..7d3693a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2627,6 +2627,15 @@ int do_adjtimex(struct __kernel_timex *txc)
 	return ret;
 }
 
+/*
+ * Invoked from NTP with the time keeper lock held, so lockless access is
+ * fine.
+ */
+long ktime_get_ntp_seconds(unsigned int id)
+{
+	return timekeeper_data[id].timekeeper.xtime_sec;
+}
+
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 8c90791..973ede6 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -45,4 +45,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask, u64 max_delta)
 unsigned long timekeeper_lock_irqsave(void);
 void timekeeper_unlock_irqrestore(unsigned long flags);
 
+/* NTP specific interface to access the current seconds value */
+long ktime_get_ntp_seconds(unsigned int id);
+
 #endif /* _TIMEKEEPING_INTERNAL_H */

