Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C96411758
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Sep 2021 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhITOpe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Sep 2021 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhITOpe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Sep 2021 10:45:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097EBC061574;
        Mon, 20 Sep 2021 07:44:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2a00e73b029b43000742.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:e73b:29b:4300:742])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62CFC1EC03D5;
        Mon, 20 Sep 2021 16:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632149041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ea5xZHoUMGBwgu76M0o+Vcth/gDSBplKYX9AxVJC3IE=;
        b=DwfxAXLVojXzp1sgzQuAARmRQKtxOVeVnDhFsr97ty4PYd5Dvc5cwSW//aIS0Q+U1Oy6f2
        0btvEQzGZmM4btL7kMHckg1gezgYxWanDpU83SiPL3+OjYV47YNz0r7ZFx7fSA1862dj+O
        vc7f0AqHkH7bA76BDnjh6aIGetlz2h8=
Date:   Mon, 20 Sep 2021 16:43:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/fault: Fix wrong signal when vsyscall
 fails with pkey
Message-ID: <YUieKy6bqcYEVVq3@zn.tnic>
References: <20210730030152.249106-1-liangjs@pku.edu.cn>
 <163213455900.25758.11915876484367505676.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163213455900.25758.11915876484367505676.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 20, 2021 at 10:42:39AM -0000, tip-bot2 for Jiashuo Liang wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     0829d0b6bf0fb3453608798442deaf00c4a1abec
> Gitweb:        https://git.kernel.org/tip/0829d0b6bf0fb3453608798442deaf00c4a1abec
> Author:        Jiashuo Liang <liangjs@pku.edu.cn>
> AuthorDate:    Fri, 30 Jul 2021 11:01:52 +08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Mon, 20 Sep 2021 12:31:06 +02:00
> 
> x86/fault: Fix wrong signal when vsyscall fails with pkey
> 
> The function __bad_area_nosemaphore() calls kernelmode_fixup_or_oops()
> with the parameter @signal being actually @pkey, which will send a
> signal numbered with the argument in @pkey.
> 
> This bug can be triggered when the kernel fails to access user-given
> memory pages that are protected by a pkey, so it can go down the
> do_user_addr_fault() path and pass the !user_mode() check in
> __bad_area_nosemaphore().
> 
> Most cases will simply run the kernel fixup code to make an -EFAULT. But
> when another condition current->thread.sig_on_uaccess_err is met, which
> is only used to emulate vsyscall, the kernel will generate the wrong
> signal.
> 
> Add a new parameter @pkey to kernelmode_fixup_or_oops() to fix this.
> 
>  [ bp: Massage commit message. ]
> 
> Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")
> Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lkml.kernel.org/r/20210730030152.249106-1-liangjs@pku.edu.cn
> ---
>  arch/x86/mm/fault.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Zapping it again because the 0day bot found some randconfig which fails:

https://lkml.kernel.org/r/202109202245.APvuT8BX-lkp@intel.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
