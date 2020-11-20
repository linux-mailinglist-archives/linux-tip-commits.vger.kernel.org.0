Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EE2BA997
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 12:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgKTLvv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 06:51:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgKTLvv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 06:51:51 -0500
Date:   Fri, 20 Nov 2020 11:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605873108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhgLeBe98T66vHPfQ+Qad065DCd4QEmp0NUSOu/SXmw=;
        b=EDQhEYu7kQIW0bmbyUTEHyh4Btx6rw8MM0Vh4VyavhdVV//zMLuGopdXuycQa7Fb4m3V08
        qhre2cjVtRk3euPWxswZTst55SEpi3YZRFPXjh1tKlTsleov2OboetxK1u69aHE6rd96DB
        96i/tunZqG/4ShBUOa4mVe84D9bh3vGbAqHgDIJREvTaWnR0rBTW426nQp+FeTNaq/GBd9
        uXkMjobKdPkeOhVjIAvA1r7j6IKkVtxMo0u1vqyvZaBMgtrgPFyb0mxZdJsGxQdmBMHn/L
        5gHcMgZHUhpzDCFkD0V2ZSPo46/sIIz5mhG/HwIsNAdGkedgLEmfgrm6g7d4Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605873108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhgLeBe98T66vHPfQ+Qad065DCd4QEmp0NUSOu/SXmw=;
        b=9vo9H9yJOxU0mRRdVZR2ZjWbnsVf/QtW/7RRonfLpxFazKL0/2Y0b33419KtDKEf1H7bNL
        StsVmrJOA6SFMeCg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Declare 'start' variable where it is used
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200928100004.25674-1-lukas.bulwahn@gmail.com>
References: <20200928100004.25674-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <160587310720.11244.17157588656599003783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     bab202ab87ba4da48018daf0f6810b22705a570d
Gitweb:        https://git.kernel.org/tip/bab202ab87ba4da48018daf0f6810b22705a570d
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Mon, 28 Sep 2020 12:00:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 Nov 2020 12:49:00 +01:00

x86/mm: Declare 'start' variable where it is used

It is not required to initialize the local variable start in
memory_map_top_down(), as the variable will be initialized in any path
before it is used.

make clang-analyzer on x86_64 tinyconfig reports:

  arch/x86/mm/init.c:612:15: warning: Although the value stored to 'start' \
  is used in the enclosing expression, the value is never actually read \
  from 'start' [clang-analyzer-deadcode.DeadStores]

Move the variable declaration into the loop, where it is used.

No code changed:

  # arch/x86/mm/init.o:

   text    data     bss     dec     hex filename
   7105    1424   26768   35297    89e1 init.o.before
   7105    1424   26768   35297    89e1 init.o.after

md5:
   a8d76c1bb5fce9cae251780a7ee7730f  init.o.before.asm
   a8d76c1bb5fce9cae251780a7ee7730f  init.o.after.asm

 [ bp: Massage. ]

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200928100004.25674-1-lukas.bulwahn@gmail.com
---
 arch/x86/mm/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c7a4760..e26f5c5 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -596,7 +596,7 @@ static unsigned long __init get_new_step_size(unsigned long step_size)
 static void __init memory_map_top_down(unsigned long map_start,
 				       unsigned long map_end)
 {
-	unsigned long real_end, start, last_start;
+	unsigned long real_end, last_start;
 	unsigned long step_size;
 	unsigned long addr;
 	unsigned long mapped_ram_size = 0;
@@ -609,7 +609,7 @@ static void __init memory_map_top_down(unsigned long map_start,
 	step_size = PMD_SIZE;
 	max_pfn_mapped = 0; /* will get exact value next */
 	min_pfn_mapped = real_end >> PAGE_SHIFT;
-	last_start = start = real_end;
+	last_start = real_end;
 
 	/*
 	 * We start from the top (end of memory) and go to the bottom.
@@ -618,6 +618,8 @@ static void __init memory_map_top_down(unsigned long map_start,
 	 * for page table.
 	 */
 	while (last_start > map_start) {
+		unsigned long start;
+
 		if (last_start > step_size) {
 			start = round_down(last_start - 1, step_size);
 			if (start < map_start)
