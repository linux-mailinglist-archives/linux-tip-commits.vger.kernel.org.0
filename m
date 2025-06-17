Return-Path: <linux-tip-commits+bounces-5855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FAADC32C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F52D3B6F16
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45028D8D1;
	Tue, 17 Jun 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDEKkTJq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RB29ACJB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260F136358;
	Tue, 17 Jun 2025 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144992; cv=none; b=jzPqiZWGnCrUwAp8JXYv/Qpszi6utwqi8LULTatoAzuSr7tNeJ8XW/FONETT9wfMoC+cW1Hm7AMRr0sVLxLOF1NgFEcqvB5hTfwHItOVtJjWUtZWX9CDGrTGglnxkRVvPKhVxNalyHQiKm43k4KRzRExXfANCErMQeMgFyKvnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144992; c=relaxed/simple;
	bh=QL5rnVySYB4u0j606Dbbvhxyl3a6d/u9v0ubbhQt6M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGwx0oYtkK1BGqcCLjsWrSpvmduIvAzagdsj63VzaoH4X/yEj47mym6pdBDsBIyq40TKuKeujrsjKsZBKneWriEcv1z49+P+rkKQeVpWCpnfCd2NzrKdiQ0VPkkknPxHm50Fxc2wWRGQ9Vz+fJPBDqB4VdP9cvaAbGey4MjYfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDEKkTJq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RB29ACJB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750144590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G4Y6TvuyVNHN1PWsG91G5aIgYTdXQnZyKGYWG9XcMo=;
	b=IDEKkTJqdCSfbB27SYK9a63VZZhdQeCif0syY9m4ucJXSjatqy7gdGwkUVSPujH1u1rPfd
	dBubBSeBiSOU66iQKjIsOB3fOJET5kB/y4B7Hgte7FXHwNu9Mbzq3NbYn3neY3SKxzbK6I
	72SXVrWtuk5Us6A6btlbx1EuxKvdXrrYdpKAPn7TEGAZNrWOGdDzbE8CHTi0s/XsInS2vy
	NAepcGK69xUff8ojWj6+gdeGjAKb7suXfxFdrTNh+fOm1/3V9kL1MCQpmJRAT0u9hRiRkz
	DYqYasJzl6vkoBW3eSFFEQmeM7L5O/wy5nMFhaj5mMvr2bEvyzan8ZdonDEFrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750144590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G4Y6TvuyVNHN1PWsG91G5aIgYTdXQnZyKGYWG9XcMo=;
	b=RB29ACJBDHSl7cWS1B213J/dq3behAIUQmPuWgfViXOQK9GY2QTqzEgLWGZRKqJBeGePsE
	XOM1t4kHHvfIvvDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250617071628.lXtqjG7C@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aFBQ8CBKmRzEqIfS@mozart.vkv.me>

On 2025-06-16 10:14:24 [-0700], Calvin Owens wrote:
> On Wednesday 06/11 at 14:39 -0000, tip-bot2 for Sebastian Andrzej Siewior=
 wrote:
> > <snip>=20
> > It is possible that two threads simultaneously request the global hash
> > and both pass the initial check and block later on the
> > mm::futex_hash_lock. In this case the first thread performs the switch
> > to the global hash. The second thread will also attempt to switch to the
> > global hash and while doing so, accessing the nonexisting slot 1 of the
> > struct futex_private_hash.
>=20
> In case it's interesting to anyone, I'm hitting this one in real life,
> one of my build machines got stuck overnight:

The scenario described in the description is not something that happens
on its own. The bot explicitly "asked" for it. This won't happen in a
"normal" scenario where you do not explicitly ask for specific hash via
the prctl() interface.

> Jun 16 02:51:34 beethoven kernel: rcu: INFO: rcu_preempt self-detected st=
all on CPU
> Jun 16 02:51:34 beethoven kernel: rcu:         16-....: (59997 ticks this=
 GP) idle=3Deaf4/1/0x4000000000000000 softirq=3D14417247/14470115 fqs=3D211=
69
> Jun 16 02:51:34 beethoven kernel: rcu:         (t=3D60000 jiffies g=3D214=
53525 q=3D663214 ncpus=3D24)
> Jun 16 02:51:34 beethoven kernel: CPU: 16 UID: 1000 PID: 2028199 Comm: ca=
rgo Not tainted 6.16.0-rc1-lto-00236-g8c6bc74c7f89 #1 PREEMPT=20
> Jun 16 02:51:34 beethoven kernel: Hardware name: ASRock B850 Pro-A/B850 P=
ro-A, BIOS 3.11 11/12/2024
> Jun 16 02:51:34 beethoven kernel: RIP: 0010:queued_spin_lock_slowpath+0x1=
62/0x1d0
> Jun 16 02:51:34 beethoven kernel: Code: 0f 1f 84 00 00 00 00 00 f3 90 83 =
7a 08 00 74 f8 48 8b 32 48 85 f6 74 09 0f 0d 0e eb 0d 31 f6 eb 09 31 f6 eb =
05 0f 1f 00 f3 90 <8b> 07 66 85 c0 75 f7 39 c8 75 13 41 b8 01 00 00 00 89 c=
8 f0 44 0f
=E2=80=A6
> Jun 16 02:51:34 beethoven kernel: Call Trace:
> Jun 16 02:51:34 beethoven kernel:  <TASK>
> Jun 16 02:51:34 beethoven kernel:  __futex_pivot_hash+0x1f8/0x2e0
> Jun 16 02:51:34 beethoven kernel:  futex_hash+0x95/0xe0
> Jun 16 02:51:34 beethoven kernel:  futex_wait_setup+0x7e/0x230
> Jun 16 02:51:34 beethoven kernel:  __futex_wait+0x66/0x130
> Jun 16 02:51:34 beethoven kernel:  ? __futex_wake_mark+0xc0/0xc0
> Jun 16 02:51:34 beethoven kernel:  futex_wait+0xee/0x180
> Jun 16 02:51:34 beethoven kernel:  ? hrtimer_setup_sleeper_on_stack+0xe0/=
0xe0
> Jun 16 02:51:34 beethoven kernel:  do_futex+0x86/0x120
> Jun 16 02:51:34 beethoven kernel:  __se_sys_futex+0x16d/0x1e0
> Jun 16 02:51:34 beethoven kernel:  do_syscall_64+0x47/0x170
> Jun 16 02:51:34 beethoven kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x=
53
=E2=80=A6
> <repeats forever until I wake up and kill the machine>
>=20
> It seems like this is well understood already, but let me know if
> there's any debug info I can send that might be useful.

This is with LTO enabled.
Based on the backtrace: there was a resize request (probably because a
thread was created) and the resize was delayed because the hash was in
use. The hash was released and now this thread moves all enqueued users
=66rom the old the hash to the new. RIP says it is a spin lock that it is
stuck on. This is either the new or the old hash bucket lock.
If this lifelocks then someone else must have it locked and not
released.
Is this the only thread stuck or is there more?
I'm puzzled here. It looks as if there was an unlock missing.

> Thanks,
> Calvin

Sebastian

