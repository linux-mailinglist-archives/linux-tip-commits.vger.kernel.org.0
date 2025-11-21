Return-Path: <linux-tip-commits+bounces-7439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F007C78086
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 150902D31C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742B33EAE7;
	Fri, 21 Nov 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Azb6RKXL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850F33B6CF;
	Fri, 21 Nov 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715671; cv=none; b=mfJbwXhgfaIEcrc9p20XgwylQ9168mmcrmGQ2aefF4PsJ8GPYF5yt6mBUG3kdfMQTgAO/UsoplYX9IRuGngejc+g9eBkvPVuPPIW++RnlAmXkFz1OB2lljOJLqi6gsRjBy4QzKixk/d3TbrgMdBOf2wQ3KhcoFEe/KTh2MG9ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715671; c=relaxed/simple;
	bh=y77EWLmtpblnWci1pN2ptg23iz+DSPyvotZd0RAvLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdBFlIvxZnIoD21U8lt9f2msAwt63kJ193QQ8rYECUzI+6rDtDxdk9NjxLSTQluCzOHBeMgOmG/vMxCymXw/tcch7eYCfIJ5NVC2Ve1JkcqiY6Hx2GSMAqgVqHIYUyGWkqui7MMYll1aEf09J55iZ3lhJLWICSLBdP3LwM7k4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Azb6RKXL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uhX4mxqPgQtdgdYQeOTPuwaL3EkS/dExII4h40JIx4o=; b=Azb6RKXLPoAeYB8xnVJnFsj4vQ
	Fn8c/+EOxLxm0gbQ5O5YEcQKP2tVyr1VhwKTj728jOw27N+mapdy0g3W9n3/FzIq87GcxLivm6ydM
	Qkc03Y6cp0Gn4LnGcr1t8QKrD+coq/rKjcTtm3QpUlm4QkyKu4T/fn/c9NiTVY+RP6QDj/hhEEADU
	bM3Nb1Q9U7xTN8ypOCK17GrpVm/jynQZfvnR7LRRJpBv4MMQLQEKwIW5eYpcODPtiSimEYmR32hJ4
	2quhVv3uPCIarUz/pGr0PXoj0wkkNuYAgi69sCA3qCPAWICwP2IiTUH7KK62fDR5Tb1XCZuogfG2N
	zx8IVByA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMM9A-0000000GMTi-0GEx;
	Fri, 21 Nov 2025 08:05:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30DE0300342; Fri, 21 Nov 2025 10:00:59 +0100 (CET)
Date: Fri, 21 Nov 2025 10:00:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251121090059.GK4067720@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
 <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
 <20251118095432.GN3245006@noisy.programming.kicks-ass.net>
 <20251121062600.GA256626@ax162>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121062600.GA256626@ax162>

On Thu, Nov 20, 2025 at 11:26:00PM -0700, Nathan Chancellor wrote:
> On Tue, Nov 18, 2025 at 10:54:32AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 17, 2025 at 10:55:07AM -0800, Tim Chen wrote:
> > 
> > > >          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
> > > > -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > > 
> > > The second argument of atomic_try_cmpxchg_acquire is "int *old" while that of atomic_cmpxchg_acquire
> > > is "int old". So the above check would result in NULL pointer access.  Probably have
> > > to do something like the following to use atomic_try_cmpxchg_acquire()
> > > 
> > > 		int zero = 0;
> > > 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
> > > 		
> > > Otherwise we should do atomic_cmpxchg_acquire() as below
> > 
> > Yes, and I'm all mightily miffed all the compilers accept 0 (which is
> > int) for an 'int *' argument without so much as a warning :/
> 
> The C11 standard says in 6.3.2.3p3
> 
>   An integer constant expression with the value 0, or such an expression
>   cast to type void *, is called a null pointer constant.

That's just bloody ludicrous :-(, I mean, the explicit cast to void*
sure, but the implicit conversion is just idiotic. I realize there's
legacy here, but urgh.

> which seems to indicate to me that
> 
>   int *foo = 0;
> 
> and
> 
>   #define NULL (void *)0
>   int *foo = NULL;
> 
> have to be treated the same way :/ I think that is a big part of the
> motivation to bring nullptr into C in C23:
> 
>   https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3042.htm

Even without that, just dropping the implicit conversion is a giant step
forward.

> > Nathan, you looked into this a bit yesterday, afaict there is:
> > 
> >   -Wzero-as-null-pointer-constant
> > 
> > which is supposed to issue a warn here, but I can't get clang-22 to
> > object :/ (GCC doesn't take that warning for C mode, only C++, perhaps
> > that's the problem?).
> 
> Right, it appears to be the same case for clang, notice the comment in
> diagnoseZeroToNullptrConversion():
> 
>   https://github.com/llvm/llvm-project/commit/d7ba86b6bf54740dd4007e65a927151cb9f510b4
> 
> That warning should probably be updated to work for C23 but that does
> not really help us now because nullptr is not available in older
> standards (and I think the support for C23 is only solid in really
> recent compilers IIUC).

So personally I really don't see a problem with '(void *)0', what if
anything does nullptr actually bring over that?

> > Help?
> 
> Maybe we could have something like -Wnon-literal-null-conversion-strict
> in clang that would behave like -Wnon-literal-null-conversion but warn
> even in the literal zero conversion case (i.e., require a 'void *'
> cast)... That does not really help GCC though since it does not warn on
> any case of implicit conversion to NULL:

Yes, that makes sense. Perhaps we can even convince GCC folks to also
implement this ;-)

Just having it in clang would mean clangd will have the warning and thus
all the LSP enabled editors will provide the warn, which is a win.

