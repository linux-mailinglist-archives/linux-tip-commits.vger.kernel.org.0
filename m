Return-Path: <linux-tip-commits+bounces-2539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC75B9AE123
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5917DB23591
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB61CB9F7;
	Thu, 24 Oct 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+owQSu9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ybUJKN47"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E918A6DE;
	Thu, 24 Oct 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762635; cv=none; b=eF7+M6/ugn2SHodTFNp1Cf2vtHtx9UpDdQD5VT9va880YCWnO2726a2a7ZjO7Y2KAFKq1PW9qnMwzWIvcmvbwAQDwhfgjQN2vHkpLE0sRnBSg+PzlJAWam8P2su/85o7/0WT9fF8jCDZRZcdLK+5rPcyB14YMEk5seJ3LdoJAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762635; c=relaxed/simple;
	bh=ZCUXwRdi+WZBikDxqBAa3NRJ5yHra4Ec+FxdiiYOvIM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Adnkq2+KOMbBU6uCFp/MqUIJhO2uiRxSIEZ8vLjwPvuo83CiGiir9MkcVknp0iKfHcAlgMZXcAW2myGsLlzwakWVtSj3iyd8IUT4EaPtmZMBcY+CedFQ/m3UpdfnWvl30+Wq5wopKA7qG9QoVfNfF5w3wk5pPtH7P8ENZB/nHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+owQSu9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ybUJKN47; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqrFeYwDDxRA5/dto/UqMTgmFfQzd0/ehuVN8CkLbs4=;
	b=D+owQSu95xbZHKJ6IHC2dAtOsLgVEoDClyfChJmh2v9QJKfndnwhNijMii6TVgeUh3eF/X
	ljT8ihbEnTfxtlfQopTUYOEtHUD6g4Enzj2YwlMjzUDPzQ/LdPUXg69n0E7ZqfRqgkTMSX
	afVcei5w4KbYDgqT8mp8/G9kIlE1mWVyTdgYk+0IGf8ye0l46+hhVm//U18PiDvWyU95Du
	d7xU33BpFcCVZuShsm3nI/brCbQ19anF36bhtnKsVLyPhIFoDw4PDT8xVRS+N4pHmC94qy
	R7LXIo+u5zTh+H3zOm7TjXEQ0AJoqk3UVJng59JT6n81mMU+I8sPaoVYkigatA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqrFeYwDDxRA5/dto/UqMTgmFfQzd0/ehuVN8CkLbs4=;
	b=ybUJKN478Lc9T3pT+tXZwQa6bRTUF1Hue7vDZjWQKnO6OeJrkVy8ZosnDC7tE6rNiFjkJ1
	gZvJTjL72JnB1ZDw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rt: Remove one __cond_lock() in RT's
 spin_trylock_irqsave()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812104200.2239232-3-bigeasy@linutronix.de>
References: <20240812104200.2239232-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976262709.1442.2801381791688783254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b1f01f9e54b1aaadb6740f86017e8fabdee77fe2
Gitweb:        https://git.kernel.org/tip/b1f01f9e54b1aaadb6740f86017e8fabdee77fe2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:39:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:27:01 +02:00

locking/rt: Remove one __cond_lock() in RT's spin_trylock_irqsave()

spin_trylock_irqsave() has a __cond_lock() wrapper which points to
__spin_trylock_irqsave(). The function then invokes spin_trylock() which
has another __cond_lock() finally pointing to rt_spin_trylock().

The compiler has no problem to parse this but sparse does not recognise
that users of spin_trylock_irqsave() acquire a conditional lock and
complains.

Remove one layer of __cond_lock() so that sparse recognises conditional
locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812104200.2239232-3-bigeasy@linutronix.de

---
 include/linux/spinlock_rt.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index babc3e0..f9f14e1 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -132,7 +132,7 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 #define spin_trylock_irq(lock)				\
 	__cond_lock(lock, rt_spin_trylock(lock))
 
-#define __spin_trylock_irqsave(lock, flags)		\
+#define spin_trylock_irqsave(lock, flags)		\
 ({							\
 	int __locked;					\
 							\
@@ -142,9 +142,6 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 	__locked;					\
 })
 
-#define spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
-
 #define spin_is_contended(lock)		(((void)(lock), 0))
 
 static inline int spin_is_locked(spinlock_t *lock)

