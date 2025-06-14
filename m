Return-Path: <linux-tip-commits+bounces-5848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43503AD9EEE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654721898CFD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DABD2D9EE5;
	Sat, 14 Jun 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/7nKS4u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvehLQj0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDD1D52B;
	Sat, 14 Jun 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924970; cv=none; b=EOx8lOmeVBnc0iNXJ4RXimm0AqKAPLoqPU6v9eeCHbz8I919m8fHlEI4A1k3fCWvSR7CAEB/0XM+GtA3G45h3KIepSrJUzGI9/tfFz9AGGC6m3X/qphjDW1oHPPQhREZzjMwZXFz8K9310AsDXpp/u9qdXc6MrLFodM34/WA2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924970; c=relaxed/simple;
	bh=iE3NzghoKuBVQ+W2ID5MXwlT8rAKywQdL1NPXSNnCic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IuhN60+wmtkDbb74lyKo1TP4i9JivYAMcHj3FJrd0/tqOfDreXHfKpLWWeRoyCigVX/FgnF3lI/taPMwpAviEzMjG7K3WuE4vOGanIQP6leQ9neJtnbJFc3pxf65unleMeUz+mEjxxtDEiscA/J5qlHYYoegBBLk9P27G6yG8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/7nKS4u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvehLQj0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Jun 2025 18:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749924966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QVqjogCVIUaITQ4y5ExvyV9KKAe4vtfqCFVsVdjcRM=;
	b=0/7nKS4ua4ROJN9d+QP31o0n3BuIAf4f6UcrobLYS6jgCoLj0O1JGwWgIjDk8YPxC8zKPj
	80aq3DIx0BdLw7ADTp6v8hN9UfFp9irTmeTwI3Avcr+ex6tS7TQbi1CJx17fcwURB/tLZI
	GpocIFavQqOMIiy8Sq5EY9BsItF13uKke5JlDcipqhxljIeX3f9bBDIliEukUbuG7yn7Kp
	49GS0bnaDODqRfKBFp0VEaSu07ksJ8+TWqeRVcaNGwBmDPJa7yUJlk78pEaletN7GwK+D3
	Ay0DzV4KnHWLJTFx0vgYR2GPwhf97/sCC5YH2eB4YwmrKKBdbSoo+YJS3zrVRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749924966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QVqjogCVIUaITQ4y5ExvyV9KKAe4vtfqCFVsVdjcRM=;
	b=pvehLQj0yFxT02k98Ug0lAOFMthyOe+wNc0QXdZ6lipAF0AC67+0qTl/gQKu/fhUijXmRC
	GXkax+HIVcOjXyCw==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Use cpumask_next_wrap() in
 clocksource_watchdog()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614155031.340988-3-yury.norov@gmail.com>
References: <20250614155031.340988-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174992496575.406.1572877544071692301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bfa788dc2ddaea7d7930f63a5c7c8f3668a3f2c5
Gitweb:        https://git.kernel.org/tip/bfa788dc2ddaea7d7930f63a5c7c8f3668a3f2c5
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sat, 14 Jun 2025 11:50:30 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 Jun 2025 20:09:44 +02:00

clocksource: Use cpumask_next_wrap() in clocksource_watchdog()

cpumask_next_wrap() is more verbose and efficient comparing to
cpumask_next() followed by cpumask_first().

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250614155031.340988-3-yury.norov@gmail.com

---
 kernel/time/clocksource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a2f2e9f..e400fe1 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -587,9 +587,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * Cycle through CPUs to check if the CPUs stay synchronized
 	 * to each other.
 	 */
-	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
-	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(cpu_online_mask);
+	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
 
 	/*
 	 * Arm timer if not already pending: could race with concurrent

