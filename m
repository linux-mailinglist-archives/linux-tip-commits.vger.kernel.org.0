Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6318317F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Mar 2020 14:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCLNcC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Mar 2020 09:32:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44982 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgCLNcB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Mar 2020 09:32:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so6412047ljp.11
        for <linux-tip-commits@vger.kernel.org>; Thu, 12 Mar 2020 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phv583KHgmBN6ZIVEZQJosCjBmDR5QWY1wYtWrk+Juk=;
        b=ZpxD3GkJmXvns9f57dn2keS/VYDG/MpB5ltln4W+Yas9UvW5h9zULypVP8+Qpi8im0
         LBQ0oZYOBeo3jY6AujhmlRTFWPIqsbSMj0C7aW13Bl/puSyQydSV1j+AmdjUGuJ/zmU3
         6MiP4hudPrZ2helO0ort+5942twdvOeeESml0HEx8vPU2GoUQRZ3cjOVEYQY99s7x52A
         KwaaBPfJZQxrW1Ct7OsWDnZfoTGBiMxfwMfS76PN9vpz80ARipO2RKYPaCgOvSBFUF/A
         rmnibzWIgMUS0U08nZ6tpcayypdAp0x6tQdmUOWO8A5sfOa7fYgZK4DYPrz56+aHb9eX
         9ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phv583KHgmBN6ZIVEZQJosCjBmDR5QWY1wYtWrk+Juk=;
        b=fVL9wHpoYCA/ErbRHDvg3IIsaSQ64rmA5ZwJWlpSfa+zxyjcxBlC7pvLRoMY2YKYrU
         qIQIlcFv5kO0W5gKgt5ni8+MKtyTHV6yeO5gZL3e/Upah3sKHZvLsYVrrZTGN+oJQtAz
         +i1oQBZzQ0mpDWEVEl/bjaDRosHlThdlvXPFg15LE3C4UWFVK4/HhNYtSBRhnD+GFO9e
         9H+MyjcbI89HPhj44ftZW0bJGI90A0Ki9XiHLOn14/xUav+r2DOIBggshC7vdXfpW9gK
         BgpGGAH7GpS+SCcG11VhYsq+sB9Tj39dJBKczM+3rXG98JVJC9wAzh3QFlRFr/rDI2f+
         xL3Q==
X-Gm-Message-State: ANhLgQ3jhw+zWHthO/cTA0KXN5t/KQ4LfsHWPtTOc5o3REmuJ4uKDpaW
        9f9nIUHzG4iy2jH1so0GZMPjcRe4qk/K0ISFz/3f3g==
X-Google-Smtp-Source: ADFU+vuIYXztVHLH+xsxSsMmMMXpQW+CFPyPa/bMdKIHfiqTcj9pSicijGhKiAHkEGcfLbtDx9szdwkIKD9offP2dO0=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr5020478ljm.168.1584019918638;
 Thu, 12 Mar 2020 06:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200123210242.53367-1-hdegoede@redhat.com> <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
In-Reply-To: <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:31:47 +0100
Message-ID: <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 11, 2020 at 10:42 PM tip-bot2 for Hans de Goede
<tip-bot2@linutronix.de> wrote:

>         select GENERIC_GETTIMEOFDAY
>         select GENERIC_VDSO_TIME_NS
>         select GUP_GET_PTE_LOW_HIGH             if X86_PAE
> +       select HARDIRQS_SW_RESEND

Just help me understand the semantics of this thing...

According to the text in KConfig:

# Tasklet based software resend for pending interrupts on enable_irq()
config HARDIRQS_SW_RESEND
       bool

According to
commit a4633adcdbc15ac51afcd0e1395de58cee27cf92

    [PATCH] genirq: add genirq sw IRQ-retrigger

    Enable platforms that do not have a hardware-assisted
hardirq-resend mechanism
    to resend them via a softirq-driven IRQ emulation mechanism.

so when enable_irq() is called, if the IRQ is already asserted,
it will be distributed in the form of a software irq?

OK I give up I don't understand the semantics of this thing.

Maybe it's because I think of a register where the IRQ line
is just a level IRQ bit thing that stays high as long as the IRQ
is not handled.

So I suppose it is for any type of transient IRQ such as
edge triggered that happened before the system came back
online entirely and now the only remnant of it is a bit in
the irchip status register?

I see that ARM and ARM64 simply just select this. What
happens if you do that and why is x86 not selecting it in general?

Explain it to me and I promise to patch kernel/irq/Kconfig
with the explanation so you don't have to give it again.

Yours,
Linus Walleij
