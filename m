Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE022ED8A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jul 2020 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgG0Ni3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Jul 2020 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0Ni2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4FC061794;
        Mon, 27 Jul 2020 06:38:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595857107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2BEpkI5vpGjWsm2oiyzPGU1NItFEGOQoSzuPNAbSWY=;
        b=WHZ+kc1LDZiycuwM8s1HhaC7PR6hPF8kId0KV438qsfbahmYdlB1EHRMOw8FKUziuZ7ufU
        oYbMnXW+YniqQgr1eq9gGzKdDGKTbE8afv3rBCtU8G1nkGvu8Ff3d3i6B00WBbArQR0k5S
        OOWG8/4hycdACA4hIkn8gt9KMNm7Dz3PrAKgn0rSTJHMLxZMS28XlaNwiNylOWKhFWANqP
        nHdi2+UHeBRlIfo/jJmuwDFY2k67h07lCWxmsatYOyc3hHLRbPZR1oleepzj3/J2ptgjBJ
        KpxprlL77nmkaWJHd5CbMYZ2iuj6Rsw7X3B54JEjukGbD+ToJveZxdOolK5gzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595857107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2BEpkI5vpGjWsm2oiyzPGU1NItFEGOQoSzuPNAbSWY=;
        b=Z+f4ULUl2G2uBKiIkvf9zO71cFu/N2rXkClyOFy2z8kTKjHimuyTzpbTTi2ZCcFY+kC4Me
        cV4tkZcCohMkq7Bw==
To:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Consolidate 32/64 bit syscall entry
In-Reply-To: <CAMzpN2ipn3tK7hg4njCG-svtbYSP_nmzr0mWHZCrkaJFYMuXWw@mail.gmail.com>
References: <20200722220520.051234096@linutronix.de> <159562150262.4006.11750463088671474026.tip-bot2@tip-bot2> <CAMzpN2ipn3tK7hg4njCG-svtbYSP_nmzr0mWHZCrkaJFYMuXWw@mail.gmail.com>
Date:   Mon, 27 Jul 2020 15:38:26 +0200
Message-ID: <871rkxcc31.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:
> On Fri, Jul 24, 2020 at 4:14 PM tip-bot2 for Thomas Gleixner
>>
>> -static bool __do_fast_syscall_32(struct pt_regs *regs)
>> +static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>
> Can __do_fast_syscall_32() be merged back into do_fast_syscall_32()
> now that both are marked noinstr?

It could.
