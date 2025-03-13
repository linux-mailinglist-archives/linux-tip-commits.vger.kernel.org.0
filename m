Return-Path: <linux-tip-commits+bounces-4181-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB42A5F265
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72E117E55A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5682266B68;
	Thu, 13 Mar 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFfCBDbb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxdB1Opy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C2266B46;
	Thu, 13 Mar 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865487; cv=none; b=df90EShpWTCE5R2rLms/QZgopaUNup25Q6mTcm7Sd+elKKFMnaxCGyyQpcRuqZFnVLu82YqciP8lQB5fL6bXI1gcwhtR6cNEjPDOcI3qjqWiV+UR16cq5IQnLE+Bc+o/nn9SOgrnaeoRIIpRc6nZdQOE/lyr8kIC6y8SPOVl4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865487; c=relaxed/simple;
	bh=lOjLl8fI352ZcJByCfB4slNhTL93qoJyaaCQX0HXf1A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WykfPLJwb6nOahbUTrf6+KSyuwpZL3TIMCbzOcFHHeTPgfCL1UTHclnLEo/AQQolPzBRubuW20dBrMNr+0uRrbGsvmp+N0MVUJyOk/dvzgM6I2XbbRI2wWDxljdJjIcTixFBJv9yqJJUKoj3rIPenOj24bcQ1iupu4n7gXFlsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFfCBDbb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxdB1Opy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jACMuz15pQqiWO6+dgRLEmDo5OaewImDt46PIOo+UbY=;
	b=jFfCBDbbTEA6btkAp4ePg6mneiydNh9O1+ofejrmMzVproT9lMAgNU4WKxX7TIFGCOnW2v
	6OYfY951wNyApE8uZdKSdlv9j2Mn1UlZLsNxnZyB5SDFBPPl6qvxZklXbrkvmFly/1h2c8
	SCHLHOqI4Lob9NRg6/VPQb4QORB6300Jxrty0rxlqoBg+MVWMlUsXINnZdWDjEFf8Rvxrw
	pL/sBa6iBsDU7DU25YEEAv8M46WHNuMdNjA6yOE4vJx9r2SWrjqJClTAL4IHhTGI1q6agA
	M44cey96hKW+WeMdQSzSZLB0GNtLhu0kAQIlet1nBT70TIoz6xamusrthrhq6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jACMuz15pQqiWO6+dgRLEmDo5OaewImDt46PIOo+UbY=;
	b=cxdB1OpyIqPRQtvploBgBA4O50d4o9cfDpngG6kvahrl3jnSIkfnGBogfy65ZUZBRF+Q4o
	z7O2rSLBKkyGN1BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Make per process list RCU safe
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.403223080@linutronix.de>
References: <20250308155624.403223080@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548391.14745.1500215774385389329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     451898ea422b5861d95089d8d9c2a0ab8383775e
Gitweb:        https://git.kernel.org/tip/451898ea422b5861d95089d8d9c2a0ab8383775e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:18 +01:00

posix-timers: Make per process list RCU safe

Preparatory change to remove the sighand locking from the /proc/$PID/timers
iterator.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155624.403223080@linutronix.de


---
 kernel/time/posix-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e4c92f4..b917a16 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -518,7 +518,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		 * Store the unmodified signal pointer to make it valid.
 		 */
 		WRITE_ONCE(new_timer->it_signal, current->signal);
-		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
 	}
 	/*
 	 * After unlocking @new_timer is subject to concurrent removal and
@@ -1004,7 +1004,7 @@ static void posix_timer_delete(struct k_itimer *timer)
 		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
 
 		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
-		hlist_del(&timer->list);
+		hlist_del_rcu(&timer->list);
 		posix_timer_cleanup_ignored(timer);
 	}
 

