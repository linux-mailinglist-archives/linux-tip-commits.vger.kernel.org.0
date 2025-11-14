Return-Path: <linux-tip-commits+bounces-7358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F389FC5F085
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6212534DEFD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684832F0669;
	Fri, 14 Nov 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xK72F1vM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHWqJR0t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837D2DE714;
	Fri, 14 Nov 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148125; cv=none; b=pTk54+7Pl3L9VTkHIGvRluMpt08LE8LHbcjJIVcgUYGzvIrAvUUJPhSw/yeknYmLdi7Dhi9ej3M4BEDH3UT8Qeo5qjAbB8nqJry8KXlVH+JxyhSg4o0BXDYZ+yqnaR536Fy0L4EwPjlFjBO0D+SjzujYUO4X4WW0QSdbtE9EJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148125; c=relaxed/simple;
	bh=M95DFcYeexLcEGUD3x2OQPNkWCalJePcofZojkFytvw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SkCmkNXIydGg0VGjAQ3/A6AMd9+ZCi6bS0IIxQdPhGZEg2yk+CV4m/efwPJshebPy/LP5F6AdgTa4LvSvazZ686lvouE+Wo+dZlb3nwsdNiEmH9t19T3osurEPLKQSUFWRidYkjsXFJNlBa5itvmipU9p7JajIbE/t8aXC2G+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xK72F1vM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHWqJR0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 19:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763148119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1p7WNs07nXLEXes9O2ZvU9r6dBrs2MKRiFFAS3BWfHA=;
	b=xK72F1vMNvQ0Yst4gaL6akFaAnt8JBYOf4VerFwE/i/+C+MvMEyqLbl3CL+uICnotdOciR
	w4FnZRn7F2hPA+0Qp3cuHrhhDhRh1QfljuMwTyQlenJW4u4YqUzmPG0uDNg8r/EoKEJpMs
	cAh31q7H8pIgLuI7SXu3BP+rOZAPp5qOeswGieVjqt6OI1xOCWbzLXFmgGeZH+4k/xRqs0
	tl4FcHlWdGBFC6DDUNbVZ2vXA4v1lGJZnZTqG5eQ/unBZOKqUL4c/bmFClwDIz35A88+sK
	DQ2JjTgmklJmJE8OflQ7LIVRmOcXQ1FZSj5ZLN+cnFOlcDidZJn6rKGzGOHpKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763148119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1p7WNs07nXLEXes9O2ZvU9r6dBrs2MKRiFFAS3BWfHA=;
	b=FHWqJR0tGv51/qLzXHf7nOZB+2tJFsOKlaJ16Rv76g3wps/9cMq/+eVpRlprmLnWKc2yB8
	hk9XL4Nq2aqX52Dw==
From: "tip-bot2 for Sunday Adelodun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: tick-oneshot: Add missing Return and
 parameter descriptions to kernel-doc
Cc: Sunday Adelodun <adelodunolaoluwa@yahoo.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106113938.34693-3-adelodunolaoluwa@yahoo.com>
References: <20251106113938.34693-3-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176314811769.498.2165775959713741464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e54dd0474c281ebcd32ada4bdbe1e0ada2e1c22b
Gitweb:        https://git.kernel.org/tip/e54dd0474c281ebcd32ada4bdbe1e0ada2e=
1c22b
Author:        Sunday Adelodun <adelodunolaoluwa@yahoo.com>
AuthorDate:    Thu, 06 Nov 2025 12:39:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 20:17:44 +01:00

time: tick-oneshot: Add missing Return and parameter descriptions to kernel-d=
oc

Several functions in kernel/time/tick-oneshot.c are missing parameter and
return value descriptions in their kernel-doc comments. This causes
warnings during doc generation.

Update the kernel-doc blocks to include detailed @param and Return:
descriptions for better clarity and to fix kernel-doc warnings.  No
functional code changes are made.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251106113938.34693-3-adelodunolaoluwa@yahoo.=
com
---
 kernel/time/tick-oneshot.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 5e2c2c2..ffee943 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -19,6 +19,10 @@
=20
 /**
  * tick_program_event - program the CPU local timer device for the next event
+ * @expires: the time at which the next timer event should occur
+ * @force: flag to force reprograming even if the event time hasn't changed
+ *
+ * Return: 0 on success, negative error code on failure
  */
 int tick_program_event(ktime_t expires, int force)
 {
@@ -57,6 +61,13 @@ void tick_resume_oneshot(void)
=20
 /**
  * tick_setup_oneshot - setup the event device for oneshot mode (hres or noh=
z)
+ * @newdev: Pointer to the clock event device to configure
+ * @handler: Function to be called when the event device triggers an interru=
pt
+ * @next_event: Initial expiry time for the next event (in ktime)
+ *
+ * Configures the specified clock event device for onshot mode,
+ * assigns the given handler as its event callback, and programs
+ * the device to trigger at the specified next event time.
  */
 void tick_setup_oneshot(struct clock_event_device *newdev,
 			void (*handler)(struct clock_event_device *),
@@ -69,6 +80,10 @@ void tick_setup_oneshot(struct clock_event_device *newdev,
=20
 /**
  * tick_switch_to_oneshot - switch to oneshot mode
+ * @handler: function to call when an event occurs on the tick device
+ *
+ * Return: 0 on success, -EINVAL if the tick device is not present,
+ *         not functional, or does not support oneshot mode.
  */
 int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 {
@@ -101,7 +116,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_e=
vent_device *))
 /**
  * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
- * returns 1 when either nohz or highres are enabled. otherwise 0.
+ * Return: 1 when either nohz or highres are enabled, otherwise 0.
  */
 int tick_oneshot_mode_active(void)
 {
@@ -120,6 +135,9 @@ int tick_oneshot_mode_active(void)
  * tick_init_highres - switch to high resolution mode
  *
  * Called with interrupts disabled.
+ *
+ * Return: 0 on success, -EINVAL if the tick device cannot switch
+ *         to oneshot/high-resolution mode.
  */
 int tick_init_highres(void)
 {

