Return-Path: <linux-tip-commits+bounces-5866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C5ADF2EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729BC3B03E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520932F0028;
	Wed, 18 Jun 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="iqP6Q8Vy"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CD2DBF4C
	for <linux-tip-commits@vger.kernel.org>; Wed, 18 Jun 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265364; cv=none; b=bHUDiWu2ZyY0y8ZsMZEQMz7EffbHJ9Uidh/oFmZPaOjkOZF3fUwP8edjksrP5Js8FM5x/Z3ragpi+AAibeiiTVvlYye+1Wjjz14oGeIsQHxJZaLFghM7aHPY7tRdsTVN3m4DpjWlNMSwrVu4AGa0SiUdjdA2Cn2aouxSmy6fjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265364; c=relaxed/simple;
	bh=V8HMeReTEG9RacYYTo724MCy4Fb1ZWP2Tta90iHMlOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ushz3Ds2XS+lu+OOH8amPOjnTnLOzCiNZCdALUvJUf/FtpCPk/PvdY9m7gMkCbQq2kl11GyD5S9Q9qwfPGVskHhbkxOoo1at0BeZsDzAFRvR23rE/HfrxrN47VmCbh/5XSmn7jWiAktmmybjF1F5w54mnL4CwUTtjMleH4kVhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=iqP6Q8Vy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7486ca9d396so4583770b3a.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 18 Jun 2025 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750265361; x=1750870161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZkwTQus/2vq0jO/Sj9po/dRlM5Kjy71UyYmwsyJ1kwA=;
        b=iqP6Q8VyQVHu+jmgNpybErCpTrse7K7/RcVw4BJCd4ivxpvzP8CoyIhU3bjQBzDAna
         2Yk1fVux8O3oCUeqGg0sEu3CfzZ1SPylIhNkBpq2YDBjqKJpgbuLSvyXaj4zfp8cCVdd
         9GWHRJ6U1zqguhBhYEo0FaCaw+s0GyjpB5v69vDPE9wne0KLCVw/XD4njWoCClzB5/Tq
         9wpQjJZdHsTFnnunMqai2Lwc7kzv4AMWZAfnhu3ao/Xuh9rPgPxsBCOk8kHZsfZC768Z
         PFFrMUKV1fpl4IB3MuXe12XIJ21Wd8Mrptlfns5qKn63mOE91XTF/P5ocncov12si9fa
         +5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265361; x=1750870161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkwTQus/2vq0jO/Sj9po/dRlM5Kjy71UyYmwsyJ1kwA=;
        b=EZSyFTqp2yf9TQYcqarT2eAG7E+vBt07fSE8Xn3bwkvZYNi4SjeZXpr3d3htMHedQf
         jRKFtWVukPpONb87PX/4tWlp92U9Z3TC+maTdcD1LbW+PP1eB2wuAtD0CDMEIUtTpNtd
         8HuL4BTusxfg2cWC1t0vnEHF3FQc99k66PA1Z/A35aI/bahbxu0Sp909heMbzGSqd4vT
         Bc9mnM9FptK+hP/uMijixDVjkJD2iNtuxrl4BRDO4UiamMgLWK6bM5wDRa8Nfa4oNFi7
         P9WpFtLLOCpq1Tc/0unRFSVVSWhIo1hoersqy6AKrKlXZHohblSijz/flsaksSx4pt0O
         PCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUrcEqG3QUrEI54LHkvimiFrHmlcPHopWzwUnSStTnhIbcz96755MRnd3HM4cnd/o0g3ka5PPWwtwSr79Irzyj/Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCE+J12K8cDJo5OF5141CHBzHaZqrqdsihSlbhgiXM6KV5aVS
	v7Dm8S02JJJIUz7/i4wvPp5lI82U+oKe1FIT7ugCuuzQoMQ8/squLqKhmjvp/AlgGgk=
X-Gm-Gg: ASbGncvFDm4bY3BslQ8zCWwZRD7eFDxzP3k9YZkpbCXXchTaZFtZvqx6w8alKMTlk9J
	ZmfApUaQgyFOFXb0bxZrQNbjwQLDg66grpmqYrrns1Qt/N/u/VMdZQw63CEFKAx9iEkJpsS9frb
	cscUjtJo5DcH7+SOCxjgrU4uQfGlVONSuea4KqWUhBT6I+Mqk7jnzge1l64rLR2bIFsjn1tn7JM
	dta+A8LtbJGNnnjBFLu177WcpI1bfj+JZdes+hVf6LHv7jUSUTQ2awyETAKJIFlKRgGJxQnbGac
	W1PBfqoGCUKByw7SHwuBDjJwhvrL7g+8KnIjcfHEo/GHFQN2V9jhMLaxHE01Yi7D3Ekdx0CT7qr
	H8HKcMua3znFqfikMzBO7LBzHgo7giI4=
X-Google-Smtp-Source: AGHT+IHzOk18KjGaaNZoUYmiApN/7FP0CoVoB5mhQ3n5lF+L6WcpU3LePSo4/IdJmEveqBzW7w9PlA==
X-Received: by 2002:a05:6a00:399d:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-7489cfc360dmr18545783b3a.17.1750265360858;
        Wed, 18 Jun 2025 09:49:20 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748f161d714sm986971b3a.148.2025.06.18.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:20 -0700 (PDT)
Date: Wed, 18 Jun 2025 09:49:18 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <aFLuDoX9BGBUC3tW@mozart.vkv.me>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
 <aFGTmn_CFkuTbP4i@mozart.vkv.me>
 <20250618160333.PdGB89yt@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618160333.PdGB89yt@linutronix.de>

On Wednesday 06/18 at 18:03 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 09:11:06 [-0700], Calvin Owens wrote:
> > Actually got an oops this time:
> > 
> >     Oops: general protection fault, probably for non-canonical address 0xfdd92c90843cf111: 0000 [#1] SMP
> >     CPU: 3 UID: 1000 PID: 323127 Comm: cargo Not tainted 6.16.0-rc2-lto-00024-g9afe652958c3 #1 PREEMPT 
> >     Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
> >     RIP: 0010:queued_spin_lock_slowpath+0x12a/0x1d0
> …
> >     Call Trace:
> >      <TASK>
> >      futex_unqueue+0x2e/0x110
> >      __futex_wait+0xc5/0x130
> >      futex_wait+0xee/0x180
> >      do_futex+0x86/0x120
> >      __se_sys_futex+0x16d/0x1e0
> >      do_syscall_64+0x47/0x170
> >      entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >     RIP: 0033:0x7f086e918779
> 
> The lock_ptr is pointing to invalid memory. It explodes within
> queued_spin_lock_slowpath() which looks like decode_tail() returned a
> wrong pointer/ offset.
> 
> futex_queue() adds a local futex_q to the list and its lock_ptr points
> to the hb lock. Then we do schedule() and after the wakeup the lock_ptr
> is NULL after a successful wake.  Otherwise it still points to the
> futex_hash_bucket::lock.
> 
> Since futex_unqueue() attempts to acquire the lock, then there was no
> wakeup but a timeout or a signal that ended the wait. The lock_ptr can
> change during resize.
> During the resize futex_rehash_private() moves the futex_q members from
> the old queue to the new one. The lock is accessed within RCU and the
> lock_ptr value is compared against the old value after locking. That
> means it is accessed either before the rehash moved it the new hash
> bucket or afterwards.
> I don't see how this pointer can become invalid. RCU protects against
> cleanup and the pointer compare ensures that it is the "current"
> pointer.
> I've been looking at clang's assembly of futex_unqueue() and it looks
> correct. And futex_rehash_private() iterates over all slots.

Didn't get much out of lockdep unfortunately.

It notices the corruption in the spinlock:

    BUG: spinlock bad magic on CPU#2, cargo/4129172
     lock: 0xffff8881410ecdc8, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
    CPU: 2 UID: 1000 PID: 4129172 Comm: cargo Not tainted 6.16.0-rc2-nolto-lockdep-00047-g52da431bf03b #1 PREEMPT
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    Call Trace:
     <TASK>
     dump_stack_lvl+0x5a/0x80
     do_raw_spin_lock+0x6a/0xd0
     futex_wait_setup+0x8e/0x200
     __futex_wait+0x63/0x120
     ? __futex_wake_mark+0x40/0x40
     futex_wait+0x5b/0xd0
     ? hrtimer_dummy_timeout+0x10/0x10
     do_futex+0x86/0x120
     __se_sys_futex+0x10d/0x180
     ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
     do_syscall_64+0x6a/0x1070
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7ff7e7ffb779
    Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
    RSP: 002b:00007fff29bee078 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
    RAX: ffffffffffffffda RBX: 00007ff7e7ffb760 RCX: 00007ff7e7ffb779
    RDX: 00000000000000b6 RSI: 0000000000000089 RDI: 000055a5e2b9c1a0
    RBP: 00007fff29bee0d0 R08: 0000000000000000 R09: 00007fffffffffff
    R10: 00007fff29bee090 R11: 0000000000000246 R12: 000000001dcd6401
    R13: 00007ff7e7f16fd0 R14: 000055a5e2b9c1a0 R15: 00000000000000b6
     </TASK>

That was followed by this WARN:

    ------------[ cut here ]------------
    rcuref - imbalanced put()
    WARNING: CPU: 2 PID: 4129172 at lib/rcuref.c:266 rcuref_put_slowpath+0x55/0x70
    CPU: 2 UID: 1000 PID: 4129172 Comm: cargo Not tainted 6.16.0-rc2-nolto-lockdep-00047-g52da431bf03b #1 PREEMPT
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    RIP: 0010:rcuref_put_slowpath+0x55/0x70
    Code: 00 00 00 c0 73 2a 85 f6 79 06 c7 07 00 00 00 a0 31 c0 c3 53 48 89 fb 48 c7 c7 da 7f 32 83 c6 05 7f 9c 35 02 01 e8 1b 83 9f ff <0f> 0b 48 89 df 5b 31 c0 c7 07 00 00 00 e0 c3 cc cc cc cc cc cc cc
    RSP: 0018:ffffc90026e7fca8 EFLAGS: 00010282
    RAX: 0000000000000019 RBX: ffff8881410ec000 RCX: 0000000000000027
    RDX: 00000000ffff7fff RSI: 0000000000000002 RDI: ffff88901fc9c008
    RBP: 0000000000000000 R08: 0000000000007fff R09: ffffffff83676870
    R10: 0000000000017ffd R11: 00000000ffff7fff R12: 00000000000000b7
    R13: 000055a5e2b9c1a0 R14: ffff8881410ecdc0 R15: 0000000000000001
    FS:  00007ff7e875c600(0000) GS:ffff88909b96a000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fd4b8001028 CR3: 0000000fd7d31000 CR4: 0000000000750ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     futex_private_hash_put+0xa7/0xc0
     futex_wait_setup+0x1c0/0x200
     __futex_wait+0x63/0x120
     ? __futex_wake_mark+0x40/0x40
     futex_wait+0x5b/0xd0
     ? hrtimer_dummy_timeout+0x10/0x10
     do_futex+0x86/0x120
     __se_sys_futex+0x10d/0x180
     ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
     do_syscall_64+0x6a/0x1070
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7ff7e7ffb779
    Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
    RSP: 002b:00007fff29bee078 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
    RAX: ffffffffffffffda RBX: 00007ff7e7ffb760 RCX: 00007ff7e7ffb779
    RDX: 00000000000000b6 RSI: 0000000000000089 RDI: 000055a5e2b9c1a0
    RBP: 00007fff29bee0d0 R08: 0000000000000000 R09: 00007fffffffffff
    R10: 00007fff29bee090 R11: 0000000000000246 R12: 000000001dcd6401
    R13: 00007ff7e7f16fd0 R14: 000055a5e2b9c1a0 R15: 00000000000000b6
     </TASK>
    irq event stamp: 59385407
    hardirqs last  enabled at (59385407): [<ffffffff8274264c>] _raw_spin_unlock_irqrestore+0x2c/0x50
    hardirqs last disabled at (59385406): [<ffffffff8274250d>] _raw_spin_lock_irqsave+0x1d/0x60
    softirqs last  enabled at (59341786): [<ffffffff8133cc1e>] __irq_exit_rcu+0x4e/0xd0
    softirqs last disabled at (59341781): [<ffffffff8133cc1e>] __irq_exit_rcu+0x4e/0xd0
    ---[ end trace 0000000000000000 ]---

The oops after that is from a different task this time, but it just
looks like slab corruption:

    BUG: unable to handle page fault for address: 0000000000001300
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0 P4D 0
    Oops: Oops: 0000 [#1] SMP
    CPU: 4 UID: 1000 PID: 4170542 Comm: zstd Tainted: G        W           6.16.0-rc2-nolto-lockdep-00047-g52da431bf03b #1 PREEMPT
    Tainted: [W]=WARN
    Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
    RIP: 0010:__kvmalloc_node_noprof+0x1a2/0x4a0
    Code: 0f 84 a3 01 00 00 41 83 f8 ff 74 10 48 8b 03 48 c1 e8 3f 41 39 c0 0f 85 8d 01 00 00 41 8b 46 28 49 8b 36 48 8d 4d 20 48 89 ea <4a> 8b 1c 20 4c 89 e0 65 48 0f c7 0e 74 4e eb 9f 41 83 f8 ff 75 b4
    RSP: 0018:ffffc90036a87c00 EFLAGS: 00010246
    RAX: 0000000000001000 RBX: ffffea0005043a00 RCX: 0000000000054764
    RDX: 0000000000054744 RSI: ffffffff84347c80 RDI: 0000000000000080
    RBP: 0000000000054744 R08: 00000000ffffffff R09: 0000000000000000
    R10: ffffffff8140972d R11: 0000000000000000 R12: 0000000000000300
    R13: 00000000004029c0 R14: ffff888100044800 R15: 0000000000001040
    FS:  00007fca63240740(0000) GS:ffff88909b9ea000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000001300 CR3: 00000004fcac3000 CR4: 0000000000750ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? futex_hash_allocate+0x17f/0x400
     futex_hash_allocate+0x17f/0x400
     ? futex_hash_allocate+0x4d/0x400
     ? futex_hash_allocate_default+0x2b/0x1e0
     ? futex_hash_allocate_default+0x2b/0x1e0
     ? copy_process+0x35e/0x12a0
     ? futex_hash_allocate_default+0x2b/0x1e0
     ? copy_process+0x35e/0x12a0
     copy_process+0xcf3/0x12a0
     ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
     kernel_clone+0x7f/0x310
     ? copy_clone_args_from_user+0x93/0x1e0
     ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
     __se_sys_clone3+0xbb/0xc0
     ? _copy_to_user+0x1f/0x60
     ? __se_sys_rt_sigprocmask+0xf2/0x120
     ? trace_hardirqs_off+0x40/0xb0
     do_syscall_64+0x6a/0x1070
     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    RIP: 0033:0x7fca6335f7a9
    Code: 90 b8 01 00 00 00 b9 01 00 00 00 eb ec 0f 1f 40 00 b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89 c7 b8 3c 00 00
    RSP: 002b:00007ffcfe17fe78 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
    RAX: ffffffffffffffda RBX: 00007fca632e18e0 RCX: 00007fca6335f7a9
    RDX: 00007fca632e18e0 RSI: 0000000000000058 RDI: 00007ffcfe17fed0
    RBP: 00007fca60f666c0 R08: 00007fca60f666c0 R09: 00007ffcfe17ffc7
    R10: 0000000000000008 R11: 0000000000000202 R12: ffffffffffffff88
    R13: 0000000000000002 R14: 00007ffcfe17fed0 R15: 00007fca60766000
     </TASK>
    CR2: 0000000000001300
    ---[ end trace 0000000000000000 ]---
    RIP: 0010:__kvmalloc_node_noprof+0x1a2/0x4a0
    Code: 0f 84 a3 01 00 00 41 83 f8 ff 74 10 48 8b 03 48 c1 e8 3f 41 39 c0 0f 85 8d 01 00 00 41 8b 46 28 49 8b 36 48 8d 4d 20 48 89 ea <4a> 8b 1c 20 4c 89 e0 65 48 0f c7 0e 74 4e eb 9f 41 83 f8 ff 75 b4
    RSP: 0018:ffffc90036a87c00 EFLAGS: 00010246
    RAX: 0000000000001000 RBX: ffffea0005043a00 RCX: 0000000000054764
    RDX: 0000000000054744 RSI: ffffffff84347c80 RDI: 0000000000000080
    RBP: 0000000000054744 R08: 00000000ffffffff R09: 0000000000000000
    R10: ffffffff8140972d R11: 0000000000000000 R12: 0000000000000300
    R13: 00000000004029c0 R14: ffff888100044800 R15: 0000000000001040
    FS:  00007fca63240740(0000) GS:ffff88909b9ea000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000001300 CR3: 00000004fcac3000 CR4: 0000000000750ef0
    PKRU: 55555554
    Kernel panic - not syncing: Fatal exception
    Kernel Offset: disabled
    ---[ end Kernel panic - not syncing: Fatal exception ]---

No lock/rcu splats at all.

> > This is a giant Yocto build, but the comm is always cargo, so hopefully
> > I can run those bits in isolation and hit it more quickly.
> 
> If it still explodes without LTO, would you mind trying gcc?

Will do.

Haven't had much luck isolating what triggers it, but if I run two copies
of these large build jobs in a loop, it reliably triggers in 6-8 hours.

Just to be clear, I can only trigger this on the one machine. I ran it
through memtest86+ yesterday and it passed, FWIW, but I'm a little
suspicious of the hardware right now too. I double checked that
everything in the BIOS related to power/perf is at factory settings.

Note that READ_ONLY_THP_FOR_FS and NO_PAGE_MAPCOUNT are both off.

> > Thanks,
> > Calvin
> 
> Sebastian

