Return-Path: <linux-tip-commits+bounces-3348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1555FA2F9B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Feb 2025 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FA7A1C7A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Feb 2025 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FE1F4611;
	Mon, 10 Feb 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuQchJVI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0SSOmOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0625C6EE;
	Mon, 10 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217912; cv=none; b=FpjfwFWnoUAG4DgnrH5WuWqTXnNZA4y+CKvlJdoyr9ffaKSEDWPNfZuKalw9pt3hDVCEfIkp+PL4Uh/4yWre8L6itIbmesUkaxoaW5EWG+9ulpIdmwjw4vKDcJb4Se1vxidPg6ZjR4JpSj1bJRVKvl7k7euy37gy+jemy+E4DCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217912; c=relaxed/simple;
	bh=NjijhPE/k3z9TVfsAiO5pkJ8i+kpeBUaRyR7I2CDeA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iYRSmG943gkcGC1CHu8g5ncqqk2BEs1ILarvQsAEX+x9k7g5GuYokYqXXTDamrcWavO77o9r0g4usFmTyCIBnRs6tRldRflbi3sZie6Yei0R+TmojLGBpAFDr6pFDNXGWxkESZDXwRNa2jfs5jOM/w22wxfJjlDxbXROObmbkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuQchJVI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0SSOmOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Feb 2025 20:05:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739217909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geeOBuf25WujjsBBFbi/oiYjyBGcs+lRJovLdw9A1/s=;
	b=fuQchJVIUVSrKalEo1ySlmxj9EY8t6ifsrFPancmms4Hkg866n+DrbFXGWovNSs9WVdo4d
	0TukCELdETcchtMQIxc09cwQSm9pl8eqcjWB2xoxsEKA9w0ErsomOTRZ6F8nGcmchFTzoO
	pY2yPzf3vNo8ZBfH0yGGjwpYUtk9ZP57UR5T7jHBhjcn8F+xHNrXT2Q5CbDU2LCm3LBmR/
	b4n54zFoJgyGSIb5ubyuPkhUmWdLGVsKr7Fk5I5ugTaLbAqV/SjnUqTn+7Q5Pobi7oQDxu
	xUgV4AHtUooHOkQtpbiFqk5ADBokaIM5hHVCAGs6HZVdA+Aji18dNmXcwJqYgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739217909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geeOBuf25WujjsBBFbi/oiYjyBGcs+lRJovLdw9A1/s=;
	b=U0SSOmOTVLIujoh3904ntNIpjFPx+uPQuNtM+lmcC/dbRw0L3qkRwlbFMvbvj1A6hJ8CHC
	wX/YxIwhESmcgYBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] hrtimers: Make hrtimer_update_function() less expensive
Cc: Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ikpllali.ffs@tglx>
References: <87ikpllali.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173921790373.10177.18365163927395084147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2ea97b76d6712bfb0408e5b81ffd7bc4551d3153
Gitweb:        https://git.kernel.org/tip/2ea97b76d6712bfb0408e5b81ffd7bc4551d3153
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 Feb 2025 22:16:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Feb 2025 20:51:12 +01:00

hrtimers: Make hrtimer_update_function() less expensive

The sanity checks in hrtimer_update_function() are expensive for high
frequency usage like in the io/uring code due to locking.

Hide the sanity checks behind CONFIG_PROVE_LOCKING, which has a decent
chance to be enabled on a regular basis for testing.

Fixes: 8f02e3563bb5 ("hrtimers: Introduce hrtimer_update_function()")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/87ikpllali.ffs@tglx

---
 include/linux/hrtimer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f7bfdcf..bdd55c1 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -333,6 +333,7 @@ static inline int hrtimer_callback_running(struct hrtimer *timer)
 static inline void hrtimer_update_function(struct hrtimer *timer,
 					   enum hrtimer_restart (*function)(struct hrtimer *))
 {
+#ifdef CONFIG_PROVE_LOCKING
 	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
 
 	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
@@ -340,7 +341,7 @@ static inline void hrtimer_update_function(struct hrtimer *timer,
 
 	if (WARN_ON_ONCE(!function))
 		return;
-
+#endif
 	timer->function = function;
 }
 

