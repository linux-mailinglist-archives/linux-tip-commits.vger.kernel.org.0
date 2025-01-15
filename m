Return-Path: <linux-tip-commits+bounces-3264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892FA12F0D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 00:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C3161F09
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 23:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8951DD9A6;
	Wed, 15 Jan 2025 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wrgifJI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474781DD866
	for <linux-tip-commits@vger.kernel.org>; Wed, 15 Jan 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983342; cv=none; b=nG/DVAdsD0OP495ssJ2XjAa4/OCQcUTq+Ivk7Xqqt+Nl48c/PFLAujsW1ShuZbaJWiVk1UUfTqquvIl0Sll+aa08AK6c/x+SlUrr1jpwyZOF5gcbcfeVA3l4/am5q7z5T0P9FzjLoK3LqM8f2fzsSr+HaHT0gRi8g92h2lnnwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983342; c=relaxed/simple;
	bh=KdlJluTkxOnfAYEFjgsHb4xMd6XZulqvgcRfp7khFXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otO+O4VktU83T69GMYFrxYZyRMV8C86MdWcurUn8+YvKIujcfIAStJ9r95CBhbPd5vbFYr0rr9c6ts+QiAF/bLXWZFPIAvSA/nIR3sRxkt8r8xZqaCIgsru3ghujiJQlyH3Mp4xdOIu62AieAPRjcMoQLE5UENEw2o528W/34kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wrgifJI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso679153a91.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 15 Jan 2025 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736983340; x=1737588140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JHIOCMGw41yGBGLuHWVhzyX82V4iAB9WkKnb5lhxgI=;
        b=2wrgifJISFw+YC37b16X7klYyf9ng1mpSAAP2kupmAiKkGudFVY5rzMN0e1VkmefPe
         21LwDvh09kv34tdbNod1v8WGJ+6h5KUtBDMVPAFYBWtz6F/SeaG1yM5nlIUFvclPqGZ5
         JurxWWQGorhvQ+qSFlBJITE/ezQDHOdM39paiRms5bO/3kCIWO7tb6l0m2xcc7RLD7cr
         nMBJibehc2QMarb5ycO26rAJTGSKACA8goC7gsuzSy+g2SiLaZgWF6AreWzfQ8rPs78O
         89PupwCPojaSt13zEpBPAiUqOAaEtpDl9uOCgNIKkCfLYniwWtwZWXdMH+t1e4UJxxW3
         ZIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736983340; x=1737588140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JHIOCMGw41yGBGLuHWVhzyX82V4iAB9WkKnb5lhxgI=;
        b=NuTmJ3ceX2zO/erhzxMKDdyTpHyYNt77GRr4H/buSKvpvkMIqT5ag1H2of58toqsXc
         9CXxLjccygebYLAzPtO6DD4JS+QWZ/TVifaZfXgAaOX8WcHNDhus/VVUtQRsd+2cFQYX
         r0JyXAH8nGe6KE+0jIFUwcM0hh/6S0zuEQfcqU4ayOVTVvKPiADEUmh6oiUtllmwcPD2
         jypFbHHqnHxclrJS4lWFrqzyLXbVnnPd5sgc7w4LMDnjgaINaMHt9bUEf78dAiFtYARg
         EMSdyso5v/XZ5qs1y8FTf7+RX86csmsdrYxOULAZP2WOIqRRHxXu5UD5KYv90kBwczkm
         0SvQ==
X-Gm-Message-State: AOJu0YyCZHQX5AQCeAUBrwUavnBO6YzqZ7KsuXHt7p7ppUdaICUGJ1Hh
	hF4OwSwI1749dvCyIW/apf3T0Jnu+rP9TkYPZAQBxw8riO+f36DjU7Ph7nimw6Ykad7b3SMV/v7
	spg==
X-Google-Smtp-Source: AGHT+IFBqE3qrBf0HSYHhZWrcCHWk/sS7blXXVC78Ra3Mf5IcMOQB/FvY2GQjkfkps9VzEOlqOEVe0u7bYc=
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:2ef:786a:1835])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:534b:b0:2ea:7329:43
 with SMTP id 98e67ed59e1d1-2f548e9a5c2mr40238879a91.6.1736983340616; Wed, 15
 Jan 2025 15:22:20 -0800 (PST)
Date: Wed, 15 Jan 2025 15:22:19 -0800
In-Reply-To: <167517494734.4906.17956886323824650289.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230126151323.702003578@infradead.org> <167517494734.4906.17956886323824650289.tip-bot2@tip-bot2>
Message-ID: <Z4hDK27OV7wK572A@google.com>
Subject: Re: [tip: sched/core] sched/clock/x86: Mark sched_clock() noinstr
From: Sean Christopherson <seanjc@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+KVM and Paolo

On Tue, Jan 31, 2023, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     8739c6811572b087decd561f96382087402cc343
> Gitweb:        https://git.kernel.org/tip/8739c6811572b087decd561f96382087402cc343
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 26 Jan 2023 16:08:36 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 31 Jan 2023 15:01:47 +01:00
> 
> sched/clock/x86: Mark sched_clock() noinstr
> 
> In order to use sched_clock() from noinstr code, mark it and all it's
> implenentations noinstr.
> 
> The whole pvclock thing (used by KVM/Xen) is a bit of a pain,
> since it calls out to watchdogs, create a
> pvclock_clocksource_read_nowd() variant doesn't do that and can be
> noinstr.

...

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 16333ba..0f35d44 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -71,12 +71,12 @@ static int kvm_set_wallclock(const struct timespec64 *now)
>  	return -ENODEV;
>  }
>  
> -static u64 kvm_clock_read(void)
> +static noinstr u64 kvm_clock_read(void)
>  {
>  	u64 ret;
>  
>  	preempt_disable_notrace();
> -	ret = pvclock_clocksource_read(this_cpu_pvti());
> +	ret = pvclock_clocksource_read_nowd(this_cpu_pvti());
>  	preempt_enable_notrace();
>  	return ret;
>  }
> @@ -86,7 +86,7 @@ static u64 kvm_clock_get_cycles(struct clocksource *cs)
>  	return kvm_clock_read();
>  }
>  
> -static u64 kvm_sched_clock_read(void)
> +static noinstr u64 kvm_sched_clock_read(void)
>  {
>  	return kvm_clock_read() - kvm_sched_clock_offset;
>  }
> diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
> index 5a2a517..56acf53 100644
> --- a/arch/x86/kernel/pvclock.c
> +++ b/arch/x86/kernel/pvclock.c
> @@ -64,7 +64,8 @@ u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src)
>  	return flags & valid_flags;
>  }
>  
> -u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
> +static __always_inline
> +u64 __pvclock_clocksource_read(struct pvclock_vcpu_time_info *src, bool dowd)
>  {
>  	unsigned version;
>  	u64 ret;
> @@ -77,7 +78,7 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
>  		flags = src->flags;
>  	} while (pvclock_read_retry(src, version));
>  
> -	if (unlikely((flags & PVCLOCK_GUEST_STOPPED) != 0)) {
> +	if (dowd && unlikely((flags & PVCLOCK_GUEST_STOPPED) != 0)) {

This effectively broke sched_clock handling of PVCLOCK_GUEST_STOPPED, which was
added by commit d63285e94af3 ("pvclock: detect watchdog reset at pvclock read").

By skipping the watchdog goo in the kvm_clock_read() path, the watchdogs will only
be petted when kvmclock's pvclock_read_wallclock() is invoked, which AFAICT is
limited to guest boot and suspend+resume (in the guest).  I.e. PVCLOCK_GUEST_STOPPED
is ignored until the *guest* suspends, which completely defeats the purpose of
petting the watchdogs when reading the clock.

I'm guessing no one has noticed/complained because watchdog_timer_fn,
wq_watchdog_timer_fn(), and check_cpu_stall() all manually handling a STOPPED
vCPU by invoking kvm_check_and_clear_guest_paused().  At a glance, only the
hung task detector isn't in on the game, but its doggie still gets petted so
long as one of the other watchdogs runs first.

One option would be to sprinkle noinstr everywhere, because despite
pvclock_touch_watchdogs() calling a lot of functions, all of those functions
are little more than one-liners, i.e. can be noinstr without significant downsides.

Alternatively, we could explicitly revert commit d63285e94af3, and then bribe
someone into finding a better/common place to handle PVCLOCK_GUEST_STOPPED.
I am leaning heavily toward this alternative, because the way things are headed
with kvmclock is that the kernel will stop using it for sched_clock[*], at which
point VMs that run on modern setups won't get the sched_clock behavior anyways.

[*] https://lore.kernel.org/all/Z4gqlbumOFPF_rxd@google.com

