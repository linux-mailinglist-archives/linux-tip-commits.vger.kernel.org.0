Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9D149C11
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jan 2020 18:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgAZRUC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Jan 2020 12:20:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35196 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZRUC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Jan 2020 12:20:02 -0500
Received: from zn.tnic (p200300EC2F25DF00BC613C117BE1B9E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:df00:bc61:3c11:7be1:b9e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE8BB1EC0B86;
        Sun, 26 Jan 2020 18:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580059201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n7aSfQAjmPocxoYvQlfxhkiRM5ozfGvvTpJJo0eEO6M=;
        b=WXhtVuCcheWjdviXuCfy4VcWr/pVU8bUs6GWnc8GXbZce4mAqsmFcfwE2Vgoko2HDiLzIW
        h6ut3htAmXO6/t2XtASvLEV+avpuEuj0vK5EfMQVvPL53CiDD+kDWzdeUrLFSxN6Og7YfA
        t+N6Ei92L0HCBNBPlds1gOIZFkyUd9o=
Date:   Sun, 26 Jan 2020 18:19:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200126171956.GB5714@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
 <20200126014318.GA5122@paulmck-ThinkPad-P72>
 <20200126112540.GA5714@zn.tnic>
 <20200126152831.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200126152831.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, Jan 26, 2020 at 07:28:31AM -0800, Paul E. McKenney wrote:
> And thank you for finding this and for the testing!
> 
> May I add your Tested-by?

Sure, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
