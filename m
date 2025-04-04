Return-Path: <linux-tip-commits+bounces-4686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 651FDA7C2E2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C85C7A6F4E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379A21CA0D;
	Fri,  4 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ek4Xd4mS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXU6thAk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FB2192F5;
	Fri,  4 Apr 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789277; cv=none; b=iqux02xSu2cD/gOPvpo2ye7g4kS67crnUzaUu8fDL6Iprh98RBFaGdq9cCDtAueG79bk4BjjmD3lURcOzw0AONDRYGIRXVpzyVbnP/+EovSDFR4QoRMXUKN1E6I6lVWof8uaydGC0e0chNgYc1rO3o6J2eaPV2yL88i5sBq33ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789277; c=relaxed/simple;
	bh=I0vqfzSJgG5sH/lIbTlD6q6RRRmj/j0uRHfH8ipUH+E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IcHJy6yLrCRqSa8yzRmeN9qvcZpNzQDDrl8KSVGvMLNWgghR2kwWnpJtuR+CnlF2brmidhIsc5Kh3OCeZ1jDeuqLBdkXkBrbq5p9LZTfR9uWSy97xm2TghrmKi8kg5k0Qb8WCTQT/sOrvW+dV6uxJvl4IR3PNzRverI245BGuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ek4Xd4mS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXU6thAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWNjODt9KdFGPmbJiXpNRvmGD4HFlb29KZD/kDPv75s=;
	b=Ek4Xd4mS4VSb8zZTu6kAUyKMxsQ2IIPUtOarF9VMAW1KGeu7CRrQxHf831MhqzkaOPM2d9
	/bjfaLr5KJnQ9aps2ocbJN+ufUq0wPMuvAStCgGxPCTBYYjLmFPROOhmGcj2h9YN6596oH
	AfYHk43wKrtvgJSIHWZzCnIv+PIgdjoPeI++GB6LUtKWy7bh1nTZXYQ+CrMEE16GyM6CCB
	IDAqGaN1XE6R0uV8OV2P2D07PJf9R0Rw9BIS6lMVWGLOT3NMrzjW/8bIVcbHI6UdpnPYWO
	mVstEQPdi9XW9VZHPuxh6hRd0LpyOGetg3gPqlVy+5kXqId5rn/p3k86YRZ3Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWNjODt9KdFGPmbJiXpNRvmGD4HFlb29KZD/kDPv75s=;
	b=tXU6thAk+Cd39uCg3AaTTPvSe2U5gjxXCPMFvAb8uKbw6QiLYO41EqpL4VtXxxI5ghGZpL
	5PScdqARxprkVtBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename __hrtimer_init_sleeper() to
 __hrtimer_setup_sleeper()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C807694aedad9353421c4a7347629a30c5c31026f=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927406.31282.7789679119864373052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     823ef15530a7d63c4d163744f445c2dc3d420228
Gitweb:        https://git.kernel.org/tip/823ef15530a7d63c4d163744f445c2dc3d420228
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper() as well, to
keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/807694aedad9353421c4a7347629a30c5c31026f.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e883f65..8cb2c85 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2016,7 +2016,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_setup_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -2026,8 +2026,8 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
 
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	/*
 	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
@@ -2067,7 +2067,7 @@ void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
+	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
 

