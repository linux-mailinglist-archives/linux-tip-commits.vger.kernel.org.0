Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7A3BEAAF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jul 2021 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhGGPdq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Jul 2021 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhGGPdq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Jul 2021 11:33:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E8C061574;
        Wed,  7 Jul 2021 08:31:05 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w74so3775726oiw.8;
        Wed, 07 Jul 2021 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wu589UyEpwCPZKdfA998XhHvrfJeA61TDfTMoVhy+pk=;
        b=bHrhj8aFx9B845mrCCqVMvwm56Xreg7IIlcIRbUH0VAR4z3eKoxxUyXhnstq2YBIdt
         m0V6pO6Rnkyk0cOfuYOj7xOySa6e8MGWKsYewPlEU4XR0ASg0P9T33R6T/ff/Oo21684
         qq8d94XC0Uzsj362ZpknoiBN5nj2mzBcE/ttEspCRQFLJl6vKKyaZv85bMHEz11u1Ztr
         Qb0fMjepKZvRsQV1Mugu8B4JGQY7efw7KXstRDM9zQGqPznOdKuYMyf+oY0QTn8Lsroh
         dZJR2CPELJRpYIPVsgSyNBJGDQb5SjRLsUgwgxpi1CU4M/fJQLHz7x4pvUXOVkBoX2zR
         6r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wu589UyEpwCPZKdfA998XhHvrfJeA61TDfTMoVhy+pk=;
        b=jDg4In1ox6r2MmeRaVDOIF8588NmBigt+Ck0r04afEjcP4XN+MA4CUXbExeeocjFT4
         wJW1DfP7abxn5r3jw3F/etX3sjy3vNFOXXZE+6hrDxazaPZ7hPMgZ3PBhI2q3LKYwgSg
         eOvuGIsD7serPjgndgxvv39VpXgzwomLgsVnNZsVDhMZxD/JJoK9ts1rVpCIxaMJMcbv
         rs/YXXEPQRXKqe2DllBNVKOqioXKOCUAJ0IIQjaqzM26WH7ZEPitobzjys7Rsm3NdNhT
         qFWRx7soV+gZO0G/90Urmar56Uj+vZPKGfLlHaFHY4c7ZXLexwN0z7TmfGhYZyscRqYs
         P9FQ==
X-Gm-Message-State: AOAM533320q8QD6q4kqDiMSUfXzvYTcilpz05y/ZlGMPvflQjNFwy31X
        jGpoBS+JlyiJlMGieBkuf58=
X-Google-Smtp-Source: ABdhPJyoBc3Zr0VgUI8Aq6qjdaQ1z5XORqMS6vMI3+Oopvw0S7h+Hp71EWwKOIwftVjKxVjKBJaWBA==
X-Received: by 2002:aca:534b:: with SMTP id h72mr7724461oib.21.1625671865355;
        Wed, 07 Jul 2021 08:31:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7sm3555730ooo.9.2021.07.07.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 08:31:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 7 Jul 2021 08:31:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/core: Initialize the idle task with
 preemption disabled
Message-ID: <20210707153102.GA1243141@roeck-us.net>
References: <20210512094636.2958515-1-valentin.schneider@arm.com>
 <162081815405.29796.14574924529325899839.tip-bot2@tip-bot2>
 <20210706194456.GA1823793@roeck-us.net>
 <87fswr6lqv.mognet@arm.com>
 <20210707120305.GB115752@lothringen>
 <87czru727k.mognet@arm.com>
 <c30097f3-63b4-6fa0-a369-8f4e20ee1040@roeck-us.net>
 <de7b1d0f-8767-1b33-2950-576029c0d9f7@ozlabs.ru>
 <878s2i6uk2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s2i6uk2.mognet@arm.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Jul 07, 2021 at 03:57:17PM +0100, Valentin Schneider wrote:
> On 08/07/21 00:35, Alexey Kardashevskiy wrote:
> > On 08/07/2021 00:14, Guenter Roeck wrote:
> >>
> >> Can you reproduce the problem with a powerpc qemu emulation ?
> >> If so, how do you reproduce it there ? Reason for asking is that I don't
> >> see
> >> the problem with any of my powerpc emulations, and I would like to add test
> >> case(s) if possible.
> >
> > I can reproduce the problem on powerpc easily - qemu with "-smp 2" does it.
> >
> 
> So on powerpc I'm chasing a slightly different problem, reported at
> [1]. I couldn't get it to trigger on qemu for powerpc64, and I'm still
> struggling with powerpc. Could you please share you qemu invocation &
> kernel .config? Thanks.
> 
Same here. Actually, worse: All 32-bit ppc emulations I tried to
run with more than 1 CPU crash when bringing up the 2nd CPU,
and that even happens with 5.13.

So, yes, please share your qemu command line and the kernel
configuration.

Thanks,
Guenter
