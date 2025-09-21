Return-Path: <linux-tip-commits+bounces-6704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E2B8D744
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Sep 2025 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60683A69E3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Sep 2025 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA654791;
	Sun, 21 Sep 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SyG74xaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wvUogs5p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7DF50F;
	Sun, 21 Sep 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441980; cv=none; b=s+xdLYkUw5TsT/OqGt/+eDlUe7Rb4S5HwRUXM2XpOOzAgfFpaUs0QEvy+tMkXze3iHFsjgr+0pL7Ao7ZywhC+uQjLZdMNSH9XZs/y4xMtE/XVIatSCa+w80BASCD/XUNUo2gLk1yrK938VCxxE/2D4tdycPxJIhDOjNl/RAB0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441980; c=relaxed/simple;
	bh=YNXO5wsfg46AgY6IvDzyZBiJiGKQm1HTV2DSzXRcSBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uO//zf7Omq7DXYRKl+ZsFYs34tO5ckIBwNMO21SoKgfw2idwFYr9N/N6AMnMZwMEHaduwlJfNg08/4mmFKbTQYLofH0TzGaFIB/pqrY7q0F9xY0J66g7sFNOyvqi3iJZu8a4wjlMoWZMDUIvxzVQ7docNYhn/E81/udHo02vPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SyG74xaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wvUogs5p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 21 Sep 2025 08:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758441976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4pultIsHG+iGzVxn1N2xaxNRWujRasgdlTN5QSfgfA=;
	b=SyG74xaKGzP5JKUcQAYc4mGK88gUh+4DlEUXIXSeZ/4T2mL8xMPDZjGLUkO2MekMOE6khX
	J+OtojLI32wuL2QDWJOkfcXOk932f/YslvSGseBvPXgYqtYN71Kagli329SXfOGNMlAdzT
	Q08DKgGt0ZbJD2w0xAyRpWnX1IsX5IQMKJ/dLQd6BpWSya3aUrl0UrnXiMeoladsqfkCAv
	1rBegIIBFqeOCiCNoP1sap5gzZA6ZDOE/XDGkBJIKJk8ujoew4bNV4mSciJ2Vx7t5/V487
	1sNRvAT2fBS+GwdVmCc7SqwX8NRMWLiVvu1aV1pOxcwLIF3+jfcCEnIn8r0bNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758441976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4pultIsHG+iGzVxn1N2xaxNRWujRasgdlTN5QSfgfA=;
	b=wvUogs5p5hMv2tAD7BZsWzpyUmoDrKJhRGHPBJQN7nuCVvRlvhzp6RhH+G8BCnhXyA9eWK
	8k44H4na9UfhJzBw==
From: "tip-bot2 for Haofeng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Fix spelling mistakes in comments
Cc: Haofeng Li <lihaofeng@kylinos.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_943DD74006B627A4CC01A3DE6AD98A769207@qq.com>
References: <tencent_943DD74006B627A4CC01A3DE6AD98A769207@qq.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175844197200.709179.14745138242148511323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     391253b25f078d2fe5657a1dedd360396d186407
Gitweb:        https://git.kernel.org/tip/391253b25f078d2fe5657a1dedd360396d1=
86407
Author:        Haofeng Li <lihaofeng@kylinos.cn>
AuthorDate:    Wed, 10 Sep 2025 17:37:03 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 21 Sep 2025 10:02:02 +02:00

time: Fix spelling mistakes in comments

Correct several typos found in comments across various files in the
kernel/time directory.

No functional changes are introduced by these corrections.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c   | 2 +-
 kernel/time/clocksource.c  | 2 +-
 kernel/time/hrtimer.c      | 2 +-
 kernel/time/posix-timers.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 577f0e6..069d93b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -35,7 +35,7 @@
=20
 /**
  * struct alarm_base - Alarm timer bases
- * @lock:		Lock for syncrhonized access to the base
+ * @lock:		Lock for synchronized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
  * @get_timespec:	Function to read the namespace time correlating to the base
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3edb01d..a1890a0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -144,7 +144,7 @@ static u64 suspend_start;
  * Default for maximum permissible skew when cs->uncertainty_margin is
  * not specified, and the lower bound even when cs->uncertainty_margin
  * is specified.  This is also the default that is used when registering
- * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * clocks with unspecified cs->uncertainty_margin, so this macro is used
  * even in CONFIG_CLOCKSOURCE_WATCHDOG=3Dn kernels.
  */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f383df2..7e7b2b4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -201,7 +201,7 @@ static bool hrtimer_suitable_target(struct hrtimer *timer=
, struct hrtimer_clock_
 	/*
 	 * The offline local CPU can't be the default target if the
 	 * next remote target event is after this timer. Keep the
-	 * elected new base. An IPI will we issued to reprogram
+	 * elected new base. An IPI will be issued to reprogram
 	 * it as a last resort.
 	 */
 	if (!hrtimer_base_is_online(this_cpu_base))
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2741f37..aa31201 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -534,7 +534,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 		goto out;
 	}
 	/*
-	 * After succesful copy out, the timer ID is visible to user space
+	 * After successful copy out, the timer ID is visible to user space
 	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create

