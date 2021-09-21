Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64B412D85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 05:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhIUDki (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Sep 2021 23:40:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhIUDk2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Sep 2021 23:40:28 -0400
Received: from zn.tnic (p200300ec2f0d06007c9abd750032b61b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:600:7c9a:bd75:32:b61b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DF0A1EC0298;
        Tue, 21 Sep 2021 05:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632195533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nZr0eMMqGzU85seVe3N8hdl2qJOEAEKLwcna2876nyc=;
        b=qo6ZGOncHn3pMNoJM2mHTGa7nHxBRy9F0D3QUZG5ZPhbw37nuN/3/mPfVTU46S0i38WV4+
        rsWeDd4ENNL4tkcHcC+RPDP9y/z7T7zS5yQIqg3oJbyvsSqQUNFVWt5HajZVmoGass05NE
        hdRyruit86Ui4tWDnCKa3822JZ6EOgM=
Date:   Tue, 21 Sep 2021 05:38:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        marmarek@invisiblethingslab.com, Juergen Gross <jgross@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/setup: Call early_reserve_memory() earlier
Message-ID: <YUlTlsVB7gJUVNT0@zn.tnic>
References: <20210914094108.22482-1-jgross@suse.com>
 <163178944634.25758.17304720937855121489.tip-bot2@tip-bot2>
 <4422257385dbee913eb5270bda5fded7fbb993ab.camel@gmx.de>
 <YUdwMm9ncgNuuN4f@zn.tnic>
 <YUkPsjUUtRewyOn3@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUkPsjUUtRewyOn3@archlinux-ax161>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 20, 2021 at 03:48:18PM -0700, Nathan Chancellor wrote:
> Could auto-latest get updated too so that it does not show up in -next?
> I just spent a solid chunk of my day bisecting a boot failure on one of
> my test boxes on -next down to this change, only to find out it was
> already reported :/

Sorry about that - commit is zapped from tip/master and tip/auto-latest.

But your effort hasn't been in vain - you have a box which triggers this
boot issue and I haven't found one yet.

Can you please test on that exact test box whether the new version of
that commit works?

That one:

https://lkml.kernel.org/r/20210920120421.29276-1-jgross@suse.com

It would be much appreciated.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
