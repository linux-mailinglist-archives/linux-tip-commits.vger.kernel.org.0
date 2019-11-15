Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305C4FD95C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOJch (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:32:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfKOJch (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:32:37 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 341031EC0D04;
        Fri, 15 Nov 2019 10:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573810356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CAOv4Yq8Q3L4DRaO1KYLm97Un5O4jUOc1CdrrthdFoQ=;
        b=OoGVdjCJ87n0Nxr7KI9h9fedhUdrxA9Z3if1+B92CSJwGS370EEZ50riOmKtXnG+WhvPVy
        DvNfrpNqyTlhdRalNLFtuS+QLjX1g/s2Xhioj5McvDG0m1hL/ByTS6ofXOZGgL5PhLTMev
        ZN96DRphw/67HN7aMlTpTOPt0UxDDeI=
Date:   Fri, 15 Nov 2019 10:32:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115093236.GG18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
 <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
 <20191115084509.GC18929@zn.tnic>
 <550ce44a-2b61-42ea-46c1-22a6a4976e5f@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550ce44a-2b61-42ea-46c1-22a6a4976e5f@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 05:08:26PM +0800, Cao jin wrote:
> Net::SMTP=GLOB(0x557db0534920)<<< 220 G08CNEXCHPEKD01.g08.fujitsu.local
> Microsoft ESMTP MAIL Service ready at Fri, 15 Nov 2019 16:49:11 +0800

If that's exchange, it has been known to mangle patches and it is
generally unsuitable for upstream work. Talk to your manager about using
a linux solution for sending patches.

> Net::SMTP=GLOB(0x557db0534920)>>> EHLO TSO.g08.fujitsu.local
> Net::SMTP=GLOB(0x557db0534920)<<< 250-G08CNEXCHPEKD01.g08.fujitsu.local
> Hello [10.167.226.60]

...

> Net::SMTP=GLOB(0x557db0534920)<<< 220 2.0.0 SMTP server ready
> STARTTLS failed! hostname verification failed at
^^^^^^^^^^^^^^^^^^

It complains about your hostname.

> /usr/libexec/git-core/git-send-email line 1515.

> Got it, thanks. I thought SOB is more of the responsibility of the patch
> content.

I will point you to a nice reading, once more:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Make sure you look at it each time you're not sure about the SOB chain.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
