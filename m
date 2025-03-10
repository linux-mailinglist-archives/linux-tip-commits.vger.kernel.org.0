Return-Path: <linux-tip-commits+bounces-4099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7941A58EA8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF6A3A53BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B91A724C;
	Mon, 10 Mar 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qY1eII80"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB9380;
	Mon, 10 Mar 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596944; cv=none; b=COq0PKzoCnwBThABMElXfBbKLttnp9ca6tUmNTb0rCfLmolN0QhhcRsXliZS8WHUXtF+PY14fYQlbHQUfizXyRfoPyignbzmJzVkbMGl5usCrEs6HDzRY6VaKL7XX5Nzlu0ZvmfJsO0hSZuGykQovhNcF+MZZhwofix0LzU2eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596944; c=relaxed/simple;
	bh=yHvsB5ALBqO6HcLi9r38BJv6YSoU1qYhhIzz3JKUdcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpseceWbJu62WYZSeEQgkPgZjtKYYA2Dy8Ukat3JahOHQmrH66L9iGyPiZuipYDnr0kkcMQT0RJZpY1HEvevd2xAC1UxrfVSs3lH+OHYZiddRobn/+i7yqEN0duBDpp/BUSr1dTf6G8RwWHtVNXYrKX6NkgszVSJdCni8y0TpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qY1eII80; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y6ewIZM2dtnWRQcBfslu1okDKdEcc8mCLFTRLy3nMdY=; b=qY1eII80wtVqZhUqGvphOqBc6p
	/Jc/c2Qop8wc3+/ZOOpcICg5f9hfwLEigNpRZIuPPgKCdXlJpQDdko+7npdFpw195J3r8FNnY+Ige
	gKdoDuBlowUr+76i3AxH3r3JCj9+5YznP6kmMGqzr7VBY3MMvByJZytnp3FY9G3MPuwOUj8g/vk+K
	b6pkv+WIYphhe8aR9OKtrofYhshhS/XzIv7YqeES9uv7RgZoQf2zeLgDao+NBHsSQPzfb2Xtj5RvX
	xnFXcfSi8zwQy0SC6gyBU2+p25yfevV+tZSJsOrmUvdAD05WOkioZg6rLZfhPcTCYce5tp4GUojBP
	vn+QbTUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trYvA-00000002l58-1k5G;
	Mon, 10 Mar 2025 08:55:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DDB143006C0; Mon, 10 Mar 2025 09:55:35 +0100 (CET)
Date: Mon, 10 Mar 2025 09:55:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, ojeda@kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Scott Constable <scott.d.constable@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	x86@kernel.org
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250310085535.GQ31462@noisy.programming.kicks-ass.net>
References: <20250224124200.820402212@infradead.org>
 <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226195308.GA29387@noisy.programming.kicks-ass.net>


Ping -- anything I can do the help?

On Wed, Feb 26, 2025 at 08:53:08PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra wrote:
> 
> > diff --git a/Makefile b/Makefile
> > index 96407c1..f19431f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1014,6 +1014,9 @@ CC_FLAGS_CFI	:= -fsanitize=kcfi
> >  ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
> >  	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
> >  endif
> > +ifdef CONFIG_FINEIBT_BHI
> > +	CC_FLAGS_CFI	+= -fsanitize-kcfi-arity
> > +endif
> >  ifdef CONFIG_RUST
> >  	# Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST selects
> >  	# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c4175f4..5c27726 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2473,6 +2473,10 @@ config CC_HAS_RETURN_THUNK
> >  config CC_HAS_ENTRY_PADDING
> >  	def_bool $(cc-option,-fpatchable-function-entry=16,16)
> >  
> > +config CC_HAS_KCFI_ARITY
> > +	def_bool $(cc-option,-fsanitize=kcfi -fsanitize-kcfi-arity)
> > +	depends on CC_IS_CLANG && !RUST
> > +
> 
> Miguel, can we work on fixing that !RUST dep?
> 
> >  config FUNCTION_PADDING_CFI
> >  	int
> >  	default 59 if FUNCTION_ALIGNMENT_64B
> > @@ -2498,6 +2502,10 @@ config FINEIBT
> >  	depends on X86_KERNEL_IBT && CFI_CLANG && MITIGATION_RETPOLINE
> >  	select CALL_PADDING
> >  
> > +config FINEIBT_BHI
> > +	def_bool y
> > +	depends on FINEIBT && CC_HAS_KCFI_ARITY
> > +
> >  config HAVE_CALL_THUNKS
> >  	def_bool y
> >  	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL

