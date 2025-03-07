Return-Path: <linux-tip-commits+bounces-4046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B749A566EB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6976F3B0E2F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D845213252;
	Fri,  7 Mar 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lKjjt++J"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4E21767C;
	Fri,  7 Mar 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347607; cv=none; b=Q2dtAJxy+kK6sjvjXBL4ALEN+BSJBx7IJnUjRUlMuwu8KqBAlxNT8vrKRMk/Y5wOPYOUtJisA5K6eLehYWIklvJ3st7Yf/WhurcEj/6fM7mG7jhODjh/XLqz4DBmLPpVa9ROz6O2d01DRTQHK51fT8yDKYV6UVouKi7VQxdca+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347607; c=relaxed/simple;
	bh=RdXGeUksPX5nBK/Nql891UU9+VHLyZXp5Jp77NwC/lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB9p3AhczKJJnUGQ2DGi7l1kQysRwZynawcDobuG6SSoiRwa6ZTIoa/j7Wiez4PX1RIjN9+CUBE9jB08EjniqW/YowWx91kcFqzkZqZXlzX0ERWagkMqLEO9xGt+kAW/Wq0a3XKTK3qw60N/mvlcGcfgDfsJkiRZ5TiHJPira+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lKjjt++J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJd8io4yNDJMwXhLW9Dt8G+ZqODy5u6PCGa0y547CXU=; b=lKjjt++J+HBCgfVI9IYXcazi5Q
	72CTIpHnw6xOivdf9EBin4omOJsOOKakaGp2XCz3wfinSdS7UNgYuW31GA9rk5cpvCNrqMmxikhnq
	QT2g4ezgHGZZgNCHMTE+RIx+c9dQiqtQ1W9HiKyHoGKjuM4jFsS6zOwRTGiV6beHFyVT45uukbja/
	rRAR5rJ2tmeqT+mz/r+LZPNTydv1KZwuz2FFnrKHDgcXmS6Uq5PIejr6RyvyKx8EiEsCBwq/lqoMG
	3AI7by4DSf4Y0t65jFGhZ6pXkttWOOYJxsERUsvbt+vTrpRaC6fJRrdsWBR+H1fDSTlyBi2HaIghT
	Sk5UKx/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqW3Y-0000000CMER-1YFt;
	Fri, 07 Mar 2025 11:39:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A392D30031C; Fri,  7 Mar 2025 12:39:55 +0100 (CET)
Date: Fri, 7 Mar 2025 12:39:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ryo Takakura <ryotkkr98@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org
Subject: Re: [tip: locking/core] lockdep: Fix wait context check on softirq
 for PREEMPT_RT
Message-ID: <20250307113955.GK16878@noisy.programming.kicks-ass.net>
References: <20250118054900.18639-1-ryotkkr98@gmail.com>
 <174102791921.14745.9525905092448169732.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174102791921.14745.9525905092448169732.tip-bot2@tip-bot2>

On Mon, Mar 03, 2025 at 06:51:59PM -0000, tip-bot2 for Ryo Takakura wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     8a9d677a395703ef9075c91dd04066be8a553405
> Gitweb:        https://git.kernel.org/tip/8a9d677a395703ef9075c91dd04066be8a553405
> Author:        Ryo Takakura <ryotkkr98@gmail.com>
> AuthorDate:    Sat, 18 Jan 2025 14:49:00 +09:00
> Committer:     Boqun Feng <boqun.feng@gmail.com>
> CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00
> 
> lockdep: Fix wait context check on softirq for PREEMPT_RT
> 
> Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> PREEMPT_RT."), the wait context test for mutex usage within
> "in softirq context" fails as it references @softirq_context.
> 
> [    0.184549]   | wait context tests |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184549]                                  | rcu  | raw  | spin |mutex |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> 
> As a fix, add lockdep map for BH disabled section. This fixes the
> issue by letting us catch cases when local_bh_disable() gets called
> with preemption disabled where local_lock doesn't get acquired.
> In the case of "in softirq context" selftest, local_bh_disable() was
> being called with preemption disable as it's early in the boot.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com

This commit is causing:

[    7.184373] NET: Registered PF_INET6 protocol family
[    7.196129] =============================
[    7.196129] [ BUG: Invalid wait context ]
[    7.196129] 6.14.0-rc5-00547-g67de62470d82-dirty #629 Not tainted
[    7.196129] -----------------------------
[    7.196129] swapper/0/1 is trying to lock:
[    7.196129] ffffffff83312108 (pcpu_alloc_mutex){+.+.}-{4:4}, at: pcpu_alloc_noprof+0x818/0xc20
[    7.196129] other info that might help us debug this:
[    7.196129] context-{5:5}
[    7.238009] ata7.00: ATA-8: ST91000640NS, SN03, max UDMA/133
[    7.196129] 3 locks held by swapper/0/1:
[    7.196129]  #0: ffffffff834414d0 (pernet_ops_rwsem){+.+.}-{4:4}, at: register_netdevice_notifier+0x1a/0x120
[    7.196129]  #1: ffffffff83442988 (rtnl_mutex){+.+.}-{4:4}, at: register_netdevice_notifier+0x1f/0x120
[    7.196129]  #2: ffffffff8324c740 (local_bh){.+.+}-{1:3}, at: dev_mc_add+0x39/0xb0
[    7.196129] stack backtrace:
[    7.196129] CPU: 31 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc5-00547-g67de62470d82-dirty #629
[    7.196129] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[    7.196129] Call Trace:
[    7.196129]  <TASK>
[    7.196129]  dump_stack_lvl+0x57/0x80
[    7.196129]  __lock_acquire+0xd72/0x17d0
[    7.196129]  ? ret_from_fork_asm+0x1a/0x30
[    7.196129]  lock_acquire+0xcd/0x2f0
[    7.196129]  ? pcpu_alloc_noprof+0x818/0xc20
[    7.196129]  __mutex_lock+0xa4/0x820
[    7.196129]  ? pcpu_alloc_noprof+0x818/0xc20
[    7.196129]  ? pcpu_alloc_noprof+0x818/0xc20
[    7.196129]  ? lock_acquire+0xcd/0x2f0
[    7.239989]  ? pcpu_alloc_noprof+0x818/0xc20
[    7.239990]  pcpu_alloc_noprof+0x818/0xc20
[    7.239993]  ? lockdep_hardirqs_on+0x74/0x110
[    7.239996]  ? neigh_parms_alloc+0xed/0x160
[    7.240001]  ? neigh_parms_alloc+0xed/0x160
[    7.240005]  ipv6_add_dev+0x154/0x520
[    7.240005]  addrconf_notify+0x2de/0x8b0
[    7.240005]  ? register_netdevice_notifier+0x1f/0x120
[    7.240005]  ? lock_acquire+0xdd/0x2f0
[    7.240005]  call_netdevice_register_net_notifiers+0x5b/0x100
[    7.240005]  register_netdevice_notifier+0x87/0x120
[    7.240005]  addrconf_init+0xa5/0x150
[    7.240005]  inet6_init+0x1f3/0x3b0
[    7.240005]  ? __pfx_inet6_init+0x10/0x10
[    7.240005]  do_one_initcall+0x53/0x2b0
[    7.240005]  ? rcu_is_watching+0xd/0x40
[    7.240005]  kernel_init_freeable+0x23f/0x280
[    7.240005]  ? __pfx_kernel_init+0x10/0x10
[    7.240005]  kernel_init+0x16/0x130
[    7.240005]  ret_from_fork+0x2d/0x50
[    7.240005]  ? __pfx_kernel_init+0x10/0x10
[    7.240005]  ret_from_fork_asm+0x1a/0x30
[    7.240005]  </TASK>

And some other weirdness for bpetkov:

  https://lkml.kernel.org/r/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local


I suspect you missed a release somewhere.

