Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41C388154
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 22:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhERU0P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhERU0O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 16:26:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9CC061573;
        Tue, 18 May 2021 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IrbRchIcupxBfoxuYtFGP6rM8LJCDXMAeIYwWtVaF6E=; b=L00CZ1wasmckLepdoFwFqxRT/s
        URimQCuCCiBqBhjuxNTaN/zS06ROtYiuJ6kGEFWry1f/5O8ii06CqUkH+LZDhcrKdexnVF8/6LZfr
        +yeAo/m0/nt9VyGZMvg5cv5cCbHVPOJ8MZbYHDMDwkpPcXWWyR69imryLLslmNRFQmK5VhwXOVLlZ
        Nql8hLA92G46wtm5Pp8JtremPgEAHXGXkGOWpn/k6yHU6GI3H0pVr1cOOFvBV/9ilhfUnYnNx/Sa3
        l2qFE5a/WtZsnpUGhDKPUnQSnzjiXVI2Vuoa/7GCW/Y2ysk6Bk4HohCoQrH5NsdsWhf2fDZLa6pT/
        n0yQshSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj6Gi-001omX-Up; Tue, 18 May 2021 20:24:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E04D7986465; Tue, 18 May 2021 22:24:43 +0200 (CEST)
Date:   Tue, 18 May 2021 22:24:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, willy@infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <20210518202443.GA48949@worktop.programming.kicks-ass.net>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518195004.GD21560@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


+kbuild maintainers

On Tue, May 18, 2021 at 09:50:04PM +0200, Peter Zijlstra wrote:
> On Wed, May 12, 2021 at 01:19:47PM -0000, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     ab3257042c26d0cd44793c741e2f89bf38b21fe8
> > Gitweb:        https://git.kernel.org/tip/ab3257042c26d0cd44793c741e2f89bf38b21fe8
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Thu, 06 May 2021 21:34:05 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 12 May 2021 14:54:56 +02:00
> > 
> > jump_label, x86: Allow short NOPs
> > 
> > Now that objtool is able to rewrite jump_label instructions, have the
> > compiler emit a JMP, such that it can decide on the optimal encoding,
> > and set jump_entry::key bit1 to indicate that objtool should rewrite
> > the instruction to a matching NOP.
> > 
> > For x86_64-allyesconfig this gives:
> > 
> >   jl\     NOP     JMP
> >   short:  22997   124
> >   long:   30874   90
> > 
> > IOW, we save (22997+124) * 3 bytes of kernel text in hotpaths.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/20210506194158.216763632@infradead.org
> 
> So Willy is having some trouble with this commit; for some reason his
> kernel is no longer booting in his qemu thing, but I can't reproduce.
> 
> I've hacked up the below vmlinux.o validation, willy can you run this on
> your vmlinux.o, something like:
> 
> 	build/tools/objtool/objtool check -abdJsuld build/vmlinux.o
> 
> Where I'm assuming you build with O=build/. When I run it on my build
> (with your .config) I get absolutely nothing :/
> 
> Alternatively, can you get me your vmlinux.o + bzImage ?
> 
> Also helpful might be trying to attach gdb to the qemu gdbstub and
> looking where the boot fails.

OK, willy followed up on IRC, and it turns out there's a kbuild
dependency missing; then objtool changes we don't rebuild:

  arch/x86/entry/vdso/vma.o

even though we should, this led to an unpatched 2 byte jump-label and
things went sideways. I'm not sure I understand the whole build
machinery well enough to know where to begin chasing this.

Now, this file is mighty magical, due to:

arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD  := y
arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD_vma.o    := n

Maybe that's related.
