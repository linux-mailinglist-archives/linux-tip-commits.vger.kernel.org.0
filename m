Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D851728DA71
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgJNH3F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 03:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgJNH3E (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 03:29:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C5F20878;
        Wed, 14 Oct 2020 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602660543;
        bh=bVOS5OD7v/UUKm67KkgDxWG0kGL5dI5WiJ8fq6+QhwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tS3snivaKkQOQH9y+Ut9gommO3l161qxawaGAZFTKB+G9f/KrqhE+gCh2coG3lN0T
         V4t0xgoPhMK0qDzi1W+tH3JvUlfK+FH6RDqzR4ZBSraQvB7QQu7aOLYEGxxLNePSeB
         hh8vog0rZuad8TqAvCP/TxqEG8tIzKHS7pUlPbPY=
Date:   Wed, 14 Oct 2020 16:28:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-Id: <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
In-Reply-To: <20201012153949.jfwa7rgpzu5b7ld4@treble>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
        <20201009203822.GA2974@worktop.programming.kicks-ass.net>
        <20201009204921.GB21731@zn.tnic>
        <20201010174415.zwopoy6vpficoqlr@treble>
        <20201012091236.0f9a64bfedb8825732b65ea5@kernel.org>
        <20201012153949.jfwa7rgpzu5b7ld4@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, 12 Oct 2020 10:39:49 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Oct 12, 2020 at 09:12:36AM +0900, Masami Hiramatsu wrote:
> > On Sat, 10 Oct 2020 12:44:15 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> > > > On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > > > > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > > > > The following commit has been merged into the objtool/core branch of tip:
> > > > > > 
> > > > > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> > > > > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > > CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> > > > > > 
> > > > > > x86/insn: Support big endian cross-compiles
> > > > > > 
> > > > > > x86 instruction decoder code is shared across the kernel source and the
> > > > > > tools. Currently objtool seems to be the only tool from build tools needed
> > > > > > which breaks x86 cross compilation on big endian systems. Make the x86
> > > > > > instruction decoder build host endianness agnostic to support x86 cross
> > > > > > compilation and enable objtool to implement endianness awareness for
> > > > > > big endian architectures support.
> > > > > > 
> > > > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > 
> > > > > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > > > > 
> > > > > I've asked Boris to truncate tip/objtool/core.
> > > > 
> > > > Yeah, top 4 are gone until this is resolved.
> > > 
> > > Masami, I wonder if we even need these selftests anymore?  Objtool
> > > already decodes the entire kernel.
> > 
> > No, they have different roles. The selftest checks if the decoder
> > works correctly by comparing with the output of objdump.
> > 
> > As far as I can see, the objtool relies on the sanity of the decoder
> > (it trusts the output of the decoder).
> 
> Ok.  I wonder if we should move the decoder selftest to the 'tools'
> subdirectory.

It is in the arch/x86/tools, so it is already in a kind of tools :)
But yeah, it was considered to be used only on x86. But if someone
start trying to run it on non-x86, cross compiling, we need to
reconsider that.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
