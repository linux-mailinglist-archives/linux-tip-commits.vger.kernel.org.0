Return-Path: <linux-tip-commits+bounces-2459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681B99FB87
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBABAB22838
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF71DF259;
	Tue, 15 Oct 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QunMiRv9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYkRla4v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DA1D63E0;
	Tue, 15 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032087; cv=none; b=SviuzwZ4LuL+I9ybEsJbvTUlhvFfZELvelFsVE+PW2vmS+tWIDMM91zw+v11WXWYUWb0T5Giig1E/G+l/sN+JC0sAA0hO2jblfYhZv5fzjLPNjwyM7Roj6HOaWt0XLumLevj1rxjGROo2918qMlVldBm251iv3AWd4dMa1+AP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032087; c=relaxed/simple;
	bh=1bHC5DJee1ELoOo44ZH+pcuNKe+M0rZxQx7UgH2e7/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uJaOGB/ey3l+v8TUtizwMaEFtDGCx69Qu0i8BLGlHnGrDSJ5VSjetkxWANVnYk9cPPEucKtN7X1IogUMdgft1Q99JwBBqsYFHQxMKCX07P7gFSmesTMD5ZoCmH4QVtI7X2RXVdWQc4+U3cKOS9xYY+V+3Sbs98pjbK4wMAsWcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QunMiRv9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYkRla4v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnVWeysV490o+gDmJRV0fr6n8kFbf8+WePZOewOzZfU=;
	b=QunMiRv9DJsHXloHG44lcQEKB3NmOseKgiwSQewh+7hZaw1UL2zhiAuydzbcqpFlUH/CZn
	BULNfiAZjo3OWOt9joAawm1jurNbzZ7/BTCmHAWe1GImUGQVXHvV2LZXxXKMqcYUYtoMz1
	uf6DOq6R9+cR8NX3iQGDP4qFxw2VycwVEgLtwkoNVRP94EQ4fvhvdKGd4nIFjntk6xz28a
	1gtUhBdDcJqNJdSDOeQ2BICy79E3fp5TtFHUqJJh4A/W0AfEj2t6vsxo+Rbz3QoCXkEcrW
	Hncn89a9cJ8wD9veBGtjkoWrwm3HjHYf/xl6svokHPLN7C94EjjRSHckae1k5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnVWeysV490o+gDmJRV0fr6n8kFbf8+WePZOewOzZfU=;
	b=uYkRla4v4xlg4V09Tb0fw2QUapfU8kuboYpXfnEdSYTlHSA00ioEus2hA1oN96AOgl9iMm
	o4F8kfRwPIme7/DA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] mm/damon/core: Use generic upper bound
 recommondation for usleep_range()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, SeongJae Park <sj@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-8-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-8-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208300.1442.6813676317012789457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ef0245582e5bccd8b4c480a58bd4da91ee276397
Gitweb:        https://git.kernel.org/tip/ef0245582e5bccd8b4c480a58bd4da91ee276397
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

mm/damon/core: Use generic upper bound recommondation for usleep_range()

The upper bound for usleep_range_idle() was taken from the outdated
documentation. As a recommondation for the upper bound of usleep_range()
depends on HZ configuration it is not possible to hard code it.

Use the define "USLEEP_RANGE_UPPER_BOUND" instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-8-dc8b907cb62f@linutronix.de

---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c725c78..79efd80 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1892,8 +1892,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 static void kdamond_usleep(unsigned long usecs)
 {
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
+	if (usecs >= USLEEP_RANGE_UPPER_BOUND)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
 		usleep_range_idle(usecs, usecs + 1);

