Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17C33B347
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 14:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCONGq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 09:06:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCONGg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 09:06:36 -0400
Date:   Mon, 15 Mar 2021 13:06:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615813595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmEUMC1Chi8vr697S3PnQ6o1wes6jaRKnUR7MvTS0to=;
        b=q2X9NLmWjdXmr6N/CXFpfC4i1xDBaZ4RT/k1x6eVV+UT0fCwHj5eXrhWPHszkBBMcErBSx
        6mie7ZM4tJJVgeL0byymNeq+Fvx9NrqJ9+A3McDi0TzJ03Kj4j8iGrh2R6KsVyEhJfe1PD
        5r+I6mx7PrWwwfmuJZ0yppZo7eZzFYIfFzKwWQiqxmZJs3JfgWoJ5COsBV0nw6fsn0vlZ7
        UuBKkX+xkr8vT9tXllsWq9Dqvcf6IB5dqINoBO6y8QTMiP93qOcJf4Ri4S+grlR4DqapF6
        DD6U5rlVUMMpxx5U13NlOfX++i6jmzFX7nH79g2i1RjhB9aRAuZQqYUac/AdrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615813595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmEUMC1Chi8vr697S3PnQ6o1wes6jaRKnUR7MvTS0to=;
        b=KiApcbFPOs8dMQMpAdUFxM1tOVPIccXYi1ZrUGtnAnA8J83NsGgRraQBBUqW0uYTO0tyNh
        LyP05xZ6ULOSHrBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Add AMD Secure Encryption leaf
Cc:     Borislav Petkov <bp@suse.de>, Feng Tang <feng.tang@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210313140118.17010-1-bp@alien8.de>
References: <20210313140118.17010-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161581359465.398.1247628750440397555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     2d4177c01b4e7496c7d47b31865f8c85bffb3604
Gitweb:        https://git.kernel.org/tip/2d4177c01b4e7496c7d47b31865f8c85bffb3604
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 13 Mar 2021 14:56:16 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 14:01:25 +01:00

tools/x86/kcpuid: Add AMD Secure Encryption leaf

Add the 0x8000001f leaf's fields.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Feng Tang <feng.tang@intel.com>
Link: https://lkml.kernel.org/r/20210313140118.17010-1-bp@alien8.de
---
 tools/arch/x86/kcpuid/cpuid.csv | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index f4a5b85..dd94c07 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -378,3 +378,13 @@
 0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
 0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
 0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
+
+# 8000001F: AMD Secure Encryption
+0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
+0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
+0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
+0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
+0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
+0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
+0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
+0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
