Return-Path: <linux-tip-commits+bounces-7386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F9C68A98
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 10:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 213ED2A7AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6B320CA2;
	Tue, 18 Nov 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjU5xisd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414C328B66;
	Tue, 18 Nov 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459775; cv=none; b=CtOOV4TQnVNp86kV529nbMYklUrEjm80wNF6R5Dl4CgjPnsyDA6TbL7jACrXnG0Geis2htNE5J+5pzQsHrXUfr+IqchmNGcge54dYfBabMh3uribDu8G4H4+YC/GacFiANhZTEPjldcW5a6++/qBU5fFsPtuyX9EsftpF2HqUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459775; c=relaxed/simple;
	bh=0HP2onGt8R3t+Jj61+t+NfIIn7iZgxXMHT/yGHGQaXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6PrdUAsGmZt/6TPYNMMS+SIU1byg5TajbL9U5QWYevRL0BYfbrEXOsbGazgwdgDTXIVliwC48ojywOM+0nV5T6FYGlEWoNmtvvNmye/5OJM8neb7WTtUKmNC7xzOcOKZ4GeNs5olKtASeg2DvRizf2fKx/jYFE/SjTkt5A19vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kjU5xisd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tN95rbT3Ge6tjj0OSWEOP/G2b8NMLg2iv+amDfX2xPU=; b=kjU5xisdLyJb8snURPO0eFzb/+
	XAseo0Hm1clArSxEfDVzKdW6kwJsIMM0He78TtwKkAmmaTJW9p5frb++8MXAEwyHjquunZLSfmRfY
	867o+g3a5Crwk2IIYphW1voYvLoAQB6MZQYLvDGXl8HJdMZzx6FGe+ewEy/2jQRs5xnYzBwxb821G
	9vS2G2sWE5hVE42RGIG+1uEQXvN0sWG/t3NjmpvEC7F1+ugec5PUagowBYuPLV2xfYEtfd7qIRbd8
	ibvbyZEEESJsYxnCJza98ys3ut6RnTYyrdjP9NeBwHUKvxP0DaXIC+13pfdLXBb8/xZJ6OeBEQ6Q3
	1dFYMD+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLIRT-0000000FI4i-01Yy;
	Tue, 18 Nov 2025 09:56:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90E2F300342; Tue, 18 Nov 2025 10:56:06 +0100 (CET)
Date: Tue, 18 Nov 2025 10:56:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>, nathan@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <20251118095606.GH4068168@noisy.programming.kicks-ass.net>
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


And now with Nathan as a recipient..

On Tue, Nov 18, 2025 at 10:54:33AM +0100, Peter Zijlstra wrote:
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
> 
> Nathan, you looked into this a bit yesterday, afaict there is:
> 
>   -Wzero-as-null-pointer-constant
> 
> which is supposed to issue a warn here, but I can't get clang-22 to
> object :/ (GCC doesn't take that warning for C mode, only C++, perhaps
> that's the problem?).
> 
> And then there is modernize-use-nullptr, but that objects to using NULL,
> although I suppose we could do:
> 
>   #define NULL nullptr
> 
> to get around that. Except I also cannot get clangd to report on the
> issue.
> 
> Help?

