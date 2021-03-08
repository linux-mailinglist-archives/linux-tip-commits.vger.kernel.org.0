Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E8330D67
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 13:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCHMW2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 07:22:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCHMWO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 07:22:14 -0500
Date:   Mon, 08 Mar 2021 12:22:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615206133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKExN4+xDpkQ0fEjU/DbH4nlWRc678J7RVNxh8wM+BM=;
        b=bmtHm8NVr93Cgi+/4iAW/GSgvwLQiX6UI8v2ZptoOt/6ogqfotFxE6OwqI9e+tWbvF+40u
        Bbl1f9xGDJe6EKnjgGzF8RVeGHDaH3CDjz6D40JkxJKiSzz4OE0v7hNH1xAobX4pSDasbz
        ffq0QlVh5+fo4r7b6CWF3Q+eCLHis/74meXuu+kNvoFMt1uRtR1IwgSn8Ahe711CIyrbOJ
        UxS2Ysq97WSVwUGz9SEF9Bzx92naD6O5Tvrk4/FrvXic3VHvEvhdhiB8ljQniEXsJMHkBv
        YSAEpQw3e2h1FHIsBWoWpmH4h5q6ARxv7+oxq/FRCtc5oQn9rWkGGHNOCg5TTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615206133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKExN4+xDpkQ0fEjU/DbH4nlWRc678J7RVNxh8wM+BM=;
        b=gOHhAJL9YyZ0pUhAMb/Sym734ueCdLwQduqdhIyBUSpnedP5dbeAzvUL8+2yOK9ezUriyS
        D/vl25P+PZwi7fBg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/virtio: Have SEV guests enforce restricted
 virtio memory access
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb46e0211f77ca1831f11132f969d470a6ffc9267=2E16148?=
 =?utf-8?q?97610=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb46e0211f77ca1831f11132f969d470a6ffc9267=2E161489?=
 =?utf-8?q?7610=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <161520613223.398.14600279488331087689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     9da54be651f8a856d9e6c14183d0df948e222103
Gitweb:        https://git.kernel.org/tip/9da54be651f8a856d9e6c14183d0df948e222103
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 04 Mar 2021 16:40:11 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 12:54:43 +01:00

x86/virtio: Have SEV guests enforce restricted virtio memory access

An SEV guest requires that virtio devices use the DMA API to allow the
hypervisor to successfully access guest memory as needed.

The VIRTIO_F_VERSION_1 and VIRTIO_F_ACCESS_PLATFORM features tell virtio
to use the DMA API. Add arch_has_restricted_virtio_memory_access() for
x86, to fail the device probe if these features have not been set for the
device when running as an SEV guest.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/b46e0211f77ca1831f11132f969d470a6ffc9267.1614897610.git.thomas.lendacky@amd.com
---
 arch/x86/Kconfig          | 1 +
 arch/x86/mm/mem_encrypt.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..e80e726 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,6 +1518,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4b01f7d..667283f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -484,3 +484,8 @@ void __init mem_encrypt_init(void)
 	print_mem_encrypt_feature_info();
 }
 
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return sev_active();
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
