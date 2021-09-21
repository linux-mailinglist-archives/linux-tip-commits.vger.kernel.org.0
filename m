Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF64413317
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhIUMD7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 08:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhIUMD7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 08:03:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E94C061757;
        Tue, 21 Sep 2021 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+kP37EKfXgboCEQjp8x5JVX9fltzDY6I8KswV5Vh4Wg=; b=Rg/ce+rxn3d069LIvENwQTh3O/
        orcvaGTo6gb3lnmTYFzP2Vm6cwC4X5yCjQ95vHd8yVW02ArlJS7udQ6C5qKkWpjcP1X+dl0+fObug
        06KJl1j0TYOjX7v+uaCMhIOdWdOWLp253WBTOMLtRo7gZqrB6iUgquRJLDLX9GEsCKNRtOsW+WgcO
        fCmkrpuOnXwYa/Yd3dYqGOKpGwt8lGAfB6HMVea1z/eoYDNv45s5K9jlCcp/B4oaGQ3/G5COK++f6
        aU1R583gU+NqJLU3EbpFoQf+EEvXKC3+GE0ef/F2P7P227CwUoPLFT2/sJFmgP4oHtcG00G6UdbgM
        S0jrmcsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSeSK-003mGX-2Y; Tue, 21 Sep 2021 12:01:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 619F2300274;
        Tue, 21 Sep 2021 14:00:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43E7D2028E984; Tue, 21 Sep 2021 14:00:59 +0200 (CEST)
Date:   Tue, 21 Sep 2021 14:00:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/iopl: Fake iopl(3) CLI/STI usage
Message-ID: <YUnJe6rijGy6q1Cz@hirez.programming.kicks-ass.net>
References: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
 <163220928593.25758.16098239507716851071.tip-bot2@tip-bot2>
 <202109211309.26518.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109211309.26518.linux@zary.sk>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:26PM +0200, Ondrej Zary wrote:
> On Tuesday 21 September 2021, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the x86/core branch of tip:
> > 
> > Commit-ID:     32e1ae626f295152d1fc9a3375214133cbe62878
> > Gitweb:        https://git.kernel.org/tip/32e1ae626f295152d1fc9a3375214133cbe62878
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Fri, 17 Sep 2021 11:20:04 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Sat, 18 Sep 2021 12:18:32 +02:00
> > 
> > x86/iopl: Fake iopl(3) CLI/STI usage
> > 
> > Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
> > scope") it's possible to emulate iopl(3) using ioperm(), except for
> > the CLI/STI usage.
> > 
> > Userspace CLI/STI usage is very dubious (read broken), since any
> > exception taken during that window can lead to rescheduling anyway (or
> > worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
> > discouraged and might even crash the system.
> > 
> > Of course, that won't stop people and HP has the dubious honour of
> > being the first vendor to be found using this in their hp-health
> > package.
> > 
> > In order to enable this 'software' to still 'work', have the #GP treat
> > the CLI/STI instructions as NOPs when iopl(3). Warn the user that
> > their program is doing dubious things.
> > 
> > Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
> > Reported-by: Ondrej Zary <linux@zary.sk>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lkml.kernel.org/r/20210918090641.GD5106@worktop.programming.kicks-ass.net
> 
> Could this be backported to 5.10 kernel so it can get into the recently released Debian 11?

Thomas also asked about a stable tag, so I'll rebase and force-push
these commits and add:

Cc: stable@kernel.org # v5.5+

to it.
