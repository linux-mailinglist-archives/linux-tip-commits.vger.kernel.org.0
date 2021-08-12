Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16813EA6A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhHLOdJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbhHLOdI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 10:33:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAEC061756;
        Thu, 12 Aug 2021 07:32:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628778762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIHYZ5fGW/DUwDGg+3IuVLf+ZAoE9UAQ5scG9d994PA=;
        b=ItNEt3fw33zOCTai+BUa0CCmXbPLZvjfGC+ZFia1yQs/yKkIUS+Yht2CytQJ6TCnSQcusq
        VOnwTAgPGPuW1ncDsMmXt/JppQhPoX3xhcvDEiZ+HQWNcEWB/yTHNsF1PhVu/U6T9kzNRj
        3romADhGi2WFg362haisbi9xDzn9hrY1DCAzdbcaRUpXEj94Pym/BU/4Fs0qmB+TzSjQpj
        HYneFQQFbOwrjUSQGF8iSw0QdHe5VAG+GyNODBmiNmSsa6+QI1O8Cio9Lnj2CFp+e40ZfC
        rhFD3q7DWfLIle668KGSYrXbr9EYJxl/k+wNJ3J677OcneNYLXlTF1uiv+3lOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628778762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIHYZ5fGW/DUwDGg+3IuVLf+ZAoE9UAQ5scG9d994PA=;
        b=diq5C1ztwLdRQqoX/Ns3CTep2UT4Yq6la+TuTHdluhxk6UFiKNbtKd90aW1vQ3dmcGe3Au
        +M9hgvP2gyZkOgBg==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
In-Reply-To: <87a6lmiwi0.ffs@tglx>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx>
Date:   Thu, 12 Aug 2021 16:32:41 +0200
Message-ID: <877dgqivhy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 12 2021 at 16:11, Thomas Gleixner wrote:

> On Thu, Aug 12 2021 at 09:19, Mike Galbraith wrote:
>> Greetings Peter, may your day get off to a better start than my box's
>> did :)
>>
>> On Tue, 2021-08-10 at 16:02 +0000, tip-bot2 for Peter Zijlstra wrote:
>>> The following commit has been merged into the timers/core branch of tip:
>>>
>>> Commit-ID:=C2=A0=C2=A0=C2=A0=C2=A0 b14bca97c9f5c3e3f133445b01c723e95490=
d843
>>> Gitweb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.or=
g/tip/b14bca97c9f5c3e3f133445b01c723e95490d843
>>> Author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Peter Zijlstra <peter=
z@infradead.org>
>>> AuthorDate:=C2=A0=C2=A0=C2=A0 Tue, 13 Jul 2021 15:39:47 +02:00
>>> Committer:=C2=A0=C2=A0=C2=A0=C2=A0 Thomas Gleixner <tglx@linutronix.de>
>>> CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00
>>>
>>> hrtimer: Consolidate reprogramming code
>>
>> Per git-bisect, this is the tip.today commit that's bricking my box
>> early in boot.
>
> Let me stare at that.

Can you please test whether the below fixes it for you?

I have yet to find a machine which reproduces it as I really want to
understand which particular part is causing this.

Thanks,

        tglx
---
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,24 +652,10 @@ static inline int hrtimer_hres_active(vo
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
=20
-static void
-__hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
-		    struct hrtimer *next_timer, ktime_t expires_next)
+static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
+				struct hrtimer *next_timer,
+				ktime_t expires_next)
 {
-	/*
-	 * If the hrtimer interrupt is running, then it will reevaluate the
-	 * clock bases and reprogram the clock event device.
-	 */
-	if (cpu_base->in_hrtirq)
-		return;
-
-	if (expires_next > cpu_base->expires_next)
-		return;
-
-	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
-		return;
-
-	cpu_base->next_timer =3D next_timer;
 	cpu_base->expires_next =3D expires_next;
=20
 	/*
@@ -707,8 +693,10 @@ hrtimer_force_reprogram(struct hrtimer_c
=20
 	expires_next =3D hrtimer_update_next_event(cpu_base);
=20
-	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
-			    expires_next);
+	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
+		return;
+
+	__hrtimer_reprogram(cpu_base, cpu_base->next_timer, expires_next);
 }
=20
 /* High resolution timer related functions */
@@ -863,7 +851,19 @@ static void hrtimer_reprogram(struct hrt
 	if (base->cpu_base !=3D cpu_base)
 		return;
=20
-	__hrtimer_reprogram(cpu_base, true, timer, expires);
+	if (expires >=3D cpu_base->expires_next)
+		return;
+
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (cpu_base->in_hrtirq)
+		return;
+
+	cpu_base->next_timer =3D timer;
+
+	__hrtimer_reprogram(cpu_base, timer, expires);
 }
=20
 static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
