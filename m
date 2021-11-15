Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA89451D34
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbhKPAZ7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012FC043197;
        Mon, 15 Nov 2021 12:22:36 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDhLrk9bFWdyV4Nvt1YGAnTseeGkUInWt3gNFx3PQAY=;
        b=vt3ZolU7F8FpQM8vLMgnguDDcS5RyQOACvMcJv8goLjvilojB7R2gBwUkvq42PL/hB5V3p
        E+tJWcCRy9YW6Hek0C60MGV7ssMpw5tQ9Sxj095ibzEaPHoIlFmEG0qUkoflsRQWGr+blv
        ybqjeyrOwPM1MHisgrdCbtiA8fhfxm0/4bDC+hsXQb97HQB39YNVMRS2yNYaDzVETVvmxu
        xEXn/zjLs3zsZWrvO5Xfa8EPrGJuy9CPIK+xrtlpKO8FqYPheo9qP7Ur05HgWBNMbt++34
        x5MztFt9vysRXElfzjzcCuo6zWpmpppLjL5DbFPOntla1pxD8ceakShxYxF/xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDhLrk9bFWdyV4Nvt1YGAnTseeGkUInWt3gNFx3PQAY=;
        b=y3z6enLdwisXgImgeb0D5oRZoETFnFiKflOzIf6Wfu4Rhqi0OQ45zuJ9nvsnqwrfdWWCw3
        oWRISCYU6EKlpQBA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add hook to error injection address validation
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026220050.697075-7-tony.luck@intel.com>
References: <20211026220050.697075-7-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163700775002.414.6848067937912536160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c6acb1e7bf4656b9434335c72b8245cc84575fde
Gitweb:        https://git.kernel.org/tip/c6acb1e7bf4656b9434335c72b8245cc84575fde
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 26 Oct 2021 15:00:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:13:16 -08:00

x86/sgx: Add hook to error injection address validation

SGX reserved memory does not appear in the standard address maps.

Add hook to call into the SGX code to check if an address is located
in SGX memory.

There are other challenges in injecting errors into SGX. Update the
documentation with a sequence of operations to inject.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211026220050.697075-7-tony.luck@intel.com
---
 Documentation/firmware-guide/acpi/apei/einj.rst | 19 ++++++++++++++++-
 drivers/acpi/apei/einj.c                        |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c042176..55e2331 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,5 +181,24 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+Special notes for injection into SGX enclaves:
+
+There may be a separate BIOS setup option to enable SGX injection.
+
+The injection process consists of setting some special memory controller
+trigger that will inject the error on the next write to the target
+address. But the h/w prevents any software outside of an SGX enclave
+from accessing enclave pages (even BIOS SMM mode).
+
+The following sequence can be used:
+  1) Determine physical address of enclave page
+  2) Use "notrigger=1" mode to inject (this will setup
+     the injection address, but will not actually inject)
+  3) Enter the enclave
+  4) Store data to the virtual address matching physical address from step 1
+  5) Execute CLFLUSH for that virtual address
+  6) Spin delay for 250ms
+  7) Read from the virtual address. This will trigger the error
+
 For more information about EINJ, please refer to ACPI specification
 version 4.0, section 17.5 and ACPI 5.0, section 18.6.
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index edb2622..95cc2a9 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -545,7 +545,8 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
 				!= REGION_INTERSECTS) &&
 	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
-				!= REGION_INTERSECTS)))
+				!= REGION_INTERSECTS) &&
+	     !arch_is_platform_page(base_addr)))
 		return -EINVAL;
 
 inject:
