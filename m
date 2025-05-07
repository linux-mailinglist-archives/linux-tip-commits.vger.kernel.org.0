Return-Path: <linux-tip-commits+bounces-5453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C5AAE9B2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75133983213
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0F202C2B;
	Wed,  7 May 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5K5At9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A71A29A;
	Wed,  7 May 2025 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643629; cv=none; b=QdFRFRikQaSfq10iHOKrI0i8QUh2lti8oaB13liisUZRI7vH0tQB60UTKtTzMlaC7ybSKj2HvM8wSMk8IpwaawwBFoaO5CSJvrky6n/RGBmDR9UiMZgy2oY0r/7SdXTZrc23frxtn2joQYPbn6jhJT325/oXwRkJVeP7uyZEFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643629; c=relaxed/simple;
	bh=M6g93D+bjw+Vyz0Z2hFP3flpB+wtQYATdyTDn2UBGEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVo8J7k3vL+J5Nu6fHPPW2J5xbe5MAHMBoNUOFVkHp1KDX53sfi+uGNDdiNcl6Oej5IpprCZyECaXeEgwbGAD5Zc9RTTbiU57+7cBQ8468yHnBaaY+gSbkzdg5WJpUvh+IRBYQfKOLa8fmqT2UCXY8mJo3kxq3I3TFLPg7WvIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5K5At9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFE0C4CEE2;
	Wed,  7 May 2025 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746643628;
	bh=M6g93D+bjw+Vyz0Z2hFP3flpB+wtQYATdyTDn2UBGEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5K5At9MGX0YQFyaRIQoqy4OAdTkdxVIwXvfA1TstN093Z9GHxG6fIZHbHsAVizTJ
	 HRoHqxGCMq5MnLxON24Q7Q+81KM+9zeWsRcVrejP4S1nV6g4s++4kcQEoAW5dnNHtj
	 8hdJRl5JC09TZWEcE035G6M5q4h6+aWqgqp50GvtbSCWjWucW2r5/geSm2hPAlu/7h
	 /ftRtrdwV19uowBM4hkczsjljgHeewmQRicoIRi5+o8beCpJGSK7A5+nLaO4gfi/QA
	 PqbCP4gxeY/vYQGz87MwzPe8ndmb9v6x9Cu5Bx0gK5qVBoGveIFiXwBtkzud55gNtU
	 0h1RSSf3MHh1Q==
Date: Wed, 7 May 2025 20:47:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>, x86@kernel.org
Subject: Re: [tip: x86/msr] um: Add UML version of <asm/tsc.h> to define
 rdtsc()
Message-ID: <aBuqqJoHOag7ZRML@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>


Johannes: this is basically an RFC, not a final commit, will add your 
Reviewed-by if it's fine to you, or will change the patch if it's not.

Thanks,

	Ingo

* tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/msr branch of tip:
> 
> Commit-ID:     24b58adaa7508d9d2cdb6bca44803954baf24459
> Gitweb:        https://git.kernel.org/tip/24b58adaa7508d9d2cdb6bca44803954baf24459
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Wed, 07 May 2025 20:18:22 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 07 May 2025 20:30:39 +02:00
> 
> um: Add UML version of <asm/tsc.h> to define rdtsc()
> 
> In the x86 tree rdtsc() methods got moved out of <asm/msr.h>, but this
> broke UML, as the x86 version of <asm/tsc.h> cannot be used by UML as-is:
> 
> 	  CC [M]  drivers/accel/habanalabs/common/habanalabs_ioctl.o
> 	In file included from drivers/accel/habanalabs/common/habanalabs_ioctl.c:20:
> 	./arch/x86/include/asm/tsc.h:70:28: error: conflicting types for ‘cycles_t’; have ‘long long unsigned int’
> 	   70 | typedef unsigned long long cycles_t;
> 	      |                            ^~~~~~~~
> 	In file included from ./arch/um/include/asm/timex.h:7,
> 	                 from ./include/linux/timex.h:67,
> 	                 from ./include/linux/time32.h:13,
> 	                 from ./include/linux/time.h:60,
> 	                 from ./include/linux/skbuff.h:15,
> 	                 from ./include/linux/if_ether.h:19,
> 	                 from ./include/linux/habanalabs/cpucp_if.h:12,
> 	                 from drivers/accel/habanalabs/common/habanalabs.h:11,
> 	                 from drivers/accel/habanalabs/common/habanalabs_ioctl.c:11:
> 	./include/asm-generic/timex.h:8:23: note: previous declaration of ‘cycles_t’ with type ‘cycles_t’ {aka ‘long unsigned int’}
> 	    8 | typedef unsigned long cycles_t;
> 	      |                       ^~~~~~~~
> 
> To resolve these kinds of problems and to allow <asm/tsc.h> to be included on UML,
> add a simplified version of <asm/tsc.h>, which only adds the rdtsc() definition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/r/202505080003.0t7ewxGp-lkp@intel.com
> ---
>  arch/um/include/asm/tsc.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 arch/um/include/asm/tsc.h
> 
> diff --git a/arch/um/include/asm/tsc.h b/arch/um/include/asm/tsc.h
> new file mode 100644
> index 0000000..a52b0e4
> --- /dev/null
> +++ b/arch/um/include/asm/tsc.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_TSC_H
> +#define _ASM_UM_TSC_H
> +
> +#include <asm/asm.h>
> +
> +/**
> + * rdtsc() - returns the current TSC without ordering constraints
> + *
> + * rdtsc() returns the result of RDTSC as a 64-bit integer.  The
> + * only ordering constraint it supplies is the ordering implied by
> + * "asm volatile": it will put the RDTSC in the place you expect.  The
> + * CPU can and will speculatively execute that RDTSC, though, so the
> + * results can be non-monotonic if compared on different CPUs.
> + */
> +static __always_inline u64 rdtsc(void)
> +{
> +	EAX_EDX_DECLARE_ARGS(val, low, high);
> +
> +	asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
> +
> +	return EAX_EDX_VAL(val, low, high);
> +}
> +
> +#endif /* _ASM_UM_TSC_H */

