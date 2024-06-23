Return-Path: <linux-tip-commits+bounces-1504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65186913D83
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745CB1C203D8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0E12EBEA;
	Sun, 23 Jun 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBamNBIS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzmG+F78"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B42F4A;
	Sun, 23 Jun 2024 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165716; cv=none; b=la6kCdUOgeI+VLdhUB8sRvghunPfR1Z7YLHy1gx0iWY+pRN0BDw9xWnQ7ZlQT21EaL4+Yn2hW8cAuQTUPlxjm2mp737323wirj5C5JAOGqtObFxOjCnb1FkC8P58DD3wMJHB1+eBvjjcTjjnu7145TjuWj4+JqqmHdLqCR8z+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165716; c=relaxed/simple;
	bh=xzyx/9tbpTo1yU1GzaIuisCOfstbwfUJdaEt30D6G08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sZQKz7L5X7djdSZHFNgvpx+h/pYJjdDfwF/NFCwPnmP/n4OQ6+6Cta6B3JhqZxikNdJ1/pLG1eHfuT8wxE78ljlLsP1LKNIUACvT06EuV17OtwIFOZBp86WTrCIDZSPBcjwZk/7kUX0TE0W5TPWPVRu5Jatojau4L6Fb5dCY9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBamNBIS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzmG+F78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 18:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlFslKpy6bAvldqG7vd+/Z/s8GzxkeiMuWP1KHn3rNM=;
	b=KBamNBISulqXqOwuncHFaGrCgVaftxG3Vw7Fx6x89Z3gwWLtShV+AhhIcvRd3H7mxP4ZSo
	Bz2RC0VhQVpC77GLvYrruGMUr9wAgFlNGzR93OKvRXL0JlHIiBuQkOZsQJC08FhQ6CVZI4
	HicXiaK7EMJPUYMLLvsO7Z3ogM3z6PfDUBZTV5M9B6W9KmUyYEr5QwSXN+r4YhatTfxfD+
	LSpBV/6fQOnMse5YNtMqr8XBuwN3jP2jn5zWS9nsWBRY3V1BLTK4QuK/v1Zz+mSn7+n/8r
	YG6RWCscTv3BtKDvPiPIT0ykik6R7McMb0ojr6cvlSH+4WUlsQ+tGkqmpW6Krg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlFslKpy6bAvldqG7vd+/Z/s8GzxkeiMuWP1KHn3rNM=;
	b=XzmG+F780xER9Npe6g2dxBm4tsHJjtznhkkNaAKBNNkB726iWfwttnOM+2UBl6sgni7B9z
	BNzATND2yqfJV/DA==
From: "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Add missing kernel-doc function comments
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Yang Li <yang.lee@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240607090656.104883-1-yang.lee@linux.alibaba.com>
References: <20240607090656.104883-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916571257.10875.10575305766925394032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e1b6a78b58aa859c66a32cfaeb121df87631d4ed
Gitweb:        https://git.kernel.org/tip/e1b6a78b58aa859c66a32cfaeb121df87631d4ed
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Fri, 07 Jun 2024 17:06:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:57:30 +02:00

timekeeping: Add missing kernel-doc function comments

Fixup the incomplete kernel-doc style comments for do_adjtimex() and
hardpps() by documenting the function parameters.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240607090656.104883-1-yang.lee@linux.alibaba.com
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9301
---
 kernel/time/timekeeping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index da984a3..2fa87dc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2547,6 +2547,7 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
@@ -2615,6 +2616,8 @@ int do_adjtimex(struct __kernel_timex *txc)
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
+ * @phase_ts:	Pointer to timespec64 structure representing phase timestamp
+ * @raw_ts:	Pointer to timespec64 structure representing raw timestamp
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {

