Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38773B7DD4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhF3HJ4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhF3HJz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 03:09:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43822C061766;
        Wed, 30 Jun 2021 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C9Zdq4bxueVc6H8rgRNSZn0889lqUZkOCahS2I5hFEI=; b=KOnWA+ggh4hkPhfQ2tSsli3tW3
        9276PEcucsgET4mu2Vsy6OeoX9u/2on/fznmhyBKMmWAzc7Sm4A2XRNlkkEhcbRf9QAeMjPHpM6oY
        Up5EyOYXv5VAgMqmn/LhtcyBUpbd4jlEkkxYkKWJ+wjIFtD+oAjRnIKNa+1B6tGHL2dJMh+zI+nzA
        YpGi59TOfJOTlE+ATg2Qczo29MDtv2XhVzPqMdVrHocgt6fgPKBhPuyAOCt8Z2+uOIj6ngFVlQzWm
        mdv8Q8f6UmYZcoow1V7LmK+WcAXUkUUjvTDdypQDIZvhUI8O9CHv3+L4Xq57qSQlmhLmYqk3YuWNG
        mJ+nl05Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyUJO-00D6tR-Uy; Wed, 30 Jun 2021 07:07:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 940B3300091;
        Wed, 30 Jun 2021 09:07:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77160201570E3; Wed, 30 Jun 2021 09:07:05 +0200 (CEST)
Date:   Wed, 30 Jun 2021 09:07:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <YNwYGVdB3QI1kcLL@hirez.programming.kicks-ass.net>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
 <20210519004411.xpx4i6qcnfpyyrbj@treble>
 <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
 <YNt7+fRNOnorLsYW@casper.infradead.org>
 <YNuEGUrjTvOrZkj5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNuEGUrjTvOrZkj5@casper.infradead.org>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Jun 29, 2021 at 09:35:37PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 29, 2021 at 09:01:25PM +0100, Matthew Wilcox wrote:
> > So this got merged without the corresponding Kbuild update being merged,
> > and my kernel failed to boot.  Bisect got as far as
> > 
> > $ git bisect good
> > Bisecting: 4 revisions left to test after this (roughly 2 steps)
> > [ab3257042c26d0cd44793c741e2f89bf38b21fe8] jump_label, x86: Allow short NOPs
> > 
> > before my sluggish memory remembered this thread from six weeks ago.
> > 
> > So if anybody else hits this, do a make clean.
> 
> Actually, this is a different bug with the same symptom.
> 
> Applying the patch from Peter, and running it:
> 
> $ ./.build_test_kernel-x86_64/tools/objtool/objtool check -abdJsuld .build_test_kernel-x86_64/vmlinux.o
> nr_sections: 15446
> section_bits: 13
> nr_symbols: 116448
> symbol_bits: 16
> max_reloc: 8031700
> tot_reloc: 12477754
> reloc_bits: 19
> nr_insns: 2523443
> .build_test_kernel-x86_64/vmlinux.o: warning: objtool: want_init_on_free()+0x0: jump-label unpatched
> 
> This is against a freshly built kernel -- i removed the build directory,
> copied in a .config file and built a fresh kernel.

You happen to have said .config for me?
