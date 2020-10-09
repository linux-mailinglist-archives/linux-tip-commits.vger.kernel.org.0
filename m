Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AC2899D3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJIUih (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389377AbgJIUih (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 16:38:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA2C0613D2;
        Fri,  9 Oct 2020 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5QO6RA3HKVUZHpGdEyUHg1uVMriNEKLFam7kt2l8WbY=; b=BykcTHfl5U5QXVGW4edmbJoejd
        /feI6aevZQDdnvhh45rvU/0eXRo+78rdChTL1QU1Nq0wNiGn73IvchEyJMpMDFko5sJZW/cNdTbjo
        CY/vlICXrw/WfyKQrGBNXsC0pP3gpGsWD1xWMR6Fu/MAcSaGEE0AlbucgSWqr+RzrXzqdFSfKUNfv
        aC3p83mK2BGDpcY50GphQuJQBBbcmCUnjsNmn/7jLfvNXSgZ5y+nyWWDT+c+9j+5TDPigoWRBZC5F
        AAO7GJ0Y/TVe2Qq1qTnl3lMi3Jf/2PQjGFTG6jyXQnZ6TH0bichbeMyzAiLye0K9jQr5IzIY+oCl4
        i8M8xTiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQz9r-0008Pe-Km; Fri, 09 Oct 2020 20:38:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC67980BDC; Fri,  9 Oct 2020 22:38:22 +0200 (CEST)
Date:   Fri, 9 Oct 2020 22:38:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <20201009203822.GA2974@worktop.programming.kicks-ass.net>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> 
> x86/insn: Support big endian cross-compiles
> 
> x86 instruction decoder code is shared across the kernel source and the
> tools. Currently objtool seems to be the only tool from build tools needed
> which breaks x86 cross compilation on big endian systems. Make the x86
> instruction decoder build host endianness agnostic to support x86 cross
> compilation and enable objtool to implement endianness awareness for
> big endian architectures support.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.

I've asked Boris to truncate tip/objtool/core.
