Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F422AAA46
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Nov 2020 10:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKHJXx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Nov 2020 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHJXw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Nov 2020 04:23:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A0C0613CF;
        Sun,  8 Nov 2020 01:23:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f270b00c61e0f9d91d0a6f9.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b00:c61e:f9d:91d0:a6f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10E001EC026D;
        Sun,  8 Nov 2020 10:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604827429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a2buimtAL9Eb9fZo0UU8VGJS+43FqGvckYGeJUnPTII=;
        b=Xt22yXlrTKBB7g13Tl+fr4qsoIWvqxyCfcZlZB9EC9d8M24zllrTbQUPw04fTtJJR8APy2
        L49iu/SnDVRl+Pv0sqU+354TVIesQJ0ZTxZSHjQQcC7/8cnZBBKnvVTD5lEVc3StrRq3NQ
        iXw+GyKeNDG06XEShKimlx8lS0B1gxs=
Date:   Sun, 8 Nov 2020 10:23:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the
 atomics-check SHA1's
Message-ID: <20201108092333.GA13870@zn.tnic>
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
 <20201107160444.GB30275@zn.tnic>
 <20201108090521.GA108695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201108090521.GA108695@gmail.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Nov 08, 2020 at 10:05:21AM +0100, Ingo Molnar wrote:
> So that mode change to executable was intentional, as mentioned in the 
> changelog.

Yeah, I thought we don't make them executable in the tree but I guess we
do, at least most of them, from looking at git ls-files *.sh output.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
