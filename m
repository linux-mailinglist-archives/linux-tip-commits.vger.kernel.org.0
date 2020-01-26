Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE6149A5A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jan 2020 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgAZLZm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Jan 2020 06:25:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgAZLZm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Jan 2020 06:25:42 -0500
Received: from zn.tnic (p200300EC2F25DF008C8DC1F5EA2ED5CC.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:df00:8c8d:c1f5:ea2e:d5cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE4791EC0CAD;
        Sun, 26 Jan 2020 12:25:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580037941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wq7+mev89++1ohlJHiO+2xBlUXDLtwx077Nyk9oE8k8=;
        b=m1hG+/H39UpK8PqKd1FMivec2Jh/4sLN8G8CZ08H9FFjFYuQzS15YTgaeghgTPQqJmmgPB
        loJjkPWCNMvzByjIevktkGrdykB9KEw6FnZE7eKK1kZesAr2RGkphur6O8FV2ejVEIzaIH
        h1hDNOVU1GClqHzftpohgT3fi0FXEyk=
Date:   Sun, 26 Jan 2020 12:25:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200126112540.GA5714@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
 <20200126014318.GA5122@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200126014318.GA5122@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Jan 25, 2020 at 05:43:18PM -0800, Paul E. McKenney wrote:
> And it passes my rcutorture testing as well!  If it does fine with 0day
> and -next, I will send a pull request Sunday evening, Pacific Time.
> In the meantime, it is right here in -rcu:
> 
> 59d8cc6b2e37 ("rcu: Forgive slow expedited grace periods at boot time")

Yap, testing looks good here too.

Thx Paul.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
