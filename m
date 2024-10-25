Return-Path: <linux-tip-commits+bounces-2587-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897E9B0C7D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28E51F24C20
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE4D214435;
	Fri, 25 Oct 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsegU4OH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcQiUaQw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BF20F3CE;
	Fri, 25 Oct 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879284; cv=none; b=rGF97fQCjjY5DFBN8dLQiNKUvetAYGTDKE/fVW32+wcKtYWfCPr2IFuASvVy4TtplkpGDa3ifBj+8/F4xuN/om5HBAfEtaOT/5ApOaG1J+6XWet0SWt0hSs5Ww8RNEHXN0sY08xr+pLfd/9OM3LsK7PHxyxqA9H6+Hb9gY9g0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879284; c=relaxed/simple;
	bh=qK4NR7d8T8hRFheeXllTHqr6CDfUqr+QrKcwLzAA7lc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pViz8Vmebdhr9Dzmhp0QmbEVEVhY8Drj8u29G7zGW4J2hgxbGfUlA/3GiRD0BmYX+BQQIhobTHMcaaJbIa9uOH8PbcqmpatTiQzVhPj0+t8fG5H2zHdCsK7J048xoSx2hQYtp6QTPhVjyZZ+KBeAkpzn25xADqPqTkpBkHCjHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsegU4OH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcQiUaQw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QuUEdWqRpxGo1Kc+21zpwEcgT/0oRgleNiFumFGM0M=;
	b=rsegU4OHxBgA1TA0C3XkTv95Mb7UeIQ9pa95c0xraQohclVpHN9h34o2M97AK7ubVKMaM3
	YbUoHDUgWf44Oxn/uM0nKLoAN/51LbMPx0cPmUwdtQSbnOW6OV5HiGAf541WHgkzmnWvn9
	nL1Zu3Sri9CRJkuEvrNiJidmAKzSK7CXaQNk2jK9Za1uuG1vW0DBaLkXuthedeBSaBXT6l
	rW4xLGgMty57sZJO6RiDiBxI/Zalx33lvTl6+5xqx4eojCVJFsRB5otHs9hIqnl/7Y3K3+
	Kgc1ES+ow9RuvI1lsx64t2L/vgcZ2mj8klOvZM5zL7ckeN2R780mBDPNzCSP2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QuUEdWqRpxGo1Kc+21zpwEcgT/0oRgleNiFumFGM0M=;
	b=RcQiUaQwY2S1D2iwpSZgEgtpjAuDUNdX/K6v4szqsIFs0o7+kWOUOSubNXYaV33QOZxHLJ
	pa6Q1hvIo7O9HMCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Provide timekeeping_restore_shadow()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-15-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-15-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928047.1442.163274573376384169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     97e53792538dd8993172e231f09dadee57f66d69
Gitweb:        https://git.kernel.org/tip/97e53792538dd8993172e231f09dadee57f66d69
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Provide timekeeping_restore_shadow()

Functions which operate on the real timekeeper, e.g. do_settimeofday(),
have error conditions. If they are hit a full timekeeping update is still
required because the already committed operations modified the timekeeper.

When switching these functions to operate on the shadow timekeeper then the
full update can be avoided in the error case, but the modified shadow
timekeeper has to be restored.

Provide a helper function for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-15-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c30b187..ed0e328 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -774,6 +774,15 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
+/*
+ * Restore the shadow timekeeper from the real timekeeper.
+ */
+static void timekeeping_restore_shadow(struct tk_data *tkd)
+{
+	lockdep_assert_held(&tkd->lock);
+	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
+}
+
 static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
 {
 	lockdep_assert_held(&tkd->lock);
@@ -801,7 +810,7 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)

