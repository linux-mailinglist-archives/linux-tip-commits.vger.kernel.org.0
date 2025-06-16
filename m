Return-Path: <linux-tip-commits+bounces-5853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54EADB7AB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Jun 2025 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8325C3A0715
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Jun 2025 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF143288C13;
	Mon, 16 Jun 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ExitEuht"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E928852F
	for <linux-tip-commits@vger.kernel.org>; Mon, 16 Jun 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094070; cv=none; b=qjj///Ixgz4wq+nSwZCQBgTt2BLx3djpk343XSa859htEEwUKITgYy/EvIqWY7uxeI/PWscU2ji4eQ/eIH7G2j6jXB1563X3EqOVLx3sQPyuqn0Jg3TQXC8V+snr+4pgksEQ08lYF3mBKaEMNsHinTK4PVbTudv4/LJOjv3dZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094070; c=relaxed/simple;
	bh=OFEsIZoZ2x5Mmf2UvRZPkqsa3+SQpPvOfqzf8VR/J4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqKZIVSjn0kn6xbYn4aBjfbNBkG33jvH/m0rBRsMzXhwQtgUAkejcSlolx8MibXnYpMm7vGTFr03ln3xIEonrg2r5zdhOrGmuiFhEsGhqswP7Hb9aTr5isqVh4Tqi5G18GGEQ676jA1WDUPyEzkxYUvaRypOSZTZ19OPqP2nYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ExitEuht; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so3919295b3a.3
        for <linux-tip-commits@vger.kernel.org>; Mon, 16 Jun 2025 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750094067; x=1750698867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT2Gg960F6nCct08h4buU1Fg42pa/POQgz2KBQCjymY=;
        b=ExitEuhtAiVn+OhCN4DU/ZQ1QhhH8DDDt93Y/rStnrbvJqqz3G3Zcg8UOG44qdLByC
         77NFG6cVc7R77Steba2CysGrbat/IjfXqbiturDiJhwCXN6wi9fa3j+SFChurKMgtwjx
         v5aAb5IzbdZQCYN45d8ML8PG3bR/EGw7TReZ5OP2AiT5Sh2SdEOObiDgpfnf/HeHWwFx
         7FTTwECPFBwxTAQhlykC1N+2m8b23K66/cCWSW8t5BqGSdfifY5a2l/wjEXfXi1dW4gY
         Z8RRXBwgqeSKRYjh53rMiymi0qCUCy+1UAvBlW+1RkQhyLcg7Ftd7AaVt5Gg/CM3DG2d
         OvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094067; x=1750698867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT2Gg960F6nCct08h4buU1Fg42pa/POQgz2KBQCjymY=;
        b=ss85eXwFesFxI09+7MyU9a0d+n0onGoLMB3/MtuXAvw1wrjqTKbzHS5ALzg0Ru0ulD
         aaAb2/BIdOkHg1QwWNS73t1P7U6w9nmliEJQMd5baPnmUvYax55h9TY04NpaN69O5k87
         G1EAK1Rns/5JWMaWrc6XKJcJw7yg34d9V5ARxaU90+ruaZkNfCvnxeMVG/v8qfuyvv+v
         3G2Snoa7BhISZxE6sINPbX8wlw7frhjncA8eJD9WKgAyYERLid7Rcmm2/JBfD/+OxkqM
         20Vte1cDLlyX/6bcC35DX6n4hwGRY7pUp8KJ704K3sSlLZ+JiHpWAISKZnBUC9amkzsx
         H+yw==
X-Gm-Message-State: AOJu0YwP4+lhPp5v8lycLRu9bCQfDdmtFfHMvF3r1ceeXPmcmqtuNvz7
	zWpaCbao4ll7/bKVQWKLfQSy6SNlSSujvmBFQy0F4NlDs49acNOk4YTBu5Qy6UTcnxw=
X-Gm-Gg: ASbGnctnJRgnY9BEM2Zcbr3g2VjBE1TqxAA4RxaBkh0HPMOVfv9AQOiSsZmMxfGw1J8
	z8LgJWzbhYY4Rk22kH1wQBFGNsaOb3APyWW+HIFZvRWg7aZV8ChVBcol3xvqw6JlGNJ7UiTvGSg
	WVtFn4I0LBUmG9WS+slBp8zpB9WdX3TDBtvSFj423rfeU5eRXWySurxMSj6SVjrhsY5dJ4mHSOn
	nfDWkAvlWEcu06AQJKPF7FaxA4r0q2VyGl55CGkSWISZUZf3eZ3fA2duKs36iMMMx8NHtWc1mfn
	dqakKTiSBteCtLaKH56ZoKinGovI0QIWkyeLS6UrHFo4GjWVw9lmAGWwqekhgY1aurx53AvzehA
	Fc7WUpzRCdaimjTLMSVNmHpPUVK+ZJaHTEp3HVKBZ6A==
X-Google-Smtp-Source: AGHT+IGo+Yn3fRGZB/M+5UglmLAVSl93G2OwT5ejJTLApDYY8rJB0Wo0PBt5zcOZuMFVZbnYsfyRiA==
X-Received: by 2002:a05:6a00:4602:b0:748:3849:e790 with SMTP id d2e1a72fcca58-7489ccc77c6mr13764312b3a.0.1750094067266;
        Mon, 16 Jun 2025 10:14:27 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005329sm7088267b3a.40.2025.06.16.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:14:26 -0700 (PDT)
Date: Mon, 16 Jun 2025 10:14:24 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, "Lai, Yi" <yi1.lai@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>

On Wednesday 06/11 at 14:39 -0000, tip-bot2 for Sebastian Andrzej Siewior wrote:
> <snip> 
> It is possible that two threads simultaneously request the global hash
> and both pass the initial check and block later on the
> mm::futex_hash_lock. In this case the first thread performs the switch
> to the global hash. The second thread will also attempt to switch to the
> global hash and while doing so, accessing the nonexisting slot 1 of the
> struct futex_private_hash.

In case it's interesting to anyone, I'm hitting this one in real life,
one of my build machines got stuck overnight:

Jun 16 02:51:34 beethoven kernel: rcu: INFO: rcu_preempt self-detected stall on CPU
Jun 16 02:51:34 beethoven kernel: rcu:         16-....: (59997 ticks this GP) idle=eaf4/1/0x4000000000000000 softirq=14417247/14470115 fqs=21169
Jun 16 02:51:34 beethoven kernel: rcu:         (t=60000 jiffies g=21453525 q=663214 ncpus=24)
Jun 16 02:51:34 beethoven kernel: CPU: 16 UID: 1000 PID: 2028199 Comm: cargo Not tainted 6.16.0-rc1-lto-00236-g8c6bc74c7f89 #1 PREEMPT 
Jun 16 02:51:34 beethoven kernel: Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
Jun 16 02:51:34 beethoven kernel: RIP: 0010:queued_spin_lock_slowpath+0x162/0x1d0
Jun 16 02:51:34 beethoven kernel: Code: 0f 1f 84 00 00 00 00 00 f3 90 83 7a 08 00 74 f8 48 8b 32 48 85 f6 74 09 0f 0d 0e eb 0d 31 f6 eb 09 31 f6 eb 05 0f 1f 00 f3 90 <8b> 07 66 85 c0 75 f7 39 c8 75 13 41 b8 01 00 00 00 89 c8 f0 44 0f
Jun 16 02:51:34 beethoven kernel: RSP: 0018:ffffc9002fb1fc38 EFLAGS: 00000206
Jun 16 02:51:34 beethoven kernel: RAX: 0000000000447f3a RBX: ffffc9003029fdf0 RCX: 0000000000440000
Jun 16 02:51:34 beethoven kernel: RDX: ffff88901fea5100 RSI: 0000000000000000 RDI: ffff888127e7d844
Jun 16 02:51:34 beethoven kernel: RBP: ffff8883a3c07248 R08: 0000000000000000 R09: 00000000b69b409a
Jun 16 02:51:34 beethoven kernel: R10: 000000001bd29fd9 R11: 0000000069b409ab R12: ffff888127e7d844
Jun 16 02:51:34 beethoven kernel: R13: ffff888127e7d840 R14: ffffc9003029fde0 R15: ffff8883a3c07248
Jun 16 02:51:34 beethoven kernel: FS:  00007f61c23d85c0(0000) GS:ffff88909b9f6000(0000) knlGS:0000000000000000
Jun 16 02:51:34 beethoven kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 16 02:51:34 beethoven kernel: CR2: 000056407760f3e0 CR3: 0000000905f29000 CR4: 0000000000750ef0
Jun 16 02:51:34 beethoven kernel: PKRU: 55555554
Jun 16 02:51:34 beethoven kernel: Call Trace:
Jun 16 02:51:34 beethoven kernel:  <TASK>
Jun 16 02:51:34 beethoven kernel:  __futex_pivot_hash+0x1f8/0x2e0
Jun 16 02:51:34 beethoven kernel:  futex_hash+0x95/0xe0
Jun 16 02:51:34 beethoven kernel:  futex_wait_setup+0x7e/0x230
Jun 16 02:51:34 beethoven kernel:  __futex_wait+0x66/0x130
Jun 16 02:51:34 beethoven kernel:  ? __futex_wake_mark+0xc0/0xc0
Jun 16 02:51:34 beethoven kernel:  futex_wait+0xee/0x180
Jun 16 02:51:34 beethoven kernel:  ? hrtimer_setup_sleeper_on_stack+0xe0/0xe0
Jun 16 02:51:34 beethoven kernel:  do_futex+0x86/0x120
Jun 16 02:51:34 beethoven kernel:  __se_sys_futex+0x16d/0x1e0
Jun 16 02:51:34 beethoven kernel:  do_syscall_64+0x47/0x170
Jun 16 02:51:34 beethoven kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
Jun 16 02:51:34 beethoven kernel: RIP: 0033:0x7f61c1d18779
Jun 16 02:51:34 beethoven kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
Jun 16 02:51:34 beethoven kernel: RSP: 002b:00007ffcd3f6e3f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
Jun 16 02:51:34 beethoven kernel: RAX: ffffffffffffffda RBX: 00007f61c1d18760 RCX: 00007f61c1d18779
Jun 16 02:51:34 beethoven kernel: RDX: 00000000000000a9 RSI: 0000000000000089 RDI: 0000564077580bb0
Jun 16 02:51:34 beethoven kernel: RBP: 00007ffcd3f6e450 R08: 0000000000000000 R09: 00007ffcffffffff
Jun 16 02:51:34 beethoven kernel: R10: 00007ffcd3f6e410 R11: 0000000000000246 R12: 000000001dcd6401
Jun 16 02:51:34 beethoven kernel: R13: 00007f61c1c33fd0 R14: 0000564077580bb0 R15: 00000000000000a9
Jun 16 02:51:34 beethoven kernel:  </TASK>
<repeats forever until I wake up and kill the machine>

It seems like this is well understood already, but let me know if
there's any debug info I can send that might be useful.

Thanks,
Calvin

