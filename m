Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25A34676F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhCWSUH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCWSTi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 14:19:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE59C061574;
        Tue, 23 Mar 2021 11:19:38 -0700 (PDT)
Date:   Tue, 23 Mar 2021 18:19:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616523575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1gCtkYO5bmi4AUfA19RFUBENH5hgj801PbOvdT/H3k=;
        b=Kl3bJ9s6ojOa4nTwXSblTo8zcWJgiU36ZYWg/oWwgdZmoYwHXxlnZHHJVoY2KMjdpkAFbd
        5eGppHTs7Zsh9PJwJDEP8TdMHg4qo7/LxjkiIoT1s4Todoi67BTS8rqXyBGomH5mf2F+Lg
        QQi1+iyDxwK0rtAQv74p4cFs5csyJ+8ICaXshDsB98z9nFqF6jnD96k+6LFtXCVMtL9fsp
        me+WEXRwFPY06rUWPi+m3f4Aelg/a/sRhUO02TDwgyPzJj6ahEFOabShLJKfztzbPYm94c
        MOnV9FaEWGo5rngnncY1GT/Y7Jfje0Nk8fkIVwTQAtq6G7PKQ2Os1am+znjDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616523575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1gCtkYO5bmi4AUfA19RFUBENH5hgj801PbOvdT/H3k=;
        b=DKsqHyEXmsC8pHumC5LSo6HnWjxOtdU5L5k0syMmX6djSh5OP7it0Z30NVClJXjvLZ8US3
        i2fDwAlswMom8YCA==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Merge several reservations of start of memory
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210302100406.22059-3-rppt@kernel.org>
References: <20210302100406.22059-3-rppt@kernel.org>
MIME-Version: 1.0
Message-ID: <161652357483.398.17741953410853599317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4c674481dcf9974834b96622fa4b079c176f36f9
Gitweb:        https://git.kernel.org/tip/4c674481dcf9974834b96622fa4b079c176f36f9
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 02 Mar 2021 12:04:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 23 Mar 2021 17:17:36 +01:00

x86/setup: Merge several reservations of start of memory

Currently, the first several pages are reserved both to avoid leaking
their contents on systems with L1TF and to avoid corrupting BIOS memory.

Merge the two memory reservations.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210302100406.22059-3-rppt@kernel.org
---
 arch/x86/kernel/setup.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e3c603..776fc9b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -713,11 +713,6 @@ static int __init parse_reservelow(char *p)
 
 early_param("reservelow", parse_reservelow);
 
-static void __init trim_low_memory_range(void)
-{
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
-}
-
 static void __init early_reserve_memory(void)
 {
 	/*
@@ -730,10 +725,17 @@ static void __init early_reserve_memory(void)
 			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
-	 * Make sure page 0 is always reserved because on systems with
-	 * L1TF its contents can be leaked to user processes.
+	 * The first 4Kb of memory is a BIOS owned area, but generally it is
+	 * not listed as such in the E820 table.
+	 *
+	 * Reserve the first memory page and typically some additional
+	 * memory (64KiB by default) since some BIOSes are known to corrupt
+	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
+	 *
+	 * In addition, make sure page 0 is always reserved because on
+	 * systems with L1TF its contents can be leaked to user processes.
 	 */
-	memblock_reserve(0, PAGE_SIZE);
+	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 
 	early_reserve_initrd();
 
@@ -746,7 +748,6 @@ static void __init early_reserve_memory(void)
 	reserve_bios_regions();
 
 	trim_snb_memory();
-	trim_low_memory_range();
 }
 
 /*
