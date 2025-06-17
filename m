Return-Path: <linux-tip-commits+bounces-5858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40686ADD621
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB3194232A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B1285047;
	Tue, 17 Jun 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="U97lQmrz"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12268285067
	for <linux-tip-commits@vger.kernel.org>; Tue, 17 Jun 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176672; cv=none; b=qOayDcoAzHEKXKTcKAtJdkBY7n28gIIZeg+qUNNQ15zQf78JOA/epm+1Zbs/728eTMqoUxIQzqLyLyzs3I5+89oYjUAQ6HfbUyBayy/QrTQ0KeR3I0dT3cBt0NiT4XB593LKF1YDY0nhzltYCEyg4wxr3fJYb0fHVjiglBTOGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176672; c=relaxed/simple;
	bh=nI6mZX8UIGXCS2ky4Mde5RPI4jG8feBj1XmxlwS/Qi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhA863gwi32LtPjOSzge7ARXtO2x5CVP+BmcvKF4LxrUyChUkPsS4FlrtsitYzasuPvLmWCbriK6A/IX0MmhjlPVgA9BbOWYTmOWxnJpbe78hQ8flEU/9Rb8v0UhFcGgKxuFJmgqXymv9bYgQwX9wDhcMvguszqifAU8wr3FcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=U97lQmrz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so6458224a12.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 17 Jun 2025 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750176669; x=1750781469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kXVdaP2cOJuMHwGR5xIkb7zkn+fH5FKb+gzDtJIqbNk=;
        b=U97lQmrzKzP3hsMgKQtZYDApTkRBU8ROKhMAATYmMC18BpRectDKUPzdJCCsZ82kzZ
         L2mhJSdsKWiQL79UPJbKxZfKpFKLBKQmwkOpPtVhy1lGiM0kAQQviSCoqOj1and0GmCZ
         wuIP5wFUu8erOBUE99ZcHykfg/8i24T4svkcPLRyxiTwwA8WMYwHZ8MKo80oDfgZvLhh
         XfuhqwriGaVcdI3IUQEmXnPkuk7YKiCVoPpvUeQr/PXjJSQZeUXeor/bgSNhsefVGOty
         uGHgMstL77RTVyQka1N81s5pdbIeiGJpiQeaNEt/P+5nmdLI09P5zhhjOgwxPaLY/1/x
         nrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176669; x=1750781469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXVdaP2cOJuMHwGR5xIkb7zkn+fH5FKb+gzDtJIqbNk=;
        b=lPEIHyl7Cu/JKoXe/T6tgRPdhvXvph2DyX8FlwfRPninQg9ipKlXpoLf//IysT4uxK
         zGV8IyztAzxcAvYfVsOk9oJZ3k97zYc3o+3ygInJC/hYvBMAFMd94QZqWckuHrOwOYC9
         AHCwsxa4jwWGs+Xe/z+MDbFY30XYxL2QOCWOK1t2haKYL3rKZh9bXq1FNr61mWQzchfM
         EKcZ+Kg73dqosyR4y910NyLVMZ/csHNoLhL7ydQkmCXz3tLmRAwHAEZrXwyHO/Nw/umD
         LeqgLB5n4RcX94kzDPHS6XAO1HzQXwQ0aZ5zwGyer55UTPLbH0BRF3Lp593fYzZmCUwk
         jYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCO6M/S1Vkxa6m6ntyVSqOMDO6AmN2LGAK3d7EdTieYwgAj61gj6/aB3qFzybfAki7jCNPQFo6KZiv9V3trUQ2Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykvrd240QBb0PPwymqW/9EWoVPVNGAK1HWrJSibyWdKBlntWj+
	lANa2NtnOss5HLGbsPbTnQCk7F60DA6ixfDhY7h5CB8gRjnepJ8+9zDxpEI8VWvsY4c=
X-Gm-Gg: ASbGncuj1+ZBYU6asgmQvSb6W51J2TnsRkRz9zVgXBhWREKK8BZG1eU/ycp0SiYjoKa
	2cJCaxlfLjM+a1TUqvWrRcfh8JJWrdVXdNHvmE7OEghuXq5WBWNHJj3+eZpgQ7H63zIC5lSslsw
	kPkwhbyPIiAgReHz5a5LrN16gqqdewmC1Z6svo9BVCpm+Ybz2Cvnhor+FQ05pAwQvpvryKXm9Z9
	h3GpJOJh01IQTiZKWlmQCM3L2In8op0w6N7YVH0MOBH54m2Ofr2bHxkVz+t8X6TpMG5rY8J9/ko
	4IezwxxZJzPdne1yM7VoBb8V8zebgxlqTbv0bBGzhwplUFygQfd+9UrH2SO7aYQWSRCjhvS1tMs
	p2tK5gq3/nzlVufrb+ARydJQ0s6Ag4DE=
X-Google-Smtp-Source: AGHT+IFYk6f34ctVBzTOxlm8fGaCjBky8FTOeYc7QhtR+iwWenKOkBoYq8IuxTXnH5FF557mzL5Rwg==
X-Received: by 2002:a05:6a20:244b:b0:215:fac3:2ce2 with SMTP id adf61e73a8af0-21fbd65e0edmr22330171637.23.1750176669337;
        Tue, 17 Jun 2025 09:11:09 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffee527sm9352985b3a.19.2025.06.17.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 09:11:08 -0700 (PDT)
Date: Tue, 17 Jun 2025 09:11:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <aFGTmn_CFkuTbP4i@mozart.vkv.me>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617095037.sOnrJlPX@linutronix.de>

On Tuesday 06/17 at 11:50 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 02:23:08 [-0700], Calvin Owens wrote:
> > Ugh, I'm sorry, I was in too much of a hurry this morning... cargo is
> > obviously not calling PR_FUTEX_HASH which is new in 6.16 :/
> No worries.
> 
> > > This is with LTO enabled.
> > 
> > Full lto with llvm-20.1.7.
> > 
> …
> > Nothing showed up in the logs but the RCU stalls on CPU16, always in
> > queued_spin_lock_slowpath().
> > 
> > I'll run the build it was doing when it happened in a loop overnight and
> > see if I can trigger it again.

Actually got an oops this time:

    Oops: general protection fault, probably for non-canonical address 0xfdd92c90843cf111: 0000 [#1] SMP
    CPU: 3 UID: 1000 PID: 323127 Comm: cargo Not tainted 6.16.0-rc2-lto-00024-g9afe652958c3 #1 PREEMPT 
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    RIP: 0010:queued_spin_lock_slowpath+0x12a/0x1d0
    Code: c8 c1 e8 10 66 87 47 02 66 85 c0 74 48 0f b7 c0 49 c7 c0 f8 ff ff ff 89 c6 c1 ee 02 83 e0 03 49 8b b4 f0 00 21 67 83 c1 e0 04 <48> 89 94 30 00 f1 4a 84 83 7a 08 00 75 10 0f 1f 84 00 00 00 00 00
    RSP: 0018:ffffc9002c953d20 EFLAGS: 00010256
    RAX: 0000000000000000 RBX: ffff88814e78be40 RCX: 0000000000100000
    RDX: ffff88901fce5100 RSI: fdd92c90fff20011 RDI: ffff8881c2ae9384
    RBP: 000000000000002b R08: fffffffffffffff8 R09: 00000000002ab900
    R10: 000000000000b823 R11: 0000000000000c00 R12: ffff88814e78be40
    R13: ffffc9002c953d48 R14: ffffc9002c953d48 R15: ffff8881c2ae9384
    FS:  00007f086efb6600(0000) GS:ffff88909b836000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000055ced9c42650 CR3: 000000034b88e000 CR4: 0000000000750ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     futex_unqueue+0x2e/0x110
     __futex_wait+0xc5/0x130
     ? __futex_wake_mark+0xc0/0xc0
     futex_wait+0xee/0x180
     ? hrtimer_setup_sleeper_on_stack+0xe0/0xe0
     do_futex+0x86/0x120
     __se_sys_futex+0x16d/0x1e0
     ? __x64_sys_write+0xba/0xc0
     do_syscall_64+0x47/0x170
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7f086e918779
    Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
    RSP: 002b:00007ffc5815f678 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
    RAX: ffffffffffffffda RBX: 00007f086e918760 RCX: 00007f086e918779
    RDX: 000000000000002b RSI: 0000000000000089 RDI: 00005636f9fb60d0
    RBP: 00007ffc5815f6d0 R08: 0000000000000000 R09: 00007ffcffffffff
    R10: 00007ffc5815f690 R11: 0000000000000246 R12: 000000001dcd6401
    R13: 00007f086e833fd0 R14: 00005636f9fb60d0 R15: 000000000000002b
     </TASK>
    ---[ end trace 0000000000000000 ]---
    RIP: 0010:queued_spin_lock_slowpath+0x12a/0x1d0
    Code: c8 c1 e8 10 66 87 47 02 66 85 c0 74 48 0f b7 c0 49 c7 c0 f8 ff ff ff 89 c6 c1 ee 02 83 e0 03 49 8b b4 f0 00 21 67 83 c1 e0 04 <48> 89 94 30 00 f1 4a 84 83 7a 08 00 75 10 0f 1f 84 00 00 00 00 00
    RSP: 0018:ffffc9002c953d20 EFLAGS: 00010256
    RAX: 0000000000000000 RBX: ffff88814e78be40 RCX: 0000000000100000
    RDX: ffff88901fce5100 RSI: fdd92c90fff20011 RDI: ffff8881c2ae9384
    RBP: 000000000000002b R08: fffffffffffffff8 R09: 00000000002ab900
    R10: 000000000000b823 R11: 0000000000000c00 R12: ffff88814e78be40
    R13: ffffc9002c953d48 R14: ffffc9002c953d48 R15: ffff8881c2ae9384
    FS:  00007f086efb6600(0000) GS:ffff88909b836000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000055ced9c42650 CR3: 000000034b88e000 CR4: 0000000000750ef0
    PKRU: 55555554
    Kernel panic - not syncing: Fatal exception
    Kernel Offset: disabled
    ---[ end Kernel panic - not syncing: Fatal exception ]---

This is a giant Yocto build, but the comm is always cargo, so hopefully
I can run those bits in isolation and hit it more quickly.

> Please check if you can reproduce it and if so if it also happens
> without lto.
> I have no idea why one spinlock_t remains locked. It is either locked or
> some stray memory.
> Oh. Lockdep adds quite some overhead but it should complain that a
> spinlock_t is still locked while returning to userland.

I'll report back when I've tried :)

I'll also try some of the mm debug configs.

Thanks,
Calvin

