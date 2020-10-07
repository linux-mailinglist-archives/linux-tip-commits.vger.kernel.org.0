Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8046286575
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgJGRKF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 13:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgJGRKE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 13:10:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DCBC061755;
        Wed,  7 Oct 2020 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EVTgrX30Sf2N0MDTPXtgxP49nGA0fxDU2gu5Ho0vIkY=; b=B1g4qsOSOqDYaNjtTtjKq622e+
        advRWgITx6SgThtKn4TcLOYMxPj2OBViZWilqAuuvPtqGUPJWH9pG9Y+R6a5BnpkQ8O9KhtMWL+Lt
        IncrdsPONYRCsjDRZCReDy6rX3ByiGQ4FA00Q6ZvL4E9QFRwT3oF9+nw84oKzny8MzoK3tdF7CK8a
        r/Pi85ilx2hRMPfEotzhkTmkyho/ZCJgrkyvpn6B0/KSBB28HxA3h51/VHS4bShr9UyKzggRSxb9N
        7+OjH94VKVz1YwXtsH6GPpAM/SGsJk0+wKSz9hLj4W7VgmVGs4OkarctBzxhk6ysaAwzDEPmGMK9n
        1py74zBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQCvc-0005r8-M3; Wed, 07 Oct 2020 17:08:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24572300B22;
        Wed,  7 Oct 2020 19:08:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1F4A2B067BCF; Wed,  7 Oct 2020 19:08:35 +0200 (CEST)
Date:   Wed, 7 Oct 2020 19:08:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Michael Matz <matz@suse.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/pasid] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20201007170835.GM2628@hirez.programming.kicks-ass.net>
References: <20201005151126.657029-2-dave.jiang@intel.com>
 <160208728972.7002.18130814269550766361.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160208728972.7002.18130814269550766361.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 07, 2020 at 04:14:49PM -0000, tip-bot2 for Dave Jiang wrote:
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 59a3e13..d4baa0e 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -234,6 +234,28 @@ static inline void clwb(volatile void *__p)
>  
>  #define nop() asm volatile ("nop")
>  
> +/* The dst parameter must be 64-bytes aligned */
> +static inline void movdir64b(void *dst, const void *src)
> +{
> +	const struct { char _[64]; } *__src = src;
> +	struct { char _[64]; } *__dst = dst;
> +
> +	/*
> +	 * MOVDIR64B %(rdx), rax.

(%rdx), %rax, surely? Also, that's a horrible convention, but I suppose
(%rdx), (%rax) was out?

> +	 *
> +	 * Both __src and __dst must be memory constraints in order to tell the
> +	 * compiler that no other memory accesses should be reordered around
> +	 * this one.
> +	 *
> +	 * Also, both must be supplied as lvalues because this tells
> +	 * the compiler what the object is (its size) the instruction accesses.
> +	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.

Can we pretty please get a binutils version that knows about this
instruction, such that we know when we can get rid of the silly .byte
encoded mess?

> +	 */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +		     : "+m" (*__dst)
> +		     :  "m" (*__src), "a" (__dst), "d" (__src));
> +}
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* _ASM_X86_SPECIAL_INSNS_H */
