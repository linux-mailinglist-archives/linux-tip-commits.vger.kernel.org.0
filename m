Return-Path: <linux-tip-commits+bounces-7438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3794C77937
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 07:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 67691293D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411D314B74;
	Fri, 21 Nov 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovdBEuMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC51314A9F;
	Fri, 21 Nov 2025 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706367; cv=none; b=mFHOZ4gnXORN3sUHvhTZtukftDZy/4qlozG1CV502vbIlmMaXQ7h/77nCKVZ7jAtWJo7NTuCkpMuYn5vmejNWJ8aopyQfMRHqK90B1BIieQQbx4VYE0/3nyvgZtC5w/eZ9PMCpCImM9G4IHREAjJiVNfU5rIsjLHavyMi/s+Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706367; c=relaxed/simple;
	bh=c0uBimvPR+f8Bi9TPxSgkEGvTjeNcSS7HB65AFlQYFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOmagR/m/UvnAuxN3+c/xAfLNdmHmOMaGb9/cRIKM28vT36MRG7h/DTDi5zUZUHI+ySt7qcxAGzIPtZ+RppCwxzJfZH/nWLXg8fxRVSp/lSGlHX5vvOtsPTCbYHwMUt9kAuD3nsKykkYFI9DAAAi1mowPy+WqDwCO1TX6vlJ9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovdBEuMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DD7C4CEF1;
	Fri, 21 Nov 2025 06:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763706365;
	bh=c0uBimvPR+f8Bi9TPxSgkEGvTjeNcSS7HB65AFlQYFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovdBEuMkM1FFSUa415kt5bWubtoSgk5K4y3MJQfnStBav9QU2QNXCOL+gHSzdmhHE
	 1rmjQ4oc3nA4u5dQN8WnlDHKa9kbegxq6FPPr2o9YKlQ/7/jPfowazMAzRBEQAz8z0
	 9Izq6PnqLgvOXbd2bMpDCV2DXaVXFTZgkgFtL803lD4nKaFFxvbtbCmPi0NQ6hYohS
	 dGFj+hPbCf2imJRb4aDXTj/Ad6iemUt2qfHW/9UhrX2EhYdpD4B8nHL1XqTuRZts7Z
	 4FcvrN8HPdMoifbOBEMVMbtL2z3GRGMW01gJps8WF084RwC76Ym6kiLxVO6I9z/pQr
	 xTkdkP4et3uUg==
Date: Thu, 20 Nov 2025 23:26:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20251121062600.GA256626@ax162>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
 <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
 <20251118095432.GN3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118095432.GN3245006@noisy.programming.kicks-ass.net>

On Tue, Nov 18, 2025 at 10:54:32AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 17, 2025 at 10:55:07AM -0800, Tim Chen wrote:
> 
> > >          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
> > > -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > 
> > The second argument of atomic_try_cmpxchg_acquire is "int *old" while that of atomic_cmpxchg_acquire
> > is "int old". So the above check would result in NULL pointer access.  Probably have
> > to do something like the following to use atomic_try_cmpxchg_acquire()
> > 
> > 		int zero = 0;
> > 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
> > 		
> > Otherwise we should do atomic_cmpxchg_acquire() as below
> 
> Yes, and I'm all mightily miffed all the compilers accept 0 (which is
> int) for an 'int *' argument without so much as a warning :/

The C11 standard says in 6.3.2.3p3

  An integer constant expression with the value 0, or such an expression
  cast to type void *, is called a null pointer constant.

which seems to indicate to me that

  int *foo = 0;

and

  #define NULL (void *)0
  int *foo = NULL;

have to be treated the same way :/ I think that is a big part of the
motivation to bring nullptr into C in C23:

  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3042.htm

> Nathan, you looked into this a bit yesterday, afaict there is:
> 
>   -Wzero-as-null-pointer-constant
> 
> which is supposed to issue a warn here, but I can't get clang-22 to
> object :/ (GCC doesn't take that warning for C mode, only C++, perhaps
> that's the problem?).

Right, it appears to be the same case for clang, notice the comment in
diagnoseZeroToNullptrConversion():

  https://github.com/llvm/llvm-project/commit/d7ba86b6bf54740dd4007e65a927151cb9f510b4

That warning should probably be updated to work for C23 but that does
not really help us now because nullptr is not available in older
standards (and I think the support for C23 is only solid in really
recent compilers IIUC).

> Help?

Maybe we could have something like -Wnon-literal-null-conversion-strict
in clang that would behave like -Wnon-literal-null-conversion but warn
even in the literal zero conversion case (i.e., require a 'void *'
cast)... That does not really help GCC though since it does not warn on
any case of implicit conversion to NULL:

https://godbolt.org/z/M5WE5covz

Cheers,
Nathan

