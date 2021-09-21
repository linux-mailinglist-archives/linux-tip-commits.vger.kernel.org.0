Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F47412D9E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 05:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhIUEBO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 00:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhIUEBN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 00:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0165611C7;
        Tue, 21 Sep 2021 03:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632196785;
        bh=jmk/uZuqLkoXagm8ygt7aBAsovLbk9vXbJTPG+BlsQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W84U9qGt1u0u62msL4AyGa+4gd4nFAUPEYylZh7owRwU/p7k1hgbFlGthx5ASx1PQ
         3HVaURkUD4RKQ49rvQv+OGqwpKPUWI8MRnlykyK2+RW2jb6qeOqXF71p216G/Rqy+v
         M70yhHmk7lCh2SSnf/WmJhJnqhiEnnp79HHyBX2jA9r5XewJ7OGuIlAu4iWPgr0NUe
         qA4m9t8nBgNVxJ5wGCrwvcX5AkwVvTr4r3PoJZlhhlNLDT8wOAlAkT2t6CJomuXszu
         gVpifXIl4+vBeu6L0U8pggl7RaL1boTaRui0iykOFMi1w8UcaQpeR0U1CFjsztQooP
         ghxR7vM3zFxXg==
Date:   Mon, 20 Sep 2021 20:59:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        marmarek@invisiblethingslab.com, Juergen Gross <jgross@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/setup: Call early_reserve_memory() earlier
Message-ID: <YUlYrLG4rLwWw1ge@archlinux-ax161>
References: <20210914094108.22482-1-jgross@suse.com>
 <163178944634.25758.17304720937855121489.tip-bot2@tip-bot2>
 <4422257385dbee913eb5270bda5fded7fbb993ab.camel@gmx.de>
 <YUdwMm9ncgNuuN4f@zn.tnic>
 <YUkPsjUUtRewyOn3@archlinux-ax161>
 <YUlTlsVB7gJUVNT0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUlTlsVB7gJUVNT0@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 21, 2021 at 05:38:40AM +0200, Borislav Petkov wrote:
> On Mon, Sep 20, 2021 at 03:48:18PM -0700, Nathan Chancellor wrote:
> > Could auto-latest get updated too so that it does not show up in -next?
> > I just spent a solid chunk of my day bisecting a boot failure on one of
> > my test boxes on -next down to this change, only to find out it was
> > already reported :/
> 
> Sorry about that - commit is zapped from tip/master and tip/auto-latest.

Thank you!

> But your effort hasn't been in vain - you have a box which triggers this
> boot issue and I haven't found one yet.
> 
> Can you please test on that exact test box whether the new version of
> that commit works?
> 
> That one:
> 
> https://lkml.kernel.org/r/20210920120421.29276-1-jgross@suse.com
> 
> It would be much appreciated.

Sure thing. I tested both of my test systems and added a tested-by tag
to that thread. Glad to hear it was not in vain :)

Cheers,
Nathan
