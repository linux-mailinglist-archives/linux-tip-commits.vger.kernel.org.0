Return-Path: <linux-tip-commits+bounces-2875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF669D264C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85682B2FD20
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E091CC179;
	Tue, 19 Nov 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXCAbvdv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC41CCB4D;
	Tue, 19 Nov 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020880; cv=none; b=VLUv3BoQLhiZR91MFb30V31hBCUGzX/XubmoC7ho+HH9Q2Tb7C5K5Ltik5ee0p2GEU8MMMET5VcarhFg/Fa2dSONyV3GrqsXOkf1jFRhoDi0sQJIUrzgHPEOrCGgs0II1HIoPSHetSBQ219aWFW8mGbY2bRwXI9ZPEuuC5GFIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020880; c=relaxed/simple;
	bh=PeZmomn7GKlCTisY4AlendLscdky4s/5oljArNTFvgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH3R/6wXrWxuELNwtCUD6iT84gVo6gcmZiENw30EJZECbLXxMNkOLP1Y6ojvi10hjazCXp2PHgnt38zqCi7GKOz7mDAvT2eJm5yiO3LnwF/PEL5d2szVLuUpMNEaW/W6UMDqK2v/DwIJNrrolrQvhuO/LuEEsxd5usScuNsZPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NXCAbvdv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tAha+/Bcbs2mitGR4LOAeKfmhmbAlpxVnBjj1GeqvOs=; b=NXCAbvdve1L8j3pglFQ/c9n7Aa
	C61BbL/NfFGceDuC7D6hmQ9cc83aGt7gFRol25KyIgXYLSEyeVmL6CwY6PXAxErvifhakZidkWS1S
	u7+PX6TGHligbI59m7aYGl7i5pVNe/34dRLniaUgjLSc3Z+VWqyIC97eSqELWkOznr8hkix5d16ej
	kfW1+BFnDItI7vgRI91Z6Y4OXqGhi7YlGOsVf8HEv5kVzk1RQz6kLPYkAPSOjh7ArsEJxavovsaUH
	v1MlfAiIzDjm6RjQ+BkIPhYCoV7Q+twpJxx24fy04V1eirEFCIMk06NoeH/HhRoh4ARbVA3xH5LCg
	9/V5u1sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNkW-000000045GX-0G8Q;
	Tue, 19 Nov 2024 12:54:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D3D23006AB; Tue, 19 Nov 2024 13:54:32 +0100 (CET)
Date: Tue, 19 Nov 2024 13:54:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Rik van Riel <riel@surriel.com>,
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/mm/tlb: Update mm_cpumask lazily
Message-ID: <20241119125432.GF2328@noisy.programming.kicks-ass.net>
References: <20241114152723.1294686-2-riel@surriel.com>
 <173201565541.412.15037901822386376271.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173201565541.412.15037901822386376271.tip-bot2@tip-bot2>

On Tue, Nov 19, 2024 at 11:27:35AM -0000, tip-bot2 for Rik van Riel wrote:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d17518c..8b66a55 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1825,11 +1825,18 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>  	return temp_state;
>  }
>  
> +__ro_after_init struct mm_struct *poking_mm;
> +__ro_after_init unsigned long poking_addr;
> +
>  static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>  {
>  	lockdep_assert_irqs_disabled();
> +
>  	switch_mm_irqs_off(NULL, prev_state.mm, current);
>  
> +	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
> +	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(poking_mm));

Oh bugger, this is really unfortunate.

Let me try and fix this.


