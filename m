Return-Path: <linux-tip-commits+bounces-4690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9599A7C2F3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819D017C5FF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582632206A9;
	Fri,  4 Apr 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCa1k7Me";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkgIAs/k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900421D3EB;
	Fri,  4 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789280; cv=none; b=s+18BiYu7R29BIrJfVksUgwL69a21ch8BKyrS7pGarOBsNJI6Mv1wTcfePN8a7lq1+MJ+zFfX0o2iKTQtqjb3SDICW4e9ST0IjS1gjJlL6R2ETrniq8m1Trxd0UZkDy+VEnoQHT84+bDKRWPG0zd+Vd+OS1nHAfRrdfxkMNXD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789280; c=relaxed/simple;
	bh=ZZ4WdJXo50NrO7RE40m1W2iken1v8isNwT/x2xg1y0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ahdyxQ+1/42puFMrl1dPNTEt02prt4QR+EgeGnV65A+mIvPO+K9AZ9FrGBKDTT8Ur9Jjmc7/Vihm2mmzpViWQWxXYDk6XK+jZJXhz47gz+gO50WkquYDZLkQadI/9U5HgtD48j80+808ZR3sJMW+RmZKxP4zw1bpq3K6wxyFEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCa1k7Me; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkgIAs/k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56tv80guiVdUCVJJ95L8Y4+PpOsEH9SPePw7fVWn5y0=;
	b=kCa1k7MeOpShtQpNSIvlSXP3EhSbDvOUe7f++EM2VukgZQv7EFxGoQAq1JrEK/2cBxmtTe
	h7BiPh02YQkfNFhI5Kk94720YVBKF0/YMtim0Y4OKyhqLrSc/hasKZgmH6USZ5TqFNxoAf
	WjVq5DvMCtbO6bUQAKhWdWRw16W5W4BoND+sfKiE1f/ClkeOXEBR5vjZo3+2/mZuG/1Kr8
	FrfemTcnejkr8xnourbwPSX64SlLDewabVGVYh1BV6nBxoc4p5LWW6rX9O1bZ1TwyGClMh
	Ma/Z8eZi1JYe0fuMUl5BEw6siqqqt+qj59wKsktnjV0Oj/J8hDAlNsY8MphAEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56tv80guiVdUCVJJ95L8Y4+PpOsEH9SPePw7fVWn5y0=;
	b=qkgIAs/k1lhe1j7BKUnN+HZJFUEdbBQ54mdiPxnnR5kMh7Cl2h+QTHgpVkbdueA2TLxuQN
	IL6LQ74lTG+bfkBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Switch to use __htimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927641.31282.8494192026176295066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     0e090a0a12d8c8e54c1056eab2dfa3d4558cf498
Gitweb:        https://git.kernel.org/tip/0e090a0a12d8c8e54c1056eab2dfa3d4558cf498
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Switch to use __htimer_setup()

__hrtimer_init_sleeper() calls __hrtimer_init() and also setups the
callback function. But there is already __hrtimer_setup() which does both
actions.

Switch to use __hrtimer_setup() to simplify the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d9a45a51b6a8aa0045310d63f73753bf6b33f385.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b7555ba..2d2835c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2061,8 +2061,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 			mode |= HRTIMER_MODE_HARD;
 	}
 
-	__hrtimer_init(&sl->timer, clock_id, mode);
-	sl->timer.function = hrtimer_wakeup;
+	__hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
 	sl->task = current;
 }
 

