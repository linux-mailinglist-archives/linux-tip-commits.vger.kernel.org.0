Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC12D582E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLJK11 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 05:27:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53924 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLJK1R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 05:27:17 -0500
Received: from zn.tnic (p200300ec2f0d4100a171b3ea1c390962.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:a171:b3ea:1c39:962])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3452C1EC054E;
        Thu, 10 Dec 2020 11:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607595991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vf9Zlp+3Kfqw0T186f/Eo5AjlBZAfwUY/WJoVr5Mbc4=;
        b=mjAsE24CIP5fp48Ydf7wK7bYRSJrzEf8vLy4shcWTaDTplyutx1ULcvZbGtUZiOISY6HZ3
        tkV41ZTEk4229AdukjxIPH4g8fJEQ3vjW70Px70ibOpIeLJTISqkkOGsAkb9l4rr+cOQ4O
        Jzrc+S8FEU5bYn8i66TAIhq59O81nJY=
Date:   Thu, 10 Dec 2020 11:26:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
Message-ID: <20201210102625.GA26529@zn.tnic>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
 <20201209222328.GA20710@zn.tnic>
 <343e2fc7-6f64-d1b7-2ea1-cd422596f5be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <343e2fc7-6f64-d1b7-2ea1-cd422596f5be@intel.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Dec 10, 2020 at 12:45:11PM +0800, Xiaochen Shen wrote:
> Thank you for clarifying this issue. It is not a 0-DAY CI issue.

Which begs the question: this patch should be Cc: stable and should go
in now, shouldn't it?

Because then the first submission applies cleanly ontop of
tip:x86/urgent.

I mean, it is fixing only reporting but that reporting is kinda waaay
off.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
