Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C315635EE87
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Apr 2021 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbhDNHhF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Apr 2021 03:37:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349754AbhDNHhE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Apr 2021 03:37:04 -0400
Date:   Wed, 14 Apr 2021 07:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618385802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhG6yeO7qUBOcTbfLkvq3N6y048F47lyYY/h7j+ClSw=;
        b=E5JYcrvgsNJJ82rYicVBYxqD3PcFxi1Ew4v8Z+dGBuq/3CMCKn6O3qA2ZoCCQNhLSCgsJS
        YZgebZfB2a6Q5VYOc8wiswRq7q1P1utq0eNuViaXkvJg0SemRFF9MVuqCcHDApNPO3ZH9l
        7TxO23gfjrB40PE7lltuxkm44Jn+eNWzjp5J5kg8GEPgDzkQEMU1JGVmVhBtZfuTNGp9tQ
        NXQ5FUQ4duJuV4eBDqIjImSZbauDkImd02zexfQbTMzVLNA3qrR7sCWfjHpmE5rGFv4KFF
        1CIKi/fg1ELX8xXcliTtkBNJFIrLuXlTt1j6YfheL4J1+FOwpxl60L2A9wOFXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618385802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhG6yeO7qUBOcTbfLkvq3N6y048F47lyYY/h7j+ClSw=;
        b=+u0ppabOu5v7QeHwJ97Z1Ba85OXPAE7n4hkukGEMfE8DpI8VLb3n7LkPrmgGipauFNuufQ
        EORG4MKZKz9wFfAA==
From:   "tip-bot2 for Jan Kiszka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pat: Do not compile stubbed functions when
 X86_PAT is off
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
References: <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
MIME-Version: 1.0
Message-ID: <161838580104.29796.1278445228759289660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     16854b567dff767e5ec5e6dc23021271136733a5
Gitweb:        https://git.kernel.org/tip/16854b567dff767e5ec5e6dc23021271136733a5
Author:        Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate:    Mon, 26 Oct 2020 18:39:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 14 Apr 2021 08:21:41 +02:00

x86/pat: Do not compile stubbed functions when X86_PAT is off

Those are already provided by linux/io.h as stubs.

The conflict remains invisible until someone would pull linux/io.h into
memtype.c. This fixes a build error when this file is used outside of
the kernel tree.

  [ bp: Massage commit message. ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com
---
 arch/x86/mm/pat/memtype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 6084d14..3112ca7 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -800,6 +800,7 @@ void memtype_free_io(resource_size_t start, resource_size_t end)
 	memtype_free(start, end);
 }
 
+#ifdef CONFIG_X86_PAT
 int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
 {
 	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
@@ -813,6 +814,7 @@ void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 	memtype_free_io(start, start + size);
 }
 EXPORT_SYMBOL(arch_io_free_memtype_wc);
+#endif
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t vma_prot)
