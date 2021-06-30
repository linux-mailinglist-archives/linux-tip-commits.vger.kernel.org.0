Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5923B7E46
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 09:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhF3Hmk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhF3Hmj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 03:42:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB0C061766;
        Wed, 30 Jun 2021 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OELB8OXI9teM7TxgJcDkkpSNV+n0n/1PROLl9QSkrI=; b=JeF/7pQ66uQ5h5XIqWjIXLoQDR
        WCcF4PLTj0Rx4NSr749dNIpfNiN0RnJOd3kKpdPOTnsN0fcaNS/1eYaWiiH3IT/AthMysoU09fSky
        a3vQZ5Dq2XsrOdecuVvQT6xKy4A8xqqEvqFuZAdMu7ceREHBtgXQGRdlRjzSE91euE454pVZG+aTD
        wlAX5WMyxSLn06EBjK130qy567pS3S8rMeaB/6JYnYRF59P61KuWRV7Rynce4UaGXN1VGIGcVhLsO
        gBjY2LQ5ZpfyGhFzOxqYTGbdlu0TsPqWRT7RiOUgX+4BeGOuabV9GXZ0wbJtyoz0urNhtUcwKo9qB
        e8hRSzgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyUnn-0053R2-Jq; Wed, 30 Jun 2021 07:38:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78970300204;
        Wed, 30 Jun 2021 09:38:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6077E201570E3; Wed, 30 Jun 2021 09:38:30 +0200 (CEST)
Date:   Wed, 30 Jun 2021 09:38:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <YNwfdltMu44wnoLH@hirez.programming.kicks-ass.net>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
 <20210519004411.xpx4i6qcnfpyyrbj@treble>
 <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
 <YNt7+fRNOnorLsYW@casper.infradead.org>
 <YNuEGUrjTvOrZkj5@casper.infradead.org>
 <YNwYGVdB3QI1kcLL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwYGVdB3QI1kcLL@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Jun 30, 2021 at 09:07:05AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 29, 2021 at 09:35:37PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 29, 2021 at 09:01:25PM +0100, Matthew Wilcox wrote:
> > > So this got merged without the corresponding Kbuild update being merged,
> > > and my kernel failed to boot.  Bisect got as far as
> > > 
> > > $ git bisect good
> > > Bisecting: 4 revisions left to test after this (roughly 2 steps)
> > > [ab3257042c26d0cd44793c741e2f89bf38b21fe8] jump_label, x86: Allow short NOPs
> > > 
> > > before my sluggish memory remembered this thread from six weeks ago.
> > > 
> > > So if anybody else hits this, do a make clean.
> > 
> > Actually, this is a different bug with the same symptom.
> > 
> > Applying the patch from Peter, and running it:
> > 
> > $ ./.build_test_kernel-x86_64/tools/objtool/objtool check -abdJsuld .build_test_kernel-x86_64/vmlinux.o
> > nr_sections: 15446
> > section_bits: 13
> > nr_symbols: 116448
> > symbol_bits: 16
> > max_reloc: 8031700
> > tot_reloc: 12477754
> > reloc_bits: 19
> > nr_insns: 2523443
> > .build_test_kernel-x86_64/vmlinux.o: warning: objtool: want_init_on_free()+0x0: jump-label unpatched
> > 
> > This is against a freshly built kernel -- i removed the build directory,
> > copied in a .config file and built a fresh kernel.
> 
> You happen to have said .config for me?

Also GCC version I suppose. The thing I'm wondering about in particular
is what translation unit is responsible for that symbol.

AFAICT the function itself is an inline from linux/mm.h, but I cannot
find any of the files or functions it's used in as being excluded from
objtool coverage :/
