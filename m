Return-Path: <linux-tip-commits+bounces-3522-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D5A3A362
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 17:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081DF162668
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4926F471;
	Tue, 18 Feb 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jsGvAig";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hywrwEjT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216226F467;
	Tue, 18 Feb 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897865; cv=none; b=aOhvB2pm1EySxJFcDjgeyE75LPz0I04vsoqMg2H5FDgNPmmTn6Gxy3vDnyxHoXzKsmzuYp7Sx6n63pP+5W5zz3b63IerT6qS7NKO49fIXaEqLGibzbj1yi83uD8SrWVf5gT7Bl0boMDV7GpsDjKTEmglEvTbB4W+rNFYH1Uy4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897865; c=relaxed/simple;
	bh=8YJGs/9zIOcEfcP+pVGdC1/eYpsDFAQ7ZFEXmUhjqx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NK4CecQ3OMNIaMe90ix5AO/D4XvKtuwo7Anhhj0TjuUiCno3b+zp90Ri0btD/Tinq2Nwj14dMxp902Ck/gKqKZjO/xIP0pZXR1poZOC8Wr5rfng+kX+qG+dPUrjhXCOhjiCuWbAwLauCsX6mkpX6q8Od7YjXQhM9Q85z6G/4h/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jsGvAig; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hywrwEjT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 16:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739897862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd/rmGCzRcJfOPncUwynUn1jrWaSxpiAmvq3VojyP2M=;
	b=0jsGvAiguuniJUOPPXcf0iSKRt42LPpSXOzlI5+acskUs8YgxY5shdipIyCZ+Hya3vBkNt
	vf5c5Fjcu3XZsYIUaDFr7YTrjgywRBlr10DdLOSVhIYmLvM32hKJTc369afTD2JgArD+6b
	qshJPR1dOM46CVGO0q8zx3O003fLGOsn0A8ISk0OCxc7C9+yFlSkOKWQpV6D70+kyQ88aw
	hP21ndMl1ENzGyLupshppCh4JfD5rSHTEBWzurpe85c7EIAu9J/sPajA93FM+iyNJ7qH09
	earCeJq/5lbOAkRTC6IcX+HSiUueNNFU56Ss3cMDZBW8w45P268e1UgdYOoWbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739897862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd/rmGCzRcJfOPncUwynUn1jrWaSxpiAmvq3VojyP2M=;
	b=hywrwEjTkq+0Z1ryu4p84mjetfI6vkv4SssIhGnnxL2Oz8Ii4BtafJMiMmX9TDz7IJ8NXe
	nVx6anAx+sy4vHDw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] io_uring: Use helper function
 hrtimer_update_function()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9b33f490fb1d207d3918ef5e116dc3412ae35c1e=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C9b33f490fb1d207d3918ef5e116dc3412ae35c1e=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173989786160.10177.12467937104358294915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     3f8d93d1371f460ed30ebfa30fb930c0605035fc
Gitweb:        https://git.kernel.org/tip/3f8d93d1371f460ed30ebfa30fb930c0605035fc
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 17:41:35 +01:00

io_uring: Use helper function hrtimer_update_function()

The field 'function' of struct hrtimer should not be changed directly, as
the write is lockless and a concurrent timer expiry might end up using the
wrong function pointer.

Switch to use hrtimer_update_function() which also performs runtime checks
that it is safe to modify the callback.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/9b33f490fb1d207d3918ef5e116dc3412ae35c1e.1738746927.git.namcao@linutronix.de

---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ceacf62..936f8b4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2421,7 +2421,7 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 			goto out_wake;
 	}
 
-	iowq->t.function = io_cqring_timer_wakeup;
+	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
 	hrtimer_set_expires(timer, iowq->timeout);
 	return HRTIMER_RESTART;
 out_wake:

