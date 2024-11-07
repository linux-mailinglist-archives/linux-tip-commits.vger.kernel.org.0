Return-Path: <linux-tip-commits+bounces-2807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F139BFC12
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220B61C220C3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBD78C6D;
	Thu,  7 Nov 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLfHMBdy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+UsNS0N0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659117BA1;
	Thu,  7 Nov 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944781; cv=none; b=AtyFO6aOaHqmNbV7n9eTNBcbIw5ouiuZ7cBtlkX1xoDhX1SYbxoTaKm6W7eUTsgL55+XNqy4jyJ1tZd6s6xzJUFZi4/qbuWYSB0Z+hNFVhmWQ7/0j3XWvhPUQFzV0pc+4VYBZRqOuqTj3iEfrDgfOyWKOMuKe0hkTSdqGCdDmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944781; c=relaxed/simple;
	bh=0j84PvABPC39fTsfKN49gEbEFVcqkx82ZGGzs4idMv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KJqDbwXyC7CB13itW00zNRAxGHs/gyKBwT5H03wgDIf5lTYHeiGpWdf169SmpDV/4VGrS2P2ipNJzqn/fJkPnIunaIjW8qcBSF4fwM2b9mVh96b9uuRlLNxFsyTzdMPSvPOblJtWnWD9swmubA8vVwBwOcLQQUJf88BMiHrZx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jLfHMBdy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+UsNS0N0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUE6fYMVMHPWwy+PMrBS2Y58UL6L++bNNCEOHTxh7MI=;
	b=jLfHMBdy6XaGdDfWRfGgzIr9ObJiaW4dbZfDAzDuns3t/aa39vFtUmTk5GVhglzSl4R9xL
	8zKZ2J1JVU5FZU8wZS1MBnZrqk9Bppc2FEVPpNkdBPeFD6ch/MFWcQHbNfVYOJRA+Cf4oj
	M9dCg+QxDIOWGIEifPv9lCqr8YtAqhG3jS9ji5stOSsuEAA49dYIRKZLzD47wNnuOpNUol
	3Ua9UHKAJniOoHUyEXxFdwvsot7vGsmkginY2yRny4S7aaHNRj06ErsbIImjlBtFfLAsmG
	0o3/1JBOyY1guouUabnW6evQhhBXZRMojkRF4Gb5da+RctGgI6fuTJ5Zwkk9Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUE6fYMVMHPWwy+PMrBS2Y58UL6L++bNNCEOHTxh7MI=;
	b=+UsNS0N0hXmPcD5AdYwl6XstiAlRdk9IfBfogmLDMK0T0H1/wz23VcEd/bXShKY9cHGqic
	9AxvvwoeCYUkwPBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Delete hrtimer_init_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C52549846635c0b3a2abf82101f539efdabcd9778=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C52549846635c0b3a2abf82101f539efdabcd9778=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477743.32228.4323373373685500669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f3bef7aaa6c807b78e8fc6929c3226d3038fe505
Gitweb:        https://git.kernel.org/tip/f3bef7aaa6c807b78e8fc6929c3226d3038fe505
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

hrtimers: Delete hrtimer_init_sleeper_on_stack()

hrtimer_init_sleeper_on_stack() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/52549846635c0b3a2abf82101f539efdabcd9778.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h |  3 ---
 kernel/time/hrtimer.c   | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 6e02673..4e4f04b 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -235,9 +235,6 @@ extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-					  clockid_t clock_id,
-					  enum hrtimer_mode mode);
 extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clockid_t clock_id,
 					   enum hrtimer_mode mode);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6943046..376b818 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2052,20 +2052,6 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 }
 
 /**
- * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
- * @sl:		sleeper to be initialized
- * @clock_id:	the clock to be used
- * @mode:	timer mode abs/rel
- */
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
-/**
  * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
  * @clock_id:	the clock to be used

