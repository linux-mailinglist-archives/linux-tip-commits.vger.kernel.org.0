Return-Path: <linux-tip-commits+bounces-5499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DCAB01D5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F5C4662B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E6286D57;
	Thu,  8 May 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdIWiX6M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HHcK2Qi0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79728640E;
	Thu,  8 May 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726872; cv=none; b=fv9lN7je+ajJ3qWNv4FhO9/LmoKFLBn+K+spsmdFKcmdXVif8qNoxmzE4xKfXR9bJ2HdD8wCCCiqGd06us4kQH8L/CjRi6JzZzUIPmjifWJGRsEUVp3xfLuwnWJ7pA5H1pWjqfDbqikaVYsTwILEQKXFTK1EmfuPTIeHAvX2zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726872; c=relaxed/simple;
	bh=OP66WgpGSPDF4ykDO2kVGYB8hAj5ZGadVkBWYhe1eQc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s7sbu4uMyqc/84OWlJIIHChnfjbCtJC8brSXN7DSi4JzvC2fLFiMryv467kioJxeEwsJvoYjlkerR2xVPSCKDU55uldaWbwTtotdQ70l/9yRlEA0OHsCZBr3y/mymNzpLOqqgt0yFLq8yvQD8PcMeOe52h9O3dsIFt/AduanQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdIWiX6M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HHcK2Qi0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o4KEx/w8gNHlLZIDplRtwQBT8oLGVjtFNZiXPAF+VQ=;
	b=JdIWiX6MgcMp2StcRpala9Xy38U5Ru/ogE5YNgbbjnWwAEt+BYUziMmRmMHkU2VBDfSP1m
	NBWuUBeq1gz+FJd6YW1DmCvjfZjeclewEVRr0NJpaQ22bxIhWBXXryi9dMlvWMd8fPjLFQ
	bknGv4EiI2KTold6lw5ImbYKk9yvNgCM0jliawLTVqtV0DuhGREIeh9qcDpz71ca8u2Czl
	ut4i7Q2ww3nAXIipUfIAAkCwpehRuCoMe8tkMsp4ZrUrpBOFHQGDv6QqIuLsdIZToYIj3N
	/UrRDUTCCxDncgKSNNHAO3TcmUPH+Ni5LIcAI7dWgcPIVgT3XDSHo35kPMVF7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o4KEx/w8gNHlLZIDplRtwQBT8oLGVjtFNZiXPAF+VQ=;
	b=HHcK2Qi0wfZh4S8fGdXOZyoQZJ2P3e1Q4ZnT9IykOhE8Wi8OcMCwmpSwy+uPKhxAR95vU/
	DZMFhJkjGXOiBHCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] timers: Rename init_timers() as timers_init()
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-8-mingo@kernel.org>
References: <20250507175338.672442-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672686829.406.7023458314247776498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     751e6a394c2ecd08825d5ba527478e171b87144e
Gitweb:        https://git.kernel.org/tip/751e6a394c2ecd08825d5ba527478e171b87144e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:33 +02:00

timers: Rename init_timers() as timers_init()

Move this API to the canonical timers_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-8-mingo@kernel.org

---
 include/linux/timer.h | 2 +-
 init/main.c           | 2 +-
 kernel/time/timer.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 68cf8e2..153d07d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -168,7 +168,7 @@ extern int timer_delete(struct timer_list *timer);
 extern int timer_shutdown_sync(struct timer_list *timer);
 extern int timer_shutdown(struct timer_list *timer);
 
-extern void init_timers(void);
+extern void timers_init(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
diff --git a/init/main.c b/init/main.c
index 7f0a2a3..bf9c5d2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1002,7 +1002,7 @@ void start_kernel(void)
 	init_IRQ();
 	tick_init();
 	rcu_init_nohz();
-	init_timers();
+	timers_init();
 	srcu_init();
 	hrtimers_init();
 	softirq_init();
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 11c6a11..012b919 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2612,7 +2612,7 @@ static void __init init_timer_cpus(void)
 		init_timer_cpu(cpu);
 }
 
-void __init init_timers(void)
+void __init timers_init(void)
 {
 	init_timer_cpus();
 	posix_cputimers_init_work();

