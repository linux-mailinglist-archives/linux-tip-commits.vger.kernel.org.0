Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72475FDB85
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKOKiX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 05:38:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfKOKiX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 05:38:23 -0500
Received: from zn.tnic (p200300EC2F0CC3006D2B69FDD4279DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:6d2b:69fd:d427:9de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD6F91EC0D08;
        Fri, 15 Nov 2019 11:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573814301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tErTabIkjmXpKkI/a1RM5Spfy0H58ujRk3b+mCakEW8=;
        b=HMrEo14IXNtgvTrdkwvhz6exqAJUQzdTFHvKBAntAhrqAcgGnt66wOXmNEhTsdFIkFilAe
        9HXBSXy1ob+4jbuzoShmHwMoxBm7W3IOXVQ//irWogwVx1NkS9TidTD9XtxG5FxYDaMRnZ
        Jn3+oVkT1wqFxvYAbMveRTne5CfEx7U=
Date:   Fri, 15 Nov 2019 11:38:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
Message-ID: <20191115103821.GI18929@zn.tnic>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic>
 <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
 <20191115084509.GC18929@zn.tnic>
 <550ce44a-2b61-42ea-46c1-22a6a4976e5f@cn.fujitsu.com>
 <20191115093236.GG18929@zn.tnic>
 <c328744b-2870-b5bd-0b1a-a092a6aaf8ed@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c328744b-2870-b5bd-0b1a-a092a6aaf8ed@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 15, 2019 at 06:12:28PM +0800, Cao jin wrote:
> Out of my manger's boundary;)

There's public mail providers like gmail or whatnot, you can use those.
Not the gmail GUI but sending mail through its smtp servers, works fine
AFAIK. Or any other public email provider which gives you smtp sending
capability.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
