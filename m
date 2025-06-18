Return-Path: <linux-tip-commits+bounces-5862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694DADE105
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 04:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BBB3A3CB8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897018FDA5;
	Wed, 18 Jun 2025 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="M692b6qQ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC39B67F
	for <linux-tip-commits@vger.kernel.org>; Wed, 18 Jun 2025 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212944; cv=none; b=R5ICMT7eqch73h9JN9Pp7z+ATKDUjU43ZpAqpBQeDnUN/YGKjDqj4mITBAMsTv1v/DtKOTWNggG0lxHKNk+7zShSn4NGLKVs+66nrBKIwahm7Eb8VGXL1X6dBg4LV9cwHr0f84Btk1eCcLqg3i/Ba+djoDCp0OEodDopIwckl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212944; c=relaxed/simple;
	bh=fll4eP4/0sS75ZUVKzIVmGaI7cS6KJtulVxT4q65/0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFvXlQx50uktJiBGn6tpN99V7rrIUZvlZGJNfXzY4rm602mg+Rj5ykxpEyfGFOYD8jWvouabKm9k2g8is5Yf2ppRptVSYcev4deOw81vddPxLiHxE6c3rP/pNL01tnoDfOpvXgCsinP0vEdohaMB99PyT9//sTj9Hue+tAEMsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=M692b6qQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313910f392dso5689566a91.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 17 Jun 2025 19:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750212940; x=1750817740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/OHYy1LHwJcqeYx0FiYaHNJhYOzxygt0eaqklk9VPI=;
        b=M692b6qQuUCgbfdXZMj63e3v6P6sheYOE9SD9IjjQJYwf5qVGVXjn5G1/eqtFEV7hH
         83ttMRHMldfyX7hMed98G3E+/FC0I0IAv2v+K/pV4cizjZZXhsdxccOvCJwQUraZsrlq
         sme/2aN1/s3LS5oQiKlQ3ajh2Z7XHKBJSNqqPVXNyZKbX+mVXeVjRY8xI8YYGB5qZYfR
         u2Nj81X5hVt9ErSPDcwzoooXcDOWFCDm831+zipCz/Hl/MW0NiZBj9XmdUwsBXSP1rwG
         RoYpgxh7aw/zY0jvkS2NQHZSoEwDgyGaJsrq1tS33bwpeDOvso3NQ/igCy+rs2GQMdxJ
         FgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750212940; x=1750817740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/OHYy1LHwJcqeYx0FiYaHNJhYOzxygt0eaqklk9VPI=;
        b=ViULTsda3lhRD+jtyZW0ySYWUswTV2a9di+CsslNXUKlgKw9ZJnX0jX+8TFyJg5faz
         HIrnRRrsmO/ol+rIGLt1sTXf55tRA81WMbt1PTGzPVJubHNKCEdUEx0dAQ85keAvyjCS
         JvZhl6YyNwDPsmFf63EASA57yWd68BvQ8h2cSvWBPECc/aattLoaYEVzqQ8jccTeE/Jj
         6deehcG1E37/iqid/R/0WgOTzkzL+ii0vzpg91FGkmN+24b6XrLMGP5tCAHYBWgBl3G9
         qNTz8payrlK8V93+QivAzJuAUwWYuTJATfRChuifXo4YO3lHeUup67qgTtDZ0sRxEPRd
         Sh2A==
X-Forwarded-Encrypted: i=1; AJvYcCUPgtFn0pGkGtpnwdLIYyQgHjsdxBA/aNn7obRr94sGhKCvhG/MYY7Xoa7gxFKUHPpiFEmaRmZOolNxzNNShwWw2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40s87GjamYRzqPqD168E8lyglVuhUx8Fs9VRSBVKKD/0++utS
	2nM6lMsDWuZWCRMFLlZ+YOFlykvLP+L4TXBbePouHBelVV2aqrszr0ohXJwC1vjBcf8=
X-Gm-Gg: ASbGncu6bdav8CTitMTsmKObykR0R9RFEvps3c3P0KjLMggOAsRjpotbCdzKeM9A5uI
	r9iC7s4UYzVO8dnyuZyYSPl8g+LhuMubVm1zD4+at8uWaLTGxlL6NlE8/+YZYkfDNUpwS2o8OEl
	bxQK/wq2CA8LD7Zewgmc4GRPQQH7qBw1v+ieiIM7uzLDIw6NOCLnkocFDKqwiXSS6peDWXfUhLb
	ZQl7I6dCbf9q1kRN4oXJeIcu59Z8YZJrMe2i6YFbXXwtiWyMknH6u36EKpXbh0vKZh5DHTKoCiP
	JS/VsHW7U4jb092TZjfid42J0Sli3pHTg9hIOEK1n+4M0y0gqgi0Tzypr1bydGzIaV9IP9QNYbR
	7TafsuvfbClVyF5xSnyYhLQNAFl//Jbk=
X-Google-Smtp-Source: AGHT+IFsADDsPfxGsuMTviokNgZsf7zLDPfKHMAMp+d66wOLYdiQe5qzj1pWp/iVG0CTEr6+NBbSVA==
X-Received: by 2002:a17:90b:528f:b0:312:2bb:aa89 with SMTP id 98e67ed59e1d1-313f1d50e08mr21871887a91.20.1750212940010;
        Tue, 17 Jun 2025 19:15:40 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb4f85sm88342865ad.183.2025.06.17.19.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 19:15:39 -0700 (PDT)
Date: Tue, 17 Jun 2025 19:15:37 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <aFIhSYmDvzRgShIy@mozart.vkv.me>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
 <aFGTmn_CFkuTbP4i@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFGTmn_CFkuTbP4i@mozart.vkv.me>

On Tuesday 06/17 at 09:11 -0700, Calvin Owens wrote:
> On Tuesday 06/17 at 11:50 +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-17 02:23:08 [-0700], Calvin Owens wrote:
> > > Ugh, I'm sorry, I was in too much of a hurry this morning... cargo is
> > > obviously not calling PR_FUTEX_HASH which is new in 6.16 :/
> > No worries.
> >
> > > > This is with LTO enabled.
> > >
> > > Full lto with llvm-20.1.7.
> > >
> > …
> > > Nothing showed up in the logs but the RCU stalls on CPU16, always in
> > > queued_spin_lock_slowpath().
> > >
> > > I'll run the build it was doing when it happened in a loop overnight and
> > > see if I can trigger it again.
>
> Actually got an oops this time:
>
> <snip>
>
> This is a giant Yocto build, but the comm is always cargo, so hopefully
> I can run those bits in isolation and hit it more quickly.
>
> > Please check if you can reproduce it and if so if it also happens
> > without lto.

It takes longer with LTO disabled, but I'm still seeing some crashes.

First this WARN:

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 1866190 at mm/slub.c:4753 free_large_kmalloc+0xa5/0xc0
    CPU: 2 UID: 1000 PID: 1866190 Comm: python3 Not tainted 6.16.0-rc2-nolto-00024-g9afe652958c3 #1 PREEMPT 
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    RIP: 0010:free_large_kmalloc+0xa5/0xc0
    Code: 02 00 00 74 01 fb 83 7b 30 ff 74 07 c7 43 30 ff ff ff ff f0 ff 4b 34 75 08 48 89 df e8 84 dd f9 ff 48 83 c4 08 5b 41 5e 5d c3 <0f> 0b 48 89 df 48 c7 c6 46 92 f5 82 48 83 c4 08 5b 41 5e 5d e9 42
    RSP: 0018:ffffc90024d67ce8 EFLAGS: 00010206
    RAX: 00000000ff000000 RBX: ffffea00051d5700 RCX: ffffea00042f2208
    RDX: 0000000000053a55 RSI: ffff88814755c000 RDI: ffffea00051d5700
    RBP: 0000000000000000 R08: fffffffffffdfce5 R09: ffffffff83d52928
    R10: ffffea00047ae080 R11: 0000000000000003 R12: ffff8882cae5cd00
    R13: ffff88819bb19c08 R14: ffff88819bb194c0 R15: ffff8883a24df900
    FS:  0000000000000000(0000) GS:ffff88909bf54000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000055842ea1e3f0 CR3: 0000000d82b9d000 CR4: 0000000000750ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     futex_hash_free+0x10/0x40
     __mmput+0xb4/0xd0
     exec_mmap+0x1e2/0x210
     begin_new_exec+0x491/0x6c0
     load_elf_binary+0x25d/0x1050
     ? load_misc_binary+0x19a/0x2d0
     bprm_execve+0x1d5/0x370
     do_execveat_common+0x29e/0x300
     __x64_sys_execve+0x33/0x40
     do_syscall_64+0x48/0xfb0
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7fd8ec8e7dd7
    Code: Unable to access opcode bytes at 0x7fd8ec8e7dad.
    RSP: 002b:00007fd8adff9e88 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
    RAX: ffffffffffffffda RBX: 00007fd8adffb6c0 RCX: 00007fd8ec8e7dd7
    RDX: 000055842ed3ce60 RSI: 00007fd8eaea3870 RDI: 00007fd8eae87940
    RBP: 00007fd8adff9e90 R08: 00000000ffffffff R09: 0000000000000000
    R10: 0000000000000008 R11: 0000000000000206 R12: 00007fd8ed12da28
    R13: 00007fd8eae87940 R14: 00007fd8eaea3870 R15: 0000000000000001
     </TASK>
    ---[ end trace 0000000000000000 ]---
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x13d1507b pfn:0x14755c
    flags: 0x2000000000000000(node=0|zone=1)
    raw: 2000000000000000 ffffea00042f2208 ffff88901fd66b00 0000000000000000
    raw: 0000000013d1507b 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: Not a kmalloc allocation
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x13d1507b pfn:0x14755c
    flags: 0x2000000000000000(node=0|zone=1)
    raw: 2000000000000000 ffffea00042f2208 ffff88901fd66b00 0000000000000000
    raw: 0000000013d1507b 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: Not a kmalloc allocation

...and then it oopsed (same stack as my last mail) about twenty minutes
later when I hit Ctrl+C to stop the build:

    BUG: unable to handle page fault for address: 00000008849281a9
    #PF: supervisor write access in kernel mode
    #PF: error_code(0x0002) - not-present page
    PGD 0 P4D 0 
    Oops: Oops: 0002 [#1] SMP
    CPU: 13 UID: 1000 PID: 1864338 Comm: python3 Tainted: G        W           6.16.0-rc2-nolto-00024-g9afe652958c3 #1 PREEMPT 
    Tainted: [W]=WARN
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    RIP: 0010:queued_spin_lock_slowpath+0x112/0x1a0
    Code: c8 c1 e8 10 66 87 47 02 66 85 c0 74 40 0f b7 c0 49 c7 c0 f8 ff ff ff 89 c6 c1 ee 02 83 e0 03 49 8b b4 f0 40 8b 06 83 c1 e0 04 <48> 89 94 30 00 12 d5 83 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
    RSP: 0018:ffffc9002b35fd20 EFLAGS: 00010212
    RAX: 0000000000000020 RBX: ffffc9002b35fd50 RCX: 0000000000380000
    RDX: ffff88901fde5200 RSI: 0000000900bd6f89 RDI: ffff88814755d204
    RBP: 0000000000000000 R08: fffffffffffffff8 R09: 00000000002ab900
    R10: 0000000000000065 R11: 0000000000001000 R12: ffff88906c343e40
    R13: ffffc9002b35fd50 R14: ffff88814755d204 R15: 00007fd8eb6feac0
    FS:  00007fd8eb6ff6c0(0000) GS:ffff88909c094000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00000008849281a9 CR3: 0000001fcf611000 CR4: 0000000000750ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     futex_unqueue+0x21/0x90
     __futex_wait+0xb7/0x120
     ? __futex_wake_mark+0x40/0x40
     futex_wait+0x5b/0xd0
     do_futex+0x86/0x120
     __se_sys_futex+0x10d/0x180
     do_syscall_64+0x48/0xfb0
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7fd8ec8a49ee
    Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
    RSP: 002b:00007fd8eb6fe9b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
    RAX: ffffffffffffffda RBX: 00007fd8eb6ff6c0 RCX: 00007fd8ec8a49ee
    RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007fd8eb6feac0
    RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
    R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd8eb6fea00
    R13: 0000000000001de0 R14: 00007fd8ececa240 R15: 00000000000000ef
     </TASK>
    CR2: 00000008849281a9
    ---[ end trace 0000000000000000 ]---

I enabled lockdep and I've got it running again.

I set up a little git repo with a copy of all the traces so far, and the
kconfigs I'm running:

    https://github.com/jcalvinowens/lkml-debug-616

...and I pushed the actual vmlinux binaries here:

    https://github.com/jcalvinowens/lkml-debug-616/releases/tag/20250617

There were some block warnings on another machine running the same
workload, but of course they aren't necessarily related.

> > I have no idea why one spinlock_t remains locked. It is either locked or
> > some stray memory.
> > Oh. Lockdep adds quite some overhead but it should complain that a
> > spinlock_t is still locked while returning to userland.
> 
> I'll report back when I've tried :)
> 
> I'll also try some of the mm debug configs.
> 
> Thanks,
> Calvin

