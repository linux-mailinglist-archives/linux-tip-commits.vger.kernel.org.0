Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A112F8E03
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Jan 2021 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAPRNE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 Jan 2021 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbhAPRKr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D11C061799;
        Sat, 16 Jan 2021 05:21:45 -0800 (PST)
Received: from zn.tnic (p200300ec2f1d4300a881d5f5d537354a.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:4300:a881:d5f5:d537:354a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 456DB1EC01DF;
        Sat, 16 Jan 2021 14:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610803303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7Zz10OE8XpyB0dTcgWlutqLK3n0EMs6JDbH60sWPGjI=;
        b=CbV98VLLOHVuQ/AKo1pfRlAA5qICcSmRujq78EQi//jjOwhAOCFp70coT3RfnPVYriwief
        fAK+NAaqlULyku7Lxb6rUroHgdgxF068uGAaiMjWxTBMCaG3yZf/lBUQqfTLDvEZsz5OU8
        esQZRxOB+aMWxv93iu/wH7C4ijLPsAM=
Date:   Sat, 16 Jan 2021 14:21:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/cleanups] x86: Remove definition of DEBUG
Message-ID: <20210116132131.GA5176@zn.tnic>
References: <20210114212827.47584-1-trix@redhat.com>
 <161069669846.414.838011020047246326.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161069669846.414.838011020047246326.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Jan 15, 2021 at 07:44:58AM -0000, tip-bot2 for Tom Rix wrote:
> The following commit has been merged into the x86/cleanups branch of tip:
> 
> Commit-ID:     b86cb29287be07041b81f5611e37ae9ffabff876
> Gitweb:        https://git.kernel.org/tip/b86cb29287be07041b81f5611e37ae9ffabff876
> Author:        Tom Rix <trix@redhat.com>
> AuthorDate:    Thu, 14 Jan 2021 13:28:27 -08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Fri, 15 Jan 2021 08:23:10 +01:00
> 
> x86: Remove definition of DEBUG
> 
> Defining DEBUG should only be done in development. So remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Link: https://lkml.kernel.org/r/20210114212827.47584-1-trix@redhat.com
> ---
>  arch/x86/kernel/cpu/mtrr/generic.c | 1 -
>  arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 --

Btw, this removes the MTRR ranges output from dmesg - something which
we have had since forever. If you guys think it is still important for
debugging purposes, I can resurrect it by making all those pr_info.

This thing:

MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF write-through
  C0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000000 mask FFFF80000000 write-back
  1 base 000080000000 mask FFFFC0000000 write-back
  2 base 0000C0000000 mask FFFFE0000000 write-back
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
TOM2: 0000000820000000 aka 33280M

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
