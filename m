Return-Path: <linux-tip-commits+bounces-2295-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B39743F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3121F25DFC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713B225A8;
	Tue, 10 Sep 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEoSdl4S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2D566A;
	Tue, 10 Sep 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999386; cv=none; b=e4m4gjCP89YEHyG2CQRk6ImlG5TzF0GVqmD+ozYiwgofaffWEWRS+j0dYAZykTrJ0XOX/+g7QDnlj7tdLzW3kmRht6sVGiENnmcEkKkYf+xbu97U4iI57CMtRvg4U0qyI8GcERh4AOue0Zz9kAL3pT2GSvPojL9pjN7URaPISpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999386; c=relaxed/simple;
	bh=HJYKcbje20h/WDUJRQJAyfWugUsdTUiUzb7xkzJpOL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L19sVnUtN9AzEZ0kFWoWxJl17HTUoOA0wPwmC37xqAhs4VFDLGojSjHrHEmlf0+NGZv0R1wlbIKk/kscnTmYvJLruEMAEny4qedY00lbsbtfvGHO+eDz9U9AG7OjQxto4MCUt+B4j/HkZR5TBR4A41PXoJK4FhJ/Zswcw+krgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEoSdl4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6506C4CEC3;
	Tue, 10 Sep 2024 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725999385;
	bh=HJYKcbje20h/WDUJRQJAyfWugUsdTUiUzb7xkzJpOL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEoSdl4SgKUVcPgxQMv7y6264JIMhvyy35scTQwfs4CQMRmxFffZaltYEPLGWBwcB
	 QFvyj4cxTR0+gPX7XLlaj2MaFTpKPBZsa0NiFG/LGSJyPozCJNUzu4dgqbwihB4pBh
	 5wjWsBOI1oR0pImu66JZlnMpkfTvZlDb53lD5IUhdUXyChbhWRBaNbGPgCmcg54TM1
	 8aTGI4kttydl499NhLZFRosgcPdTBNmGaYBL+VoTLLTTZp6TymEaJSeZ0zOa6U5cWf
	 wtOUG706dDOfteGwi4MHCg14vi1vbEhS4ZCcLtwEoZXipGy3MeF08Zg3h4km0YLQwf
	 Ci2FwDYfu7G6g==
Date: Tue, 10 Sep 2024 21:16:20 +0100
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Aishwarya.TCV@arm.com
Subject: Re: [tip: locking/urgent] jump_label: Fix static_key_slow_dec() yet
 again
Message-ID: <fefd460f-ae33-44cc-9143-d1de4ab64b35@sirena.org.uk>
References: <875xsc4ehr.ffs@tglx>
 <172563367463.2215.5542972042769938731.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NYw/P0L4bhK7Sn5+"
Content-Disposition: inline
In-Reply-To: <172563367463.2215.5542972042769938731.tip-bot2@tip-bot2>
X-Cookie: Not every question deserves an answer.


--NYw/P0L4bhK7Sn5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:41:14PM -0000, tip-bot2 for Peter Zijlstra wrote:

> The following commit has been merged into the locking/urgent branch of ti=
p:

> jump_label: Fix static_key_slow_dec() yet again
>=20
> While commit 83ab38ef0a0b ("jump_label: Fix concurrency issues in
> static_key_slow_dec()") fixed one problem, it created yet another,
> notably the following is now possible:

This patch, which is now in -next appears to have caused the KVM unit
tests to start exploding badly on some arm64 systems (at least N1SDP and
Cavium TX2).  I've bisected the issue, but not analyzed it at all beyond
noting that the commit looks relevant to the failure.  None of the other
tests we run on these platforms seem to trigger the issue.

Before producing any output the tests trigger a warning:

<4>[   17.303495] ------------[ cut here ]------------
<4>[   17.308364] WARNING: CPU: 1 PID: 279 at kernel/jump_label.c:266 stati=
c_key_dec+0x68/0x74
<4>[   17.316706] Modules linked in: crct10dif_ce arm_spe_pmu coresight_rep=
licator coresight_funnel coresight_tmc coresight_stm stm_core coresight_tpi=
u arm_cmn coresight cfg80211 rfkill fuse dm_mod ip_tables x_tables ipv6
<4>[   17.336080] CPU: 1 UID: 0 PID: 279 Comm: qemu-system-aar Not tainted =
6.11.0-rc7-00006-g3a0c7230588b #10
<4>[   17.345719] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
<4>[   17.352927] pc : static_key_dec+0x68/0x74
<4>[   17.357183] lr : __static_key_slow_dec_cpuslocked+0x24/0x84
<4>[   17.363003] sp : ffff800083c8ba80

=2E...

<4>[   17.440381] Call trace:
<4>[   17.443074]  static_key_dec+0x68/0x74
<4>[   17.446984]  static_key_slow_dec+0x2c/0x80
<4>[   17.451327]  preempt_notifier_dec+0x18/0x24
<4>[   17.455759]  kvm_destroy_vm+0x208/0x2b0
<4>[   17.459845]  kvm_vm_release+0x80/0xb0
<4>[   17.463754]  __fput+0xcc/0x2d4
<4>[   17.467057]  ____fput+0x10/0x1c
<4>[   17.470446]  task_work_run+0x78/0xd4
<4>[   17.474268]  do_exit+0x2c8/0x90c

then the test times out and all the remaining cores splat on:

4>[   18.067930] registering preempt_notifier while notifiers disabled
<4>[   18.067935] WARNING: CPU: 2 PID: 470 at kernel/sched/core.c:4729 pree=
mpt_notifier_register+0x24/0x58

The bisect seems to converge fairly smoothly:

git bisect start
# status: waiting for both good and bad commits
# bad: [6708132e80a2ced620bde9b9c36e426183544a23] Add linux-next specific f=
iles for 20240910
git bisect bad 6708132e80a2ced620bde9b9c36e426183544a23
# status: waiting for good commit(s), bad commit known
# good: [028ac237a57e1bcb07c7130b11527c0e025e4bef] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 028ac237a57e1bcb07c7130b11527c0e025e4bef
# good: [b66d58fce82c825b3dbb57a46b9a74f081ef7ec7] Merge branch 'main' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good b66d58fce82c825b3dbb57a46b9a74f081ef7ec7
# good: [a636a90415dbc59f005369e3053996f859f0af50] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good a636a90415dbc59f005369e3053996f859f0af50
# bad: [8e5ac35ddecbeddce79e915c226baaf577a2be6e] Merge branch 'driver-core=
-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.=
git
git bisect bad 8e5ac35ddecbeddce79e915c226baaf577a2be6e
# bad: [1bcadc80ec6a46fb7193999935aaa299b4916569] Merge branch 'master' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 1bcadc80ec6a46fb7193999935aaa299b4916569
# good: [c2d0e416bdd9c83db3c9bb1f19433d5ba34e18c2] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good c2d0e416bdd9c83db3c9bb1f19433d5ba34e18c2
# bad: [723da3b00882e1d13038fc48ba2602af9de4dd2e] Merge branch into tip/mas=
ter: 'locking/core'
git bisect bad 723da3b00882e1d13038fc48ba2602af9de4dd2e
# bad: [a70a5c33a65ee54048e4ae479e3479d765a1bbc2] Merge branch into tip/mas=
ter: 'core/core'
git bisect bad a70a5c33a65ee54048e4ae479e3479d765a1bbc2
# good: [85e511df3cec46021024176672a748008ed135bf] sched/eevdf: Allow short=
er slices to wakeup-preempt
git bisect good 85e511df3cec46021024176672a748008ed135bf
# good: [20f13385b5836d00d64698748565fc6d3ce9b419] posix-timers: Consolidat=
e timer setup
git bisect good 20f13385b5836d00d64698748565fc6d3ce9b419
# good: [42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7] timekeeping: Use time_af=
ter() in timekeeping_check_update()
git bisect good 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
# bad: [3a0c7230588b40caf1d81270ceaa3aa5c0355bc0] Merge branch into tip/mas=
ter: 'perf/urgent'
git bisect bad 3a0c7230588b40caf1d81270ceaa3aa5c0355bc0
# bad: [de752774f38bb766941ed1bf910ba5a9f6cc6bf7] jump_label: Fix static_ke=
y_slow_dec() yet again
git bisect bad de752774f38bb766941ed1bf910ba5a9f6cc6bf7
# good: [fe513c2ef0a172a58f158e2e70465c4317f0a9a2] static_call: Replace poi=
ntless WARN_ON() in static_call_module_notify()
git bisect good fe513c2ef0a172a58f158e2e70465c4317f0a9a2
# first bad commit: [de752774f38bb766941ed1bf910ba5a9f6cc6bf7] jump_label: =
Fix static_key_slow_dec() yet again

--NYw/P0L4bhK7Sn5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbgqRMACgkQJNaLcl1U
h9CaoAf/WEHszCEtu0E/ZLuteJCN/8fHtjcQYf85VbcmRn4ar2Tx/s0lQycNbup+
vYz/MmdyatYIOkepv6Bog0K9z0vCYNgTssvide+cfoNBwz8wB9/c4+HaUFhznNoH
XO9Tx/ImFpMEefF3lv3QwVKyGAZHzjsGaN/wMm9HktMnSW9VkW6QcbwuG04Aq2mP
jBk1Mh0PZ5jl0aE2cS1+Z/l8UiUY5q8XSiuUoD8qdb4U9iOG/K24ZFIFVusfm5b5
/HyxU4+bSybwLxz61+MOB+r8yJYgKnToEwbXt2nu2lQikns9WHDAWjGBTnbnxvhX
uVKTIB3QrlzkMDiEwhWIVD41mKLecw==
=6Vrc
-----END PGP SIGNATURE-----

--NYw/P0L4bhK7Sn5+--

