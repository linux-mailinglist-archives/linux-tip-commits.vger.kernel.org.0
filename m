Return-Path: <linux-tip-commits+bounces-2208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA321970955
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4A1C20D1B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ED1179953;
	Sun,  8 Sep 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+3w8/KV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nsYgpJG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCA178361;
	Sun,  8 Sep 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821891; cv=none; b=kZljSi1P6HifKjA7LQQChFOKNbDX9XLlchNbfOu+xqIKSVag5Gd8hgbyGMPG1XvhTwuVHert38q6FL2umHnqWR8cu5SUhAjI5CxWTKjrP7PjKj8ou4DAwLRiCEE9oAmxJpJB8AdogDsvc5JlvKr86MTuw07jkyPd5OzIu4n2+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821891; c=relaxed/simple;
	bh=RIcSHEsxYsqFDvsRb2ncCSNmGCp+xY/QniGb7KfLL/k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mQU9O+8phHFczg2P+K19LrvcSz6Iv+FiQGd2fFT0HDxjdS8t+fqSuUScitLenLpFG5IHYmv4E26ovsu3g63Np3N1jqEGK+fJECeVdxBw/cM0ZAmKv9YHztwv9EObXRgaVcCdXz/npkZFvjjX0QHqWup88m6Gdd+l4PZBnBkr+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+3w8/KV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nsYgpJG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 18:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725821888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcVq3my1a9NWu+TQ6MRBnCI/gruQJHojCVmRgV2jGXI=;
	b=N+3w8/KVkdAWY8ar/grrWxwma+kphfOzjbx/ZCks385CqZSOhjYv2L1ScOGEqIBhiQ0KVL
	5jZyhBXUmo+z527hiOwO+2EPW5byKxtog5bzKObjvrWczTz+xdPkPezk7CTOTKIcgFgGPi
	227gExIbUZ+/SOVq/YJ+n+hLlbxmjuiep0h1ZBEg4+REjTwDq+K1esDQPscCkZ3OIig0s8
	SSJzKA7WcyFrFhjkmtVXDxvODzD0aVW9l1tGCAhMD+lBf6te9Pesvha959ZdtH/OYD31VD
	qUTkGLfhHG5zawGehvfXHLqRlwvFN63MDCBycBcUwQtm3ZnIHfabLUVv6qxSpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725821888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcVq3my1a9NWu+TQ6MRBnCI/gruQJHojCVmRgV2jGXI=;
	b=7nsYgpJGr2Al3NJ4h/iCsMg2VpYyk9yubcngnRPu+XGknjVGGQR94iAX537AdqQZZ3i2LI
	vIgNUMwMyVGll8Dw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Rename next_expiry_recalc() to be unique
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de>
References:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172582188754.2215.6018971900093876238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fe90c5ba88ad43d42acefb21b57df837be86a61a
Gitweb:        https://git.kernel.org/tip/fe90c5ba88ad43d42acefb21b57df837be86a61a
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 15:04:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 20:47:40 +02:00

timers: Rename next_expiry_recalc() to be unique

next_expiry_recalc is the name of a function as well as the name of a
struct member of struct timer_base. This might lead to confusion.

Rename next_expiry_recalc() to timer_recalc_next_expiry(). No functional
change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de

---
 kernel/time/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 311ea45..5e021a2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1900,7 +1900,7 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
  *
  * Store next expiry time in base->next_expiry.
  */
-static void next_expiry_recalc(struct timer_base *base)
+static void timer_recalc_next_expiry(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -2009,7 +2009,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 					  unsigned long basej)
 {
 	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
 
 	/*
 	 * Move next_expiry for the empty base into the future to prevent an
@@ -2413,7 +2413,7 @@ static inline void __run_timers(struct timer_base *base)
 		 * jiffies to avoid endless requeuing to current jiffies.
 		 */
 		base->clk++;
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);

