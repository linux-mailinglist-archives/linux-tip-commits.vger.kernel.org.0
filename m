Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F51183201
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Mar 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLNtp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Mar 2020 09:49:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgCLNtp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Mar 2020 09:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584020983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJs8yOMXumhEsBAQIQNOmZwhjwQqs4MeidJ20K6lf6M=;
        b=ZUXzgAItwOlbusT9W6m0ffsAGzEpiNndLBcJdxW0kUTJIikBspoz+o/iL1msR01a4tGFIE
        dHQLOj/0kseDgh9K+91NV7SCmv5Bhe5Y4z8qaOLDeTUIl7UKr8FapPqbp7dQB6vE9dIfIK
        PtyUJLpM/PkTFVkFOELSataTeJYuZs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-nKbXuHN6Owq0WYVF0fcj4Q-1; Thu, 12 Mar 2020 09:49:41 -0400
X-MC-Unique: nKbXuHN6Owq0WYVF0fcj4Q-1
Received: by mail-wm1-f70.google.com with SMTP id z26so2383117wmk.1
        for <linux-tip-commits@vger.kernel.org>; Thu, 12 Mar 2020 06:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJs8yOMXumhEsBAQIQNOmZwhjwQqs4MeidJ20K6lf6M=;
        b=Q8IK0zxf3ac3XO07/ucTj1jxAUv+jAFoSZuFO6/XSo2NsHmERjEFMkBWBiCGTOFsyt
         h9fVehPGRfjiWnTcbbTdFjPo9dgSy/Va2c+nn+zVf4Qs6cE5J2Q3VlRebk1XQ6SsICg3
         Uc4QYRovl1JHCKkh9AUDf64NOFcMv+O4kgz0hze9R+2IM2IsGey+RL3BOhZU467T6QjI
         4P7sEUie/JnZxsFUDimFXgZWCc3RpKLOlA1L4pbvDUK1NZtUBVnFPl93rpo5Pd7OhmOw
         T3OOCli9821XhVhxaQJ7l53c7dWX/68X7HRih6iNDBELYNgPjB3ebF/t5ExuEqlZ1wN/
         aBwg==
X-Gm-Message-State: ANhLgQ3RkL1HLa9ToWnEqQYoYAiWO0fobiEiDHCLQC3e4IPFguiQbkec
        95iR1rhLtUcs9IGaFRmPXMQBywmoP9dgAA2iG6OxOwkuvKD1nEYlX8yrYBksYCcezzMkWixlem2
        LZSo7Qo01eo4bck6y/itQlX7p9QAaY88=
X-Received: by 2002:adf:f847:: with SMTP id d7mr10753584wrq.31.1584020980565;
        Thu, 12 Mar 2020 06:49:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtKExZ6/bWWQcZnhHrIyO98G2UtYV/EjSkAe+g7eZomMLrn+gXs4sxMr/u97SFeMezwkn3ubQ==
X-Received: by 2002:adf:f847:: with SMTP id d7mr10753567wrq.31.1584020980343;
        Thu, 12 Mar 2020 06:49:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id g7sm274970wrs.68.2020.03.12.06.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:49:39 -0700 (PDT)
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
References: <20200123210242.53367-1-hdegoede@redhat.com>
 <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
 <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1cb0397f-e583-3d7e-dff3-2cc916219846@redhat.com>
Date:   Thu, 12 Mar 2020 14:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

On 3/12/20 2:31 PM, Linus Walleij wrote:
> On Wed, Mar 11, 2020 at 10:42 PM tip-bot2 for Hans de Goede
> <tip-bot2@linutronix.de> wrote:
> 
>>          select GENERIC_GETTIMEOFDAY
>>          select GENERIC_VDSO_TIME_NS
>>          select GUP_GET_PTE_LOW_HIGH             if X86_PAE
>> +       select HARDIRQS_SW_RESEND
> 
> Just help me understand the semantics of this thing...
> 
> According to the text in KConfig:
> 
> # Tasklet based software resend for pending interrupts on enable_irq()
> config HARDIRQS_SW_RESEND
>         bool
> 
> According to
> commit a4633adcdbc15ac51afcd0e1395de58cee27cf92
> 
>      [PATCH] genirq: add genirq sw IRQ-retrigger
> 
>      Enable platforms that do not have a hardware-assisted
> hardirq-resend mechanism
>      to resend them via a softirq-driven IRQ emulation mechanism.
> 
> so when enable_irq() is called, if the IRQ is already asserted,
> it will be distributed in the form of a software irq?
> 
> OK I give up I don't understand the semantics of this thing.
> 
> Maybe it's because I think of a register where the IRQ line
> is just a level IRQ bit thing that stays high as long as the IRQ
> is not handled.
> 
> So I suppose it is for any type of transient IRQ such as
> edge triggered that happened before the system came back
> online entirely and now the only remnant of it is a bit in
> the irchip status register?

The way I understand it is like this:

1. We have an edge triggered IRQ from a peripheral to a
GPIO controller

2. We have a level triggered IRQ from the GPIO controller to the
"root" IRQ controller.

3. With modern x86 suspend, we do not really put the entire
system in a firmware-controller suspend state, instead the CPU is
halted until any IRQ happens; and there is a power-management
micro-controller which shuts various things down while the CPU
is halted leading to similar power consumption as old S3 suspend.

The combination of these 3 means that we must ack the edge
triggered IRQ at the GPIO controller level even while suspended
(we briefly wake up for this) to make the level-triggered IRQ
coming from the GPIO controller low so that we can go back to sleep.

When this happens we record in the kernel IRQ tracking data for
the edge-triggered IRQ tied to the GPIO (there are no "remnants"
of it in any chuip registers), that the IRQ needs to be replayed
on resume. Some IRQ controllers allow writing a register to
retrigger the IRQ without the level on the external GPIO actually
changing.

Some IRQ controllers do not allow this, in this case we need to
emulate this retriggering in software, this is what the
HARDIRQS_SW_RESEND option is for, this handles this in a generic
way, so that we do not have to add emulation to every IRQ-chip
driver where the hardware lacks a "retrigger" register.

> I see that ARM and ARM64 simply just select this. What
> happens if you do that and why is x86 not selecting it in general?

Erm, "selecting it in general" (well at least on x86) is what
this patch is doing. But I guess you mean why is this not
selected on all architectures?  If I've understood tglx correctly
the HARDIRQS_SW_RESEND option is incompatible with some irq-chip
drivers. I think it was incompatible with using nested threaded
handlers are some such...

tglx can probably explain this way better then I can :)

Regards,

Hans

