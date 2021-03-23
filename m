Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C423458DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 08:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCWHiK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCWHhu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 03:37:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D54C061574;
        Tue, 23 Mar 2021 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=28zxBqK/DmKD7Fz/Yi3TtB21ftumoyYpSPGsW5HWTeM=; b=Ry23EI5FgyKRqUB3aF4Mkk3o7o
        hOq49wyX34oxJUwBOCSOgCYrHwGf6kTFNZl9VR7gqkAzAjzeM1pBU0H4g0MLqTWDq55vLhKkYNaKX
        O94clAC69gcftl+6F7nYPhmnu/IC41ShtiIwXuGoNhaI2PlU3/KmsjAVj1i4MWeSD5N/ldXXpXcMM
        vMSTjHkl45NA0++wvJJBLfPHS4IYr2cyr+qbCkrNC5B+nxSsqHYAMYjvkFPWge1EKQgEmhscD/sUX
        GXMhxVsDciWe9xIOvQ3c4sHEOvfDUQEFkiQE7pdIEyev86qmCCE5ds6pzrvTBoowDL8FKb90XKP0d
        Tl+V0+7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lObbZ-009jFZ-T3; Tue, 23 Mar 2021 07:37:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95FEF3010C8;
        Tue, 23 Mar 2021 08:37:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 884AC23601882; Tue, 23 Mar 2021 08:37:33 +0100 (CET)
Date:   Tue, 23 Mar 2021 08:37:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/core] static_call: Fix function type mismatch
Message-ID: <YFmavWCgUOOfibXR@hirez.programming.kicks-ass.net>
References: <20210322214309.730556-1-arnd@kernel.org>
 <161645580767.398.731817901273202970.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161645580767.398.731817901273202970.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Mar 22, 2021 at 11:30:07PM -0000, tip-bot2 for Arnd Bergmann wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
> Gitweb:        https://git.kernel.org/tip/335c73e7c8f7deb23537afbbbe4f8ab48bd5de52
> Author:        Arnd Bergmann <arnd@arndb.de>
> AuthorDate:    Mon, 22 Mar 2021 22:42:24 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 23 Mar 2021 00:08:53 +01:00
> 
> static_call: Fix function type mismatch
> 
> The __static_call_return0() function is declared to return a 'long',
> while it aliases a couple of functions that all return 'int'. When
> building with 'make W=1', gcc warns about this:
> 
>   kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
>    5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> 
> Change all these function to return 'long' as well, but remove the cast to
> ensure we get a warning if any of the types ever change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20210322214309.730556-1-arnd@kernel.org

So I strongly disagree and think the warning is bad and should be
disabled. I'll go uncommit this patch.
