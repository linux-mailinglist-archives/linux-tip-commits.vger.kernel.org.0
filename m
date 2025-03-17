Return-Path: <linux-tip-commits+bounces-4291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA350A65701
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 17:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE5F7AC499
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E215CD55;
	Mon, 17 Mar 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxgHr6u3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620C149E17;
	Mon, 17 Mar 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227263; cv=none; b=EzmT2UHpoB2Wqr7AeGpLset9PqJ+Y8vKFD/Jus2jAyknAJO62CD7EEZ7/kBdzVrZmun1IRF2TsLnXyQtIw23/ML/g92HcsXGJ5mDCP9DGiL8QR4C8WBv1QzeeMBNSBv2PPkfdsfAsapZBr1dB6yeYLAUGj7AFBjo3xb2pNUciFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227263; c=relaxed/simple;
	bh=sQONLY3EvvXe/kR6sXDFs5LjOhiIS3Jxz4mhJSCwegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdXsakEniJSPLSX0/2BzzVxLECecQverjz2Tc+w4lOs/6HSRZQwPgdMcl6ua4yHJzyD8J87rt+uqlDJpWyEC2FB7fOhC+Mdho2EpZsdIEq4DzYuwYuBYBzW3+GItTtJ7mEhuYuVAxpf4gFAM2WrnTYGvIcvb8y/MAGa23atmhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxgHr6u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EB0C4CEE3;
	Mon, 17 Mar 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227263;
	bh=sQONLY3EvvXe/kR6sXDFs5LjOhiIS3Jxz4mhJSCwegg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxgHr6u3MFKq8HA9gdvjI50exZGENaHPgU6j3kYvM9J1dWxQaMGq5by/xXPLQgFYt
	 ISrk03QXtpaO5tyEKYyoSPyGhiJLnJLqWA/KlTS0N0Xs/2FlEroYw4A+VGTKHrPcJ7
	 87ln8WTTPBix6rZms5xFu2+G8L/TABIBJLMSdnKbT5ColCdRDmf1kaPSbNYBNBB5TB
	 OBcAyQuQ8ZSyX/kRWmMq+v0ceTVcty24+9nmmxQ65nFhhNmj2P/HFqvKzkfQsP4AcV
	 Vyba0RVliRfRsJl36aliEsthI3ZJ0JkNwe57Mck70PW7hlTxR+3RA9bK1IGoSZT5LP
	 jRdGWwgPL+OOA==
Date: Mon, 17 Mar 2025 09:01:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Matteo Rizzo <matteorizzo@google.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86: Check data address for IBS software
 filter
Message-ID: <Z9hHPA5MwrIDtJFm@google.com>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
 <20250317101504.GB34541@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317101504.GB34541@noisy.programming.kicks-ass.net>

Hi Peter,

On Mon, Mar 17, 2025 at 11:15:04AM +0100, Peter Zijlstra wrote:
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
> 
> If only you'd looked at all the other filter code :/ everybody uses
> kernel_ip() helper for this, not access_ok().

I thought it also needs __KERNEL_CS but now I see it only checks the
address.  Will change in v2.

Thanks,
Namhyung


> 
> > +		throttle = perf_event_account_interrupt(event);
> > +		goto out;
> > +	}
> > +
> >  	/*
> >  	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
> >  	 * recorded as part of interrupt regs. Thus we need to use rip from

