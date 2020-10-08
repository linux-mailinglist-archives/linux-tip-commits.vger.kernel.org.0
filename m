Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D43286ED3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Oct 2020 08:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJHGtq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Oct 2020 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGtq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Oct 2020 02:49:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB3C061755;
        Wed,  7 Oct 2020 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7WfGhc/5unh1aadlTugJ+R/gB2aZlZqLIHwiGTVdeag=; b=JXXfj+qTLlhjIW5eMrx4iWFn99
        SZppZEjBMbd2xxRN6TPgouKby0VVf2b+vs3FjK7ePO+bOC+iRysJnDd3pZreYfC7ZptYWdxAYb8Jq
        RH+hc5SUlZIglLwuncgP3IaJGzyrnYc20HKoTQEPIT3RjnoHXjVSWdnClc8mITr4LKbJZuU/QxrdB
        pFB5M/UT1SOLHSG5WHFzKrYRFoMBawCYm75v72dLN89q3wwp6FR/RJFRzfGlH3MrgV75Heeeip82b
        X4/+oRg8IsJGd+z5duswDdUmGFy7AjmTgvbsxIEGqe2Cp83h8xEr2hDH/DdtdxQ4YbDCOvG7YR+c+
        WzNoS1/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQPk8-0003kS-72; Thu, 08 Oct 2020 06:49:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6A22301A42;
        Thu,  8 Oct 2020 08:49:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94FCE2B6225D0; Thu,  8 Oct 2020 08:49:28 +0200 (CEST)
Date:   Thu, 8 Oct 2020 08:49:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Michael Matz <matz@suse.de>, Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, hjl.tools@gmail.com,
        linux-toolchains@vger.kernel.org
Subject: Re: [tip: x86/pasid] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20201008064928.GR2628@hirez.programming.kicks-ass.net>
References: <20201005151126.657029-2-dave.jiang@intel.com>
 <160208728972.7002.18130814269550766361.tip-bot2@tip-bot2>
 <20201007170835.GM2628@hirez.programming.kicks-ass.net>
 <20201007211327.GN5607@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007211327.GN5607@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 07, 2020 at 11:13:27PM +0200, Borislav Petkov wrote:
> On Wed, Oct 07, 2020 at 07:08:35PM +0200, Peter Zijlstra wrote:
> > (%rdx), %rax, surely?
> 
> Right, later. Already tagged the branch so that Vinod can base stuff ontop.
> 
> > Also, that's a horrible convention, but I suppose (%rdx), (%rax) was
> > out?
> 
> See the end of this mail:
> 
> https://lkml.kernel.org/r/alpine.LSU.2.20.2009241356020.20802@wotan.suse.de

That, 100x that. Why wasn't it fixed then? How about we fix binutils to
accept the sane mnemonic as well?

> > Can we pretty please get a binutils version that knows about this
> > instruction, such that we know when we can get rid of the silly .byte
> > encoded mess?
> 
> It looks like support for this insn got introduced in this binutils commit:
> 
> c0a30a9f0ab4 ("Enable Intel MOVDIRI, MOVDIR64B instructions")
> 
> So I guess from 2.31 onwards:

Then we'll just keep the byte code around until we reach the min
binutils that's sane, but at least we can fix the comment to not be
insane.
