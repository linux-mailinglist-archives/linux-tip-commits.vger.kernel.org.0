Return-Path: <linux-tip-commits+bounces-3690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FEFA46B6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBB81889458
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 19:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40C82561D6;
	Wed, 26 Feb 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXJRKTPi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477F21B192;
	Wed, 26 Feb 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599594; cv=none; b=ZmYfuv5pdrqpObckd38ccaclIoeBRzG37uSRnNYqe3+u+byjsYGNtqnD+1znldgUpxchB4LUAi7OPWw4zpmZ0ElFIXg2iTKbT0jB/GUIef4CLuZm3KWyOhObgmAMMI99ytIPBgPOfth3C3V3aFGySSP7bbXZah7g8hfJpVqxSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599594; c=relaxed/simple;
	bh=fjNznI7ikazb+EF1sd1I6lh/W9iPJGpYuHhscRMec2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTZtHqx73c2MSAdeAAQOZZI5cHO0qYXF1um1PfdJWDZsabs887ax9xuqLGfW5tjx+BjfS6cc/u+JzUc3TP0iovJI+6IDzCQY34vPYsy+GEOQpPffsfVF6qfy1p8E8NnnZu1t1QZwitg6fwv1mrREouPv6nzmqNKhP2xIiph1ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SXJRKTPi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MlkY8E0ykQtOxNBdGL5vBmEs1N89TyYPAy0burVU63Q=; b=SXJRKTPiEJ027l6aVtdu+lAnI4
	FeLsNtnlOuNu2NEi6znmO0LfJ/Qm03UzoSCm4X8W3LrHGyZLh7pvZZBFsjNtxsgaza3TqKpDT47Ve
	RLbEIS9mHjq/TUSVpH391OyiQlLtcHewUzN31uTWoJkbXYxv6eHO6v1WcYOo9AmTeU5dzIsOb6Goi
	xr/qG0u8Rd0dOy7cVsJBV9vniAkafjsYwRQLqDMroXvbMR0uVezmRpcEOREW8LiUJtKPiBf0bexfn
	Tsq4Yjq3pOcB9qNFTmLSrmbxwamRKTEEONLQ94kjV7n9Grvc0At8EA+PQEhsTwtCNn4HMXSfTajbE
	a6aqYnmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNSv-00000003gF0-2k1g;
	Wed, 26 Feb 2025 19:53:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2EA530072F; Wed, 26 Feb 2025 20:53:08 +0100 (CET)
Date: Wed, 26 Feb 2025 20:53:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org, ojeda@kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Scott Constable <scott.d.constable@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	x86@kernel.org
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250226195308.GA29387@noisy.programming.kicks-ass.net>
References: <20250224124200.820402212@infradead.org>
 <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>

On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra wrote:

> diff --git a/Makefile b/Makefile
> index 96407c1..f19431f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1014,6 +1014,9 @@ CC_FLAGS_CFI	:= -fsanitize=kcfi
>  ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
>  	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
>  endif
> +ifdef CONFIG_FINEIBT_BHI
> +	CC_FLAGS_CFI	+= -fsanitize-kcfi-arity
> +endif
>  ifdef CONFIG_RUST
>  	# Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST selects
>  	# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c4175f4..5c27726 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2473,6 +2473,10 @@ config CC_HAS_RETURN_THUNK
>  config CC_HAS_ENTRY_PADDING
>  	def_bool $(cc-option,-fpatchable-function-entry=16,16)
>  
> +config CC_HAS_KCFI_ARITY
> +	def_bool $(cc-option,-fsanitize=kcfi -fsanitize-kcfi-arity)
> +	depends on CC_IS_CLANG && !RUST
> +

Miguel, can we work on fixing that !RUST dep?

>  config FUNCTION_PADDING_CFI
>  	int
>  	default 59 if FUNCTION_ALIGNMENT_64B
> @@ -2498,6 +2502,10 @@ config FINEIBT
>  	depends on X86_KERNEL_IBT && CFI_CLANG && MITIGATION_RETPOLINE
>  	select CALL_PADDING
>  
> +config FINEIBT_BHI
> +	def_bool y
> +	depends on FINEIBT && CC_HAS_KCFI_ARITY
> +
>  config HAVE_CALL_THUNKS
>  	def_bool y
>  	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL

