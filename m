Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667D6419DD6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Sep 2021 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhI0SJQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Sep 2021 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhI0SJO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Sep 2021 14:09:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394BC061769
        for <linux-tip-commits@vger.kernel.org>; Mon, 27 Sep 2021 11:07:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f088a00001d5161ddbeebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8a00:1d:5161:ddbe:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B8FB1EC0664;
        Mon, 27 Sep 2021 20:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632766049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sFHvoCwSiMjhuMQMg6HHyZ/GDpAr2Z9UdOuS/I9lnko=;
        b=MrTfrRNlj17FvM3zi46tWdMr8JhpGdxMtLeTuUWwxm3TR/o/RX606HVdjLARFbnApUFdRS
        Ij3xsI5Eb3GXyFvJOcJ7dicMebo6dx+1mK0Jl6YaUlR9ZIMG0tUOec5iUDr6ClEP/pGdTW
        y8uM1/VNXeazo8QgYMUWVElywuK9vow=
Date:   Mon, 27 Sep 2021 20:07:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [bisected] endless sd card reader polling in tip
Message-ID: <YVIIXKmrw02FS13T@zn.tnic>
References: <688ffe368375270f6e71f0bbfac9d004cfd39867.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <688ffe368375270f6e71f0bbfac9d004cfd39867.camel@gmx.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Sep 27, 2021 at 06:56:39PM +0200, Mike Galbraith wrote:
> I then perfectly cleanly bisected the little bugger to the below.
> Mmm.. not convinced. Suggestions?

Yah, that doesn't look like a tip commit to me. Hmm, maybe we've pulled
in some broken stuff.

So what I do in such cases is bisect the tip merge commits:

$ git log --oneline --merges tip/master
d478ddf4e3cf Merge remote-tracking branch 'tip/irq/urgent' into tip-master
f9bfed3ad5b1 Merge tag 'irqchip-fixes-5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent
430117f4e609 Merge branch 'tip-x86-urgent' into tip-master
d2134885549e Merge remote-tracking branch 'tip/x86/cpu' into tip-master
723c56e57a63 Merge remote-tracking branch 'tip/timers/urgent' into tip-master
f1dfe445713e Merge remote-tracking branch 'tip/ras/core' into tip-master
ad214c6bf962 Merge remote-tracking branch 'tip/x86/fpu' into tip-master
b93350f79ec6 Merge remote-tracking branch 'tip/x86/urgent' into tip-master
f6d58d7648d4 Merge remote-tracking branch 'tip/x86/misc' into tip-master
b386cdf52519 Merge remote-tracking branch 'tip/x86/core' into tip-master
9a91b66ea202 Merge remote-tracking branch 'tip/irq/core' into tip-master
9665682cd5c3 Merge remote-tracking branch 'tip/sched/core' into tip-master
2e0f59f0ccbd Merge remote-tracking branch 'tip/x86/cleanups' into tip-master
66dced5982db Merge remote-tracking branch 'tip/locking/core' into tip-master
0a3dd0c68cfd Merge remote-tracking branch 'tip/locking/wwmutex' into tip-master
bec64008cfba Merge remote-tracking branch 'tip/perf/core' into tip-master
c6999a0491f7 Merge remote-tracking branch 'tip/objtool/core' into tip-master
9261e152ecf4 Merge remote-tracking branch 'tip/x86/cpu' into tip-master
...

You can either start in the middle of that list above and jot down in a
text file which merge is ok and which is not ok or you can simply get
the latest master, and start merging bottom to top, one by one and test
each merge in the process.

That would at least tell us which branch introduces the problem and then
we can drill down deeper.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
