Return-Path: <linux-tip-commits+bounces-2550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0B9B0652
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13EC1F23856
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE31632D0;
	Fri, 25 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FvskVX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5zXyTzoo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E015821A;
	Fri, 25 Oct 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868029; cv=none; b=M3G9aTjzBZLqFcG+34e1DuBDqGKvuvZvMT5agE7SDKSxRYszYGoiflQB8tk9IqjShFq6c6kN4J3lGYDwi01vdrc608yMTBch8QkniYs5SZufTuvbtnBGt5BDdqf2SZ7OgQRU1V5681p3lncvsVBOkgCUPI+5J0+/1NDtKDjdlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868029; c=relaxed/simple;
	bh=FP697xHO10SM+DqUqOjQz8TwG8qQKzcDAn021RGOuqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ll3pPSLgBNWSbt/WkbEhfvVgGvpg/iixh91z81pDLoa8r+vQzRJL6HOPpmJ8IdroCbiD+vinHTDV7xu9e5iDW9Bh2uU+P26LauunhOjKBtv7CvdzgVHjkiyiSeA5TatxcMyR4qIwxXbj+E0j8F8sqm4+hidsZfQ9n1Cw+FOEwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FvskVX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5zXyTzoo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwRcPXeL4NggGKI2IUXcUaijT7wfiWCf9bJRPoluvDU=;
	b=4FvskVX23+v0+qia+gt2NX7OIOnjRanBp7UgW5U1WntZef2PdVA4nzY6dsDwOudbN/dQEG
	wguT37ur2xQa6pBJnBVUsvHCdbSTWeq49IupIHaH6pMiDvJmr4thPrk36clLWKvpxpRnTq
	hzvMNXSh7y/6DiA6201RK3KMtvfKqznTH6rgh7DGcFAQ96Jf5y4mPF8xp0IQHbW8n/Q6Xk
	Yq2GBICYwqPRT7yh5mnLXS/XK9kN8RTQcvk2x6EwWZObuH45kwQz4O7NgV/y8l+h2AVMik
	/qGN0r1HT5LDumRWd/fTGjGX1BcEP0kFERXtTP5xpWLvUzNd8EnXelNnbBbw2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwRcPXeL4NggGKI2IUXcUaijT7wfiWCf9bJRPoluvDU=;
	b=5zXyTzooi5LbKnCymAoRqBCM9/R3YXCHhJONxh8zwCjB+F+B9KWH26fXn+j2Mla21Xs354
	V7AYnqDXekSSjuAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Remove TK_MIRROR timekeeping_update() action
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-24-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-24-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802538.1442.3024123527670216234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     da5cf1159cd1fb7016633c68fc4be72a6b8a3db4
Gitweb:        https://git.kernel.org/tip/da5cf1159cd1fb7016633c68fc4be72a6b8a3db4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

timekeeping: Remove TK_MIRROR timekeeping_update() action

All call sites of using TK_MIRROR flag in timekeeping_update() are
gone. The TK_MIRROR dependent code path is therefore dead code.

Remove it along with the TK_MIRROR define.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f117982..6ca250a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -30,8 +30,7 @@
 #include "timekeeping_internal.h"
 
 #define TK_CLEAR_NTP		(1 << 0)
-#define TK_MIRROR		(1 << 1)
-#define TK_CLOCK_WAS_SET	(1 << 2)
+#define TK_CLOCK_WAS_SET	(1 << 1)
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
@@ -816,13 +815,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-	/*
-	 * The mirroring of the data to the shadow-timekeeper needs
-	 * to happen last here to ensure we don't over-write the
-	 * timekeeper structure on the next update with stale data
-	 */
-	if (action & TK_MIRROR)
-		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)

