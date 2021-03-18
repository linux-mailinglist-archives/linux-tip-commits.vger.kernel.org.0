Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2F340387
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCRKj0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCRKjG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 06:39:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017FC06174A;
        Thu, 18 Mar 2021 03:38:57 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:38:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616063935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1wdTRtnrBFsFQ6xJlLLoRyIXFu3v5Kcl+TfWKg8yJI=;
        b=Y/dtYQpWuZJtLOcgYhXVj1jw8Z1HV4qbU94ZVdfFh2F6yC4WfS5TbwepotBl6Mt+ol7r97
        QDcdJ33bhW3ebAl6D30X7Ixjhq7K5GDDPP5SHDNtaEy2Y+WbWWfQSv9k5pY/RckJ+uBKx4
        ElUQ9c4CbAt73miAZdZhJoWYz1N6RQ+QyvmCBPTWGy5DhHKllXjL/jiFcC8JRautiIsUfd
        rKxE0VPEGmqRAqi7x2D+hhNsyZ4YqKB//vgetDaBXLmIFeEOYacMTxpSd88kAFzBywzUe/
        ENijuNfJyLfXUqKs/zsP21NWyx9DiOdN9qgJut4pR0lPjOsBiyOOn0N4S/zXOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616063935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1wdTRtnrBFsFQ6xJlLLoRyIXFu3v5Kcl+TfWKg8yJI=;
        b=ETMQGf1WyS0hxdFFggLNi8NWzfumbx5VXwLF2IEJhoSINwMYzW14WBzjIMllDpGL+a9upi
        1VsePB8uSfmcU5AA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Cc:     Borislav Petkov <bp@suse.de>, Feng Tang <feng.tang@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210315125901.30315-2-bp@alien8.de>
References: <20210315125901.30315-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161606393512.398.9596866275749768661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f281854fa743f3474b2d0d69533301f48cf0e184
Gitweb:        https://git.kernel.org/tip/f281854fa743f3474b2d0d69533301f48cf0e184
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 15 Mar 2021 13:55:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 11:36:14 +01:00

tools/x86/kcpuid: Add AMD leaf 0x8000001E

Contains core IDs, node IDs and other topology info.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Feng Tang <feng.tang@intel.com>
Link: https://lkml.kernel.org/r/20210315125901.30315-2-bp@alien8.de
---
 tools/arch/x86/kcpuid/cpuid.csv | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index dd94c07..4f1c4b0 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -379,12 +379,22 @@
 0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
 0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
 
+# 0x8000001E
+# EAX: Extended APIC ID
+0x8000001E,	0, EAX,   31:0, extended_apic_id, Extended APIC ID
+# EBX: Core Identifiers
+0x8000001E,	0, EBX,    7:0, core_id, Identifies the logical core ID
+0x8000001E,	0, EBX,   15:8, threads_per_core, The number of threads per core is threads_per_core + 1
+# ECX: Node Identifiers
+0x8000001E,	0, ECX,    7:0, node_id, Node ID
+0x8000001E,	0, ECX,   10:8, nodes_per_processor, Nodes per processor { 0: 1 node, else reserved }
+
 # 8000001F: AMD Secure Encryption
-0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
-0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
-0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
-0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
-0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
-0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
-0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
-0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
+0x8000001F,	0, EAX,	     0, sme,	Secure Memory Encryption
+0x8000001F,	0, EAX,      1, sev,	Secure Encrypted Virtualization
+0x8000001F,	0, EAX,      2, vmpgflush, VM Page Flush MSR
+0x8000001F,	0, EAX,      3, seves, SEV Encrypted State
+0x8000001F,	0, EBX,    5:0, c-bit, Page table bit number used to enable memory encryption
+0x8000001F,	0, EBX,   11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
+0x8000001F,	0, ECX,   31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
+0x8000001F,	0, EDX,   31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
