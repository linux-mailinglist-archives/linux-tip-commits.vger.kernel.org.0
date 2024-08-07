Return-Path: <linux-tip-commits+bounces-1968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC794A64E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352361F23118
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADFC1E211E;
	Wed,  7 Aug 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2KgKfpv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWxsZwPF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB01E2109;
	Wed,  7 Aug 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027919; cv=none; b=gHm3twtmU7w5NAhbS/QCipcM3IuG6IpAKyy853gqDzaMCX0iPx0FRpmuzcZ6o9Q90BnWGSZC45Z79ak5VEVEjQMlE2nKxBV5+darU1irWVdjeylnpOg95A7VJ3TPW71SHVb6SiS1fUF//IP90aIzUgDS4S3qvMCSiJzZi4dWKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027919; c=relaxed/simple;
	bh=gPsC2UlLxBw3BL0age7vpz8KLTHMKYLe4B9EaxN7Zfk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9WrGMdmg2Naa3Jb5v+/bAg0hnTy+FcSW6HvuHYHvKnG3tQyNh8j6GH6/s+ZVh1p+5TUKI6snmVxLJES2N9rMM+1wDPKGDN2LtIFdNkrksd11oxQdo1WvXhbNwJKJMs+KVH3CZFOrPDfttYenYlTpFe3kgFiCb/OdFNz4FKkxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2KgKfpv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWxsZwPF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/sP3bZnw6J72GIcKs+xcMiUcE+F2F9IcVC7hpl2HE=;
	b=M2KgKfpviE8CAOez+kBtIZfgpxcbSYJxwH+EiycgxZtrgCgfVh7Ikz5VUk7nx33URdfqm4
	dMLIjCrMCHz+LVoTn7rHDR+8MMOpiCYy2OG3fFNB2XaofdYXmLClXbpYRyEUtTdm/wXJ4U
	JVd3nWqouQQYT6CC7cbbuDiMFGvfU83AS/tl4E4pR57DJ2qGwaoBbX1hlWChqk6PsxKRwl
	R/FdFyTdmdgHoft+gpHpPrOQB7FOKMthqgT4TjF/vE+3UIuxGc9WzDDafwGr3G81bndeZ7
	j7CqwlCYRTVjywgXWxNT3AqL1gKKOcN5Bcymg1G2RGU7o94BlKZ/6i426NILIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H/sP3bZnw6J72GIcKs+xcMiUcE+F2F9IcVC7hpl2HE=;
	b=jWxsZwPF4cwkLeP6k+VVWW4UFk6dplc7MUEEnhmA+ST1sFexbomZSoU3v1RGOyrQOz0aAA
	gzKAmjylIEZTyPCg==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Fix fair_server_period_max value
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain>
References: <a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302791517.2215.9583140780460140951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4ae0c2b91110dab6f4291c2c7f99dde60ecc97d8
Gitweb:        https://git.kernel.org/tip/4ae0c2b91110dab6f4291c2c7f99dde60ecc97d8
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Thu, 01 Aug 2024 10:44:03 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Aug 2024 12:44:16 +02:00

sched/debug: Fix fair_server_period_max value

This code has an integer overflow or sign extension bug which was caught
by gcc-13:

  kernel/sched/debug.c:341:57: error: integer overflow in expression of
  type 'long int' results in '-100663296' [-Werror=overflow]
    341 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */

The result is that "fair_server_period_max" is set to 0xfffffffffa000000
(585 years) instead of instead of 0xfa000000 (4 seconds) that was
intended.

Fix this by changing the type to shift from (1 << 22) to (1UL << 22).

Closes: https://lore.kernel.org/all/CA+G9fYtE2GAbeqU+AOCffgo2oH0RTJUxU+=Pi3cFn4di_KgBAQ@mail.gmail.com/
Fixes: d741f297bcea ("sched/fair: Fair server interface")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Arnd Bergmann <arnd@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e75914e..831a77a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,7 +338,7 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
 static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
 static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,

