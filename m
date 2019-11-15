Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEAFFDC5F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKOLiq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 06:38:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfKOLiq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 06:38:46 -0500
Received: from zn.tnic (p200300EC2F0CC3006D2B69FDD4279DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:6d2b:69fd:d427:9de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41F051EC0C35;
        Fri, 15 Nov 2019 12:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573817925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hNpVvEqjvAKsdPU3KwSZaAcIcAO6LqsMpBVZ7EdMwcY=;
        b=q3TPWAhOKrk/rfG8sPJA+qE9TT4pRQFi40EVUDnETOdGW9LDMs/Rew+UBxWkUan+lIJaqv
        cjpxt4vKik7TU9T+YmBN+QtxOud34bFdrKXNAR4nAwQ5WrFT6EtM8p9FyXw4WLOnElmuER
        heeLMVPABo92I19eglF8Lenq8nOSsaM=
Date:   Fri, 15 Nov 2019 12:38:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115113838.GK18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
 <20191115094009.GA25874@gmail.com>
 <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
 <20191115104113.GJ18929@zn.tnic>
 <756e5529-5550-f4d3-ba8b-8d247a479f31@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <756e5529-5550-f4d3-ba8b-8d247a479f31@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 07:13:59PM +0800, Cao jin wrote:
> I still need my colleague to send the patches for me for the time being,
> since the patches are removed now, so I am actually asking: does these 2
> patches need to be resent with my SOB & my college's SOB, or maintainer
> can do that for us?
> 
> Not aware where I am wrong.

Ok, lemme try again:

If you send someone else's patch, you need to denote that the patch
has been handled by you too. The reason this is done is so that it is
crystal clear how a patch has found its way upstream: from the author,
through the sender, then through the upstream maintainer and ending up
in the upstream kernel.

IOW, the SOB chain needs to *show* that:

Signed-off-by: Patch Author
Signed-off-by: Patch Sender
Signed-off-by: Subsystem maintainer

You can find a gazillion examples for this in git history, some of them,
unfortunately incorrect. Hopefully a small number.

And to answer your question: yes, the SOB needs to come from your
colleague and upstream maintainers cannot do that for you. The SOB is
his to give and cannot simply be slapped by maintainers at will because
it entails the Certificate of Origin. That's also in the link I pointed
you to earlier.

All clear? Or need more clarification?

If so, don't hesitate to ask.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
