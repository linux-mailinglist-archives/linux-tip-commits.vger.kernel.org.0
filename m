Return-Path: <linux-tip-commits+bounces-2307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDE97DD66
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Sep 2024 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0120E281E96
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Sep 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068B154433;
	Sat, 21 Sep 2024 13:52:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC7137E;
	Sat, 21 Sep 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726926754; cv=none; b=pP6oxhurHD2XYdhZR3dVd9iRzCtH3otE6ftS088JErLXL+Dav4gk778Uy8Xeaboc9cuqYJ30Ff0ADTU5bEpsJm1JZjrqbmJkKvu5yB7Mi+Pa1TLsstZJcpujVochrF3JipwjHdFriJuvkx4b7OBBOzddem43V4QqFxqJBGkVY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726926754; c=relaxed/simple;
	bh=qMv7gTePJk54ZB7Nmrg64rjcTnOcPV/5olBEQKg7R3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOD8Q/ND1tXcMa9yLPIE0KKOnCb/gLT3DUj82mQ6XYm8g08cCVoibntRapUeGQIXe+iJNi3p131lkjtrGq1UHJKp+c6hP6SQY1nI3FpFHehlXucQixS9UkTh4ay9DZCF74S6Fkl9KHZG/b4aDjE8y8cNAljYf3as8z0VyiMjBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92306FEC;
	Sat, 21 Sep 2024 06:52:53 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198FB3F66E;
	Sat, 21 Sep 2024 06:52:21 -0700 (PDT)
Date: Sat, 21 Sep 2024 15:52:15 +0200
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Aishwarya.TCV@arm.com
Subject: Re: [tip: locking/urgent] jump_label: Fix static_key_slow_dec() yet
 again
Message-ID: <Zu7Pj7lFc5VYhi1h@J2N7QTR9R3>
References: <875xsc4ehr.ffs@tglx>
 <172563367463.2215.5542972042769938731.tip-bot2@tip-bot2>
 <fefd460f-ae33-44cc-9143-d1de4ab64b35@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefd460f-ae33-44cc-9143-d1de4ab64b35@sirena.org.uk>

On Tue, Sep 10, 2024 at 09:16:20PM +0100, Mark Brown wrote:
> On Fri, Sep 06, 2024 at 02:41:14PM -0000, tip-bot2 for Peter Zijlstra wrote:
> 
> > The following commit has been merged into the locking/urgent branch of tip:
> 
> > jump_label: Fix static_key_slow_dec() yet again
> > 
> > While commit 83ab38ef0a0b ("jump_label: Fix concurrency issues in
> > static_key_slow_dec()") fixed one problem, it created yet another,
> > notably the following is now possible:
> 
> This patch, which is now in -next appears to have caused the KVM unit
> tests to start exploding badly on some arm64 systems (at least N1SDP and
> Cavium TX2).  I've bisected the issue, but not analyzed it at all beyond
> noting that the commit looks relevant to the failure.  None of the other
> tests we run on these platforms seem to trigger the issue.
> 
> Before producing any output the tests trigger a warning:

FWIW, I believe this has been fixed. The old version of the patch was
broken:

  de752774f38bb766 ("jump_label: Fix static_key_slow_dec() yet again")

... and I could get that to explode consistently when running the
kvm:smccc_filter test.

The version that eventually made it into tip locking/urgent works
fine for me:

  1d7f856c2ca449f0 ("jump_label: Fix static_key_slow_dec() yet again")

... and I don't see any warnings even if I repeatedly run the entire KVM
selftest suite.

Mark.

> <4>[   17.303495] ------------[ cut here ]------------
> <4>[   17.308364] WARNING: CPU: 1 PID: 279 at kernel/jump_label.c:266 static_key_dec+0x68/0x74
> <4>[   17.316706] Modules linked in: crct10dif_ce arm_spe_pmu coresight_replicator coresight_funnel coresight_tmc coresight_stm stm_core coresight_tpiu arm_cmn coresight cfg80211 rfkill fuse dm_mod ip_tables x_tables ipv6
> <4>[   17.336080] CPU: 1 UID: 0 PID: 279 Comm: qemu-system-aar Not tainted 6.11.0-rc7-00006-g3a0c7230588b #10
> <4>[   17.345719] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> <4>[   17.352927] pc : static_key_dec+0x68/0x74
> <4>[   17.357183] lr : __static_key_slow_dec_cpuslocked+0x24/0x84
> <4>[   17.363003] sp : ffff800083c8ba80
> 
> ....
> 
> <4>[   17.440381] Call trace:
> <4>[   17.443074]  static_key_dec+0x68/0x74
> <4>[   17.446984]  static_key_slow_dec+0x2c/0x80
> <4>[   17.451327]  preempt_notifier_dec+0x18/0x24
> <4>[   17.455759]  kvm_destroy_vm+0x208/0x2b0
> <4>[   17.459845]  kvm_vm_release+0x80/0xb0
> <4>[   17.463754]  __fput+0xcc/0x2d4
> <4>[   17.467057]  ____fput+0x10/0x1c
> <4>[   17.470446]  task_work_run+0x78/0xd4
> <4>[   17.474268]  do_exit+0x2c8/0x90c
> 
> then the test times out and all the remaining cores splat on:
> 
> 4>[   18.067930] registering preempt_notifier while notifiers disabled
> <4>[   18.067935] WARNING: CPU: 2 PID: 470 at kernel/sched/core.c:4729 preempt_notifier_register+0x24/0x58
> 
> The bisect seems to converge fairly smoothly:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [6708132e80a2ced620bde9b9c36e426183544a23] Add linux-next specific files for 20240910
> git bisect bad 6708132e80a2ced620bde9b9c36e426183544a23
> # status: waiting for good commit(s), bad commit known
> # good: [028ac237a57e1bcb07c7130b11527c0e025e4bef] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect good 028ac237a57e1bcb07c7130b11527c0e025e4bef
> # good: [b66d58fce82c825b3dbb57a46b9a74f081ef7ec7] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good b66d58fce82c825b3dbb57a46b9a74f081ef7ec7
> # good: [a636a90415dbc59f005369e3053996f859f0af50] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
> git bisect good a636a90415dbc59f005369e3053996f859f0af50
> # bad: [8e5ac35ddecbeddce79e915c226baaf577a2be6e] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> git bisect bad 8e5ac35ddecbeddce79e915c226baaf577a2be6e
> # bad: [1bcadc80ec6a46fb7193999935aaa299b4916569] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> git bisect bad 1bcadc80ec6a46fb7193999935aaa299b4916569
> # good: [c2d0e416bdd9c83db3c9bb1f19433d5ba34e18c2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> git bisect good c2d0e416bdd9c83db3c9bb1f19433d5ba34e18c2
> # bad: [723da3b00882e1d13038fc48ba2602af9de4dd2e] Merge branch into tip/master: 'locking/core'
> git bisect bad 723da3b00882e1d13038fc48ba2602af9de4dd2e
> # bad: [a70a5c33a65ee54048e4ae479e3479d765a1bbc2] Merge branch into tip/master: 'core/core'
> git bisect bad a70a5c33a65ee54048e4ae479e3479d765a1bbc2
> # good: [85e511df3cec46021024176672a748008ed135bf] sched/eevdf: Allow shorter slices to wakeup-preempt
> git bisect good 85e511df3cec46021024176672a748008ed135bf
> # good: [20f13385b5836d00d64698748565fc6d3ce9b419] posix-timers: Consolidate timer setup
> git bisect good 20f13385b5836d00d64698748565fc6d3ce9b419
> # good: [42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7] timekeeping: Use time_after() in timekeeping_check_update()
> git bisect good 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
> # bad: [3a0c7230588b40caf1d81270ceaa3aa5c0355bc0] Merge branch into tip/master: 'perf/urgent'
> git bisect bad 3a0c7230588b40caf1d81270ceaa3aa5c0355bc0
> # bad: [de752774f38bb766941ed1bf910ba5a9f6cc6bf7] jump_label: Fix static_key_slow_dec() yet again
> git bisect bad de752774f38bb766941ed1bf910ba5a9f6cc6bf7
> # good: [fe513c2ef0a172a58f158e2e70465c4317f0a9a2] static_call: Replace pointless WARN_ON() in static_call_module_notify()
> git bisect good fe513c2ef0a172a58f158e2e70465c4317f0a9a2
> # first bad commit: [de752774f38bb766941ed1bf910ba5a9f6cc6bf7] jump_label: Fix static_key_slow_dec() yet again



