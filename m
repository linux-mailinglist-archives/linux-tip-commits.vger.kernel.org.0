Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9533F603
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhCQQtP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCQQsx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 12:48:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E5C06174A;
        Wed, 17 Mar 2021 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aKYAUWxzHH2YQlBHn5zoUP40iw+Vp4x7ql39u69isK4=; b=B6k1onKLJXuCfb5eXGDkizM8ag
        08pdPqLLDuiwRP/dAtHLEQtLNlDRX1P/PvIpFJbzCCxEqLdblSjjMREgwR4VjccC6ZgyB6iBUON2F
        delEtbvN9dN0coN5QU44UIEKTPZPxq5VYp2s1/OcnKlNuA0pX3l5dwf+XwGN9CnR5hiF13jSgsmtm
        qJpOlC1Gn198Wo5P6RKmP9uByYV3dgn7oG04j8KamWR9n2yp3Loc+wDzRhF7YgnpSj3YavkMes2Df
        +IPJXhFBh9cC6fCOyguETgF3stcUYe64k5OOnRpN2gJPP7ZnMsurzLTVXI6fJPB0vSqcIDQc6J0Ao
        eeQQctRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZLl-003aJU-AA; Wed, 17 Mar 2021 16:48:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB68F301324;
        Wed, 17 Mar 2021 17:48:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0388203D90C4; Wed, 17 Mar 2021 17:48:48 +0100 (CET)
Date:   Wed, 17 Mar 2021 17:48:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
Message-ID: <YFIy8Bzj7WAHFmlG@hirez.programming.kicks-ass.net>
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
 <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
 <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
 <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 11:35:12AM -0400, Waiman Long wrote:

> From reading the source code, nest_lock check is done in check_deadlock() so
> that it won't complain. However, nest_lock isn't considered in
> check_noncircular() which causes the splat to come out. Maybe we should add
> a check for nest_lock there. I will fiddle with the code to see if it can
> address the issue.

Nah, that's not how it's supposed to work. I think the problem is that
DEFINE_WW_MUTEX is buggered, there's not actually any other user of it
in-tree.

Everybody else (including locking-selftests) seem to be using
ww_mutex_init().

So all locks in a ww_class should be having the same lock class, and
then nest_lock will fold them all into a single entry with ->references
incremented. See __lock_acquire().

But from the report:

> [  103.892671] -> #2 (torture_ww_mutex_0.base){+.+.}-{3:3}:
> [  103.892706] -> #1 (torture_ww_mutex_1.base){+.+.}-{3:3}:
> [  103.892730] -> #0 (torture_ww_mutex_2.base){+.+.}-{3:3}:

that went sideways, they're *not* the same class.

I think you'll find that if you use ww_mutex_init() it'll all work. Let
me go and zap this patch, and then I'll try and figure out why
DEFINE_WW_MUTEX() is buggered.
