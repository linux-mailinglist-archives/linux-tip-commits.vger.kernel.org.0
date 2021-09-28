Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4541ABC7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Sep 2021 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhI1J32 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 28 Sep 2021 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbhI1J32 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 28 Sep 2021 05:29:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE2C061575
        for <linux-tip-commits@vger.kernel.org>; Tue, 28 Sep 2021 02:27:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b20096a750066da08c79.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:96a7:5006:6da0:8c79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F5E41EC06C2;
        Tue, 28 Sep 2021 11:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632821263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cYEPAa/E/PcTahNnaunE5XEl00cNIcGTV4DmfDQ70HA=;
        b=L23ScCSGhKqd7dL9oGbzWphcF0MdBe1BlhKl6NjZcaiiToLuyhRQGRYaIYvf95iBGNZEs5
        5yp1r4XznM47S86t3+h2MIK00UuNsdmZWSDtZ+12jsQj6KaprKBr6GIsMCdSkW9C5MznTF
        r9BiUPmdCpXK1J4YM3U5n0TjYUOWsu8=
Date:   Tue, 28 Sep 2021 11:27:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [bisected] endless sd card reader polling in tip
Message-ID: <YVLgDiva3S2thMju@zn.tnic>
References: <688ffe368375270f6e71f0bbfac9d004cfd39867.camel@gmx.de>
 <YVIIXKmrw02FS13T@zn.tnic>
 <3dac2fe735de34497dc5fe465337f2d61bbf2a46.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dac2fe735de34497dc5fe465337f2d61bbf2a46.camel@gmx.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 28, 2021 at 05:18:21AM +0200, Mike Galbraith wrote:
> Well, looks like it's gotta be a timing Fairy tickling my hardware or
> such.  Who knows, maybe the thing has been intermittently behaving this
> way and the new to this cycle printk just made it visible.
>
> I merged tip into master, and it works fine.  Thinking maybe there's a
> merge artifact in the tip clone, I merged master into it, and diffed
> the result of both merged trees - they're identical, and work fine.
> Build freshly cloned tip/master (d478ddf4e3cf), and it's bad.
>
> Elves 'n Gremlins, crap hardware, even crappier bios... <shrug>.

Oh great. :-\

Ok, I guess there's no need to spend any more time on this transient
balooney. Lemme recreate tip/master ontop of -rc3 - that should at least
make it go away.

Please lemme know if it doesn't.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
