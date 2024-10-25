Return-Path: <linux-tip-commits+bounces-2549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABDC9B0651
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCBD1C224C7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2A15DBC1;
	Fri, 25 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3TXYQi8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpdZLiiC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925E15665D;
	Fri, 25 Oct 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868029; cv=none; b=MIcyROpw26rUPYhotf3oZmyqBsmBH0o2pE0CSlS41Bz7Od6x76jOeYDK5Dm1YRj/YuHj5yJy4GyaKhaHZyeBR58pzjBVGJwwH/lgsNdYHHVr59YmVKaYweuy4Hs7UfzzYdc1cwSlmAv765lhLgF2TY97B4KhV6qux3xT6z5Z/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868029; c=relaxed/simple;
	bh=p0C9WBAClptUwCpYUqeb2qFuecw1mesCF/RHvYOTGr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MBE3kJgV5s2jyiVJoYxS20nFp+QTY5sFMtsDzq66850hqAoO3VT2CdVDFgSDp1iKp2EFcg50WMj/iwerLNmd6OOTiisEbU6U0NUBKTFnBaM8l/sATmtmEpP4+vSeFp7ZMQB7LkCDocDMkzVUMZboTeyo0rZST6HIaa0pCxCtG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3TXYQi8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpdZLiiC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQwSdMLK01bXoxGrAF7XqUtV1IGLkPdSUtsJGVDPPp0=;
	b=n3TXYQi842xauYtWx9d+Z2KPwWy7c6tAh/orYl1G/LOQydd1nf3MlkI3vYX5mec2rXyUkH
	ACW3JCtkQvb8AXVdjeDlZZh7skZFRf6/wi5bP+NyMmfsHno6dmNksZUbIizPk/O8C3cVOl
	cemVN4kNtR6254mCtho86MFeyvEr8aVx2ADGFWPnmhQgQX8VqWJcDiSpK+1SZiBEh3wabA
	OhsPv38DAprXsTuUOKSauZtJi93NGcojLXLXUoFKhdkhq1y1Yl43dPZQcdfNQXQNl1gMBx
	21dWfrMudhpzuUxLEGCow42jwfK4IRpwfZV9o51wiQqsHt6uP3AlSqp7ibM9rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQwSdMLK01bXoxGrAF7XqUtV1IGLkPdSUtsJGVDPPp0=;
	b=YpdZLiiCzDGuY5NmKighTaj/WDpAeNr8sLk30hd9OwGozyuk37n1+c4SyJApHeQgFiS+DW
	pP1NgfYzQrZQnfBA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Merge timekeeping_update_staged() and
 timekeeping_update()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-25-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-25-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802469.1442.10628703789090915696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     15797be1876ed1c81b2e4170be8fc8b5a2acf6c9
Gitweb:        https://git.kernel.org/tip/15797be1876ed1c81b2e4170be8fc8b5a2acf6c9
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:14 +02:00

timekeeping: Merge timekeeping_update_staged() and timekeeping_update()

timekeeping_update_staged() is the only call site of timekeeping_update().

Merge those functions. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-25-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6ca250a..17cae88 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -548,7 +548,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
+ *    timekeeping_update_staged(tkd, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -794,10 +794,21 @@ static void timekeeping_restore_shadow(struct tk_data *tkd)
 	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
 }
 
-static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
+static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+
 	lockdep_assert_held(&tkd->lock);
 
+	/*
+	 * Block out readers before running the updates below because that
+	 * updates VDSO and other time related infrastructure. Not blocking
+	 * the readers might let a reader see time going backwards when
+	 * reading from the VDSO after the VDSO update and then reading in
+	 * the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
 		ntp_clear();
@@ -815,20 +826,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-}
-
-static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
-{
-	/*
-	 * Block out readers before invoking timekeeping_update() because
-	 * that updates VDSO and other time related infrastructure. Not
-	 * blocking the readers might let a reader see time going backwards
-	 * when reading from the VDSO after the VDSO update and then
-	 * reading in the kernel from the timekeeper before that got updated.
-	 */
-	write_seqcount_begin(&tkd->seq);
-
-	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
 
 	/*
 	 * Update the real timekeeper.
@@ -838,7 +835,7 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 	 * the cacheline optimized data layout of the timekeeper and requires
 	 * another indirection.
 	 */
-	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	memcpy(&tkd->timekeeper, tk, sizeof(*tk));
 	write_seqcount_end(&tkd->seq);
 }
 

