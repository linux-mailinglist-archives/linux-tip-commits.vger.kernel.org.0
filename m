Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF62BAA54
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKTMlX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKTMlW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:41:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F40C0613CF;
        Fri, 20 Nov 2020 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0W1qIKamdIi1WLhOTedot2TAOmMGy/szb5xPJbQDGhY=; b=d0IhNCASZr1XkFVXcG67Wn6Vok
        5XliI+Ppobnq0CE/JhPQSmoSX9o79IJHV6MLKJa6sg81py8BJk7b88AUhukRmdYaoS6kDBUfzHy0v
        ijmcf6pSHn8sjdGCALoTpNGLMYTUaNlWgYPgq8v5CggmPcT8AqpbG6d7uuCYWVhdDSuxn0GstP1U3
        uZMxfwkMoyc2wKrVrP3AasRC0EREJa5NgOpeUgdi1fMu5OhtMJwUg5Xw4gr59E8bgE2u91yIfBQEa
        P25X9473Mncgen8omogLoIi58K7TdGQFRYFzo5vg683kgjYlVjI7cgP5dSP/JdP91JvjVtHKT+mJl
        k4gUNDLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg5j4-0000FM-VZ; Fri, 20 Nov 2020 12:41:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 576AD3011C6;
        Fri, 20 Nov 2020 13:41:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4377320250969; Fri, 20 Nov 2020 13:41:18 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:41:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>, x86@kernel.org
Subject: Re: [tip: core/core] ilog2 vs. GCC inlining heuristics
Message-ID: <20201120124118.GI3021@hirez.programming.kicks-ass.net>
References: <20201021132718.GB2176@tucnak>
 <160587563846.11244.17275939588139394513.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160587563846.11244.17275939588139394513.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


Sorry, I typoed the branch name. I'll make this branch go away.

Anyway, Jacub, your patch seems to not upset the robots, so I'll go post
it properly for you.

On Fri, Nov 20, 2020 at 12:33:58PM -0000, tip-bot2 for Jakub Jelinek wrote:
> The following commit has been merged into the core/core branch of tip:
> 
> Commit-ID:     ecbd43f6728a5cf79c8b50ed326658e9181531b1
> Gitweb:        https://git.kernel.org/tip/ecbd43f6728a5cf79c8b50ed326658e9181531b1
> Author:        Jakub Jelinek <jakub@redhat.com>
> AuthorDate:    Wed, 21 Oct 2020 15:27:18 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 19 Nov 2020 11:26:18 +01:00
> 
> ilog2 vs. GCC inlining heuristics
> 
> Hi!
> 
> Based on the GCC PR97445 discussions, I'd like to propose following change,
> which should significantly decrease the amount of code in inline functions
> that use ilog2, but as I'm already two decades out of the Linux kernel
> development, I'd appreciate if some kernel developer could try that (all
> I have done is check that it gives the same results as before) and if it
> works submit it for inclusion into the kernel?
> 
> Thanks.
> 
> Improve ilog2 for constant arguments
> 
> As discussed in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97445
> the const_ilog2 macro generates a lot of code which interferes badly
> with GCC inlining heuristics, until it can be proven that the ilog2
> argument can or can't be simplified into a constant.
> 
> It can be expressed using __builtin_clzll builtin which is supported
> by GCC 3.4 and later and when used only in the __builtin_constant_p guarded
> code it ought to always fold back to a constant.
> Other compilers support the same builtin for many years too.
> 
> Other option would be to change the const_ilog2 macro, though as the
> description says it is meant to be used also in C constant expressions,
> and while GCC will fold it to constant with constant argument even in
> those, perhaps it is better to avoid using extensions in that case.
> 
> Signed-off-by: Jakub Jelinek <jakub@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20201021132718.GB2176@tucnak
> ---
>  include/linux/log2.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index c619ec6..4307d34 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -156,7 +156,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  #define ilog2(n) \
>  ( \
>  	__builtin_constant_p(n) ?	\
> -	const_ilog2(n) :		\
> +	((n) < 2 ? 0 :			\
> +	 63 - __builtin_clzll (n)) :	\
>  	(sizeof(n) <= 4) ?		\
>  	__ilog2_u32(n) :		\
>  	__ilog2_u64(n)			\
