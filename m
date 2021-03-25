Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E409E3489BD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 08:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYG7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCYG7s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 02:59:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5519C06174A;
        Wed, 24 Mar 2021 23:59:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616655584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqIq49+N7fAmgfwvFt9RMFYxAW8A3Q2mHvTPkDOHwzk=;
        b=MVGWO/pbseUMXOMFBa+WH9by1oc6bUfmHsHOrXlIWbAjuRWysK8YjJCQS+RocNIh2JH84L
        QW4p+2tzgj/p56xaooDTauWms5aHH58NkZDeKsdOgxSLyRwZrYXq6KaWJUQC4Sg1dDlTeh
        vxh9oo1s+/qbCGtT4VliFyZXaUltAk2tnuN2YjKCjsDIZXf1VBuuL50reKCutzYQWTPXLo
        8ppi1Hp3lPQb7cO218gYHK5L0Dzm3UvkFUMEVm4+EI5Ksbnd319gYEk6OYubF25CZXxi6V
        9uH+/sc63mYwHfueJGgK21kj+DxrD5+hejgKmOZpy4VDXcFOOxf4KivBSF5uqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616655584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqIq49+N7fAmgfwvFt9RMFYxAW8A3Q2mHvTPkDOHwzk=;
        b=NZNRgyVgWOoVaPf55SsCjNCUTkFt3IKEPS0tzeSZBOg8LsSvQc0LCYG8jULfZlGEcAJjaw
        DSf7f/KAhsEB5oBg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     tip-bot2 for Barry Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
In-Reply-To: <YFpvU30bKEZu0CSh@google.com>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com> <161485523394.398.10007682711343433706.tip-bot2@tip-bot2> <87zgzj5gpo.fsf@nanos.tec.linutronix.de> <87o8fy69e0.fsf@nanos.tec.linutronix.de> <YFpvU30bKEZu0CSh@google.com>
Date:   Thu, 25 Mar 2021 07:59:44 +0100
Message-ID: <87k0pvbtwf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Dmitry,

On Tue, Mar 23 2021 at 15:44, Dmitry Torokhov wrote:
> On Thu, Mar 04, 2021 at 07:50:31PM +0100, Thomas Gleixner wrote:
>> Please hold on:
>> 
>>   https://lkml.kernel.org/r/CAHk-=wgZjJ89jeH72TC3i6N%2Bz9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com
>> 
>> I'll recreate a tag for you once rc2 is out.
>
> It looks like the change has been picked up as
> cbe16f35bee6880becca6f20d2ebf6b457148552i on top of -rc2,
> but I don't think there is tag for it?

Sorry, forgot about it. Here you go:

      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-no-autoen-2021-03-25

Thanks,

        tglx
