Return-Path: <linux-tip-commits+bounces-4290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA95A6574E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32315189B0AF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E2224D7;
	Mon, 17 Mar 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="talXNKxN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7A28EB;
	Mon, 17 Mar 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227043; cv=none; b=TaWk2EMGtFEKYu/HSff9p5zNTVADN/AGqx0H60S3sSaSJluc1o7Bz6Of7r8Q73a+dTfepAjEoJvPe1QkbLXgOLTq7rvfXXciO+l1x7sex4W+eliiALTNT5gz84o5dbRyAm2bLzwOPt1fYNhGtXW4nxY1IgAuqMhZy3fvLdFf+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227043; c=relaxed/simple;
	bh=Z393QTCPkGUwqAKXZiX9OYGpork+zYIhwJzOk3f+DR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIsuqjKqYMO+P0lRRMUW+8WvHTdULLAKCcjtyCNAwMDz5J7HqgmiB0i7n8JNRnnnp8kE0LjmJi18EvxaQTVsl4FyHsnJ9x7jUzMmEANdcdhY6R9OP3xBN5664P1qv05zbnfH+d2PC5VxNA/+q4PDyGIJYJdysKOfvZG9ehRoj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=talXNKxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5071C4CEE3;
	Mon, 17 Mar 2025 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227043;
	bh=Z393QTCPkGUwqAKXZiX9OYGpork+zYIhwJzOk3f+DR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=talXNKxNZkpqi1mzOE7aP34ZEd17xw0JWO7D6f9DIDg4SG9/v9YBfX3DfmpDQlbwi
	 YrR00gDIL7RVTiByS0OIUOZ6z0VjrTpd2mvR30aod6LRBReW290Mo7w4wD+WlfUoUl
	 Si8p8gX2Yzg9ddZt6NdOoaa2pAOIvw30051bUCygczaKtXHTFBtCKgKZQbwBHYHIjB
	 dH8XoMqJrRLX11G6VHTwdg4EUDJoeZYSBYuOSAwi57HzXGqfT3pztWeWLLP0izXnJC
	 eoDExaaTfLYu1GonnkmZ5V636kmEyJNoL+O9KCiXAjZic5MxJ3+1SBZHLRbwWy0mqm
	 cnyJCe+GSlifQ==
Date: Mon, 17 Mar 2025 08:57:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Matteo Rizzo <matteorizzo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86: Check data address for IBS software
 filter
Message-ID: <Z9hGYP76E6dDEppS@google.com>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
 <20250317101048.GAZ9f1KEixI3-b0EoR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317101048.GAZ9f1KEixI3-b0EoR@fat_crate.local>

On Mon, Mar 17, 2025 at 11:10:48AM +0100, Borislav Petkov wrote:
> On Mon, Mar 17, 2025 at 09:15:05AM -0000, tip-bot2 for Namhyung Kim wrote:
> > The following commit has been merged into the perf/urgent branch of tip:
> > 
> > Commit-ID:     b0be17d8108bf3448a58be319d085155a128cf3a
> > Gitweb:        https://git.kernel.org/tip/b0be17d8108bf3448a58be319d085155a128cf3a
> > Author:        Namhyung Kim <namhyung@kernel.org>
> > AuthorDate:    Mon, 17 Mar 2025 01:10:58 -07:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Mon, 17 Mar 2025 10:04:31 +01:00
> > 
> > perf/x86: Check data address for IBS software filter
> > 
> > The IBS software filter is filtering kernel samples for regular users in
> > PMI handler.  It checks the instruction address in the IBS register to
> > determine if it was in the kernel mode or not.
> > 
> > But it turns out that it's possible to report a kernel data address even
> > if the instruction address belongs to the user space.  Matteo Rizzo
> > found that when an instruction raises an exception, IBS can report some
> > kernel data address like IDT while holding the faulting instruction's
> > RIP.  To prevent an information leak, it should double check if the data
> > address in PERF_SAMPLE_DATA is in the kernel space as well.
> > 
> > Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20250317081058.1794729-1-namhyung@kernel.org
> > ---
> >  arch/x86/events/amd/ibs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> > index e7a8b87..24985c7 100644
> > --- a/arch/x86/events/amd/ibs.c
> > +++ b/arch/x86/events/amd/ibs.c
> > @@ -1147,6 +1147,13 @@ fail:
> >  	if (perf_ibs == &perf_ibs_op)
> >  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
> >  
> > +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> > +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> > +	    event->attr.exclude_kernel && !access_ok(data.addr)) {
> > +		throttle = perf_event_account_interrupt(event);
> > +		goto out;
> > +	}
> 
> Did anyone build this?

Oops, sorry about this.  I fixed it locally but sent the one before
adding the change.  Will send v2.

Thanks,
Namhyung


> 
> arch/x86/events/amd/ibs.c: In function ‘perf_ibs_handle_irq’:
> arch/x86/events/amd/ibs.c:1291:63: error: macro "access_ok" requires 2 arguments, but only 1 given
>  1291 |             event->attr.exclude_kernel && !access_ok(data.addr)) {
>       |                                                               ^
> In file included from ./arch/x86/include/asm/uaccess.h:25,
>                  from ./include/linux/uaccess.h:12,
>                  from ./include/linux/sched/task.h:13,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/ptrace.h:7,
>                  from ./include/uapi/asm-generic/bpf_perf_event.h:4,
>                  from ./arch/x86/include/generated/uapi/asm/bpf_perf_event.h:1,
>                  from ./include/uapi/linux/bpf_perf_event.h:11,
>                  from ./include/linux/perf_event.h:18,
>                  from arch/x86/events/amd/ibs.c:9:
> ./include/asm-generic/access_ok.h:45: note: macro "access_ok" defined here
>    45 | #define access_ok(addr, size) likely(__access_ok(addr, size))
>       | 
> arch/x86/events/amd/ibs.c:1291:44: error: ‘access_ok’ undeclared (first use in this function)
>  1291 |             event->attr.exclude_kernel && !access_ok(data.addr)) {
>       |                                            ^~~~~~~~~
> arch/x86/events/amd/ibs.c:1291:44: note: each undeclared identifier is reported only once for each function it appears in
> make[5]: *** [scripts/Makefile.build:207: arch/x86/events/amd/ibs.o] Error 1
> make[4]: *** [scripts/Makefile.build:465: arch/x86/events/amd] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:465: arch/x86/events] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:465: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/6th/linux/Makefile:1997: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

