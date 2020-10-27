Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7929CD4D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 02:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ1Bi0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 21:38:26 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40250 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832993AbgJ0XT5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 19:19:57 -0400
Received: by mail-yb1-f195.google.com with SMTP id n142so2689038ybf.7
        for <linux-tip-commits@vger.kernel.org>; Tue, 27 Oct 2020 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxA/FTzW2i1d24RS8IAJvgkUnZ1daeCJad8ZQtHPyjw=;
        b=ZV3b04sKyAaIqU6I+07pnq7LItgyzOJZINCJ8GoWSTTPVIMukV6X/LG0pxhXTmHkf9
         85DxHPmw6TLUULyhxLOvwxlMSLY1HKupqIlRsiozckcTJ7mpCbmjDOzypWIG8GyB5/4a
         4XHEQHsyv+qQdue/uzR1XKIhDk+uEhNba33GbHT3QqCR+PlbLGPOUxN10uauNfa2bdd1
         fWjzE9cNg6N852LKGtgxRaQYO0zryOokP/MuSxzaRMXTMp8YMdp3g6KomBCqpTMjjQJQ
         DPuXnUnrtSVTfTgID2XEQ3borI8Dw+/S4jijpvtqyPLYtFmwZyhWYiqdAOdISnYnKuse
         UqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxA/FTzW2i1d24RS8IAJvgkUnZ1daeCJad8ZQtHPyjw=;
        b=S8Zq6ZKfVRfUYZkoFOjZQCr6blE23axY1TiM+zUXN03pj5JdmfKHLBcq3+GWH//t4d
         ZGr7IEdmnIzUhDIGrGyRhscDTJV5dAMDGUvh4bbcCYnDbVHOkfD39Cu8cXWoxHDYL2p7
         7vzUadzaTExjDYkskRxhkdcO92GbjFTFql4nxzK/G+Iw8hK+CBy5dXaZpEGOAO5X7oXi
         XId0kAdFS7wJqLONpr5hcJoiTpwZ/a19dvu6uvZm1MJag6EsgnUpcErXi7z/rzaVO3YE
         4X1RvKlGwA+vAr8xl7ugYPSKMd+F3Ic5mZsNc1MotziYUeWeT64yJ3OB1qJdfuT3j9my
         p8Ag==
X-Gm-Message-State: AOAM531/G8BnSASQNqxhQ8NoxPcB4/D/v3Xh1/EWTALLnQpF/WFsjLW1
        wtSEL1l4n88/StjMs9m/yVNs3PoRUTcxrh4QK6Li/Q==
X-Google-Smtp-Source: ABdhPJwW8JFlnoJfrFbun3wyL7kmjVW4jY8gPVUIRb3NnGb+2Fq0mYfoVDuSHrqVaY8RCM3KsyFaM8EbRQOSlr8Kk88=
X-Received: by 2002:a25:da92:: with SMTP id n140mr6448310ybf.275.1603840795951;
 Tue, 27 Oct 2020 16:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200907131613.12703-65-joro@8bytes.org> <159972972557.20229.773744278485296601.tip-bot2@tip-bot2>
In-Reply-To: <159972972557.20229.773744278485296601.tip-bot2@tip-bot2>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Tue, 27 Oct 2020 16:19:45 -0700
Message-ID: <CAAYXXYwFxuK7NvaXTebag0vczRRRyYNRdVPd66GeiCz9_2TXCA@mail.gmail.com>
Subject: Re: [tip: x86/seves] x86/vmware: Add VMware-specific handling for
 VMMCALL under SEV-ES
To:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, dcovelli@vmware.com
Cc:     linux-tip-commits@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Looking at the VMWARE_VMCALL(cmd, eax, ebx, ecx, edx) definition, it
seems to me only 4 registers are required to be shared with
hypervisor. I don't know much about vmware but is not
vmware_sev_es_hcall_prepare expose more registers than needed and also
vmware_sev_es_hcall_finish might let the hypvervisor to modify
additional registers which are not used?

Just checking if this is intentional and what I am missing here.

Thanks
-Erdem


On Thu, Sep 10, 2020 at 2:23 AM tip-bot2 for Doug Covelli
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/seves branch of tip:
>
> Commit-ID:     1a222de8dcfb903d039810b0823570ee0be4e6c6
> Gitweb:        https://git.kernel.org/tip/1a222de8dcfb903d039810b0823570ee0be4e6c6
> Author:        Doug Covelli <dcovelli@vmware.com>
> AuthorDate:    Mon, 07 Sep 2020 15:16:05 +02:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00
>
> x86/vmware: Add VMware-specific handling for VMMCALL under SEV-ES
>
> Add VMware-specific handling for #VC faults caused by VMMCALL
> instructions.
>
> Signed-off-by: Doug Covelli <dcovelli@vmware.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: - Adapt to different paravirt interface ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20200907131613.12703-65-joro@8bytes.org
> ---
>  arch/x86/kernel/cpu/vmware.c | 50 +++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 9b6fafa..924571f 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -33,6 +33,7 @@
>  #include <asm/timer.h>
>  #include <asm/apic.h>
>  #include <asm/vmware.h>
> +#include <asm/svm.h>
>
>  #undef pr_fmt
>  #define pr_fmt(fmt)    "vmware: " fmt
> @@ -476,10 +477,49 @@ static bool __init vmware_legacy_x2apic_available(void)
>                (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
>  }
>
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
> +                                       struct pt_regs *regs)
> +{
> +       /* Copy VMWARE specific Hypercall parameters to the GHCB */
> +       ghcb_set_rip(ghcb, regs->ip);
> +       ghcb_set_rbx(ghcb, regs->bx);
> +       ghcb_set_rcx(ghcb, regs->cx);
> +       ghcb_set_rdx(ghcb, regs->dx);
> +       ghcb_set_rsi(ghcb, regs->si);
> +       ghcb_set_rdi(ghcb, regs->di);
> +       ghcb_set_rbp(ghcb, regs->bp);
> +}
> +
> +static bool vmware_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
> +{
> +       if (!(ghcb_rbx_is_valid(ghcb) &&
> +             ghcb_rcx_is_valid(ghcb) &&
> +             ghcb_rdx_is_valid(ghcb) &&
> +             ghcb_rsi_is_valid(ghcb) &&
> +             ghcb_rdi_is_valid(ghcb) &&
> +             ghcb_rbp_is_valid(ghcb)))
> +               return false;
> +
> +       regs->bx = ghcb->save.rbx;
> +       regs->cx = ghcb->save.rcx;
> +       regs->dx = ghcb->save.rdx;
> +       regs->si = ghcb->save.rsi;
> +       regs->di = ghcb->save.rdi;
> +       regs->bp = ghcb->save.rbp;
> +
> +       return true;
> +}
> +#endif
> +
>  const __initconst struct hypervisor_x86 x86_hyper_vmware = {
> -       .name                   = "VMware",
> -       .detect                 = vmware_platform,
> -       .type                   = X86_HYPER_VMWARE,
> -       .init.init_platform     = vmware_platform_setup,
> -       .init.x2apic_available  = vmware_legacy_x2apic_available,
> +       .name                           = "VMware",
> +       .detect                         = vmware_platform,
> +       .type                           = X86_HYPER_VMWARE,
> +       .init.init_platform             = vmware_platform_setup,
> +       .init.x2apic_available          = vmware_legacy_x2apic_available,
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       .runtime.sev_es_hcall_prepare   = vmware_sev_es_hcall_prepare,
> +       .runtime.sev_es_hcall_finish    = vmware_sev_es_hcall_finish,
> +#endif
>  };
