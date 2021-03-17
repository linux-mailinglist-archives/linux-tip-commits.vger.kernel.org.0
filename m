Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9933F269
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCQORW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhCQORM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 10:17:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE34C06174A;
        Wed, 17 Mar 2021 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ySJwnXmmut2FRkHGqONP6uMpr1gdDk9gWPXbqHdMFeU=; b=D1eg6Xkib9+0luGkFQ1ugveZHi
        V2Qf5V4mqRzFbPfGpGS3ZidSxjMdx8OjvGUydu5qiQO8fnkd1HqGHvRrdspQn1Dh4DbWmdw6cqvP2
        O9mp4l5rASAfA8WUrxNgmPt6pnELvPvSN7iSRDJntAmDAUcPXzFPC4jf3y1Nonw7FKJx7kkpTubDg
        4qpu5vEKZ17hidVmN1eeZeUQ84FtPd9kCPVK0v3EBJDcdluqekdXAZv/bQOPeVsrZbIwsTg+5QJns
        ZSYZJzg/FSA9LZGH0v2q7kWA4MC7W5zL7cJ36NYia+3j8Et2SkYj2OPmkUU94V6LtjtCDKetCJLo1
        cRiOJzDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMWyx-003EiT-Pz; Wed, 17 Mar 2021 14:17:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E87103050F0;
        Wed, 17 Mar 2021 15:17:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D05B42078107C; Wed, 17 Mar 2021 15:17:06 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:17:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Simplify use_ww_ctx &
 ww_ctx handling
Message-ID: <YFIPYmFE7ChGrpf2@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-2-longman@redhat.com>
 <161598470257.398.5006518584847290113.tip-bot2@tip-bot2>
 <YFH9Pw3kwCZC1UTB@hirez.programming.kicks-ass.net>
 <85fbce04-c544-6041-6e7d-76f47b90e263@redhat.com>
 <YFIKWCUAZabBsji0@hirez.programming.kicks-ass.net>
 <bbfca577-b680-4c73-3f35-22179bd1a498@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfca577-b680-4c73-3f35-22179bd1a498@redhat.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 10:10:16AM -0400, Waiman Long wrote:
> On 3/17/21 9:55 AM, Peter Zijlstra wrote:
> > On Wed, Mar 17, 2021 at 09:43:20AM -0400, Waiman Long wrote:
> > 
> > > Using gcc 8.4.1, the generated __mutex_lock function has the same size (with
> > > last instruction at offset +5179) with or without this patch. Well, you can
> > > say that this patch is an no-op wrt generated code.
> > OK, then GCC has gotten better. Because back then I tried really hard
> > but it wouldn't remove the if (ww_ctx) branches unless I had that extra
> > const bool argument.
> > 
> I think ww_mutex was merged in 2013. That is almost 8 years ago. It could
> still be the case that older gcc compilers may not generate the right code.
> I will try the RHEL7 gcc compiler (4.8.5) to see how it fares.

I really don't care about code generation qualitee of anything before
8-ish at this point. That's already an old compiler.

If you run on ancient compilers, you simply don't care about code
quality.
