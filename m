Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2B2D4D85
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 23:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgLIWYY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 17:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbgLIWYP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 17:24:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B436C0613CF;
        Wed,  9 Dec 2020 14:23:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f48007ada6acf171b6be1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:7ada:6acf:171b:6be1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 997B41EC04DF;
        Wed,  9 Dec 2020 23:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607552613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mgukwVob2EoCGhGApdrVTjzzZQvwndB4i7C7CK4WcWw=;
        b=iuKl6wwX+ZujgjK6wflKCtJnNRq3w7Zrk138BG6cqquQsCi1QP0LprC9E8C1zAbw3MGXPh
        gTuC5tmCDijjKs47J1W7MtB+Zvsi3HxtIjjklyYSeZPMwVXSMvWUA7WYFlAvNtR7dqE+Kq
        ls8+eO1jh0QgXc8ERIsnX6sL/jy+IY8=
Date:   Wed, 9 Dec 2020 23:23:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
Message-ID: <20201209222328.GA20710@zn.tnic>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Dec 09, 2020 at 07:06:58PM -0000, tip-bot2 for Xiaochen Shen wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 622073f..93a33b7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -320,7 +320,6 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  	}
>  
>  	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
> -	m->chunks += chunks;
>  	m->prev_msr = tval;
>  
>  	rr->val += get_corrected_mbm_count(rmid, m->chunks);


Hmm, zapping this one. First, there's an unused variable warning:

https://lkml.kernel.org/r/202012100516.H7sTNehL-lkp@intel.com

and you should remove the chunks assignment too.

And then it didn't apply cleanly:

$ test-apply.sh /tmp/xiaochen.01 
checking file arch/x86/kernel/cpu/resctrl/monitor.c
Hunk #1 FAILED at 279.
Hunk #2 succeeded at 514 (offset 64 lines).
1 out of 2 hunks FAILED

I wiggled it in but it ended up removing the wrong chunks inc line -
not the one in mbm_bw_count() but in __mon_event_count() - which I just
realized.

So please redo this patch against:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/cache

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
