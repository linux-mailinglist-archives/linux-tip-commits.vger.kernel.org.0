Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B84451612
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhKOVLk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 16:11:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLK+9YU8UUwPmzWLdn/X0NQ1zxJU2afVaEfKnJrA3NM=;
        b=07LXuHKXvOfTm5WBSP8szPw7p2TkeziuQP5BcU3W698leCoaqN2RpkzCif8bpyRdiE5Sgw
        x/GaMnrjyK9eEh4mqKv7ka686XsE0a392kSiq/W/Lcu8rLL0jMslQmr4kLodSMz8TjW9z8
        pKmG55Sr8TYBs6Kgc9JHFjH/2POnPXiNG6VFIDMrYk/7JL8IzG3Nf96UPx7KCdvhEODRoW
        nP39H0iHbi8aMAnGuwe24CdLI96/9b0FqtHJ8oVgtK/AP5LNm4WdjsU3SJxJeYYBfhS30O
        yhRcuC9AZLswlrUkSqHRiGZYPP4WT0s3SdZDILBIzf59szQRiSoqKrHTA2lhPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLK+9YU8UUwPmzWLdn/X0NQ1zxJU2afVaEfKnJrA3NM=;
        b=0bEXPYbnUNbkOUYTAqjIx6Hcz00V61OuA8XGae1uI0VbcCWQrK1yZ5L9kR7Bhsi3+e/5tp
        Q50D45SlDlrvBuCw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add infrastructure to identify SGX EPC pages
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026220050.697075-3-tony.luck@intel.com>
References: <20211026220050.697075-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163700775275.414.16538578736369961562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     40e0e7843e23d164625b9031514f5672f8758bf4
Gitweb:        https://git.kernel.org/tip/40e0e7843e23d164625b9031514f5672f8758bf4
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 26 Oct 2021 15:00:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:13:16 -08:00

x86/sgx: Add infrastructure to identify SGX EPC pages

X86 machine check architecture reports a physical address when there
is a memory error. Handling that error requires a method to determine
whether the physical address reported is in any of the areas reserved
for EPC pages by BIOS.

SGX EPC pages do not have Linux "struct page" associated with them.

Keep track of the mapping from ranges of EPC pages to the sections
that contain them using an xarray. N.B. adds CONFIG_XARRAY_MULTI to
the SGX dependecies. So "select" that in arch/x86/Kconfig for X86/SGX.

Create a function arch_is_platform_page() that simply reports whether an
address is an EPC page for use elsewhere in the kernel. The ACPI error
injection code needs this function and is typically built as a module,
so export it.

Note that arch_is_platform_page() will be slower than other similar
"what type is this page" functions that can simply check bits in the
"struct page".  If there is some future performance critical user of
this function it may need to be implemented in a more efficient way.

Note also that the current implementation of xarray allocates a few
hundred kilobytes for this usage on a system with 4GB of SGX EPC memory
configured. This isn't ideal, but worth it for the code simplicity.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211026220050.697075-3-tony.luck@intel.com
---
 arch/x86/Kconfig               |  1 +
 arch/x86/kernel/cpu/sgx/main.c |  9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee..b9281fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1917,6 +1917,7 @@ config X86_SGX
 	select SRCU
 	select MMU_NOTIFIER
 	select NUMA_KEEP_MEMINFO if NUMA
+	select XARRAY_MULTI
 	help
 	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
 	  that can be used by applications to set aside private regions of code
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 825aa91..5c02cff 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -20,6 +20,7 @@ struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
 static int sgx_nr_epc_sections;
 static struct task_struct *ksgxd_tsk;
 static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
+static DEFINE_XARRAY(sgx_epc_address_space);
 
 /*
  * These variables are part of the state of the reclaimer, and must be accessed
@@ -650,6 +651,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
+	xa_store_range(&sgx_epc_address_space, section->phys_addr,
+		       phys_addr + size - 1, section, GFP_KERNEL);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
@@ -661,6 +664,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	return true;
 }
 
+bool arch_is_platform_page(u64 paddr)
+{
+	return !!xa_load(&sgx_epc_address_space, paddr);
+}
+EXPORT_SYMBOL_GPL(arch_is_platform_page);
+
 /**
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
