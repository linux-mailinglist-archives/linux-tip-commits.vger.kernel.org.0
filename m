Return-Path: <linux-tip-commits+bounces-1351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7998FD399
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FB9288386
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B6188CD6;
	Wed,  5 Jun 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6V95OJ1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A714D6F6;
	Wed,  5 Jun 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607261; cv=none; b=oNs8H/hF4BpzACssPt9T9mM6V4MYy1zr/yisHWOY/DMg1IdObep70nGf0dPHWnFueSFbdmtAc21Eied0yBlyGQZ8QLkpBlMYHUUJ8a3le3eAYfoZ7qMGLiLlOLwaindczaPDfIli+Ouo6Z3M2dZW7LPLeJGzRmW16j/k/hw4Wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607261; c=relaxed/simple;
	bh=admCTi0dRN3e9uqsj0+Zv4ya/X1UvHIHHvEvMdzomKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKTbchw9tb1XLf9pXku5SReX9fcxbFJGYzyhkM0wYL+a2HOpMNRgBnlkzEqbVVkDk7KWla2fTC98XX2or2vStRT39QRJALoA3tzwM9/9BOE02guuKpZuS/qDYkuborbb9sY6SADdbvr5Jmbn76zM2eqVPmDb4kdplW9AJwP9Drk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6V95OJ1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717607260; x=1749143260;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=admCTi0dRN3e9uqsj0+Zv4ya/X1UvHIHHvEvMdzomKI=;
  b=e6V95OJ11K1mq4MN/1E88wtlEEV4KB12DuG/ndnyZkirifbIUOkhwqPq
   ol/pbEoxpPY3z4W/8bOnLjSdnvCab/Fi3gO5ShXQy5DsoFJLriaBCqwKw
   oakmLnvQq2EVcjGHj9YYUcg3+2ctjx10VuWcU9uvJnOGbcqx4vuBJaJvK
   gDomLCyxvAvO0pkVi90SVjYXp6fMOdStQIi8ctYleC4Z6v9BmoEjpkyiq
   KEDeeH+bFLGWUKGYjWs91Ok1pm4by1+8XMnWWhddS7HA30OIeOmZlLrsP
   C/4bxn5re90RwjjPr31ZhW2oE2zC2AOQ+zESIXdaPjSvTq2BVbh3k3tmI
   g==;
X-CSE-ConnectionGUID: 8pIqXb/3TguF9PNHF7tw9w==
X-CSE-MsgGUID: gld8nkvsShG0YDXsJgDIaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31779190"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="31779190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 10:07:40 -0700
X-CSE-ConnectionGUID: DzUyDe2QQBS/BgG3E97Bdw==
X-CSE-MsgGUID: iYxnW/oiQv6PnFC3eWUcIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="38224501"
Received: from smulagon-mobl2.amr.corp.intel.com (HELO [10.212.148.106]) ([10.212.148.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 10:07:34 -0700
Message-ID: <6c4a508382d7f485c87814152282679aff120f86.camel@linux.intel.com>
Subject: Re: [tip: sched/core] sched/balance: Skip unnecessary updates to
 idle load balancer's flags
From: Tim Chen <tim.c.chen@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu
	 <yu.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	x86@kernel.org, Mohini Narkhede <mohini.narkhede@intel.com>
Date: Wed, 05 Jun 2024 10:07:33 -0700
In-Reply-To: <171759927306.10875.2450909647126184930.tip-bot2@tip-bot2>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
	 <171759927306.10875.2450909647126184930.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 14:54 +0000, tip-bot2 for Tim Chen wrote:
>=20
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/r/20240531205452.65781-1-tim.c.chen@linux.i=
ntel.com

Peter,

Thanks for putting the patch in tip.

Can you also also add=C2=A0

Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>

Thanks.

Tim

> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 63113dc..41b5838 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11892,6 +11892,13 @@ static void kick_ilb(unsigned int flags)
>  		return;
> =20
>  	/*
> +	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
> +	 * i.e. all bits in flags are already set in ilb_cpu.
> +	 */
> +	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) =3D=3D flags)
> +		return;
> +
> +	/*
>  	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
>  	 * the first flag owns it; cleared by nohz_csd_func().
>  	 */


