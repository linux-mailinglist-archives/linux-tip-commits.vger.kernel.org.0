Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D102D4DAC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgLIW2R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 17:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgLIW2K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 17:28:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4108C0613CF;
        Wed,  9 Dec 2020 14:27:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f48007ada6acf171b6be1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:7ada:6acf:171b:6be1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87AC01EC04DF;
        Wed,  9 Dec 2020 23:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607552848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h2fy0fvnYwFLjDBti98s5w3tsvjjCKMi6HmPbW6kDFA=;
        b=g44GVv8ztExuHyFGN4yx1tL2ZPlrAr2leof+bYGdVea/+N/HCoNYGMXR2N5zScrFXWUoyl
        7HdA6XId2qWO6AYehMSdYHSEgG6sYLu2DTnoCUCmI2SqDb7d5hytfLTdYXaNE4b8F2qvG2
        ODM0tcqxI9mDaF16HPUF5Dla5ZBxQJ8=
Date:   Wed, 9 Dec 2020 23:27:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
Message-ID: <20201209222729.GC20638@zn.tnic>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
 <20201209222328.GA20710@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209222328.GA20710@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Dec 09, 2020 at 11:23:28PM +0100, Borislav Petkov wrote:
> and you should remove the chunks assignment too.

Yah, ignore that part - mbm_bw_count() does need chunks for cur_bw. Oh
well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
