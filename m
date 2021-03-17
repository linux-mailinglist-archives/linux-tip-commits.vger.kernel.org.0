Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2BD33F99C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 20:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhCQT7I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCQT6k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 15:58:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5020BC06174A;
        Wed, 17 Mar 2021 12:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oC8GCTmvlsFkDJ1hgVzSWJ6fGOhXyrj/G6vJTANh9M8=; b=C3bq/xcLSTWNKn1DdXGc9MAbWW
        fCr5UDHnFBlDxsz5Zs1UKZGPsQet+8IBqS+ZdB+wE0cFiFF8MCvhlRg7mRdIzSpd6d2tFmvHPzK0c
        l3g6CjXPdAgPmNKvmhAQXxexruIHJYpAQqNWDcseryOORJGbsOMzddTPIsoMSSTz5Z3tTbl2WE9W2
        1iLQSnwrEMd0EDAa2PwEuftQnXuDZLf+EnqgSJq/WgSCrvw2zG6ewwTOI4bZeP2rSRIL13jg6skOH
        cOsWf2XeVlLZD28QP1OHB+HWpnfW4SJftzMQt/YRBc6IUFrwzhlEJOxW46JUkCw3172u/vQRw4dr9
        yTjLBZ2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMcJP-003qKE-Hm; Wed, 17 Mar 2021 19:58:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1D54980BEF; Wed, 17 Mar 2021 20:58:34 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:58:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] locking/ww_mutex: Treat ww_mutex_lock()
 like a trylock
Message-ID: <20210317195834.GV4746@worktop.programming.kicks-ass.net>
References: <20210316153119.13802-4-longman@redhat.com>
 <161598470197.398.8903908266426306140.tip-bot2@tip-bot2>
 <YFIASRkXowQWgj2s@hirez.programming.kicks-ass.net>
 <YFIEo8IVQ/Mm9jUE@hirez.programming.kicks-ass.net>
 <e1bcd7fb-3a40-f207-ee19-d276c8b8bb75@redhat.com>
 <e39f4e37-e3c0-e62a-7062-fdd2c8b3d3b9@redhat.com>
 <YFIy8Bzj7WAHFmlG@hirez.programming.kicks-ass.net>
 <YFI/C4VZuWjyHLNK@hirez.programming.kicks-ass.net>
 <YFJAP8x917Ef0Khj@hirez.programming.kicks-ass.net>
 <36d26109-f08a-6254-2fd3-ad1a28fcc260@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d26109-f08a-6254-2fd3-ad1a28fcc260@redhat.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17, 2021 at 02:32:27PM -0400, Waiman Long wrote:
> On 3/17/21 1:45 PM, Peter Zijlstra wrote:

> > > +# define __DEP_MAP_WW_MUTEX_INITIALIZER(lockname, class) \
> > > +		, .dep_map = { \
> > > +			.key = &(class).mutex_key, \
> > > +			.name = (class).mutex_name, \
> > 			,name = #class "_mutex", \
> > 
> > and it 'works', but shees!
> 
> The name string itself may be duplicated for multiple instances of
> DEFINE_WW_MUTEX(). Do you want to keep DEFINE_WW_MUTEX() or just use
> ww_mutex_init() for all?

So linkers can merge literals, but no guarantee. But yeah, lets just
kill the thing, less tricky macro crud to worry about.

> I notice that the problem with DEFINE_WW_MUTEX is that the ww_mutex
> themselves has null key instead of the same key from the ww_class as with
> ww_mutex_init().

Correct.
