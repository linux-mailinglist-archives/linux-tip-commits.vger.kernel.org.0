Return-Path: <linux-tip-commits+bounces-3407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10647A39760
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6645D170962
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB54232792;
	Tue, 18 Feb 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+oQnwS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuuewVaf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1422E401;
	Tue, 18 Feb 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871991; cv=none; b=IDJMhsY0h1u2rFXK9vWIixAW+aK4nk6HEcUdeXxTbMv1N1PxvFxW1kCbL251KgC/fsYBbdZFIjjMO6LgxjuFJb6UOPad/rQbXq8KteYFtZe7H80Ym+wCrt/IcY4TK1+7ucrPW1YNvUg0AtKO0GmK9zm9v6c3Mum0dUXZN+Ui/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871991; c=relaxed/simple;
	bh=0EBUgqst8aGUlvXxUzHuSN9qL1F77NyKlayJH48Io7o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdzZnWzfEX+zws+3ps52BB0PP33+NyB3JGlTt5HDTEAQlchhSBba91nlcMgGb0sIXdzRaBejcTdLrFuPQhQ6cmC9Gx5I8hklclyWNw9XQoSQbCl7RDPNRJYwdtU7CcLveyxe/Rw7zX49AstKSZlv9Lr2tW7pIcz3mE5WJPSnR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+oQnwS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CuuewVaf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mhbji5V8t6rI2nNH+mI+bkwNNWXo4IIG15a204kZgY=;
	b=d+oQnwS/ZlNno3XCDkdYjToHrZEd7X2laOkySd3CJ0iWar4VcKbbz6SKVqC9x/VF9ek7Aq
	XfUGugvyQIZjoL8aTaCXztmMuj6LUUbmP2h1n0m0maA11TP42jxzELE59MQrC/31rOjWn6
	cj46Kj/9q+5HB/GusLmvnp/kNtCGgH6MhIhem9RY4uVW0947YCmtNvdyTyqmPP/5zz+5qM
	kzGxj6nAzo1NANVKtoeBknrbOOiVEemPs9frFnrs9Y8wErHQuIfrDeIeUu5srI3XNJHPSO
	OtJ5/pZZ5ohbwfwVEQfvy9xCsCdRcrr6aKwtwdkU+YnnnysHjZ+qk6YNskBDsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mhbji5V8t6rI2nNH+mI+bkwNNWXo4IIG15a204kZgY=;
	b=CuuewVaf0mkyau36dgza174eqM5PCEJ5iUOzK/aPE4I1qrOgkfTvJu3Umtj5c0MzUv4A9m
	4r8WEhacet6TpgAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] PM: runtime: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8d1ce108b043896733ce08d3deea6e84941d499b=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C8d1ce108b043896733ce08d3deea6e84941d499b=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987198796.10177.7436957307001342420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     efad91a9836e3c26194a18947e0af7f575c254fb
Gitweb:        https://git.kernel.org/tip/efad91a9836e3c26194a18947e0af7f575c254fb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:34 +01:00

PM: runtime: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/all/8d1ce108b043896733ce08d3deea6e84941d499b.1738746821.git.namcao@linutronix.de

---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee4584..425c43b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1764,8 +1764,8 @@ void pm_runtime_init(struct device *dev)
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-	hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	dev->power.suspend_timer.function = pm_suspend_timer_fn;
+	hrtimer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS);
 
 	init_waitqueue_head(&dev->power.wait_queue);
 }

