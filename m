Return-Path: <linux-tip-commits+bounces-2562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F89B066D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A8E1C22800
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D620F3CD;
	Fri, 25 Oct 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TdcuBHL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6F0uELf9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5D20BB44;
	Fri, 25 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868038; cv=none; b=itdfAT0Duiw+sjhh0cVOwN3EfnOOGE6ie1JDJPl8mECtRqIM6YP89oc31r0Gh28FvM51lFzbFpGyUp3SHkAga8NIKqv86TtFLcveQwqIT3gRjN8Mly60rm/ETSO3y/erDyRPmZCGo9TBRyXrzK2dRwv2+HQeWX1l11mvCoL8T1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868038; c=relaxed/simple;
	bh=AZFGF0S2J59Pfl/DMmpjbhtMpZ0A/CvoQ7yF94Ustsk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WdHXGYVtdfS/LLooiBb5JWoJ9LnUBL0JgbWt/SBP0ZcCtUifRMcevz0sG+WefCtCKvhSjGhzli1+1ZEZ/bt6CRt2+1IgbyDyOh3h2nxjHn9BJxIs5p3T2p3jliYg9vjyBgA381eEHWPKJMn66tQv6r30tal63LbiMHm/m2B8IDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TdcuBHL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6F0uELf9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8obq3TyOOYvMjAAUXsqtxpMYwKt6WDJAkMFkkbHKWU=;
	b=1TdcuBHL/X34C6zYf+otIxya15yE/7l/kfzAvhO/CS3chdFjmPDNr6p/fpIaO7kGKqRe9W
	a5FP1usgxhBwTLjNW46yhb5HFELzPyIaTRfj+MLIweSbZphAX2/QuWinIRCsII8+vhM6dJ
	Jr13q4ibAWPr1j7vSTaks8NEuvRBMxDGXaUe76rTLK0jQqdoQwIkdgT5Fv36PlHQs8/5n6
	Xn91bC+D10LrDbojLfQdKNSAFIZgFzGvKfdp6AI3LE/9ZH15vvJKrcgyRXkHaIVIPd2T/Q
	cAw8FGnmGtiXZW2k8L4j3Ih2tcm4P7+JRZ4qkeKNfa0T8WLNIADqKcf4W/egbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8obq3TyOOYvMjAAUXsqtxpMYwKt6WDJAkMFkkbHKWU=;
	b=6F0uELf9mkd0QtIf+Good0iE7nx7oasBQdwG/FQESkelO3Mj3TCz/dL3CX7y/Pui5nOhsn
	Ic7CSKmawgplNaDg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Introduce tkd_basic_setup() to make
 lock and seqcount init reusable
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-11-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-11-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803401.1442.2735708155036370167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e202a13aea0cc80266604f3cdbcab9d9b5592a9b
Gitweb:        https://git.kernel.org/tip/e202a13aea0cc80266604f3cdbcab9d9b5592a9b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:12 +02:00

timekeeping: Introduce tkd_basic_setup() to make lock and seqcount init reusable

Initialization of lock and seqcount needs to be done for every instance of
timekeeper struct. To be able to easily reuse it, create a separate
function for it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d520c11..cd83dea 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1765,6 +1765,12 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
+static __init void tkd_basic_setup(struct tk_data *tkd)
+{
+	raw_spin_lock_init(&tkd->lock);
+	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+}
+
 /*
  * Flag reflecting whether timekeeping_resume() has injected sleeptime.
  *
@@ -1792,8 +1798,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
 
-	raw_spin_lock_init(&tk_core.lock);
-	seqcount_raw_spinlock_init(&tk_core.seq, &tkd->lock);
+	tkd_basic_setup(&tk_core);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&

