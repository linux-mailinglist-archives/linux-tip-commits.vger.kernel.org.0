Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAB3B7906
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jun 2021 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhF2UEH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Jun 2021 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhF2UEF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Jun 2021 16:04:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EFC061760;
        Tue, 29 Jun 2021 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43EXmuxyFngAmR7da1cOLXA97ga+3kbzRG83psgM9Zg=; b=RbzmHRRMrMKfTKX7RoQERx1/qO
        pKXln50vJgqpCwaXzJIj17d7PPOwwzUme+3HAlQYvsUr4pxyxPDq7R+d3ezX8EDKt13sZh12NLqD/
        H3QCe0vAy9NNdICFt3VMVLOJ/EjRR82pn3VX2mb/Sd94qEwJvHBpauaZDJLBSRTdflHeSsZvKkcCi
        C22+F6vcAasYXHQf/qlKZSK1G5DC2n75K0f+2nII3lzwoK9g2TcgopKmZ05AlvKxizlpT6QtxJA4S
        e0tGq1zQEPWcS0K+iAm96cSees3mTaMFOBtDdWbFNpAEhe61vqs2fHWh+DZklnW6cX0YgT/PIi5Vx
        smtIZmUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyJuj-004UIj-PR; Tue, 29 Jun 2021 20:01:04 +0000
Date:   Tue, 29 Jun 2021 21:00:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <YNt7+fRNOnorLsYW@casper.infradead.org>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
 <20210519004411.xpx4i6qcnfpyyrbj@treble>
 <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


So this got merged without the corresponding Kbuild update being merged,
and my kernel failed to boot.  Bisect got as far as

$ git bisect good
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[ab3257042c26d0cd44793c741e2f89bf38b21fe8] jump_label, x86: Allow short NOPs

before my sluggish memory remembered this thread from six weeks ago.

So if anybody else hits this, do a make clean.

On Wed, May 19, 2021 at 08:56:33AM +0200, Peter Zijlstra wrote:
> On Tue, May 18, 2021 at 07:44:11PM -0500, Josh Poimboeuf wrote:
> 
> > I'm not exactly thrilled that objtool now has the power to easily brick
> > a system :-/  Is it really worth it?
> 
> The way I look at it is that not running objtool is a bug either way,
> bricking a system is ofcourse a somewhat more drastic failure mode than
> missing ORC info for example, but neither are good.
> 
> As to worth, about half the jump labels are shorter now, this reduces I$
> pressure on hot paths. Any little thing to offset the ever increasing
> bulk seems like a good thing to me. But yes, it would be nice if the
> assemblers wouldn't suck so bad and this wouldn't need objtool :/ But
> I've tried poking the tools guys and they don't really seem interested
> :-(
> 
> Also, only dirty builds are affected here; clean builds (always
> recommended afaik, because dep trouble isn't unheard of) are fine.
> 
> > Anyway, here's one way to fix it.  Maybe Masahiro has a better idea.
> 
> Thanks! lemme go read up on this magic :-)
