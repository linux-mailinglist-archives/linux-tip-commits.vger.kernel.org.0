Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE8DCF2C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2019 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505947AbfJRTPp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Oct 2019 15:15:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43808 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394833AbfJRTPo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Oct 2019 15:15:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so3292556plj.10
        for <linux-tip-commits@vger.kernel.org>; Fri, 18 Oct 2019 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ksmMq5PJMPTcChdT55T+04d0IXtcT3GLo2lk0rvGOlI=;
        b=J8tgyZMtLFNIMlUCddYvjdf2ohUdoAji84wy7YKg3G4aPhyszLfZCNQaeAJe+Fpg0s
         dGmGugt1VYyapur6eTnfujHvqT1gYH3ksZTPBa8HH77A3Ehn50/ja4DhjPaPbOOLUtX9
         pspp9yGx3O6S/ECb1UUp4vn2y52GhFDHCWSatXjVweMiSRiH/f3ahBxfoVSKJtvovSp/
         uE8nlc/neK1bbpvg5yMGk4P/2HsAe490laoWf6u8Q40EPq5hOye1TXzrbFY1V8gOWFxr
         GCLW2HjbrAt1gwlBinlhbXPrywHf2ValMJ5DacSmTstFEAHmP1M9FuwsB78M/YTbOcu/
         4FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ksmMq5PJMPTcChdT55T+04d0IXtcT3GLo2lk0rvGOlI=;
        b=H9SOCwLuKLgwRk+Bd4tUba9VNWDf3AxKqRFOhRgd8HR7+Fb7+7mFXp5cf3jn5X38n9
         r+vdqFbh0TH0NVSQ1zg78PK1kIiz9uhDCR/vhVREISCg8Wv8utOf9iNS+6RlEGA3Qyq4
         EE0sZfILnSIQIk9nXm8PZgxVzP2cas+V75mNfauXw6XZLV9/rJimXujG50WX2Omgife2
         OeaZpM3rqZ03m/1+ZADaTMj6K9nWnd9W9iI4ah1tcITjd+2hk3HKfV7MjTebVt+08sMU
         pAMx/BPiqRu7E04pp4isForvthnJ/Z6sJ+CTuexe+siOaVb4uKhfzPpJ1j7IvzrjTl0i
         9quA==
X-Gm-Message-State: APjAAAVZIY2ayj2JSEY3XkE+ShdcJqz5N4oB6GrQAINS2lkknoexFeum
        9LXPCgXiYoDxwYGlPiL4mze4zQ==
X-Google-Smtp-Source: APXvYqwN3HoWEml3YmhY87n+3RsGuigL0mmAYXjKa217g8/hgPOUDb2XJRcuEQ6XEAAP0Kg7yd6mVg==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr11583846plp.2.1571426143036;
        Fri, 18 Oct 2019 12:15:43 -0700 (PDT)
Received: from localhost ([152.179.112.46])
        by smtp.gmail.com with ESMTPSA id v3sm6966003pfn.18.2019.10.18.12.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 12:15:42 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:15:42 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 12:15:06 PDT (-0700)
Subject:     Re: [tip: irq/urgent] irqchip/sifive-plic: Switch to fasteoi flow
In-Reply-To: <20191016124311.B06A621848@mail.kernel.org>
CC:     sashal@kernel.org, tip-bot2@linutronix.de,
        linux-tip-commits@vger.kernel.org, maz@kernel.org,
        stable@vger.kernel.org, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     sashal@kernel.org
Message-ID: <mhng-1477acac-8104-4b37-bf7f-c77cd0fcd756@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, 16 Oct 2019 05:43:10 PDT (-0700), sashal@kernel.org wrote:
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.3.6, v5.2.21, v4.19.79, v4.14.149, v4.9.196, v4.4.196.
>
> v5.3.6: Build OK!
> v5.2.21: Build OK!
> v4.19.79: Failed to apply! Possible dependencies:
>     86c7cbf1e8d1d ("irqchip/sifive-plic: Pre-compute context hart base and enable base")
>     cc9f04f9a84f7 ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
>
> v4.14.149: Failed to apply! Possible dependencies:
>     215f4cc0fb208 ("irqchip/meson: Add support for gpio interrupt controller")
>     33c57c0d3c67f ("RISC-V: Add a basic defconfig")
>     4235ff50cf98d ("irqchip/irq-goldfish-pic: Add Goldfish PIC driver")
>     4a632cec8884b ("RISC-V: Enable module support in defconfig")
>     8237f8bc4f6eb ("irqchip: add a SiFive PLIC driver")
>     86c7cbf1e8d1d ("irqchip/sifive-plic: Pre-compute context hart base and enable base")
>     c2ba80af48055 ("dt-bindings/goldfish-pic: Add device tree binding for Goldfish PIC driver")
>     c94fb639d5462 ("irqchip: Add Kconfig menu")
>     cc9f04f9a84f7 ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
>     f55c73aef8904 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")
>
> v4.9.196: Failed to apply! Possible dependencies:
>     215f4cc0fb208 ("irqchip/meson: Add support for gpio interrupt controller")
>     33c57c0d3c67f ("RISC-V: Add a basic defconfig")
>     4235ff50cf98d ("irqchip/irq-goldfish-pic: Add Goldfish PIC driver")
>     4a632cec8884b ("RISC-V: Enable module support in defconfig")
>     5ed34d3a4387c ("irqchip: Add UniPhier AIDET irqchip driver")
>     7a08de1d8fd27 ("dt-bindings: Add device tree binding for Goldfish RTC driver")
>     8237f8bc4f6eb ("irqchip: add a SiFive PLIC driver")
>     86c7cbf1e8d1d ("irqchip/sifive-plic: Pre-compute context hart base and enable base")
>     c2ba80af48055 ("dt-bindings/goldfish-pic: Add device tree binding for Goldfish PIC driver")
>     c94fb639d5462 ("irqchip: Add Kconfig menu")
>     cc9f04f9a84f7 ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
>     f20cc9b00c7b7 ("irqchip/qcom: Add IRQ combiner driver")
>     f55c73aef8904 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")
>
> v4.4.196: Failed to apply! Possible dependencies:
>     215f4cc0fb208 ("irqchip/meson: Add support for gpio interrupt controller")
>     33c57c0d3c67f ("RISC-V: Add a basic defconfig")
>     4235ff50cf98d ("irqchip/irq-goldfish-pic: Add Goldfish PIC driver")
>     44df427c894a4 ("irqchip: add nps Internal and external irqchips")
>     4a632cec8884b ("RISC-V: Enable module support in defconfig")
>     5952884258e52 ("irqchip/aspeed-vic: Add irq controller for Aspeed")
>     5ed34d3a4387c ("irqchip: Add UniPhier AIDET irqchip driver")
>     7a08de1d8fd27 ("dt-bindings: Add device tree binding for Goldfish RTC driver")
>     8237f8bc4f6eb ("irqchip: add a SiFive PLIC driver")
>     aaa8666ada780 ("IRQCHIP: irq-pic32-evic: Add support for PIC32 interrupt controller")
>     c27f29bbbf021 ("irqchip/mvebu-odmi: Add new driver for platform MSI on Marvell 7K/8K")
>     c2ba80af48055 ("dt-bindings/goldfish-pic: Add device tree binding for Goldfish PIC driver")
>     c94fb639d5462 ("irqchip: Add Kconfig menu")
>     cc9f04f9a84f7 ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
>     d03c023e1ea6c ("MAINTAINERS: Add Android Ion as a separate entry")
>     e072041688ca7 ("drivers/irqchip: Add STM32 external interrupts support")
>     f20cc9b00c7b7 ("irqchip/qcom: Add IRQ combiner driver")
>     f55c73aef8904 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?

I think it's fine to leave this out of 4.19, as I doubt we have anyone using it 
on RISC-V systems as there were some pretty major kernel bugs back then.

The PLIC driver was merged in 4.19, so the older kernels are obvious 
non-starters.
