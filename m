Return-Path: <linux-tip-commits+bounces-2592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB7A9B0C87
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9231F2523A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5521218A;
	Fri, 25 Oct 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nZzU5ty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oiXHsxnj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15687216216;
	Fri, 25 Oct 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879290; cv=none; b=LV0d4mF062PIOx5h6TmgODXYKWU8e4FR1uEQHVXR/AYGwvwoznnlniV9IAYU6ByOg24htUxAqzTdt5kMPf1j05gKM5WUvJwdnPfoNVE2R8QMyBGE/fcLcQHp1isHHKKz9p09GlTwPnzXadrc7KuZB2rPj+Ha4DcNnvLzXr24JXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879290; c=relaxed/simple;
	bh=wddcG6cb6Tg7loyviDGpZBaV3J0GHfHk0wyirR9Ht44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qc96mdeu9mbZJdqr4+p2QzEn4d+alKCMiCKtz7egk6DxCDrR84XV8bDeg+NnBh3xp+D3a2ISfx3AtLHXamP6BJ/8uGYbrOfBMBr9LyQHInUwXj+8QMMOFbtgs/Gjc4LpGPv0n6/BuKqi0X0OWudYcfRz7UxSZDA1fg7pDcOK+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2nZzU5ty; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oiXHsxnj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2JvceF9OaGS9JhxJWCxmEuAHCEGqj85lq88ZD4flRA=;
	b=2nZzU5tyN+AtYqk7WLirChYjKj+V5o5LEbkc+tW35kGh31frfjD+BpMbUydcIKWzOqa439
	LB3L9UMJQnsbqXq8wUKiv3vk7HEMt5+TdC7Yk06Jtw8jqLrtYrOFVQXzMj97EaHhTQl2xI
	oi+WT86CW9yIl79fO6h9/74I7R/8qixn7rY0o4B2MzY9T2JpaD71ALeMU4d8/ViDY0AXVl
	yzytXjKHelWsdewpyx5IIxCz9Ufpawoi9Sne9L4ndUmNGhDE2PBXVt6LCuubzI/98tiy8M
	U9YISE+ZCcZvk1HglPHGygwZHjw5SdyxbkyiyjVa43gLwqInSkBYjJLtNWdr+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2JvceF9OaGS9JhxJWCxmEuAHCEGqj85lq88ZD4flRA=;
	b=oiXHsxnji8AcTTkm7pE2ujLuBczsqbhW/H5vwBUmOLFpR4fJAOs2lQV6lk+HJ7dh7GAHRt
	mC4eRxGwmpVpShDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Define a struct type for tk_core to
 make it reusable
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-10-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-10-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928392.1442.5120214324565403754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     10f7c178a9dad803e80bc01f47e7b30e12a78957
Gitweb:        https://git.kernel.org/tip/10f7c178a9dad803e80bc01f47e7b30e12a78957
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Define a struct type for tk_core to make it reusable

The struct tk_core uses is not reusable. As long as there is only a single
timekeeper, this is not a problem. But when the timekeeper infrastructure
will be reused for per ptp clock timekeepers, an explicit struct type is
required.

Define struct tk_data as explicit struct type for tk_core.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5392a66..d520c11 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -45,12 +45,14 @@ enum timekeeping_adv_mode {
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
-static struct {
+struct tk_data {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
 	raw_spinlock_t		lock;
-} tk_core ____cacheline_aligned;
+} ____cacheline_aligned;
+
+static struct tk_data tk_core;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;

