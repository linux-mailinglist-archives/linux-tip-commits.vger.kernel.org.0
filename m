Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C3833F0CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCQNAX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 09:00:23 -0400
Received: from casper.infradead.org ([90.155.50.34]:34866 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCQNAB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OsgWaEcn4B2Y823RuGirB7smdrHD9ktZSszdfbNXaUg=; b=XA+1uUVnlgXcQjbmDjnaBuuEGR
        flhEq42UNEW4sYM0rYOZ7WUmbAL6XtRJyKNJ4Ucn/xgXOkZbK/Ik8+TnijKolPD6cX3QmHCiEViIC
        /s0XB2mCOKTk4twi9ZRWJ4wIDSPWkLjabmSpZsRrt/QP6Kwhspea/Z/Getkon820mAhQ4iBRmHnoA
        TgPzTzT39v/5TbC/63CYBmxDppHGJOOBvFwa2QRxdW4CkQRRUu0AZaatHVtc/HpXx8oN66setnybA
        cGoE5ZNf8vXBtevL9FDPulEq48QiBhvdOkmqpW9s5WDZT3DYgqSRNZUTAgKZcVoLf25YhkWjsUCn/
        txYZFmuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMVm5-001UL8-1g; Wed, 17 Mar 2021 12:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10F833050F0;
        Wed, 17 Mar 2021 13:59:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF79A2B4F1EB8; Wed, 17 Mar 2021 13:59:43 +0100 (CET)
Date:   Wed, 17 Mar 2021 13:59:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
Message-ID: <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 12:38:22PM -0000, tip-bot2 for Waiman Long wrote:
> The following commit has been merged into the locking/urgent branch of tip:
> 
> Commit-ID:     5de2055d31ea88fd9ae9709ac95c372a505a60fa
> Gitweb:        https://git.kernel.org/tip/5de2055d31ea88fd9ae9709ac95c372a505a60fa
> Author:        Waiman Long <longman@redhat.com>
> AuthorDate:    Tue, 16 Mar 2021 11:31:16 -04:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 17 Mar 2021 09:56:44 +01:00
> 
> locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling
> 
> The use_ww_ctx flag is passed to mutex_optimistic_spin(), but the
> function doesn't use it. The frequent use of the (use_ww_ctx && ww_ctx)
> combination is repetitive.
> 
> In fact, ww_ctx should not be used at all if !use_ww_ctx.  Simplify
> ww_mutex code by dropping use_ww_ctx from mutex_optimistic_spin() an
> clear ww_ctx if !use_ww_ctx. In this way, we can replace (use_ww_ctx &&
> ww_ctx) by just (ww_ctx).

The reason this code was like this is because GCC could constant
propagage use_ww_ctx but could not do the same for ww_ctx (since that's
external).

Please double check generated code to make sure you've not introduced a
bunch of extra branches.
