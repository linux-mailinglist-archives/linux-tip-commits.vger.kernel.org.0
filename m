Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A43EA640
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhHLOLh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhHLOLh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 10:11:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A42C061756;
        Thu, 12 Aug 2021 07:11:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628777464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWNgdxiXy6tMLVp4Qpu0K2wwVVcdTTpcBJJFD/kOpu8=;
        b=nzuyuQaNf5fLWH7s3wfMWfiSJ3QK5NhcB6EDBcjgAtkEuni4k5aY9Fct8teoEOKpsOaF5N
        p//nmInufnbiTP49CyyYHT0W3AopuW6TdGHbXGNYjR/H6gRZVXgt1GFRc0Nu3oO9SeDDJ+
        tD3oZpzg0vp8QCe3WouyToTLnbaI2KL0CAoBwI4mXJsT2kCR3U9L+hHsq58rTNvfU4gocu
        XwiKG3ptHK9eebZAEuvB7dplsW2QIvSbqQFjOcviHCqzYSYh2/spqtAOQo4noxddfOyAEa
        I3dD7DfU4Ew/hfWYn4+r06N8B4dBmjnDBckBljmc9SxfYVnmPx1+kGbPeF2cfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628777464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWNgdxiXy6tMLVp4Qpu0K2wwVVcdTTpcBJJFD/kOpu8=;
        b=JrQH4lErxA2CEWs/bfuqVb4vmdMzYqQrgEEG+hBk282vHof13cLDfZfuCIVy1voSj3kSoG
        n99yUzZO4tbHf6Dg==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
In-Reply-To: <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
Date:   Thu, 12 Aug 2021 16:11:03 +0200
Message-ID: <87a6lmiwi0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 12 2021 at 09:19, Mike Galbraith wrote:
> Greetings Peter, may your day get off to a better start than my box's
> did :)
>
> On Tue, 2021-08-10 at 16:02 +0000, tip-bot2 for Peter Zijlstra wrote:
>> The following commit has been merged into the timers/core branch of tip:
>>
>> Commit-ID:=C2=A0=C2=A0=C2=A0=C2=A0 b14bca97c9f5c3e3f133445b01c723e95490d=
843
>> Gitweb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.org=
/tip/b14bca97c9f5c3e3f133445b01c723e95490d843
>> Author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Peter Zijlstra <peterz=
@infradead.org>
>> AuthorDate:=C2=A0=C2=A0=C2=A0 Tue, 13 Jul 2021 15:39:47 +02:00
>> Committer:=C2=A0=C2=A0=C2=A0=C2=A0 Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00
>>
>> hrtimer: Consolidate reprogramming code
>
> Per git-bisect, this is the tip.today commit that's bricking my box
> early in boot.

Let me stare at that.

> Another inspires the moan below, courtesy of VM, which
> unlike desktop box does not brick immediately thereafter.

> [    0.556416] rtc_cmos 00:04: RTC can wake from S4
> [    0.557184] rtc_cmos 00:04: registered as rtc0
> [    0.557636] BUG: using smp_processor_id() in preemptible [00000000] co=
de: swapper/0/1
> [    0.558169] caller is debug_smp_processor_id+0x13/0x20
> [    0.558511] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.14.0.g1fd628c-=
tip #15
> [    0.558946] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [    0.559623] Call Trace:
> [    0.559796]  dump_stack_lvl+0x62/0x78
> [    0.560041]  dump_stack+0xc/0xd
> [    0.560263]  check_preemption_disabled+0xd3/0xe0
> [    0.560576]  debug_smp_processor_id+0x13/0x20
> [    0.560954]  clock_was_set+0x1c/0x310

My stupidity. Fix for that below.

Thanks,

        tglx
---
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -944,10 +944,11 @@ static bool update_needs_ipi(struct hrti
  */
 void clock_was_set(unsigned int bases)
 {
+	struct hrtimer_cpu_base *cpu_base =3D raw_cpu_ptr(&hrtimer_bases);
 	cpumask_var_t mask;
 	int cpu;
=20
-	if (!hrtimer_hres_active() && !tick_nohz_active)
+	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
 		goto out_timerfd;
=20
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -958,9 +959,9 @@ void clock_was_set(unsigned int bases)
 	/* Avoid interrupting CPUs if possible */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct hrtimer_cpu_base *cpu_base =3D &per_cpu(hrtimer_bases, cpu);
 		unsigned long flags;
=20
+		cpu_base =3D &per_cpu(hrtimer_bases, cpu);
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
=20
 		if (update_needs_ipi(cpu_base, bases))

