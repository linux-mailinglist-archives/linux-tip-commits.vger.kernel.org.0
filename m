Return-Path: <linux-tip-commits+bounces-7385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6FC68A89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 10:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89D04EB5D3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927383019DA;
	Tue, 18 Nov 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ijBAdpNw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3748268C42;
	Tue, 18 Nov 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459683; cv=none; b=KN28w60jxAGoKnP4dO4QI2P+hIBooCXS1ccKDTE+PjnvdYC/tD3XBeIJjnef0t+Q/p5zsiEVq/rUQmsN4F34/B+Qco03hfgmXtAaLXcyKi8ys/XWT+92Xl9PXf5b6FwuRxNRUNYCh5XFgA3O6anHP0ZSrwzJIJOnB4Uc3e+Hctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459683; c=relaxed/simple;
	bh=6BqNpCtrC9S3CNsuOtYZ2axLtp5IDP6Ke7okkjO/7lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAogmn9BMcxDoqcWnPIBRVmWGytk6+qM99iO6rE0MFlPJ/F0GZrGBHoJQozms3ucnCsvrDeFWlKvN/oqf20+bvFnF10NN5BBHAHhmhCSZXpw7+dzMSk1e/sXL5131Uv+CrBHY6kc4PXfry81LWrirqtmsETvrr5S2YJZFtF4P3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ijBAdpNw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QUqeXzYToalxWsd90ZNuCoYV8VI1QtWGl17pYs5H1Rw=; b=ijBAdpNwUz2rfp3hYuJvftE+ow
	+FOeu/8yDEPJK6js+JpOdF0TB5Kn0mFeh81trqrT/v0IcomPaCOQ8PszwJatSPr/x5tJW4QocwXtZ
	K60qCxXhZWDCFSvycw6e4NoZkYuckigojo4BV4750OsNBtg/e0zqixXinvtRhVZsJiQkRviF5TV80
	4SqcOfrUojI4TONHXo7G6yrmj/1n9u26LxqTr3ZvRaGWnz2dQ+pHGoTgjbDBkHFRgo1cjNny8+V4r
	nTFfWOcCqci28QbBqMuqEKL7d4xsc+bm82XuJEduoB+2/vwcpLEF13XTCawpHM+Ke+ZqizrFvDvaY
	i8xwTvhA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLIPy-0000000FHpE-0iRp;
	Tue, 18 Nov 2025 09:54:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0755430029E; Tue, 18 Nov 2025 10:54:33 +0100 (CET)
Date: Tue, 18 Nov 2025 10:54:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251118095432.GN3245006@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <176312274812.498.6548506845675120622.tip-bot2@tip-bot2>
 <dffe53a4-0ef2-4346-ad73-c4b71a734b3a@linux.ibm.com>
 <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceffc6f7870711d40f195191d298ca9bf1def022.camel@linux.intel.com>

On Mon, Nov 17, 2025 at 10:55:07AM -0800, Tim Chen wrote:

> >          if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
> > -               if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> 
> The second argument of atomic_try_cmpxchg_acquire is "int *old" while that of atomic_cmpxchg_acquire
> is "int old". So the above check would result in NULL pointer access.  Probably have
> to do something like the following to use atomic_try_cmpxchg_acquire()
> 
> 		int zero = 0;
> 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
> 		
> Otherwise we should do atomic_cmpxchg_acquire() as below

Yes, and I'm all mightily miffed all the compilers accept 0 (which is
int) for an 'int *' argument without so much as a warning :/

Nathan, you looked into this a bit yesterday, afaict there is:

  -Wzero-as-null-pointer-constant

which is supposed to issue a warn here, but I can't get clang-22 to
object :/ (GCC doesn't take that warning for C mode, only C++, perhaps
that's the problem?).

And then there is modernize-use-nullptr, but that objects to using NULL,
although I suppose we could do:

  #define NULL nullptr

to get around that. Except I also cannot get clangd to report on the
issue.

Help?

