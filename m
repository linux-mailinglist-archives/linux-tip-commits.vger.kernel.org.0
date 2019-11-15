Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B546EFD7DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKOI0K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 03:26:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOI0K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 03:26:10 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A3C91EC0D00;
        Fri, 15 Nov 2019 09:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573806369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=55/u3HA//v8T8QvPnyu8iFYuOtJ0mSaRZWcyFgGrwR8=;
        b=mXWPqVw+NAgnZ/rPlbM21lhdDO2DfXJfBdKwrV/Y3EjiUQwNi9o0g1WBYWg+/vep5LXP03
        89M4Acs2Av53Efo7JN194zmt+fDYcS6AKC1bMqW1bXGB4pbeOEwanqDtQU8uANYuORkNhz
        wUGYuNRlTpNnqhnjhfYQYyncYshsuSg=
Date:   Fri, 15 Nov 2019 09:26:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115082604.GA18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 07:28:55AM -0000, tip-bot2 for Cao jin wrote:
> The following commit has been merged into the x86/cleanups branch of tip:
> 
> Commit-ID:     bff3dc88003badacb7ed685e301ab38dbdc36a8b
> Gitweb:        https://git.kernel.org/tip/bff3dc88003badacb7ed685e301ab38dbdc36a8b
> Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
> AuthorDate:    Fri, 15 Nov 2019 13:08:28 +08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 15 Nov 2019 08:26:07 +01:00
> 
> x86/numa: Fix typo
> 
> encomapssing -> encompassing.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Cc: <bp@alien8.de>
> Cc: <dave.hansen@linux.intel.com>
> Cc: <hpa@zytor.com>
> Cc: <luto@kernel.org>
> Cc: <peterz@infradead.org>
> Cc: <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

This is all fine and good but this one and the other patch doesn't have
the sender's SOB, i.e., that dude:

From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

and I was about to point that out but you applied them already.

I'm guessing Shiyang is sending those because the author's mail has been
bouncing recently. I guess he left or so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
