Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CCE32D9AC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhCDSvb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 13:51:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbhCDSvN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 13:51:13 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614883832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlpktAyvlXWS4xtFajsvPPK4M1rR/ipWuKYVyEDaYD4=;
        b=d+/46lRy6Kpj45L4juv6QdrjQr+GxoSqbW5fplrtwfaD/UjY5wpVHKrj1Fr79IDSV7QcHF
        8VjiMXz7c/FjQ7e6I2ZAVhCipUpQyD5Wxzm9mzOLtcYpwgc56Zf30XhsWwm7qVotrHWfc7
        A/tQz8eacyrRrgBm64t+DqYGpr2pbD/F0sGPXSzehktrv+zC13nJcw0fbiasecjWY7TI8Z
        JcLQtaNA/W+3xiPmw401Y00O+7tAwn8BWO40gd96gDGluc3g0FESuD74A0xTJI0kazxYnF
        pxkfSh8KkAOfQm/MSj4lorVT8nnt8STK4qA7OvnW0iI/+ueIZ6x1TlE21EBe0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614883832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlpktAyvlXWS4xtFajsvPPK4M1rR/ipWuKYVyEDaYD4=;
        b=wJ5loI+ayFNXU2yfV1Ond+NHpRFYELPwTQ63QQSafK64v3Edd4HhKcsAXR1Dq//tCkfBhm
        AK3S8pORD/Rb3iDg==
To:     tip-bot2 for Barry Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>, dmitry.torokhov@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
In-Reply-To: <87zgzj5gpo.fsf@nanos.tec.linutronix.de>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com> <161485523394.398.10007682711343433706.tip-bot2@tip-bot2> <87zgzj5gpo.fsf@nanos.tec.linutronix.de>
Date:   Thu, 04 Mar 2021 19:50:31 +0100
Message-ID: <87o8fy69e0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Dmitry,

On Thu, Mar 04 2021 at 11:57, Thomas Gleixner wrote:
> On Thu, Mar 04 2021 at 10:53, tip-bot wrote:
>
>> The following commit has been merged into the irq/core branch of tip:
>>
>> Commit-ID:     e749df1bbd23f4472082210650514548d8a39e9b
>> Gitweb:        https://git.kernel.org/tip/e749df1bbd23f4472082210650514548d8a39e9b
>> Author:        Barry Song <song.bao.hua@hisilicon.com>
>> AuthorDate:    Wed, 03 Mar 2021 11:49:15 +13:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Thu, 04 Mar 2021 11:47:52 +01:00
>>
>> genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
>
> this commit is immutable and I tagged it so you can pull it into your
> tree to add the input changes on top:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-no-autoen-2021-03-04

Please hold on:

  https://lkml.kernel.org/r/CAHk-=wgZjJ89jeH72TC3i6N%2Bz9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com

I'll recreate a tag for you once rc2 is out.

Thanks,

        tglx
