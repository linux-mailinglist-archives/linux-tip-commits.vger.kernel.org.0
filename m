Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AA452A1A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 06:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbhKPF70 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Nov 2021 00:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhKPF7S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Nov 2021 00:59:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DAC0BC548;
        Mon, 15 Nov 2021 21:25:41 -0800 (PST)
Date:   Tue, 16 Nov 2021 05:25:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637040338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pYJS0v4RndphXGDmKoWr9QHzgZz3Y9xgZ1ZJVhXGSi8=;
        b=2np/zFeWAshQuZr94FUl24ymVl7wt4GHmBGMVdU/rvjwqVd1C5zJVsqvJuLEqg8Oxsgds8
        sNSFFM3TCP/6iOpLZTES4Q0mDj4gaf2QlZ3rrjjHucNNjUcMDEJhnzHXDIR22BQX5gNvrL
        Nh3vssT2uABf1g5nIh2lrMUmR2HBttiooUNQjkBIL+btEFFCEJrCZLX+q+lD20kNoCjI61
        51j9jSZlHr82g8rA3PPlsdhI5h0aZYmvmW7auy2dwP3S51m38nqRCSOXwLvdaO7QFUMVIg
        o2I3Bej0/5bIBP/L/rFbvkMJl66mIeak0OrTgZRBVVH8SCs2Vi5KDhP7VXuH+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637040338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pYJS0v4RndphXGDmKoWr9QHzgZz3Y9xgZ1ZJVhXGSi8=;
        b=pqa2PBpr1z/j91RD+RD9CanFOWTWe9B/ePg7inzAd5U/blmOVjwh/47NRIxQhsa6CY85Ck
        59Ftl4Y389BHdnCQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add missing <asm/cpufeatures.h> dependency to
 <asm/page_64.h>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163704033708.414.17524226024605974433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     19c88fc96d941dd7102399bbf7f437f2b93d7e4e
Gitweb:        https://git.kernel.org/tip/19c88fc96d941dd7102399bbf7f437f2b93d7e4e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 16 Nov 2021 06:13:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Nov 2021 06:22:01 +01:00

x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>

In the following commit:

  025768a966a3 x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant

... we added the new task_size_max() inline, which uses X86_FEATURE_LA57,
but doesn't include <asm/cpufeatures.h> which defines the constant.

Due to the way alternatives macros work currently this doesn't get reported as an
immediate build error, only as a link error, if a .c file happens to include
<asm/page.h> first:

   > ld: kernel/fork.o:(.altinstructions+0x98): undefined reference to `X86_FEATURE_LA57'

In the current upstream kernel no .c file includes <asm/page.h> before including
some other header that includes <asm/cpufeatures.h>, which is why this dependency
bug went unnoticed.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc..e9c8629 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -5,6 +5,7 @@
 #include <asm/page_64_types.h>
 
 #ifndef __ASSEMBLY__
+#include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
 /* duplicated to the one in bootmem.h */
