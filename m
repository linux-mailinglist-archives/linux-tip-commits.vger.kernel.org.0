Return-Path: <linux-tip-commits+bounces-4244-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFCA64941
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28D9173228
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2C226D16;
	Mon, 17 Mar 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLVGiqTz"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF123314C;
	Mon, 17 Mar 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206509; cv=none; b=mIsplYNFTlVXBRa2gt4c+LYW2MHIm4NVQJeTDOg6swZiVEqbvOm4QJ+EMfHrKtJQmOR8qbP2orImh9rxmyWqJpWJwgTTPHNQ+y4XORzXGVwimFS6rnm4WUnx8ri1W8rI9wqpxkOcGqmSM8tHXpQEHl4n3l5CelNT5VjUd1OLI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206509; c=relaxed/simple;
	bh=n5LhFU+YcX3bAX7sgQ2s3sUFXvzJJrWqs184HxNL3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdBB5V1DzkQMNbv0NxCMuZN+E4RM0O2DdlTPaqz81eqX0C9YfA8Is/213ovQ7IfHgWgXkInylyqMngsHYqAPq2yBAZNzIx5cuz/sOEKfv/Mv1ejkE6hFntd8qq4SDJ96HCu7pytzvumkLAtgm7vDBXCn41+DlifA+OyKd9DZ4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aLVGiqTz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zeww+8QuNj0jixKn798iJsLySUWHlgG2Ok7itDbaQOA=; b=aLVGiqTzNMlNSFx9F4sKZ07K3S
	LELgeZkQuAdgIVYhpE9Vyz5t91GSXRaPdjJO9fl/PxvvdxTrgMs4bCI2pHSXvqcaKYJGy6CypO0jn
	DuuVgqoBKqdJE5wN/wDsGD8p2MFBKSeC3WWlqzXgUz/90Ea8f8OX+yXqdkeby5zY1JXhPLePlR2ul
	viqo23YF08xvFhlzJx3LJ4zRYJ6A4aIv1vgqOnCYFdvEsuoPWsEX94+3WxHKoA2IoxFdIL5P/R2AX
	NUlPq57twSmTMduV+xmgcx18HRIUgdL2j0XASErZzUM8kWrOl+xdlZt+EvlXZ/yCI4d5nvQ8XJ+Pd
	uC/ES09Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7Uv-00000003Q9M-0x4t;
	Mon, 17 Mar 2025 10:15:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A09EB300783; Mon, 17 Mar 2025 11:15:04 +0100 (CET)
Date: Mon, 17 Mar 2025 11:15:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Matteo Rizzo <matteorizzo@google.com>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86: Check data address for IBS software
 filter
Message-ID: <20250317101504.GB34541@noisy.programming.kicks-ass.net>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>

On Mon, Mar 17, 2025 at 09:15:05AM -0000, tip-bot2 for Namhyung Kim wrote:
> The following commit has been merged into the perf/urgent branch of tip:
> 
> Commit-ID:     b0be17d8108bf3448a58be319d085155a128cf3a
> Gitweb:        https://git.kernel.org/tip/b0be17d8108bf3448a58be319d085155a128cf3a
> Author:        Namhyung Kim <namhyung@kernel.org>
> AuthorDate:    Mon, 17 Mar 2025 01:10:58 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 17 Mar 2025 10:04:31 +01:00
> 
> perf/x86: Check data address for IBS software filter
> 
> The IBS software filter is filtering kernel samples for regular users in
> PMI handler.  It checks the instruction address in the IBS register to
> determine if it was in the kernel mode or not.
> 
> But it turns out that it's possible to report a kernel data address even
> if the instruction address belongs to the user space.  Matteo Rizzo
> found that when an instruction raises an exception, IBS can report some
> kernel data address like IDT while holding the faulting instruction's
> RIP.  To prevent an information leak, it should double check if the data
> address in PERF_SAMPLE_DATA is in the kernel space as well.
> 
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20250317081058.1794729-1-namhyung@kernel.org
> ---
>  arch/x86/events/amd/ibs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e7a8b87..24985c7 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1147,6 +1147,13 @@ fail:
>  	if (perf_ibs == &perf_ibs_op)
>  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
>  
> +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> +	    event->attr.exclude_kernel && !access_ok(data.addr)) {

If only you'd looked at all the other filter code :/ everybody uses
kernel_ip() helper for this, not access_ok().

> +		throttle = perf_event_account_interrupt(event);
> +		goto out;
> +	}
> +
>  	/*
>  	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
>  	 * recorded as part of interrupt regs. Thus we need to use rip from

