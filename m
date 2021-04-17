Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8A362FC1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Apr 2021 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhDQMHQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 17 Apr 2021 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMHQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 17 Apr 2021 08:07:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFFDC061574;
        Sat, 17 Apr 2021 05:06:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c4200f944f17f6d67a0aa.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:4200:f944:f17f:6d67:a0aa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 933AA1EC0350;
        Sat, 17 Apr 2021 14:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618661207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nE6tv9CArLBjdf6W3ZCG71idf2Qt9t0kDlmZ+4D8pSc=;
        b=H4/8MQ5yqeigh9WNAzQEC0yDybE2CkoSe1v4H8L9Q+J1bwWN98kcVZYQxpm5OtKomBAjdO
        XzZpA8q1ytefHhfDutAA+BDAS1W0FHfhOZE8hgFk9b25InZrDkVKWC3JXVcNk9E08yHEyO
        QFXvIZBlIRrel5LFFQbn57A7rc5suMo=
Date:   Sat, 17 Apr 2021 14:06:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Subject: Re: [tip: x86/urgent] x86/dma: Tear down DMA ops on driver unbind
Message-ID: <20210417120644.GA5235@zn.tnic>
References: <20210414082633.877461-1-jean-philippe@linaro.org>
 <161847725788.29796.15623166781765421094.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161847725788.29796.15623166781765421094.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Apr 15, 2021 at 09:00:57AM -0000, tip-bot2 for Jean-Philippe Brucker wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     9f8614f5567eb4e38579422d38a1bdfeeb648ffc
> Gitweb:        https://git.kernel.org/tip/9f8614f5567eb4e38579422d38a1bdfeeb648ffc
> Author:        Jean-Philippe Brucker <jean-philippe@linaro.org>
> AuthorDate:    Wed, 14 Apr 2021 10:26:34 +02:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Thu, 15 Apr 2021 10:27:29 +02:00
> 
> x86/dma: Tear down DMA ops on driver unbind
> 
> Since
> 
>   08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
> 
> a user can switch a device between IOMMU and direct DMA through sysfs.
> This doesn't work for AMD IOMMU at the moment because dev->dma_ops is
> not cleared when switching from a DMA to an identity IOMMU domain. The
> DMA layer thus attempts to use the dma-iommu ops on an identity domain,
> causing an oops:
> 
>   # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/unbind
>   # echo identity > /sys/bus/pci/devices/0000:00:05.0/iommu_group/type
>   # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/bind
>    ...
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>    ...
>    Call Trace:
>     iommu_dma_alloc
>     e1000e_setup_tx_resources
>     e1000e_open
> 
> Implement arch_teardown_dma_ops() on x86 to clear the device's dma_ops
> pointer during driver unbind.
> 
>  [ bp: Massage commit message. ]
> 
> Fixes: 08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20210414082633.877461-1-jean-philippe@linaro.org
> ---
>  arch/x86/Kconfig          | 1 +
>  arch/x86/kernel/pci-dma.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2792879..2c90f8d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,7 @@ config X86
>  	select ARCH_HAS_STRICT_MODULE_RWX
>  	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	select ARCH_HAS_SYSCALL_WRAPPER
> +	select ARCH_HAS_TEARDOWN_DMA_OPS	if IOMMU_DMA
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index de234e7..60a4ec2 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -154,3 +154,10 @@ static void via_no_dac(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>  				PCI_CLASS_BRIDGE_PCI, 8, via_no_dac);
>  #endif
> +
> +#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
> +void arch_teardown_dma_ops(struct device *dev)
> +{
> +	set_dma_ops(dev, NULL);
> +}
> +#endif

Nope, sorry, no joy. Zapping it from tip.

With that patch, it fails booting on my test box with messages like
(typing up from video I took):

...
ata: softreset failed (1st FIS failed)
ahci 0000:03:00:1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=...]
ahci 0000:03:00:1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=...]
<--- EOF

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
