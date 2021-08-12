Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA83EABC7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhHLUbw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 16:31:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhHLUbw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 16:31:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628800285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3exK/lR6t6Dbvglgzd+Bf4fBmwMv8kRs9nn23PWQEM=;
        b=Y5+HA1E7/u03PL+rCmCOnL0fuU0NGWloBEApwv/NAeO539dTI4eIAHDQ7UffnNc7BGxQZN
        nrGM1fsHU3yuVuKfvQWF2D5Ejz6Okg9isd05fkK43VLJDD/WECYPRjJguWQm4avSCHs6+4
        S2jkpBcy0aC860MvdA1DCsENgnQVzi9su5gUkVXimJFC5F8pyid0KN1uC68v4YsXivM5Gr
        T4VuDBTZCQrl3wsiyIlLZL0lOZfr2Gfo5cT1Go5P89+Zlr1qaALAan1z4CRXAyHLF+fOjP
        exEuyFre2N8bABLKdf38w8ab2klvsDG51/y3tkngXg0U0USFu989Bv7w+Y59hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628800285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3exK/lR6t6Dbvglgzd+Bf4fBmwMv8kRs9nn23PWQEM=;
        b=fGdZmd5Z/lT71YUoVKW/uI0bHV+P9lahndmDL6ArS1FXRZSi/vrkVQzCG502PnHJqbHHwP
        cHGPWrJr8U4MCmAw==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] hrtimer: Use raw_cpu_ptr() in clock_was_set()
In-Reply-To: <87a6lmiwi0.ffs@tglx>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx>
Date:   Thu, 12 Aug 2021 22:31:24 +0200
Message-ID: <875ywacsmb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

clock_was_set() can be invoked from preemptible context. Use raw_cpu_ptr()
to check whether high resolution mode is active or not. It does not matter
whether the task migrates after acquiring the pointer.

Fixes: e71a4153b7c2 ("hrtimer: Force clock_was_set() handling for the HIGHRES=n, NOHZ=y case")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -944,10 +944,11 @@ static bool update_needs_ipi(struct hrti
  */
 void clock_was_set(unsigned int bases)
 {
+	struct hrtimer_cpu_base *cpu_base = raw_cpu_ptr(&hrtimer_bases);
 	cpumask_var_t mask;
 	int cpu;
 
-	if (!hrtimer_hres_active() && !tick_nohz_active)
+	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -958,9 +959,9 @@ void clock_was_set(unsigned int bases)
 	/* Avoid interrupting CPUs if possible */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
 		unsigned long flags;
 
+		cpu_base = &per_cpu(hrtimer_bases, cpu);
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 		if (update_needs_ipi(cpu_base, bases))
