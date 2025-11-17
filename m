Return-Path: <linux-tip-commits+bounces-7380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90606C65D4A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C74EC63F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99633EB0E;
	Mon, 17 Nov 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7u7t6mF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637B33E377;
	Mon, 17 Nov 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405713; cv=none; b=lK/bpqby5Fv/I9++kZG12N6gIwdqEfiJeTPNKH3Q+iN6xBj8QBuLinnPAO52kvosSffSKt0Sm9/8uC5E79WElktzf9kWU48d5zt7zQD/4NzJXbiAWGL/RQwaVm2BnefaejJh8LWoaU+tvBmGFLJSrcsrccgq8sNt3DvLALfvp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405713; c=relaxed/simple;
	bh=vtT+WtTf/UBUYKnc+b3ZReWm4oesw8m7FKXyGXeXf+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3nrr1nVkMM+GPQWajVcRiCvi2KR9Mtu72p995QNAHCMSUjb7dMrNJOX5IHAb2NPHfaUjD9SqGJgXaLdhpqkG/CDrJYwqEYZAsNlRyVAM74b4bsqLF0cHnPRiBDWiPhwR8jLFBwXeZHNMHrHPzKoBxPF//7nCeBNxGKoGD4h+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7u7t6mF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763405709; x=1794941709;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vtT+WtTf/UBUYKnc+b3ZReWm4oesw8m7FKXyGXeXf+w=;
  b=m7u7t6mFpPwywviStA/IZQDB3xOasuItEBE0NYysdSPdbTvF+RgQONxy
   O4SobdFR2lgs+ba6lFTe6quinVB7MqUkfARv/bZOk0pM0ZYMjSXS2GTDl
   bsOLyafnGYhhPBjeeYcBu8J91M0h0TInNNONmvJlzpR7qThX29KN5Ef9a
   RnOyp0+MpqWtsglfi102N+mtC0hBySAfC3CYJziAIbMmtXsX1DsCjF74k
   FPasrh0ig5HikaUN/c84nryHWdRaKloWrV9O/0okQcXF3rxiSI5ONKk3W
   QxgQXSbZCRdvSkkGN34irnJZGJUXbwFGRMgMapxV1W7I+tK8jbRvUJLcn
   w==;
X-CSE-ConnectionGUID: QRhMCRQ0TLegAP6C76X9Qw==
X-CSE-MsgGUID: XaZbI2rwQDW/ACCnlmKABA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65348582"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65348582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 10:55:09 -0800
X-CSE-ConnectionGUID: O1hhndQSSVOsSx8sQbM5mg==
X-CSE-MsgGUID: Lz0TjpW8TYuYKkt3LlVNQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195467850"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 10:55:08 -0800
Message-ID: <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running
 cmpxchg when balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, 
 "Peter Zijlstra (Intel)"
	 <peterz@infradead.org>
Cc: linux-tip-commits@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Srikar Dronamraju	 <srikar@linux.ibm.com>, Mohini
 Narkhede <mohini.narkhede@intel.com>, 	x86@kernel.org
Date: Mon, 17 Nov 2025 10:55:07 -0800
In-Reply-To: <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
References: 
	<6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
	 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
	 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBE6N6zwBCADFoM9QBP6fLqfYine5oPRtaUK2xQavcYT34CBnjTlhbvEVMTPlNNzE5
 v04Kagcvg5wYcGwr3gO8PcEKieftO+XrzAmR1t3PKxlMT1bsQdTOhKeziZxh23N+kmA7sO/jnu/X2
 AnfSBBw89VGLN5fw9DpjvU4681lTCjcMgY9KuqaC/6sMbAp8uzdlue7KEl3/D3mzsSl85S9Mk8KTL
 MLb01ILVisM6z4Ns/X0BajqdD0IEQ8vLdHODHuDMwV3veAfnK5G7zPYbQUsK4+te32ruooQFWd/iq
 Rf815j6/sFXNVP/GY4EWT08UB129Kzcxgj2TEixe675Nr/hKTUVKM/NrABEBAAGJAS4EIAECABgFA
 k6ONYoRHQFLZXkgaXMgcmVwbGFjZWQACgkQHH3vaoxLv2UmbAgAsqa+EKk2yrDc1dEXbZBBGeCiVP
 XkP7iajI/FiMVZHFQpme4vpntWhg0BIKnF0OSyv0wgn3wzBWx0Zh3cve/PICIj268QvXkb0ykVcIo
 RnWwBeavO4dd304Mzhz5fBzJwjYx06oabgUmeGawVCEq7UfXy+PsdQdoTabsuD1jq0MbOL/4sB6CZ
 c4V2mQbW4+Js670/sAZSMj0SQzK9CQyQdg6Wivz8GgTBjWwWsfMt4g2u0s6rtBo8NUZG/yw6fNdao
 DaT/OCHuBopGmsmFXInigwOXsjyp15Yqs/de3S2Nu5NdjJUwmN1Qd1bXEc/ItvnrFB0RgoNt2gzf2
 5aPifLabQlVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokBOAQTAQIAIgUCTo3
 rPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHH3vaoxLv2XYdAf8DgRO4eIAtWZy4zLv
 0EZHWiJ35GYAQ5fPFWBoNURE0+vICrvLyfCKTlUTFxFxTiAWHUO7JM+uBHQSJVsE+ERmTPsiUO1m7
 SxZakGy9U2WOEiWMZMRp7HZE8vPUY5AM1OD0b38WBeUD3FPx5WRlQ0z6izF9aIHxoQhci0/WtmGLO
 Pw3HUlCy1c4DDl6cInpy/JqUPcYlvsp+bWbdm7R5b33WW2CNVVr1eLj+1UP0Iow4jlLzNLW+jOpiv
 LDs3G/bNC1Uu/SAzTvbaDBRRO9ToX5rlg3Zi8PmOUXWzEfO6N+L1gFCAdYEB4oSOghSbk2xCC4DRl
 UTlYoTJCRsjusXEy4ZkCDQROjjboARAAtXPJWkNkK3s22BXrcK8w9L/Kzqmp4+V9Y5MkkK94Zv66l
 XAybnXH3UjL9ATQgo7dnaHxcVX0S9BvHkEeKqEoMwxg86Bb2tzY0yf9+E5SvTDKLi2O1+cd7F3Wba
 1eM4Shr90bdqLHwEXR90A6E1B7o4UMZXD5O3MI013uKN2hyBW3CAVJsYaj2s9wDH3Qqm4Xe7lnvTA
 GV+zPb5Oj26MjuD4GUQLOZVkaA+GX0TrUlYl+PShJDuwQwpWnFbDgyE6YmlrWVQ8ZGFF/w/TsRgJM
 ZqqwsWccWRw0KLNUp0tPGig9ECE5vy1kLcMdctD+BhjF0ZSAEBOKyuvQQ780miweOaaTsADu5MPGk
 d3rv7FvKdNencd+G1BRU8GyCyRb2s6b0SJnY5mRnE3L0XfEIJoTVeSDchsLXwPLJy+Fdd2mTWQPXl
 nforgfKmX6BYsgHhzVsy1/zKIvIQey8RbhBp728WAckUvN47MYx9gXePW04lzrAGP2Mho+oJfCpI0
 myjpI9CEctvJy4rBXRgb4HkK72i2gNOlXsabZqy46dULcnrMOsyCXj6B1CJiZbYz4xb8n5LiD31SA
 fO5LpKQe/G4UkQOZgt+uS7C0Zfp61+0mrhKPG+zF9Km1vaYNH8LIsggitIqE05uCFi9sIgwez3oiU
 rFYgTkTSqMQNPdweNgVhSUAEQEAAbQ0VGltIENoZW4gKHdvcmsgcmVsYXRlZCkgPHRpbS5jLmNoZW
 5AbGludXguaW50ZWwuY29tPokCVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQT
 RofI2lb24ozcpAhyiZ7WKota4SQUCYjOVvwUJF2fF1wAKCRCiZ7WKota4SeetD/4hztE+L/Z6oqIY
 lJJGgS9gjV7c08YH/jOsiX99yEmZC/BApyEpqCIs+RUYl12hwVUJc++sOm/p3d31iXvgddXGYxim0
 0+DIhIu6sJaDzohXRm8vuB/+M/Hulv+hTjSTLreAZ9w9eYyqffre5AlEk/hczLIsAsYRsqyYZgjfX
 Lk5JN0L7ixsoDRQ5syZaY11zvo3LZJX9lTw0VPWlGeCxbjpoQK91CRXe9dx/xH/F/9F203ww3Ggt4
 VlV6ZNdl14YWGfhsiJU2rbeJ930sUDbMPJqV60aitI93LickNG8TOLG5QbN9FzrOkMyWcWW7FoXwT
 zxRYNcMqNVQbWjRMqUnN6PXCIvutFLjLF6FBe1jpk7ITlkS1FvA2rcDroRTU/FZRnM1k0K4GYYYPj
 11Zt3ZBcPoI0J3Jz6P5h6fJioqlhvZiaNhYneMmfvZAWJ0yv+2c5tp2aBmKsjmnWecqvHL5r/bXez
 iKRdcWyXqrEEj6OaJr3S4C0MIgGLteARvbMH+3tNTDIqFuyqdzHLKwEHuvKxHzYFyV7I5ZEQ2HGH5
 ZRZ2lRpVjSIlnD4L1PS6Bes+ALDrWqksbEuuk+ixFKKFyIsntIM+qsjkXseuMSIG5ADYfTla9Pc5f
 VpWBKX/j0MXxdQsxT6tiwE7P+osbOMwQ6Ja5Qi57hj8jBRF1znDjDZkBDQRcCwpgAQgAl12VXmQ1X
 9VBCMC+eTaB0EYZlzDFrW0GVmi1ii4UWLzPo0LqIMYksB23v5EHjPvLvW/su4HRqgSXgJmNwJbD4b
 m1olBeecIxXp6/S6VhD7jOfi4HACih6lnswXXwatzl13OrmK6i82bufaXFFIPmd7x7oz5Fuf9OQlL
 OnhbKXB/bBSHXRrMCzKUJKRia7XQx4gGe+AT6JxEj6YSvRT6Ik/RHpS/QpuOXcziNHhcRPD/ZfHqJ
 SEa851yA1J3Qvx1KQK6t5I4hgp7zi3IRE0eiObycHJgT7nf/lrdAEs7wrSOqIx5/mZ5eoKlcaFXiK
 J3E0Wox6bwiBQXrAQ/2yxBxVwARAQABtCVUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC
 5jb20+iQFUBBMBCAA+FiEEEsKdz9s94XWwiuG96lQbuGeTCYsFAlwLCmACGwMFCQHhM4AFCwkIBwI
 GFQoJCAsCBBYCAwECHgECF4AACgkQ6lQbuGeTCYuQiQf9G2lkrkRdLjXehwCl+k5zBkn8MfUPi2It
 U2QDcBit/YyaZpNlSuh8h30gihp5Dlb9BnqBVKxooeIVKSKC1HFeG0AE28TvgCgEK8qP/LXaSzGvn
 udek2zxWtcsomqUftUWKvoDRi1AAWrPQmviNGZ4caMd4itKWf1sxzuH1qF5+me6eFaqhbIg4k+6C5
 fk3oDBhg0zr0gLm5GRxK/lJtTNGpwsSwIJLtTI3zEdmNjW8bb/XKszf1ufy19maGXB3h6tA9TTHOF
 nktmDoWJCq9/OgQS0s2D7W7f/Pw3sKQghazRy9NqeMbRfHrLq27+Eb3Nt5PyiQuTE8JeAima7w98q
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-16 at 02:26 +0530, Shrikanth Hegde wrote:
> Hi Peter.
>=20
> On 11/14/25 5:49 PM, tip-bot2 for Tim Chen wrote:
> > The following commit has been merged into the sched/core branch of tip:
> >=20
> > Commit-ID:     2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> > Gitweb:        https://git.kernel.org/tip/2265c5d4deeff3bfe4580d9ffe718=
fd80a414cac
> > Author:        Tim Chen <tim.c.chen@linux.intel.com>
> > AuthorDate:    Mon, 10 Nov 2025 10:47:35 -08:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 14 Nov 2025 13:03:05 +01:00
> >=20
> > sched/fair: Skip sched_balance_running cmpxchg when balance is not due
> >=20
> >=20
>=20
>   =20
> > +	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle !=3D CPU_NEWLY=
_IDLE) {
> > +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
>=20
> This should be atomic_cmpxchg_acquire?
>=20
> I booted the system with latest sched/core and it crashes at the boot.
>=20
> BUG: Kernel NULL pointer dereference on read at 0x00000000
> Faulting instruction address: 0xc0000000001db57c
> Oops: Kernel access of bad area, sig: 7 [#1]
> LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D8192 NUMA pSeries
> Modules linked in:
> CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.18.0-rc3+ #242 PREEMPT=
(lazy)
> NIP [c0000000001db57c] sched_balance_rq+0x560/0x92c
> LR [c0000000001db198] sched_balance_rq+0x17c/0x92c
> Call Trace:
> [c00000111ffdfd10] [c0000000001db198] sched_balance_rq+0x17c/0x92c (unrel=
iable)
> [c00000111ffdfe50] [c0000000001dc598] sched_balance_domains+0x2c4/0x3d0
> [c00000111ffdff00] [c000000000168958] handle_softirqs+0x138/0x414
> [c00000111ffdffe0] [c000000000017d80] do_softirq_own_stack+0x3c/0x50
> [c000000008a57a60] [c000000000168048] __irq_exit_rcu+0x18c/0x1b4
> [c000000008a57a90] [c0000000001691a8] irq_exit+0x20/0x38
> [c000000008a57ab0] [c000000000028c18] timer_interrupt+0x174/0x394
> [c000000008a57b10] [c000000000009f8c] decrementer_common_virt+0x28c/0x290
>=20
>=20
> Bisect pointed to:
> git bisect bad 2265c5d4deeff3bfe4580d9ffe718fd80a414cac
> # first bad commit: [2265c5d4deeff3bfe4580d9ffe718fd80a414cac] sched/fair=
: Skip sched_balance_running cmpxchg when balance is not due
>=20
>=20
> I wondered what is really different since the tim's v4 boots fine.
> There is try instead in the tip, i think that is messing it since likely
> we are dereferencing 0?
>=20
>=20
> With this diff it boots fine.
>=20
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aaa47ece6a8e..01814b10b833 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11841,7 +11841,7 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
>          }
>  =20
>          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
> -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0=
, 1))

The second argument of atomic_try_cmpxchg_acquire is "int *old" while that =
of atomic_cmpxchg_acquire
is "int old". So the above check would result in NULL pointer access.  Prob=
ably have
to do something like the following to use atomic_try_cmpxchg_acquire()

		int zero =3D 0;
		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
	=09
Otherwise we should do atomic_cmpxchg_acquire() as below

> +               if (!atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)=
)

Tim

>                          goto out_balanced;
>  =20
>                  need_unlock =3D true;
>=20
>=20

