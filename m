Return-Path: <linux-tip-commits+bounces-1739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B4939450
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D0E1F222C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE28A17084F;
	Mon, 22 Jul 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q11nxDbW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2NAlVfW2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673201BF54;
	Mon, 22 Jul 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676921; cv=none; b=Irx33Y8XaZKLUc0gzo0IISswmS2L2SgqkNNOywB9HwGQCGBp5ViZn4949ZUDd2FuA6/nM3jtyPDpEUVa2moRTi3bvdGNgoo0BwEIrvIYa5qakdErm8VRXPBAimDa4e6xtz2YYvJELuycTXb4L+6PCjhUB3cBWnkhjy3+Odr9Lo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676921; c=relaxed/simple;
	bh=gJDjzCs5GMBlJvCD0bkganVseCKJ4DQukKx7u4rCMEE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UbKwAJA6KaWKO+p4pV8NK/HCQHhaMMZ7r2pBzyd3kQgviVR0RFgTzkTvsyI16TzdZrYeMGzJpvOW5NTwE+veEQKJ6MJQ8qR8qh+Sman1HPNtAr7hjIi5gl1/Uivsp5A3r1j3EJlMKiGcEV3rqdfjmfntZUbR9nwXKRjPT1VtNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q11nxDbW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2NAlVfW2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jul 2024 19:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD8d/NqTO5ueMi+SfT+LQ3iynU2pO0G8Z7DXhSUCwE4=;
	b=Q11nxDbWJ4tuy/r/IfdSseXvPnmTVbu9jKxQaKfFulAuTKagKbrIkB3uoXBOinhzs/UiOH
	8vujbQb//CZojnQfUPTQfRFzg4WyQZlKOgXjAE7WwIoY01CyS0GcP+67TM4u3iZcWV/yLh
	cuqcOJxUOyyq9/wHHqI1K712RYZbZ7f/vbVuYpHwX4oukfzeVCaHwMLSMW2SuuiGJcislZ
	/L9frZUjNv0yJPhvjj1DhsBoppLIBhAezlOjPciRNaD8Emcz86mSOrH0wmvQJSA3CWYsbV
	fZxVN5Kf2PfsSjqjU3CvDzr8QSnj9jyznHAorukhDEJalOwL6q5J27rcDA7l1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD8d/NqTO5ueMi+SfT+LQ3iynU2pO0G8Z7DXhSUCwE4=;
	b=2NAlVfW2gxfJtbIEHf2BvTtrm1yhdhe3yrxhjcezHc221XcDKWyhFF/wD00NmrWzyoLYg8
	Kuw8nvP30CBm07BA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/migration: Spare write when nothing changed
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172167691840.2215.11473035056721858214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     2367e28e231af05243b92325de9a38956ad0b565
Gitweb:        https://git.kernel.org/tip/2367e28e231af05243b92325de9a38956ad0b565
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Jul 2024 18:03:34 +02:00

timers/migration: Spare write when nothing changed

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move the write to the place where wakeup value is changed changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ca76120..9c15ae8 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1215,14 +1215,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp != tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;

