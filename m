Return-Path: <linux-tip-commits+bounces-5856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B3ADC62C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C618993C2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFC28BAAD;
	Tue, 17 Jun 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="H09c7TTT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C516293C4A
	for <linux-tip-commits@vger.kernel.org>; Tue, 17 Jun 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152195; cv=none; b=Mrn1yNMbSjAvd/3BM4W5H97askkA5zP9Cm9J8XjAm1bNqGayJAwDcEzuDISp2KziF0ZHUq+pNzjrxLnN8yOl7tezPsYqvP1SX1ml+fUHnvBYBuUt50wrY2dKjoyy4+lW6CNij22/jgbZYLxV3Sbx9RUGn5RBCAv9vLBEmBlSZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152195; c=relaxed/simple;
	bh=htIxJB1hkmnNQPnCUWn4SZAiE2V0v1y2KSb0tmp8aXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTVZjp+LfRP7Jb2MSUJA4StPVrdBBwbf5eBE+rfrHvqsnuOHOxHq1R0a8DR1lTRxny6S6y5ETwbekvcYuEMp6ZD2rVdm1zwO3CxdBXRmLUw1mV2YSJ/a4Z4OV+kyHKg7+Ievk0Gr2dHu+vjyJLRIElNbZqiA3ibP+3y3gfJRh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=H09c7TTT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af6a315b491so4977352a12.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 17 Jun 2025 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750152192; x=1750756992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=worsq4RaxCANyyo32YRRmga9A1sz0A2jdjQo23dmUq8=;
        b=H09c7TTTs1Ie2il6BZBc1NPUOggBjtv73HF6M2g+2BzYWk7pHWZ0cjVQd2Y9EBI0Vs
         jk2WzHZAgHy7rEn6i5wssQBrYsRi9U1MLtfozzJfB0Gtrk4tug3NFMEzXqtY/eY+bbl+
         hRLomAKqdoH5V+i5vmAKb8at2L0n8cwFHUjG4HLNL0vNWJT5pdb/j3gm2ciqH7zLXLuF
         3LTixwpH6nRk+WWP7H9Uwd1sqysS31NE9ng3eX3Tbr7NwokkL115/7rU0ZsZ9msul7kh
         fVfDU2yirhm4lqXEIKZwkHDgPu3FArrVUmV7XWE6T4rNx4hVJ6vrzMguta3N1rCSA/47
         Smew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152192; x=1750756992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=worsq4RaxCANyyo32YRRmga9A1sz0A2jdjQo23dmUq8=;
        b=uDoqowSGTgfV9e88F0A1o+QUP4ZTonrnoiNvhmiwNBsfiYC0SYwpQDOem60YRSPbPE
         hgcVdT5TQqV6vOscSdEKgI7FNQA27v9xXls2xg+G/Wzc132mBoIySakdUFgNkY4EG5S1
         F2vBAJfDxyEn7J8aFIo1hEqJyZc9B4q+x+Rv0y3eBGjNd4fFhldCdlSuhTKkWo6Zt8A9
         iYFTjZ23EWmE5z3GVFVIdOV3ahWpRgiY0LnBP4FiWOclMZnzqKDzMmh12aVP7CjiD6mi
         p1TtX1EdCJ2O5ytlq3UwMBrGRejK7T1vbWjHCKX0dQklQP+8BTdkgZEaW236rk4GN2vy
         WyOw==
X-Forwarded-Encrypted: i=1; AJvYcCV1I0nKTN2zFIKZo51awiA1hy+GomrA9DZrqgG5bnOnhl/j69TWZMXs2+yutIkAkG62chdMlLmpv4Sq6s5VpE92EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMRtOoWFTDE9ZcXRLIWOin/qLmdtvjwBlE8Zd4GjIDKcepa2g
	fB9dGH6LaZYLNlC40dDqPdMtsLZipRk44ikkbhGLTN/LOZVjysYNZbf/TiZiTCeYpdc=
X-Gm-Gg: ASbGncvDpxrATr8WVrWQHNW1ynCKg3amzVTzE8/aEXlsfWI4XIWgKJk2dQ6s4WIge4D
	aK50lplIlldNduaVnj8n2M/QsbHJBoIGR/CGgI1NmlUPVNr/P7aZcso/yQuH91OVi3F+BQascKV
	4MpUh4W5nt7/c1tjlj4Uz/Pkpg/LwoulQCcNXvHEHmOzSFPd7vKZj5hngrU3j2rE28wzFAwnIDZ
	bX5HqIY5MvRsGM/zUPT6BA8EzGdINGg7HSdDzD/3nqDS7Rn4F6oZRAcMnJONi+bD8ALiIiLgRgL
	5d5I31gOm+DRp+VeoUmvSMVTAKRb1b3mRC9sPNo1pzzV/7/nmoh34L5jmCGnraboZKfhSCZREyg
	TUhxAHI8CcEaDOkGrHSM4CdojpqhtKkM=
X-Google-Smtp-Source: AGHT+IGnpKUd6Np4be3UnDRaw1JNVwQa7E5dy8Dnok+7eWLJ2DGIG2AHqgIcdQ7MFDu0ZEMxFL/FSA==
X-Received: by 2002:a05:6a21:69b:b0:215:dfee:bb70 with SMTP id adf61e73a8af0-21fbd57ac35mr20152751637.29.1750152192019;
        Tue, 17 Jun 2025 02:23:12 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2e25sm8618179b3a.171.2025.06.17.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:23:11 -0700 (PDT)
Date: Tue, 17 Jun 2025 02:23:08 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617071628.lXtqjG7C@linutronix.de>

On Tuesday 06/17 at 09:16 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-16 10:14:24 [-0700], Calvin Owens wrote:
> > On Wednesday 06/11 at 14:39 -0000, tip-bot2 for Sebastian Andrzej Siewior wrote:
> > > <snip> 
> > > It is possible that two threads simultaneously request the global hash
> > > and both pass the initial check and block later on the
> > > mm::futex_hash_lock. In this case the first thread performs the switch
> > > to the global hash. The second thread will also attempt to switch to the
> > > global hash and while doing so, accessing the nonexisting slot 1 of the
> > > struct futex_private_hash.
> > 
> > In case it's interesting to anyone, I'm hitting this one in real life,
> > one of my build machines got stuck overnight:
> 
> The scenario described in the description is not something that happens
> on its own. The bot explicitly "asked" for it. This won't happen in a
> "normal" scenario where you do not explicitly ask for specific hash via
> the prctl() interface.

Ugh, I'm sorry, I was in too much of a hurry this morning... cargo is
obviously not calling PR_FUTEX_HASH which is new in 6.16 :/

> > Jun 16 02:51:34 beethoven kernel: rcu: INFO: rcu_preempt self-detected stall on CPU
> > Jun 16 02:51:34 beethoven kernel: rcu:         16-....: (59997 ticks this GP) idle=eaf4/1/0x4000000000000000 softirq=14417247/14470115 fqs=21169
> > Jun 16 02:51:34 beethoven kernel: rcu:         (t=60000 jiffies g=21453525 q=663214 ncpus=24)
> > Jun 16 02:51:34 beethoven kernel: CPU: 16 UID: 1000 PID: 2028199 Comm: cargo Not tainted 6.16.0-rc1-lto-00236-g8c6bc74c7f89 #1 PREEMPT 
> > Jun 16 02:51:34 beethoven kernel: Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
> > Jun 16 02:51:34 beethoven kernel: RIP: 0010:queued_spin_lock_slowpath+0x162/0x1d0
> > Jun 16 02:51:34 beethoven kernel: Code: 0f 1f 84 00 00 00 00 00 f3 90 83 7a 08 00 74 f8 48 8b 32 48 85 f6 74 09 0f 0d 0e eb 0d 31 f6 eb 09 31 f6 eb 05 0f 1f 00 f3 90 <8b> 07 66 85 c0 75 f7 39 c8 75 13 41 b8 01 00 00 00 89 c8 f0 44 0f
> …
> > Jun 16 02:51:34 beethoven kernel: Call Trace:
> > Jun 16 02:51:34 beethoven kernel:  <TASK>
> > Jun 16 02:51:34 beethoven kernel:  __futex_pivot_hash+0x1f8/0x2e0
> > Jun 16 02:51:34 beethoven kernel:  futex_hash+0x95/0xe0
> > Jun 16 02:51:34 beethoven kernel:  futex_wait_setup+0x7e/0x230
> > Jun 16 02:51:34 beethoven kernel:  __futex_wait+0x66/0x130
> > Jun 16 02:51:34 beethoven kernel:  ? __futex_wake_mark+0xc0/0xc0
> > Jun 16 02:51:34 beethoven kernel:  futex_wait+0xee/0x180
> > Jun 16 02:51:34 beethoven kernel:  ? hrtimer_setup_sleeper_on_stack+0xe0/0xe0
> > Jun 16 02:51:34 beethoven kernel:  do_futex+0x86/0x120
> > Jun 16 02:51:34 beethoven kernel:  __se_sys_futex+0x16d/0x1e0
> > Jun 16 02:51:34 beethoven kernel:  do_syscall_64+0x47/0x170
> > Jun 16 02:51:34 beethoven kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> …
> > <repeats forever until I wake up and kill the machine>
> > 
> > It seems like this is well understood already, but let me know if
> > there's any debug info I can send that might be useful.
> 
> This is with LTO enabled.

Full lto with llvm-20.1.7.

> Based on the backtrace: there was a resize request (probably because a
> thread was created) and the resize was delayed because the hash was in
> use. The hash was released and now this thread moves all enqueued users
> from the old the hash to the new. RIP says it is a spin lock that it is
> stuck on. This is either the new or the old hash bucket lock.
> If this lifelocks then someone else must have it locked and not
> released.
> Is this the only thread stuck or is there more?
> I'm puzzled here. It looks as if there was an unlock missing.

Nothing showed up in the logs but the RCU stalls on CPU16, always in
queued_spin_lock_slowpath().

I'll run the build it was doing when it happened in a loop overnight and
see if I can trigger it again.

> > Thanks,
> > Calvin
> 
> Sebastian

