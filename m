Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2887C3B796E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Jun 2021 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhF2Uip (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Jun 2021 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhF2Uio (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Jun 2021 16:38:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B9C061760;
        Tue, 29 Jun 2021 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LVxbuLMLcRpyjQRz1kncVZYfUbiUuDqHXsL23IYKsAY=; b=Kp5YrV6NDDHSjE90/fqu4gF+1L
        EX6fRw/AgoFU14R9swh3NPg1FeGggmsk/CWWtLVQ7XIPZ1Ndd3lDcok/Ps00f/48iAxQ1XfzROkob
        U5K/7U1o+5mpcRTGMZZ4YE2uZocZED5W6nlhtTs81cm6KVGzkRadLWUqvPf8lLq3ZUYGWEdNV/5Xg
        KokSW396SlHuQ+ESiF9Qxm2UgzJT09DEizVi4nPDcJKP166rO00MXwUu3HUBNQrq0jZNrHh4qXbkV
        HTIn5iOZcuQa0oU8AxcXFNohLBUoNkqctZC+Tj8ycp5HuzNT1+16P8Co+5g+8t8J6gKmAmXx01ud4
        QHvx9oEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyKSH-004VrN-JG; Tue, 29 Jun 2021 20:35:42 +0000
Date:   Tue, 29 Jun 2021 21:35:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <YNuEGUrjTvOrZkj5@casper.infradead.org>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
 <20210519004411.xpx4i6qcnfpyyrbj@treble>
 <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
 <YNt7+fRNOnorLsYW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNt7+fRNOnorLsYW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Jun 29, 2021 at 09:01:25PM +0100, Matthew Wilcox wrote:
> So this got merged without the corresponding Kbuild update being merged,
> and my kernel failed to boot.  Bisect got as far as
> 
> $ git bisect good
> Bisecting: 4 revisions left to test after this (roughly 2 steps)
> [ab3257042c26d0cd44793c741e2f89bf38b21fe8] jump_label, x86: Allow short NOPs
> 
> before my sluggish memory remembered this thread from six weeks ago.
> 
> So if anybody else hits this, do a make clean.

Actually, this is a different bug with the same symptom.

Applying the patch from Peter, and running it:

$ ./.build_test_kernel-x86_64/tools/objtool/objtool check -abdJsuld .build_test_kernel-x86_64/vmlinux.o
nr_sections: 15446
section_bits: 13
nr_symbols: 116448
symbol_bits: 16
max_reloc: 8031700
tot_reloc: 12477754
reloc_bits: 19
nr_insns: 2523443
.build_test_kernel-x86_64/vmlinux.o: warning: objtool: want_init_on_free()+0x0: jump-label unpatched

This is against a freshly built kernel -- i removed the build directory,
copied in a .config file and built a fresh kernel.
