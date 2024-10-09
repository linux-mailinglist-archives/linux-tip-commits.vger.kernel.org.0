Return-Path: <linux-tip-commits+bounces-2392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5330996538
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Oct 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F811C237CA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Oct 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C28B18CBF9;
	Wed,  9 Oct 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jrr9N2Xr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3MT9GfG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3003189BA2;
	Wed,  9 Oct 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465714; cv=none; b=B1sRcCZ6pOcrUMLu5TwkhGYWfCNhB5S4B8UgLhBoe3hDPhlx3+4N2D3Gy5vvfwzAT7gKaxHPfs7dYtQsHJQmjCJ+SPImowA40Nsf6SDQIo5+kqtCZ9XGaMPRjyUh2/le2JWRpLxe+3ySsfv3K2f0laIu6EOaFHPks9U1qGsLUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465714; c=relaxed/simple;
	bh=+Eu8FVQhd542cysh/WxOzlybLSHvB5lcDCwYoHePP5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NZ3l1+LmxUNKMYKL+4D/yu8H7hKeenUFcQwuo2Kn4Sqa8ganwbdlpYelA1tLtIWRnDXIiVqdWWwCsmhjOWvQntVyqOiWrA2n/+Thl6gF6UZplj8zGK+KCtzx5BoBxSSRbp/h4WOHR7uf6K3zFZPJScuvjIPk5JGN/AMeZsD6JbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jrr9N2Xr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3MT9GfG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Oct 2024 09:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728465710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDCJxJ3eCN6MJCFUBbljx0WkoRjF5PJfmH47ifNwzE4=;
	b=jrr9N2Xrj0fpyDwZcRyrs6KS2NEz/tavjK3BO2nsYF38cb2i1FvvSQPcsgpjuRp+WhEp6E
	348bww1NUa/k2WVy7XllTEOEaNPxR8FUS5Kn8Fpo1cQQPwWrsYF3/HN5O4qlWBNX4lpqoo
	H1RleJ8MKxxWrb0aHYpwpyKmR3rIayn1mNKuOD39YdStoI3CMLJzCfxNLLU8LkIWPDhFIF
	WVO//Et85AbzuvHWt2KOCMdmZHT23hcIAltOZl4BrGgZvysLdYB9bPuJQMe+jX88tjOdqL
	SQ0vEPTPrEG2aEplWS1a59sJtpg7tELnrCQ5I64I+O8CETAYO1uqYnANq0RbnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728465710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDCJxJ3eCN6MJCFUBbljx0WkoRjF5PJfmH47ifNwzE4=;
	b=c3MT9GfG9qhuUQjsvk+Y4iHKrzv75x5r/k7u2Im96FRxm0Z4txizvXMKFCV3UDfKxJ38Po
	jstsvdQhcUz/orDA==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource: Remove unused clocksource_change_rating
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241009003032.254348-1-linux@treblig.org>
References: <20241009003032.254348-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172846570954.1442.6028241325035117957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5ce9bb4d5af2f5ef38f134e3cb400c873d357de7
Gitweb:        https://git.kernel.org/tip/5ce9bb4d5af2f5ef38f134e3cb400c873d357de7
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Wed, 09 Oct 2024 01:30:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Oct 2024 11:14:29 +02:00

clocksource: Remove unused clocksource_change_rating

clocksource_change_rating() has been unused since 2017's commit
63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific
clocksource code")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009003032.254348-1-linux@treblig.org
---
 include/linux/clocksource.h |  1 -
 kernel/time/clocksource.c   | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d35b677..ef1b16d 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -215,7 +215,6 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult, u32 shift)
 
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23336ee..e041ba8 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1262,27 +1262,6 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating)
 	clocksource_enqueue(cs);
 }
 
-/**
- * clocksource_change_rating - Change the rating of a registered clocksource
- * @cs:		clocksource to be changed
- * @rating:	new rating
- */
-void clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	unsigned long flags;
-
-	mutex_lock(&clocksource_mutex);
-	clocksource_watchdog_lock(&flags);
-	__clocksource_change_rating(cs, rating);
-	clocksource_watchdog_unlock(&flags);
-
-	clocksource_select();
-	clocksource_select_watchdog(false);
-	clocksource_suspend_select(false);
-	mutex_unlock(&clocksource_mutex);
-}
-EXPORT_SYMBOL(clocksource_change_rating);
-
 /*
  * Unbind clocksource @cs. Called with clocksource_mutex held
  */

