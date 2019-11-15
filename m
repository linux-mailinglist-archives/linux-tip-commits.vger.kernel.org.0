Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B68FDB90
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOKlP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 05:41:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKOKlO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 05:41:14 -0500
Received: from zn.tnic (p200300EC2F0CC3006D2B69FDD4279DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:6d2b:69fd:d427:9de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E35A1EC0D08;
        Fri, 15 Nov 2019 11:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573814473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cVrZsWxokk2IfQChzkb+oOH3bqrQdEIDzJ9oXU82FJM=;
        b=d0aXGz9yDB7ZYNjEN+aUme4c4NaTOPC3asPdSgmqvlX1FdxrrkjjBQlaRbYhuLtT9lpXYk
        s+S6AFnIO2OmQhAePPHCX1nYyMeLoHPPsU8tWicnllmRKIzDJnulkAONNfbNchZ4GoxfyF
        YeFUvCRy7OZxs4BWYmfgWg4iR4MLOoY=
Date:   Fri, 15 Nov 2019 11:41:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115104113.GJ18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
 <20191115094009.GA25874@gmail.com>
 <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 06:12:50PM +0800, Cao jin wrote:
> Does them need to be resent with my college's SOB?

Please slow down and think before replying! I just pointed you to that
document. I even wrote:

"If you do ask your colleague to send patches for you, he needs to
add his SOB under yours because it shows this way that the patch went
through him and it is important to know the path a patch took upstream."

Now if that is still unclear, ask and I'll try explaining again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
