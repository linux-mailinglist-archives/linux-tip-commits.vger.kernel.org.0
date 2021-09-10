Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEF407051
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Sep 2021 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhIJRNx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 13:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhIJRNx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 13:13:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1D5C061574;
        Fri, 10 Sep 2021 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HeUfcZtIsgblcevNKKHZTsW8AiwklxONuJ7zMC1Q4A4=; b=mbDUkgGe5rpUkAHXZlugsTroc+
        r5erQ0nT4vB2Q3iuUV5Vj3hQdT44+EG4U4uXFu9siBk1N0/Lf5NzXNg5CqS8sXUdBDWiPWIYExsBq
        1D8FC1hS/5zWHDlm/if1TN5FiD7aOYtTwBb75WobQhpPTkXiXhMI3rXu0aJfpEbhmkz3sdlIVSHjB
        tcvu/Q/skXk4eJSoq6uSl3Z25lGcRK4XV2G1XwG6Wm4dJ90a7uBywZbawLGUpIaizAXDsXi+G1idg
        il40O4znQRhg3n//4jzCiwhVccAErWBycWHI/MlLkqNPCaZwdT8DjL8Fv7MKVMoqQrDuuugWsd3Xk
        3OEIuM8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOk4c-002B8V-EA; Fri, 10 Sep 2021 17:12:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99C1498627A; Fri, 10 Sep 2021 19:12:21 +0200 (CEST)
Date:   Fri, 10 Sep 2021 19:12:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-tip-commits@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20210910171221.GN4323@worktop.programming.kicks-ass.net>
References: <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net>
 <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
 <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
 <YTm26u9i3hpjrNpr@hirez.programming.kicks-ass.net>
 <20210909133535.GA9722@willie-the-truck>
 <5412ab37-2979-5717-4951-6a61366df0f2@nvidia.com>
 <20210909180005.GA2230712@paulmck-ThinkPad-P17-Gen-1>
 <YTtpnZuSId9yDUjB@boqun-archlinux>
 <20210910163632.GC39858@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910163632.GC39858@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 10, 2021 at 12:36:32PM -0400, Alan Stern wrote:
> +Here the second spin_lock() is po-after the first spin_unlock(), and
> +therefore the load of x must execute before the load of y, even tbough

I think that's commonly spelled: though, right?                    ^^^^^^

