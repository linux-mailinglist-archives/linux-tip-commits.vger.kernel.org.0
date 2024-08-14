Return-Path: <linux-tip-commits+bounces-2048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966C95195D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 12:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34393284211
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AA1AE04C;
	Wed, 14 Aug 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40sPwqHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/EdWsW4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F51AE02D;
	Wed, 14 Aug 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632594; cv=none; b=Y83qOxlgHyZNPlHI9g+OQNbmjkSvdgxx+Q/bEglVGSERPNH8YUpaXZrfcj0HKsyX+cjqezUZgdFaWY4MFtI3ELO4Oyfuuwp/AsPf1egVp+1MXEBDmYxLCoIn+hyVe7vvlsfPk71ZC24sQGtQqddMmkr/Sb0oSHyQ/IfH1SeV4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632594; c=relaxed/simple;
	bh=hvrxb+yP2U/MuvdupA6qK0u2SlnEDY3FvwFSCzgCJPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tBgMW2NSjdRJddSSuuA/pzVgLrf+XuylcP/6NcCIp7RgTXe8ZncXXoJQ2YqMo5vkt77cw57ryX/S8T/bB3r5OgzZM4AuAcQ5Y3Iu710tt8dGk9zIA7SMWnBrlHFXdYzt8qfDZslAvOILF163ClhMoDf+p2P7ECvXWThLYzgIRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40sPwqHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/EdWsW4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 10:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723632591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXjXV6ypyUw08J79M5GJMxTmVVyn0GrdVkSBbCLTiFU=;
	b=40sPwqHnVL+qY155/HGavqBCVsK/5Gft3B26/Lnn/ufkZ9peLkPPoh+/Ii/cqmAJzSsn1o
	ee8fgU9Q2xQGVZxwHcarM1T7OjnR7YXHmN8DF3vTEcakoDAf0PHEpOkyG45PcoR7w+aqiI
	E4ugQGwUseY7DxzAGbyp+320jHh8Jwia6+3myJANkNZ/MGkX0Tt2UqOqJAxjqQdI6GuAM7
	dJzw4E6mxroAyTeR/TOVYF2lBVwW9p/KaSf9Eb5hyVplnDZuOyzZu2UdUZoqR+R4v28mux
	S+yCTEWJzFY97RZ8VHjxeeBqFcDyXeClFKonqmavgDkDP8vOLuZAmABf7Gtfng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723632591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXjXV6ypyUw08J79M5GJMxTmVVyn0GrdVkSBbCLTiFU=;
	b=Y/EdWsW4vgOmsLSLH0gptkKRJrU46LG9MxgOstT2nC6ZMHS/jPvyx5BYwjeCaq0H7IZgo8
	NqYjt9hiCnnoBbCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Add sparse annotation for
 timer_sync_wait_running().
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812105326.2240000-2-bigeasy@linutronix.de>
References: <20240812105326.2240000-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172363259147.2215.10753471240747177073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     38cd4cee73a87c40a3e9ef31c0ca7b179fd282f0
Gitweb:        https://git.kernel.org/tip/38cd4cee73a87c40a3e9ef31c0ca7b179fd282f0
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:51:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 12:44:41 +02:00

timers: Add sparse annotation for timer_sync_wait_running().

timer_sync_wait_running() first releases two locks and then acquires
them again. This is unexpected and sparse complains about it.

Add sparse annotation for timer_sync_wait_running() to note that the
locking is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812105326.2240000-2-bigeasy@linutronix.de

---
 kernel/time/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a..429232d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1561,6 +1561,8 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
  * the waiter to acquire the lock and make progress.
  */
 static void timer_sync_wait_running(struct timer_base *base)
+	__releases(&base->lock) __releases(&base->expiry_lock)
+	__acquires(&base->expiry_lock) __acquires(&base->lock)
 {
 	if (atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);

