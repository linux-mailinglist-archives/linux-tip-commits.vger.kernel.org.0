Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EA2D6280
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392206AbgLJQva (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbgLJQvS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 11:51:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D9AC0613CF;
        Thu, 10 Dec 2020 08:50:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d4100e4701ee3c8ed8bc5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:e470:1ee3:c8ed:8bc5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15A4A1EC054C;
        Thu, 10 Dec 2020 17:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607619037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ltz1Gfhlkm8S+aCwj4HHLeku70bwDcxrbCUdyuzFSkY=;
        b=eCz12k74oVhUbZxwC91mbegEvVLKouI1zkf7q4Vc7K7Wx3nnJgP/2k70FrZHsO88h2UsUk
        tY4T4NftHDw2r7LAYzS/r3i/0OaXhb6USMWwz7791avgZudVsBn46S1ksaeHgfcTk3e7wI
        o+r1UT4OgbKBEWWtvmVc1wiXynkYt/Q=
Date:   Thu, 10 Dec 2020 17:50:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
Message-ID: <20201210165037.GC26529@zn.tnic>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
 <20201209222328.GA20710@zn.tnic>
 <343e2fc7-6f64-d1b7-2ea1-cd422596f5be@intel.com>
 <20201210102625.GA26529@zn.tnic>
 <f965241c-69c7-c021-47c9-ef0c028e8399@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f965241c-69c7-c021-47c9-ef0c028e8399@intel.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Dec 11, 2020 at 12:40:46AM +0800, Xiaochen Shen wrote:
> I plan to do backporting for all -stable trees after this patch is merged
> into upstream.

Ok, you can do that when Greg sends the mails that it cannot apply to
the respective trees. Lemme queue this one to urgent now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
