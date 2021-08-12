Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E63EA771
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhHLPW4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhHLPWz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 11:22:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156FC061756;
        Thu, 12 Aug 2021 08:22:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrg8BoginmIWT80KAp60mYuc3nXoFJZV7qu1CCM8wZg=;
        b=e7gXoSgmDdXOmwz9EjwZoYE2nuJOEt9ZoruyVnn72o7AzQorqvIi1zol1ie2vqaZKH3PWN
        xtjpQaOjZTcIgFZMdNGMVxqComhFg0M91ax8e7JK2+v+k7w5NMkIBY6Gsc+5DF/eYPyTUt
        an+vZgKqp7PEarJjJIL95FEZzCLYk9skZbZzE9z8JSlkti/MfQYUIIrp8t4/sTsl5BPf+C
        Qbb9lKw77SkcZet15ITerpAtZWR5ApVFuZHvgru+Qyg//f9/0g2eLdXS16hFGmkYHB0FWT
        syt3bw4VRTLVyPa2nTdiB2naQT2LKc52dRkmJwtOx7N6mVNG6EpIVWAEeDjEvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrg8BoginmIWT80KAp60mYuc3nXoFJZV7qu1CCM8wZg=;
        b=wP8KaWssTL2dW5QxiVk8cO3frdKQGmSt46Xojm9YGQmTPb4NwXjsSf56+/S4/v77xiE7hz
        EB8ELejdkXiBhrDw==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
In-Reply-To: <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx>
 <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
Date:   Thu, 12 Aug 2021 17:22:28 +0200
Message-ID: <87v94ahemj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 12 2021 at 17:04, Mike Galbraith wrote:

> On Thu, 2021-08-12 at 16:32 +0200, Thomas Gleixner wrote:
>> 
>> Can you please test whether the below fixes it for you?
>
> Yes, that boots.

Not that I'm surprised, but I still do not know why :)

>> I have yet to find a machine which reproduces it as I really want to
>> understand which particular part is causing this.
>
> Config attached just in case.

I rather assume it's a hardware dependency. What kind of machine are you
using?

Thanks,

        tglx
