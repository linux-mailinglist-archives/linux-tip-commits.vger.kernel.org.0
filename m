Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145082869E8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgJGVNi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 17:13:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgJGVNi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 17:13:38 -0400
Received: from zn.tnic (p200300ec2f091000329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B85551EC047E;
        Wed,  7 Oct 2020 23:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602105216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/Yh+wbC0gePra/fHYoDJBYHzwvAnC3odlqyeb1eRkS0=;
        b=Ahf9g86lq4umgnClS2SgAlXjH3q8p/EGeW3E/h1y+n2Z2C36gTb4SS2luUWONCEkQxF1y3
        uY/Ic3KwuleaXauo/4WodNuPropBofqVWw8PcZNDIeoE0hbOqLegth9TMiKN1QIjmZdCgJ
        TY2FWjueaW0HRiDyieoy+76tHexnF28=
Date:   Wed, 7 Oct 2020 23:13:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Michael Matz <matz@suse.de>, Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/pasid] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20201007211327.GN5607@zn.tnic>
References: <20201005151126.657029-2-dave.jiang@intel.com>
 <160208728972.7002.18130814269550766361.tip-bot2@tip-bot2>
 <20201007170835.GM2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007170835.GM2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 07, 2020 at 07:08:35PM +0200, Peter Zijlstra wrote:
> (%rdx), %rax, surely?

Right, later. Already tagged the branch so that Vinod can base stuff ontop.

> Also, that's a horrible convention, but I suppose (%rdx), (%rax) was
> out?

See the end of this mail:

https://lkml.kernel.org/r/alpine.LSU.2.20.2009241356020.20802@wotan.suse.de

> Can we pretty please get a binutils version that knows about this
> instruction, such that we know when we can get rid of the silly .byte
> encoded mess?

It looks like support for this insn got introduced in this binutils commit:

c0a30a9f0ab4 ("Enable Intel MOVDIRI, MOVDIR64B instructions")

So I guess from 2.31 onwards:

$ git tag --contains c0a30a9f0ab48
binutils-2_31
binutils-2_31_1
binutils-2_32
binutils-2_33
binutils-2_33_1
binutils-2_34
binutils-2_35
binutils-2_35_1
gdb-8.2-release
gdb-8.2.1-release
gdb-8.3-release
gdb-8.3.1-release
gdb-9.1-release
gdb-9.2-release
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
