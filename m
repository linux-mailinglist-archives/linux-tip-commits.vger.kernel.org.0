Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31C646EC29
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Dec 2021 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhLIPwx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Dec 2021 10:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234463AbhLIPww (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Dec 2021 10:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639064958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vE3X5PcC2Z2O022xsm2IPMV0azzJRXIn3o/0Te950Do=;
        b=OtPbYnV03gL61O/FDqHQ1DnJq2zWyP/rltPFvz8zngwUfE9Y1gs82/gO6M4ic4DmsXbcLl
        WUbBurPlKT5mMx01h0vFbsgsS5pTqs4DL31oHMDBN+Xgh161HotyUVjX8pmYutW90iFx5J
        /JvTXWcSdZfb2+uGS6AiwQ7yIrX9+fo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-lc7EIovxOhOQta_y1EXGgw-1; Thu, 09 Dec 2021 10:49:17 -0500
X-MC-Unique: lc7EIovxOhOQta_y1EXGgw-1
Received: by mail-vk1-f197.google.com with SMTP id u4-20020ac5c924000000b002fe4e2bb06aso3661381vkl.22
        for <linux-tip-commits@vger.kernel.org>; Thu, 09 Dec 2021 07:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vE3X5PcC2Z2O022xsm2IPMV0azzJRXIn3o/0Te950Do=;
        b=6pDOyEBvB9g7UecdN76WAWZfdMEod1bed8U5mg83JvfKhzdgFDcHdRhpm4AFilGjmZ
         UCwbkLfSNoTb9uURDMTuT7K2Y2/RqLk5nWHs1EZxzKqY+8TFis07ZZxcvnGrvS0J1cG8
         IQUf+eVRBzJYZpcpP0RX8vxQzRe63TVGFKG3YK2PIsgJakZbvM9wlogzRVro9pc6jFfl
         6CxwwZfNphjY1qWeMJvculj5OEKf8RgI7DJwr6njU+wHPXeDLhyua60fFro0pgdvMiuq
         Je0D/OemlIPNbSjGilSa+93SUoRx2uOBh+B1VoPyRUtaAD7oQk+5Wkf7LjMEPjJcNk5c
         olzQ==
X-Gm-Message-State: AOAM531TcNv+8segOpIm5o0p8IpYmUHJ1OJVroHsmrMoKxLDU+sVFU63
        Ukdjv+p3mSr0jQLKZcSKgtsQwnGZg0U5u9Pw1jk5WvLWkm4/SxvWfgnV+Y+dCUv8vbHCk3ktiSo
        hRaguJLIIcL06Dqtx9TkPtEehoUpbkyHsG+xt0a9NdNKCwVM=
X-Received: by 2002:ab0:7c7a:: with SMTP id h26mr19971077uax.103.1639064957162;
        Thu, 09 Dec 2021 07:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4wuiX9hG4fcizCLh5b8/IBZgxmPJD9LNvpo3V+fGeBIqyXBqv7E3265Vjgr7wZY3XOUM/6M/snrmEXgtRaWo=
X-Received: by 2002:ab0:7c7a:: with SMTP id h26mr19971056uax.103.1639064956957;
 Thu, 09 Dec 2021 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <163697618022.414.12673958553611696646.tip-bot2@tip-bot2>
 <20211209143810.452527-1-jdorminy@redhat.com> <YbIeYIM6JEBgO3tG@zn.tnic>
In-Reply-To: <YbIeYIM6JEBgO3tG@zn.tnic>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 9 Dec 2021 10:49:06 -0500
Message-ID: <CAMeeMh_Huv-XAx4WHRDvTNoZb3J76y0jft05u18uGAfVCrj96w@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/boot: Pull up cmdline preparation and early
 param parsing
To:     Borislav Petkov <bp@alien8.de>
Cc:     tip-bot2@linutronix.de, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Dec 9, 2021 at 10:19 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + Hugh and Patrick.
>
> On Thu, Dec 09, 2021 at 09:38:10AM -0500, John Dorminy wrote:
> > Greetings;
> >
> > It seems that this patch causes a mem=3D parameter to the kernel to hav=
e no effect, unfortunately...
> >
> > As far as I understand, the x86 mem parameter handler parse_memopt() (c=
alled by parse_early_param()) relies on being called after e820__memory_set=
up(): it simply removes any memory above the specified limit at that moment=
, allowing memory to later be hotplugged without regard for the initial lim=
it. However, the initial non-hotplugged memory must already have been set u=
p, in e820__memory_setup(), so that it can be removed in parse_memopt(); if=
 parse_early_param() is called before e820__memory_setup(), as this change =
does, the parameter ends up having no effect.
> >
> > I apologize that I don't know how to fix this, but I'm happy to test pa=
tches.
>
> Yeah, people have been reporting boot failures with mem=3D on the cmdline=
.
>
> I think I see why, can you try this one:
>
> ---
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71..6db971e61e4b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -862,6 +862,8 @@ void __init setup_arch(char **cmdline_p)
>          */
>         x86_configure_nx();
>
> +       e820__memory_setup();
> +
>         /*
>          * This parses early params and it needs to run before
>          * early_reserve_memory() because latter relies on such settings
> @@ -884,7 +886,6 @@ void __init setup_arch(char **cmdline_p)
>         early_reserve_memory();
>
>         iomem_resource.end =3D (1ULL << boot_cpu_data.x86_phys_bits) - 1;
> -       e820__memory_setup();
>         parse_setup_data();
>
>         copy_edd();
> ---
>
Confirmed that that patch makes mem=3D work again:

[    0.000000] Command line:
BOOT_IMAGE=3D(hd0,msdos1)/boot/vmlinuz-5.16.0-rc4+ root=3DUUID=3D0e
750e61-b92e-4708-a974-c50a3fb7e969 ro net.ifnames=3D0 crashkernel=3D128M me=
m=3D4G
...
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007dd3afff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007dd3b000-0x000000007deeffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007def0000-0x000000007e0d3fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007e0d4000-0x000000007f367fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f368000-0x000000007f7fffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207fffffff] usabl=
e
[    0.000000] e820: remove [mem 0x100000000-0xfffffffffffffffe] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] user: [mem 0x000000000009ac00-0x000000000009ffff] reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] user: [mem 0x0000000000100000-0x000000007dd3afff] usable
[    0.000000] user: [mem 0x000000007dd3b000-0x000000007deeffff] reserved
[    0.000000] user: [mem 0x000000007def0000-0x000000007e0d3fff] ACPI NVS
[    0.000000] user: [mem 0x000000007e0d4000-0x000000007f367fff] reserved
[    0.000000] user: [mem 0x000000007f368000-0x000000007f7fffff] ACPI NVS
[    0.000000] user: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] user: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
[    0.000000] user: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
...
[    0.025520] Memory: 1762976K/2061136K available (16394K kernel
code, 3568K rwdata, 10328K rodata, 2676K init, 4924K bss, 297900K
reserved, 0K cma-reserved)

