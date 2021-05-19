Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A33887DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhESG6s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhESG6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 02:58:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A137C06175F;
        Tue, 18 May 2021 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yR4HIbsOuCNiqwnMZ6oojYJI0qVF+NxXEr3UMzE7jxc=; b=sEYpWJdC/PkF58DyVztc24qcVs
        PHCyER2RbURnpPPvO7FOu8JWqaQy7X55rAuUUhdF6Xb9nUaIC2O2bW8TjC70kU/JyQnHYkbrqzQPa
        vEAib/TCCJXUY530heLmmpXuYXBt2uGdYCkEv8jyWm1qXDmme9Qwpn8zS0ZrJTB4rXiDmzmM6Cg1K
        kShPU1otYba2SFM568CPgXlYR6vFYlrNXYvgo6jzF13GwooYkEUxrgvAEQnGaeSsETsPqxicxduRV
        rr9zueqRHvX1CP3NoFIs5eWyEvSXxt7GWoDtXEZ6LFtS2Y8kiyUvgn8XGz8rDfbQ9M+f93YQLMywm
        iF74YcMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljG8A-00EhnQ-Vh; Wed, 19 May 2021 06:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8593D30021B;
        Wed, 19 May 2021 08:56:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65F4B2027BB36; Wed, 19 May 2021 08:56:33 +0200 (CEST)
Date:   Wed, 19 May 2021 08:56:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        willy@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <YKS2oX/PCfp4NQ8V@hirez.programming.kicks-ass.net>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
 <20210519004411.xpx4i6qcnfpyyrbj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519004411.xpx4i6qcnfpyyrbj@treble>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 18, 2021 at 07:44:11PM -0500, Josh Poimboeuf wrote:

> I'm not exactly thrilled that objtool now has the power to easily brick
> a system :-/  Is it really worth it?

The way I look at it is that not running objtool is a bug either way,
bricking a system is ofcourse a somewhat more drastic failure mode than
missing ORC info for example, but neither are good.

As to worth, about half the jump labels are shorter now, this reduces I$
pressure on hot paths. Any little thing to offset the ever increasing
bulk seems like a good thing to me. But yes, it would be nice if the
assemblers wouldn't suck so bad and this wouldn't need objtool :/ But
I've tried poking the tools guys and they don't really seem interested
:-(

Also, only dirty builds are affected here; clean builds (always
recommended afaik, because dep trouble isn't unheard of) are fine.

> Anyway, here's one way to fix it.  Maybe Masahiro has a better idea.

Thanks! lemme go read up on this magic :-)
